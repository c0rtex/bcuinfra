;(function() {

  var ls = window.localStorage;
  
  function MortgageAnalyzer( options ) {
    this.mortgage_types = {};
    this.constants = JSON.parse( $("#shebang-constants").text() );

    $.each( JSON.parse( $("#calc_mortgage_rates").text() ), $.proxy(function(i, type) {
      type.$article = $("#mort_desc_" +type.mort_type).remove();
      this.mortgage_types[ type.mort_type ] = type;
    },this));

    $.extend( this, options );
    this.$explainerContainer = $("<div class='explainer-container'>").insertAfter( this.$tbody.closest("section") );
    this.setupInputs();
    this.setMortgages();
  }

  MortgageAnalyzer.prototype.mortgages = {};

  MortgageAnalyzer.prototype.elements = {};

  MortgageAnalyzer.prototype.parameters = {
    mortgage_amount: 150000,
    mortgage_holding_period_years: 10,
    home_value: 200000,
    marginal_tax_rate: 25,
    itemize_flag: 1,
    mortgage_discount_points_fixed: 0,
    mortgage_discount_points_arm: 0,
    compare_mortgage_type: "71_arm",
    closing_cost_fixed_amount: 2500
  };

  MortgageAnalyzer.prototype.setupInputs = function() {
    var $inputs = this.$form.find("input, select"),
        $yearsIndicators = $("span.mtg-length-yrs"),
        cmt = "compare_mortgage_type";

    // Run through each of the parameters, fetching the input with that parameter name and 
    // setting it to the default or saved value for the parameter, and setting up the calculation when the inputs change
    $.each( this.parameters, $.proxy( function(name, defaultValue) {

      // Get the initial value out of localStorage or use the default;
      var value = ls.getItem( name ) || defaultValue;

      // Store the value on this instance, in case it was fetched from localStorage
      this.parameters[ name ] = value;

      // Store a reference to the input element inside of the elements cache
      this.elements[ "$" + name ] = $inputs.filter("[name='"+ name +"']")
      .bind("keypress change blur click", $.proxy(function(e) {
        // Get the current element off the elements cache instead of creating a redundant jQuery
        var $el = this.elements[ "$" + name ],
            v = $el.val();

        // If an element has a max and it is presently above it, clamp it to the max
        // Uses HTML5 validity API
        if ( e.target.validity.rangeOverflow ) {
          v = $el.attr("max");
          $el.val( v );
        }

        // If an element has a minimum and it is presently below it (negative numbers),
        // reset to last good stored value
        // Uses HTML5 validity API
        if ( e.target.validity.rangeUnderflow ) {
          v = this.parameters[ name ];
          $el.val( v );
        }

        // Set the parameter on the MortgageAnalyzer from the value
        // and save the value in localStorage
        this.parameters[ name ] = v;
        ls.setItem( name, v );

      }, this))
      // Set the value of the input to the current (possibly restored) value
      .val( value )
      // Recalculate the analysis 100ms after any amount of input has concluded
      // Allows for tpying to conplete, etc, to cut down on *really* redundant calculations
      .bind("keypress change blur click", $.proxy(function(e) {
        this.calcDelay && clearTimeout( this.calcDelay );
        this.calcDelay = setTimeout( $.proxy( this.calculate, this ), 100 );
      }, this));

    }, this));

    // Set the value of the holding period in years from the parameter
    // in case it was updated via localStorage
    $yearsIndicators = $("span.mtg-length-yrs").text( this.parameters.mortgage_holding_period_years );
    this.elements.$mortgage_holding_period_years
    .val ( this.parameters.mortgage_holding_period_years )
    // When the number of years changes, set the relevant displays of that value
    .change(function(e) {
          $yearsIndicators.text( e.target.value );
    });

    // Set the maximum amount of the mortgage to the value of the home
    this.elements.$mortgage_amount.attr("max", this.parameters.home_value );

    // Reset the maximum amount of the mortgage as the home value changes.
    this.elements.$home_value.change($.proxy(function(e) {
      this.elements.$mortgage_amount.attr("max", e.target.value);
      // If the value of the home is now less than the mortgage amount, lower the mortgage amount
      if ( parseInt(e.target.value,10) < parseInt(this.parameters.mortgage_amount,10) ) {
        this.elements.$mortgage_amount.val( e.target.value );
        this.parameters.mortgage_amount = e.target.value;
        ls.setItem( "mortgage_amount", e.target.value );
      }
    },this));

    // The 'compare mortgage type' select boxes are templated in on each Mortgage
    // but there is only one such select in the DOM at a time
    // When this changes, we need to reset the mortgage comparison
    this.$form.delegate("select[name='"+cmt+"']", "change", $.proxy(function(e) {

      // Store the choice in MortgageAnalyzer paramters and localStorage
      this.parameters[ cmt ] = e.target.value;
      ls.setItem( cmt, e.target.value );

      // Set the mortgages (uses the stored value);
      this.setMortgages();
    },this));

    // Map the 'if interest rates jump' link in explanatory text to the actual checkbox
    this.$form.delegate("a.rates-jump-link", "click", $.proxy(function(e) {

      e.preventDefault();

      var $t = $( e.target ),
          $ua = this.$form.find("input[name='use_adjustment']"),
          checked = $ua.is(":checked");

      $ua.prop("checked", !checked).trigger("change");
    },this));


  };

  MortgageAnalyzer.prototype.calcDelay = false;

  MortgageAnalyzer.prototype.calculate = function() {
    var compare_type = this.parameters.compare_mortgage_type,
        ARM = false,
        outputs = $.map( this.mortgages, function( mortgage, type ) {
          ARM = mortgage.ARM;
          return mortgage.calculate();
        }),
        bt_impact = outputs[0].monthly_mortgage_payment_bt - outputs[1].monthly_mortgage_payment_bt,
        at_impact = outputs[0].monthly_mortgage_payment_at - outputs[1].monthly_mortgage_payment_at,
        saveOrCost = bt_impact > 0 ? "save" : "cost",
        lessOrMore = bt_impact > 0 ? "less" : "more",
        $article = this.mortgages[ compare_type ].$article;

    $article.find("#mort-diff-"+compare_type+"-bt").text("$" + numberUtils.format(Math.abs(bt_impact)) );
    $article.find("#mort-diff-"+compare_type+"-at").text("$" + numberUtils.format(Math.abs(at_impact)) );
    console.log(lessOrMore);
    $article.find('.mo-payment-gt-lt').first().text(lessOrMore);
    /*
    if (lessOrMore == 'more' && bt_impact){
    	$article.find('.mo-payment-gt-lt').first().closest('.highlight-fig').addClass('more');
    } else {
    	$article.find('.mo-payment-gt-lt').first().closest('.highlight-fig').removeClass('more');
    }*/
    
    if (bt_impact < 0){
    	$article.find('.hf-diff-bt').addClass('more');
    } else {
    	$article.find('.hf-diff-bt').removeClass('more');
    }
    
    if (at_impact < 0){
    	$article.find('.hf-diff-at').addClass('more');
    } else {
    	$article.find('.hf-diff-at').removeClass('more');
    }
    
    if (saveOrCost == 'more'){
    	$article.find('.ht-total').addClass('more');
    } else {
    	$article.find('.ht-total').removeClass('more');
    }
    
	$article.find("#mort-remain-diff-"+compare_type).text("$" + numberUtils.format(Math.abs(outputs[1].loan_remaining_current_dollars)) );
    $article.find("#desc-save-or-cost").text( saveOrCost );

	if ( ARM ) {
		bt_impact = outputs[0].monthly_mortgage_payment_bt - outputs[2].monthly_mortgage_payment_bt;
		at_impact = outputs[0].monthly_mortgage_payment_at - outputs[2].monthly_mortgage_payment_at;
		$article.find("#mort-diff-"+compare_type+"_adjusted-bt").text("$" + numberUtils.format(Math.abs(bt_impact)) );
		$article.find("#mort-diff-"+compare_type+"_adjusted-at").text("$" + numberUtils.format(Math.abs(at_impact)) );
		var lessOrMoreARM = bt_impact > 0 ? "less" : "more";
		$article.find('.mo-payment-gt-lt').last().text(lessOrMoreARM);
		if (lessOrMoreARM == 'more'){
			$article.find('.ht-total').addClass('more');
		} else {
			$article.find('.ht-total').removeClass('more');
		} 
	} else {
		var lessOrMoreFixedLife = outputs[1].loan_remaining_current_dollars > 0 ? 'more' : '';
		$article.find('.mo-overall-gt-lt').text(lessOrMoreFixedLife);
		if (lessOrMoreFixedLife == 'more'){
			$article.find('.ht-total').addClass('more');
		} else {
			$article.find('.ht-total').removeClass('more');
		}
	}

    this.$explainerContainer.html( $article );
  };

  MortgageAnalyzer.prototype.setMortgages = function( types ) {
    this.$tbody.empty();
    this.mortgages = {};
    this.addMortgage("30_fixed");
    this.addMortgage( this.parameters.compare_mortgage_type );
    this.calculate();
  };

  MortgageAnalyzer.prototype.addMortgage = function( mortgageType ) {
    this.mortgages[ mortgageType ] = new Mortgage( mortgageType, this );

    //If we're adding an ARM, we have to add the 'adjusted' version as well
    if ( this.mortgages[mortgageType].ARM ) {
      this.mortgages[ mortgageType + "_adjusted" ] = new Mortgage( mortgageType + "_adjusted", this );
    }
  };

  function Mortgage( type, analyzer) {
    this.analyzer = analyzer;
    this.ARM = !!( ~type.indexOf("arm") );
    this.adjusted = !!( ~type.indexOf("adjusted") );
    type = this.analyzer.mortgage_types[ type ];
    $.extend( this, type );
    if ( this.adjusted ) {
      var ua = ls.getItem("use_adjustment");
      this.use_adjustment = ua && ua == "true" ? true : false;
      this.interest_rate_jump = parseFloat(this.analyzer.mortgages[ this.mort_type.replace("_adjusted", "")].interest_rate) + 0.06;
    } else {
      this.interest_rate = ls.getItem(this.mort_type+"_interest_rate") || this.interest_rate;
    }
    this.$row = $(Mortgage.template( this, analyzer )).appendTo( analyzer.$tbody ).data( "mortgage", this );
    this.calcDelay = false;
    this.$row.delegate("input.mtg-int-input", "change click", $.proxy(function(e) {
      this.calcDelay && clearTimeout(this.calcDelay);
      this.calcDelay = setTimeout($.proxy(function(){
        this.interest_rate = e.target.value / 100;
        if ( this.ARM ) {
          var r,
              adjusted = analyzer.mortgages[ this.mort_type + "_adjusted" ];
          if ( adjusted.use_adjustment ) {
            r = adjusted.interest_rate_jump = this.interest_rate + 0.06;
            adjusted.$row.find(".mtg-int-adjusted").text( Math.round(r * 10000) / 100 );
          }
        }
        ls.setItem(this.mort_type+"_interest_rate", this.interest_rate );
        analyzer.calculate();
      },this),100);
    },this));

    if ( this.adjusted ) {
      this.$row.delegate("input[name='use_adjustment']", "change", $.proxy(function(e) {
        this.use_adjustment = $(e.target).is(":checked");
        ls.setItem("use_adjustment", this.use_adjustment);
        this.$row.find(".mtg-int-adjusted").text( Math.round(this[ "interest_rate" +( this.use_adjustment ? "_jump" : "" ) ] * 10000) / 100);
        analyzer.calculate();
      },this));
    }
    this.parameters = $.extend({}, this.parameters);
  }

  Mortgage.prototype.parameters = {
    home_equity: 0,
    loan_remaining_current_dollars: 0,
    monthly_mortgage_payment_bt: 0,
    monthly_mortgage_payment_at: 0
  };

  Mortgage.prototype.calculate = function() {

    // Step 0
    // Calculate intermediate values

    var parms = this.analyzer.parameters,
        amount = parseInt(parms.mortgage_amount, 10),

        // Get the right interest rate to use
        rate = this.ARM && this.adjusted && this.use_adjustment ? this.interest_rate_jump : this.interest_rate,

        // Percentage points of interest to buy down (select the appropriate version depending if it's an ARM)
        points = parseInt( parms[ "mortgage_discount_points_" + (this.ARM ? "arm" : "fixed") ], 10) / 100,

        // Length of mortgage in months
        length_months = this.length * 12,

        // Effective interest rate after points are factored in
        interest_rate_adj = parseFloat( rate ) - (0.125 * points ),

        // Monthly interest rate
        monthly_interest_rate = interest_rate_adj / 12,

        // Number of months the mortgage will actually be held
        // Can't be longer than the actual length of the mortgage
        holding_period_months = parms.mortgage_holding_period_years * 12,
        holding_period_months = holding_period_months > length_months ? length_months : holding_period_months,
        // Total Closing Costs
        closing_costs = parseInt(parms.closing_cost_fixed_amount,10),

        // Adjusted amount of mortgage after points and closing costs are factored in
        amount_adj = amount + parseInt(closing_costs,10) + points ;

    this.parameters.closing_costs = closing_costs;

    // Step 1
    // Calculate the before-tax monthly payment (monthly_mortgage_payment_bt)
    // monthly_mortgage_payment_bt = mortgage_amount_adj * (monthly_interest / ( 1- (1+monthly_interest) ^ (-mortgage_length_months ) )  )
    this.parameters.monthly_mortgage_payment_bt = Math.round(( amount_adj * ( monthly_interest_rate / ( 1 - Math.pow( 1 + monthly_interest_rate, (-length_months) ) ) ) / 10) ) * 10;

    // Step 2
    // Amortization - calculate and collect the impact of each monthly payment
    var i = 0,
        payments = [],
        itemize = !!parseInt( parms.itemize_flag, 10),
        marginal_tax_rate = parseInt( parms.marginal_tax_rate, 10 ) / 100;


    function monthImpact( month ) {
      // Calculate each month in the loan term
      // Starting principal is the ending principal of the previous period or the original loan amount on the first iteration
      var start_principal = payments[ month-1 ] ? payments[ month-1 ].end_principal : amount_adj,
          interest_paid = start_principal * monthly_interest_rate,
          principal_paid = this.parameters.monthly_mortgage_payment_bt - interest_paid;

      return {
        start_principal: start_principal,
        principal_paid: principal_paid,
        interest_paid: interest_paid,
        tax_savings: itemize ? interest_paid * marginal_tax_rate : 0,
        end_principal: start_principal - principal_paid
      };
    }

    for ( i=0; i<length_months; i++ ) {
      payments.push( monthImpact.call( this, i ) );
    }

    // Step 3
    // Calculate remaining output variables
    var inflation_rate = parseFloat(this.analyzer.constants.inflation_rate) / 100,
        // Get the principal remaining for the last month the mortgage is held
        last_month = payments[ holding_period_months - 1 ];

    // Inflation-adjust the remaining loan amount, round to the nearest thousand
    this.parameters.loan_remaining_current_dollars = Math.round( (last_month.end_principal / Math.pow( 1 + inflation_rate, parms.mortgage_holding_period_years )) / 250 ) * 250;
    // Logically cannot be less than zero
    this.parameters.loan_remaining_current_dollars = this.parameters.loan_remaining_current_dollars < 0 ? 0 : this.parameters.loan_remaining_current_dollars;

    // Subtract the remaining amount from the home's value to get the percentage owned
    this.parameters.home_equity = parseInt( parms.home_value, 10) - this.parameters.loan_remaining_current_dollars;

    // Determine what percentage of the loan has been paid off
    var pctOwned = Math.abs( Math.round( (this.parameters.home_equity / parms.home_value) * 100 ) ),
        pctOwed = 100 - pctOwned;

    // Determine the after-tax payment using the tax savings from the first month of the amortization
    this.parameters.monthly_mortgage_payment_at = Math.round( (this.parameters.monthly_mortgage_payment_bt - payments[0].tax_savings) / 10 ) * 10;

    // Display the calculated display parameters and adjust the "graph"
    this.$row.find(".monthly_mortgage_payment_bt").text( numberUtils.format(this.parameters.monthly_mortgage_payment_bt) );
    this.$row.find(".monthly_mortgage_payment_at").text( numberUtils.format(this.parameters.monthly_mortgage_payment_at) );
    this.$row.find(".own-fig").text("$" + numberUtils.format(this.parameters.home_equity) + " Owned");
    this.$row.find(".home_equity").width( pctOwned + "%");
    this.$row.find(".owe-fig").text("$" + numberUtils.format(this.parameters.loan_remaining_current_dollars) + " Owed");
    this.$row.find(".loan_remaining_current_dollars").width( pctOwed + "%");

    // Set the proper content of the interest-rate tooltip in the adjusted ARM
    if ( this.adjusted ) {
      this.$row.find(".initial-rate-show").toggle( !this.use_adjustment ).next().toggle( this.use_adjustment );
    }

    return this.parameters;
  };

  Mortgage.template = function( type, analyzer ) {
    return [ "<tr class='mtg-group-", type.mort_type, (type.adjusted ? " ma-adjustable-after-group" : "") ,"'>",
        ( type.mort_type == "30_fixed" || type.adjusted ? 
          "<td class='mtg-type-data'>" + 
            type.pretty_name + 
          "</td>" : [
          "<td class='mtg-type-select'>",
            "<select name='compare_mortgage_type' id='mtg-compare-select' class='mtg-compare-select'>",
            (function() {
              return $.map( analyzer.mortgage_types, function( t ) {
                return t.mort_type == "30_fixed" || ~t.mort_type.indexOf("adjusted") ? "" : "<option value='" + t.mort_type +"'"+ (t.mort_type == type.mort_type ? "selected" : "") +">"+ t.pretty_name +"</option>";
              }).join("");
            })(),
            "</select>",
          "</td>"].join("")
        ),
        "<td class='mtg-int-data form-field-med-pct'>",
        ( type.adjusted ?
          ["<span class='info-box tip-trigger'>",
            "<span class='mtg-int-adjusted'>",Math.round(type[ "interest_rate" +( type.use_adjustment ? "_jump" : "" ) ] * 10000) / 100,"</span>",
            "<span class='pct'>%</span>",
            "<div class='tooltip'>",
              "<span class='initial-rate-show'>",
                "This rate is based on an estimated "+((type.interest_rate * 100) - 3).toFixed(2)+"% index rate plus a 3% margin.",
              "</span>",
              "<span class='initial-rate-hide'>",
                "This is your initial interest rate plus 6%, which is the cap for most adjustable-rate mortgages.",
              "</span>",
            "</div>",
            "</span>"
          ].join("") :
          "<input class='mtg-int-input mtg-int-current' name='"+type.mort_type+"_interest_rate' value='"+ type.interest_rate * 100+"' type='number' placeholder='4.0' step='0.125'><span class='pct'>%</span>"
        ),
        "</td>",
        "<td class='mtg-payment-data'>",
        "<span class='dollar'>$</span><span class='monthly_mortgage_payment_bt'></span>" ,
        "</td>",
        "<td class='mtg-payment-data-at'>",
        "<span class='dollar'>$</span><span class='monthly_mortgage_payment_at'></span>",
        "</td>",
        ( type.adjusted ?
          ["<td class='rates-jump last'>",
            "<input id='rates-jump' class='rates-jump-checkbox checkbox-input' type='checkbox' name='use_adjustment' value='rates-jump' ",
            (type.use_adjustment ? "checked='checked'" : "") ,
            "><label class='rates-jump-label checkbox-label tip-trigger info-box' for='rates-jump'>See what might happen in a worst-case scenario<div class='tooltip'>You would also owe more when you move, refinance, or pay off the mortgage.</div></label>",
          "</td>"] :
          ["<td class='own-owe-data last'>",
            "<div class='own-bar home_equity'><span class='own-fig owe-own-fig'>$0 Owned</span></div>",
            "<div class='owe-bar loan_remaining_current_dollars'><span class='owe-fig owe-own-fig'>$0 Owed</span></div>",
            "<div class='tooltip-dark'><span class='own-fig'></span> / <span class='owe-fig'></span></div>",
          "</td>"]
        ).join(""),
      "</tr>"
    ].join("");
  };

  $(function() {

    var analyzer = new MortgageAnalyzer({
      $form: $("form.mtg-analyzer-form"),
      $tbody: $("#ma-compare-table tbody")
    });

  });

})();
