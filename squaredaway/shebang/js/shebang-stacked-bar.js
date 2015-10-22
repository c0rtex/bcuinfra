function StackedBar(container) {
	this.overall = 4000;
	this.height = 500;
	this.roundTo = 10;
	this.container = container;
	if (typeof container == 'string'){
		this.container = $(container);
	}
	var bs = this.container.find('.bar-graph-bar');
	this.barsByName = new Array();
	this.bars = new Array();
	var THIS = this;
	bs.each(function(){
		var bar = new Bar($(this));
		bar.roundTo = THIS.roundTo;
		THIS.bars.push(bar);
		var barName = $(this).attr('id');
		bar.name = barName;
		THIS.barsByName[barName] = bar;
	});
}

StackedBar.prototype.refresh = function(){

	var overflow = this.getOverflow();
	var graphMax = Math.max(this.overall, overflow);
	var THIS = this;
	$.each(this.bars, function(i, bar){
		var val = bar.value;
		if (val){
			var ht = val / graphMax * THIS.height;
			bar.setHeight(ht);
		} else {
			bar.setHeight(0);
		}
	});
}

StackedBar.prototype.getOverflow = function(){
	var overflow = 0;
	$.each(this.bars, function(i, bar){
		overflow += bar.value;
	});
	return overflow;
}

StackedBar.prototype.updateBar = function(barName, value){
	var bar = this.barsByName[barName];
	if (!bar){
		console.log('Could not find ' + barName);
		return;
	}
	bar.setValue(value);
}

StackedBar.prototype.setOverall = function(overall){
	this.overall = overall;
}

function Bar(dom) {
	this.value = 0;
	this.dom = dom;
	this.name;
	this.roundTo = 10;
}

Bar.prototype.setValue = function(val){
	val = toNumber(val);
	this.value = val;
	var displayValue = addCommas(roundTo(val, this.roundTo));
	this.dom.find('.amount').html(displayValue);
}

Bar.prototype.setHeight = function(ht){
	this.dom.height(ht);
	if (ht){
		this.dom.fadeIn();
	} else {
		this.dom.fadeOut();
	}
	if (ht < 20){
		this.dom.addClass('too-small-bar');
	} else {
		this.dom.removeClass('too-small-bar');
	}
}

