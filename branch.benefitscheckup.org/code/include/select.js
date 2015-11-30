// Crude browser detect
var ns = (document.layers) ? true : false;
var ie = (document.all) ? true : false;

if (ie == false){
	if (navigator.userAgent.indexOf('Firefox') != -1){
		ie = true;
	}
}

// Runs on page load
function rxInit() {
	//document.forms.formDrug.elements.avlDrugNm.focus();
	//document.forms.formDrug.elements.avlDrugNm.options.selectedIndex = 0;
}

// Accepts two select list objects, and copies all selected list
// elements from one to the other.  The second two arguments
// specify, first, a select list object that gets its values
// indexed into, second, a hidden form element specified by 'log.'
function copyElements (selectSrc, selectDst, selectToLog, log) {
	selectedElems = new Array();
	selectedCount = 0;
	for (elemNum = 0; elemNum < selectSrc.options.length; elemNum++) {
		if (selectSrc.options[elemNum].selected) {
			selectedElems[selectedCount] = elemNum;
			selectedCount++;
		}
	}
	for (mesI = 0; mesI < selectedCount; mesI++) {
		elemNum = selectedElems[mesI];
		elem = selectSrc.options[elemNum];
		elemText = elem.text;
		elemValue = elem.value;
		selectSrc.selectedIndex = elemNum;
		insertNum = findUniqueInsertPoint(selectDst, elemText);
		if (insertNum > -1)
			insertElem(selectDst, insertNum, elemText, elemValue);
	}
	setList(selectToLog, log);
}

// Accepts one select list object, and removes all selected list
// elements from it.  The second two arguments specify, first, a
// select list object that gets its values indexed into, second,
// a hidden form element specified by 'log.'
function removeElements (selectSrc, selectToLog, log) {
	selectedElems = new Array();
	selectedCount = 0;
	for (elemNum = 0; elemNum < selectSrc.options.length; elemNum++) {
		if (selectSrc.options[elemNum].selected) {
			selectedElems[selectedCount] = elemNum;
			selectedCount++;
		}
	}
	for (mesI = 0; mesI < selectedCount; mesI++) {
		elemNum = selectedElems[mesI] - mesI;
		deleteElem(selectSrc, elemNum);
	}
	setList(selectToLog, log);
}

// Given a select list object and a list position, adds
// the option specified by text and value to the list.
function insertElem(select, pos, text, value) {
	if (select.options.length == pos) {
		select.options[select.options.length] = new Option(text, value);
	} else {
		for (i = select.options.length; i > pos; i--) {
			select.options[i] = new Option(select.options[i - 1].text, select.options[i - 1].value);
		}
		select.options[pos] = new Option(text, value);
	}
}

// Deletes an element from the given select list, and positions the
// highlight in the select list on the element after the one deleted
function deleteElem(select, pos) {
	if (pos >= select.options.length - 1) {
		select.selectedIndex = select.options.length - 2;
	} else {
		select.selectedIndex = pos + 1;
	}
	select.options[pos] = null;
}

// Given a sorted select list and a string, moves the
// highlight to the first item in the list matching the
// string
function matchElement(select, text) {
	select.selectedIndex = select.options.length - 1;
	jumpToIndex = findInsertPoint(select, text);
	if (jumpToIndex > 0 && select.options[jumpToIndex].text.toLowerCase().indexOf(text.toLowerCase()) == -1)
		jumpToIndex--;
	if (jumpToIndex != select.options.selectedIndex) {
		if (jumpToIndex >= select.options.length) {
			select.selectedIndex = select.options.length - 1;
		} else {
			select.selectedIndex = jumpToIndex;
		}
	}
}

// Given a sorted select list and new text, finds the point
// at which to add the new text, preserving the sort order
function findInsertPoint(select, text) {
	if (select.options.length == 0) {
		answer = 0;
	} else {
		answer = binarySearch(select, 0, select.options.length - 1, text, 1);
	}
	return answer;
}

// Given a sorted select list and new text, finds the point
// at which to add the new text, preserving the sort order.
// Returns -1 if the new text already exists in select list
function findUniqueInsertPoint(select, text) {
	if (select.options.length == 0) {
		answer = 0;
	} else {
		answer = binarySearch(select, 0, select.options.length - 1, text, 1);
	}
	if (answer > 0 && text == select.options[answer - 1].text)
		answer = -1;
	return answer;
}

// A recursive binary search which zeroes in on the location
// at which to add new text to an alphabetized select list
function binarySearch(select, low, high, text, time) {
	textLow = text.toLowerCase();
	if (time == 1 && textLow < select.options[low].text.toLowerCase()) {
		return low;
	} else if (time == 1 && textLow >= select.options[high].text.toLowerCase()) {
		return high + 1;
	} else if (low == high) {
		return high + 1;
	} else if (low == high - 1) {
		return high;
	} else {
		mid = Math.floor((low + high) / 2);
		if (text.toLowerCase() < select.options[mid].text.toLowerCase()) {
			return binarySearch(select, low, mid, text, time + 1);
		} else {
			return binarySearch(select, mid, high, text, time + 1);
		}
	}
}

// Indexes values from the given select list into a hidden form field
function setList(select, hidden) {
	hidden.value="";
	for (i = 0; i < select.options.length; i++ ) {
		if (i > 0) {
			hidden.value += ",";
		}
		hidden.value += select.options[i].value;
	}
}

// Touches each of the select lists, forcing reevaluation,
// then submits the given form.
function submitDrugs(s, h, f) {
	s.options[s.options.length] = new Option(" ", "null");
	s.selectedIndex = s.options.length - 1;
	setList(s, h);
	f.submit();
}

// Submits drugs somewhere different
function submitDrugsBack(s, h, f, u) {
	f.action = u;
	submitDrugs(s, h, f);
}