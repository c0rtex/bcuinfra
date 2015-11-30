
var count = 0;

function incrementCount() {
	count++;
}

function writeSubFrame() {
    if (parent.sub != null) {
    	parent.sub.document.location="timeoutwarning.html";
    }
}

function disableSubFrame() {
    if (parent.sub != null) {
        parent.sub.document.location="blank.html";
    }
}

function enableSubFrame() {
    if (parent.sub != null) {
        parent.sub.document.location="timeoutwarning.html";
    }
}

var wassubmit = false;

function disableButtons() {
	if (!wassubmit) {
		wassubmit = true;
		return true;
	}

	return false;
}
