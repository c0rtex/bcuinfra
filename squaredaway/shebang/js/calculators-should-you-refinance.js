;(function() {

  var ls = window.localStorage;

  function RefiAnalyzer( options ) {
    this.mortgage_types = {};
    this.constants = JSON.parse( $("#shebang-constants").text() );

    $.each( JSON.parse( $("#calc_mortgage_rates").text() ), $.proxy(function(i, type) {
      this.mortgage_types[ type.mort_type ] = type;
    },this));

    $.extend( this, options );
    this.setupInputs();
    this.setupFurnitureEvents();
    this.setMortgages();
  }

  RefiAnalyzer.prototype.mortgages = {};

  RefiAnalyzer.prototype.elements = {};

  RefiAnalyzer.prototype.parameters = {
    mortgage_amount_remaining: 200000,
    mortgage_holding_period_years: 10,
    current_mortgage_payment: 1200,
    home_value: 200000,
    marginal_tax_rate: 25,
    itemize_flag: 1,
    mortgage_discount_points_fixed: 0,
    mortgage_discount_points_arm: 0,
    current_mortgage_type: "30_fixed",
    refi_mortgage_type: "71_arm",
    closing_cost_fixed_amount: 2500,
    get_cash_out_impact: false
  };
  
  RefiAnalyzer.prototype.setupFurnitureEvents = function(){
  	$('.trigger-closing-costs-change').bind('click', function(e){
  		e.preventDefault();
  		$('#refi-advanced-trigger').trigger('click');
  		$('#pay-pts').trigger('focus');
  	});
  }

  RefiAnalyzer.prototype.setupInputs = function() {
    var $inputs = this.$form.find("input, select"),
        $yearsIndicators = $("span.mtg-length-yrs");
	
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

        if ( $el.is("[type='checkbox']") ) { 
          // For the checkbox(es), we want to use the checkbox's checked state, not its actual value property
          v = $el.is(":checked");
        } else if ( $el.is("[type='number']") ) {
          // Handle numeric inputs
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
        }

        // Set the parameter on the RefiAnalyzer from the value
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

    // Set the current value for the get_cash_out_impact checkbox and the parameter from localStorage, casting it from string to boolean
    this.elements.$get_cash_out_impact[0].checked = this.parameters.get_cash_out_impact = this.parameters.get_cash_out_impact == "true";

    // Set the value of the holding period in years from the parameter
    // in case it was updated via localStorage
    $yearsIndicators = $("span.mtg-length-yrs").text( this.parameters.mortgage_holding_period_years );
    this.elements.$mortgage_holding_period_years
    .val ( this.parameters.mortgage_holding_period_years )
    // When the number of years changes, set the relevant displays of that value
    .change(function(e) {
      $yearsIndicators.text( e.target.value );
    });

    this.$form.delegate("select.mtg-compare-select", "change", $.proxy(function(e) {

      // Store the choice in RefiAnalyzer paramters and localStorage
      var field = e.target.name;
      this.parameters[ field ] = e.target.value;
      ls.setItem( field, e.target.value );
      ls.removeItem( "refi_interest_rate" );
      // Set the mortgages (uses the stored value);
      this.setMortgages();
    },this));

  };

  RefiAnalyzer.prototype.calcDelay = false;

  RefiAnalyzer.prototype.calculate = function() {
    var refi_type = this.parameters.refi_mortgage_type,
        ARM = false,
        outputs = $.map( this.mortgages, function( mortgage, type ) {
          ARM = mortgage.ARM;
          return mortgage.calculate();
        }),
        bt_impact = outputs[0].monthly_mortgage_payment_bt - outputs[1].monthly_mortgage_payment_bt,
        at_impact = outputs[0].monthly_mortgage_payment_at - outputs[1].monthly_mortgage_payment_at,
        same_dollar_impact = Math.abs( at_impact ) < 25,
        owed_diff = outputs[0].loan_remaining_current_dollars - outputs[1].loan_remaining_current_dollars,
        owed_diff_pct = Math.abs( outputs[1].loan_remaining_current_dollars / outputs[0].loan_remaining_current_dollars ),
        same_owed_pct = owed_diff_pct >= 0.95 && owed_diff_pct <= 1.05,
		
        monthlyLessOrMore = bt_impact > 0 ? "less" : "more",
        owedLessOrMore = owed_diff > 0 ? "less" : "more",

        closing_cost_recoup_years = Math.round( outputs[1].closing_costs / bt_impact / 12 ),
        closing_cost_recoup_years = closing_cost_recoup_years < 1 ? 1 : closing_cost_recoup_years,

        // Only show the closing cost savings payoff if
        // 1) The monthly payment is actually less in the refi
        // 2) The interest rate on the refi loan is lower than the interest rate on the current loan
        // 3) The refi loan will be paid off within 5 years of the time the original loan would have been paid off
        show_closing_cost_calcs = bt_impact >= 0 &&
                                  (this.mortgages.refi.interest_rate <= this.mortgages.current.interest_rate) &&
                                  (this.mortgages.refi.length - this.parameters.mortgage_yrs_left <= 5),

        cash_out_exists = outputs[1].cash_out_max > 0;

    this.$explainer.find(".payment-diff-bt").text("$" + numberUtils.format(Math.abs(bt_impact)) ).toggleClass("more", monthlyLessOrMore == "more");
    this.$explainer.find(".payment-diff-at").text("$" + numberUtils.format(Math.abs(at_impact))).toggleClass("more", monthlyLessOrMore == "more");
    this.$explainer.find('.monthly_at').text('$'+numberUtils.format(outputs[1].monthly_mortgage_payment_at));
    this.$explainer.find(".mo-payment-gt-lt").text( monthlyLessOrMore ).toggleClass("more", monthlyLessOrMore == "more");
    this.$explainer.find(".arm-only").toggle( this.mortgages.refi.ARM );

    this.$explainer.find(".closing-costs").text( "$" + numberUtils.format(outputs[1].closing_costs) );
    this.$explainer.find(".exp-yrs-to-cover").text( closing_cost_recoup_years );
    this.$explainer.find(".yrs-to-cover-plural").toggle( closing_cost_recoup_years > 1 );
    this.$explainer.find(".cc-calcs").toggle( show_closing_cost_calcs );

    this.$explainer.find(".same-pct-show").toggle( same_owed_pct ).next(".same-pct-hide").toggle( !same_owed_pct );
    this.$explainer.find(".same-dollar-show").toggle( same_dollar_impact ).next(".same-dollar-hide").toggle( !same_dollar_impact );

    this.$explainer.find(".amount-owed-gt-lt").text( owedLessOrMore ).toggleClass("more", owedLessOrMore == "more");
    this.$explainer.find(".amt-owed-diff").text("$" + numberUtils.format(Math.abs( owed_diff )) ).toggleClass("more", owedLessOrMore == "more");
    this.$explainer.find(".amt-owed-refi").text("$" + numberUtils.format(outputs[1].loan_remaining_current_dollars) );
    this.$explainer.find(".amt-owed-current").text("$" + numberUtils.format(outputs[0].loan_remaining_current_dollars) );

    this.$explainer.find(".lower-payment-data .is-isnt-switch").text( at_impact < 0 || same_dollar_impact ? "isn't" : "is" );
    this.$explainer.find(".pay-faster-data .is-isnt-switch").text( owed_diff < 0 || same_owed_pct ? "isn't" : "is" );
    this.$explainer.find(".home-value").text( "$" + numberUtils.format(this.parameters.home_value) );
    this.$explainer.find(".cash-out-limit").text( "$" + numberUtils.format(this.parameters.home_value * 0.75) );
    this.$explainer.find(".cash-out-max").text( "$" + numberUtils.format( outputs[1].cash_out_max) );
    this.$explainer.find(".cash-out-exists-show").toggle( cash_out_exists ).next().toggle( !cash_out_exists );

  };

  RefiAnalyzer.prototype.setMortgages = function( types ) {
    this.$tbody.empty();
    this.mortgages = {};
    this.addMortgage( this.parameters.current_mortgage_type, "current");
    this.addMortgage( this.parameters.refi_mortgage_type, "refi" );
    this.calculate();
  };

  RefiAnalyzer.prototype.addMortgage = function( mortgageType, role ) {
    this.mortgages[ role ] = new Mortgage( mortgageType, role, this );

    //If we're adding an ARM, we have to add the 'adjusted' version as well
    if ( role == "refi" && this.mortgages[ role ].ARM ) {
      this.mortgages[ role + "_adjusted" ] = new Mortgage( mortgageType + "_adjusted", role, this );
    }
  };

  function Mortgage( type, role, analyzer) {
    this.role = role;
    this.analyzer = analyzer;
    this.ARM = !!( ~type.indexOf("arm") );
    this.adjusted = !!( ~type.indexOf("adjusted") );
    type = this.analyzer.mortgage_types[ type ];
    $.extend( this, type );
    if ( this.role == "current" && this.ARM ) {
      this.interest_rate = analyzer.mortgage_types[ type.mort_type + "_adjusted"].interest_rate;
    }
    if ( this.adjusted ) {
      var ua = ls.getItem("use_adjustment");
      this.use_adjustment = ua && ua == "true" ? true : false;
      this.interest_rate_jump = parseFloat( analyzer.mortgages.refi.interest_rate ) + 0.06;
    } else {
      this.interest_rate = ls.getItem(this.role+"_interest_rate") || this.interest_rate;
    }
    this.$row = $(Mortgage.template( this, analyzer )).appendTo( analyzer.$tbody ).data( "mortgage", this );
    this.calcDelay = false;
    this.$row.delegate("input.mtg-int-input", "change click", $.proxy(function(e) {
      this.calcDelay && clearTimeout(this.calcDelay);
      this.calcDelay = setTimeout($.proxy(function(){
        this.interest_rate = e.target.value / 100;
        if ( this.role == "refi" && this.ARM && analyzer.mortgages.refi_adjusted.use_adjustment ) {
          var r = analyzer.mortgages.refi_adjusted.interest_rate_jump = this.interest_rate + 0.06;
          analyzer.mortgages.refi_adjusted.$row.find(".mtg-int-adjusted").text( Math.round(r * 10000) / 100 );
        }
        ls.setItem(this.role+"_interest_rate", this.interest_rate );
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
    monthly_mortgage_payment_at: 0,
    closing_costs: 0
  };

  Mortgage.prototype.calculate = function() {

    // Step 0
    // Calculate intermediate values, including the original loan amount

    var parms = this.analyzer.parameters,

        // Get the right interest rate to use
        rate = this.ARM && this.adjusted && this.use_adjustment ? this.interest_rate_jump : this.interest_rate,

        // Percentage points of interest to buy down (select the appropriate version depending if it's an ARM)
        points = this.role == "current" ? 0 : parseInt( parms[ "mortgage_discount_points_" + (this.ARM ? "arm" : "fixed") ], 10) / 100,

        // Length of mortgage in months
        length_months = this.length * 12,

        // Effective interest rate after points are factored in
        interest_rate_adj = parseFloat( rate ) - (0.125 * points ),

        // Monthly interest rate
        monthly_interest_rate = interest_rate_adj / 12,

        // Loan amount - calculate the original loan amount for the current loan, grab the refinance amount from the current loan's calculation for the refi.
        amount = parseInt(this.analyzer.parameters.mortgage_amount_remaining, 10),

        // Number of months the mortgage will actually be held
        // Can't be longer than the actual length of the mortgage
        holding_period_months = parms.mortgage_holding_period_years * 12,
        holding_period_months = holding_period_months > length_months ? length_months : holding_period_months,
        // Total Closing Costs
        closing_costs = this.parameters.closing_costs = this.role == "current" ? 0 : parseInt(parms.closing_cost_fixed_amount,10),

        // Figure out the maximum amount that could be used in a 'cash out' refinance
        // Can't be less than 0
        cash_out_max = this.role == "refi" ? (Math.round(this.analyzer.parameters.home_value * 0.75) - closing_costs - this.analyzer.parameters.mortgage_amount_remaining) : 0,
        cash_out_max = this.parameters.cash_out_max = cash_out_max < 0 ? 0 : cash_out_max,

        // Adjusted amount of mortgage after points and closing costs are factored in
        // We only want to account for closing costs on the refinanced mortgage, not the current one
        amount_adj = amount + closing_costs + points + (this.role == "refi" && this.analyzer.parameters.get_cash_out_impact ? cash_out_max : 0);

    // Step 1
    // Calculate the before-tax monthly payment (monthly_mortgage_payment_bt)
    // monthly_mortgage_payment_bt = mortgage_amount_adj * (monthly_interest / ( 1- (1+monthly_interest) ^ (-mortgage_length_months ) )  )
    this.parameters.monthly_mortgage_payment_bt = this.role == "current" ? parseInt( this.analyzer.parameters.current_mortgage_payment, 10 ) : Math.round(( amount_adj * ( monthly_interest_rate / ( 1 - Math.pow( 1 + monthly_interest_rate, (-length_months) ) ) ) / 10) ) * 10;

    // Step 2
    // Amortization - calculate and collect the impact of each monthly payment
    var i = 0,
        payments = [],
        itemize = !!parseInt( parms.itemize_flag, 10),
        marginal_tax_rate = parseInt( parms.marginal_tax_rate, 10 ) / 100,
        principal_remaining = amount_adj;


    function monthImpact( month ) {
      // Calculate each month in the loan term
      // Starting principal is the ending principal of the previous period or the original loan amount on the first iteration
      var start_principal = payments[ month-1 ] ? payments[ month-1 ].end_principal : amount_adj,
          interest_paid = start_principal * monthly_interest_rate,
          principal_paid = this.parameters.monthly_mortgage_payment_bt - interest_paid,
          end_principal = start_principal - principal_paid;

      principal_remaining = end_principal;

      return {
        start_principal: start_principal,
        principal_paid: principal_paid,
        interest_paid: interest_paid,
        tax_savings: itemize ? interest_paid * marginal_tax_rate : 0,
        end_principal: end_principal
      };
    }

    while ( principal_remaining > 10 ) {
      payments.push( monthImpact.call( this, i ) );
      // Don't allow there to be more pay periods than there actually would be in the term of the mortgage
      if ( ++i > length_months ) {
        break;
      }
    }

    // Step 3
    // Calculate remaining output variables
    var inflation_rate = parseFloat(this.analyzer.constants.inflation_rate) / 100,
        // Get the principal remaining for the last month the mortgage is held
        last_month = payments[ holding_period_months - 1 ] || payments.slice( -1 )[0];

    // Inflation-adjust the remaining loan amount, round to the nearest thousand
    this.parameters.loan_remaining_current_dollars = Math.round( (last_month.end_principal / Math.pow( 1 + inflation_rate, parms.mortgage_holding_period_years )) / 1000 ) * 1000;
    // Logically cannot be less than zero
    this.parameters.loan_remaining_current_dollars = this.parameters.loan_remaining_current_dollars < 0 ? 0 : this.parameters.loan_remaining_current_dollars;

    // Subtract the remaining amount from the home's value to get the percentage owned
    this.parameters.home_equity = parseInt( parms.home_value, 10) - this.parameters.loan_remaining_current_dollars;

    // Determine the after-tax payment using the tax savings from the first month of the amortization
    this.parameters.monthly_mortgage_payment_at = Math.round( (this.parameters.monthly_mortgage_payment_bt - payments[0].tax_savings) / 10 ) * 10;

    // Display the calculated display parameters
    this.$row.find(".mtg-payment-data-"+this.role).text( numberUtils.format(this.parameters.monthly_mortgage_payment_bt) );
    this.$row.find(".mtg-payment-data-at-"+this.role).text( numberUtils.format(this.parameters.monthly_mortgage_payment_at) );

    // Set the proper content of the interest-rate tooltip in the adjusted ARM
    if ( this.adjusted ) {
      this.$row.find(".initial-rate-show").toggle( !this.use_adjustment ).next().toggle( this.use_adjustment );
    }

    return this.parameters;
  };

  Mortgage.template = function( type, analyzer ) {
    return [ "<tr class='mtg-group-", type.role, " mtg-group-",type.mort_type, (type.adjusted ? " refi-mtg-group-adjusted ma-adjustable-after-group" : "") ,"'>",
      "<td class='mtg-compare-data'>",
        type.adjusted ? 
        "<span>" + type.pretty_name + "</span>" :
        ((type.role == 'current' ? 'Current' : 'Refinanced')+' Mortgage'), '</td>',
        ( type.adjusted ? ["<td class='rates-jump last'>",
          "<input id='rates-jump' class='rates-jump-checkbox checkbox-input' type='checkbox' name='use_adjustment' ",
          (type.use_adjustment ? "checked='checked'" : ""),
          "value='rates-jump' ","><label class='rates-jump-label checkbox-label' for='rates-jump'>See worst-case scenario</label>",
          "</td>"] :
          [ "<td class='mtg-type-data form-field-med'>",
            "<select name='",type.role,"_mortgage_type' id='mtg-compare-select' class='mtg-compare-select'>",
          (function() {
            return $.map( analyzer.mortgage_types, function( t ) {
              return ~t.mort_type.indexOf("adjusted") ? "" : "<option value='" + t.mort_type +"'"+ (t.mort_type == type.mort_type ? "selected" : "") +">"+ t.pretty_name +"</option>";
            }).join("");
          })(),
          "</select></td>"])
        .join(""),
        "</td>",
        "<td class='mtg-int-data ", (type.adjusted ? "mtg-int-data-adjusted" : "form-field-med-pct"), "'>",
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
          "<input class='mtg-int-input mtg-int-current' name='"+type.role+"_interest_rate' value='"+ type.interest_rate * 100+"' type='number' placeholder='4.0' step='0.125'><span class='pct'>%</span>"
        ),
        "</td>",
        "<td class='mtg-payment-data'>",
          "<span class='dollar'>$</span>",
          "<span class='mtg-payment-data-",type.role ,"'>0</span>",
        "</td>",
        "<td class='mtg-payment-data-at'>",
          "<span class='dollar'>$</span><span class='mtg-payment-data-at-", type.role ,"'>134</span>",
        "</td>",
      "</tr>"
    ].join("");
  };

  $(function() {

    var analyzer = new RefiAnalyzer({
      $form: $("form.refi-form"),
      $tbody: $("#refi-compare-table tbody"),
      $explainer: $("section.compare-explainer")
  });

  });

})();
