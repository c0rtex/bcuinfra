//<script>

var ae_saved_range;

function ae_bs_saveRange(num) {
	var sel=ae_bs_sel(aeObjects[num]);
	ae_saved_range=ae_bs_range(aeObjects[num]);
}

function ae_bs_restoreRange(num) {
	ae_bs_updateSelection(aeObjects[num], ae_saved_range);
}

function ae_bs_selectNode(range, node) {
	var parent=node.parentNode;
	var n=parent.firstChild;
	var i=0;
	while(n!=null&&n!=node) {
		n=n.nextSibling;
		i++;
	}
	if(n==null) return;
	range.setStart(parent, i);
	range.setEnd(parent, i+1);
}

function ae_bs_getFirstSelectedTag(num, tagname) {
	var instance=aeObjects[num];
	var range=ae_bs_range(instance);
	var tagrange=instance.contentDocument.createRange();
	var tag;
	
	var tags=instance.contentDocument.getElementsByTagName(tagname);
	for(var i=0;i<tags.length;i++) {
		tag=tags[i];
		tagrange.setStart(tag, 0);
		tagrange.setEnd(tag, 1);

		if( (range.compareBoundaryPoints(Range.START_TO_START,tagrange)<=0 &&
				range.compareBoundaryPoints(Range.END_TO_START,tagrange)>=0) ||
			(range.compareBoundaryPoints(Range.START_TO_START,tagrange)>=0 &&
				range.compareBoundaryPoints(Range.END_TO_END,tagrange)<=0) ||
			(range.compareBoundaryPoints(Range.START_TO_END,tagrange)<=0 &&
				range.compareBoundaryPoints(Range.END_TO_END,tagrange)>=0) ) {
			return tag;
		}
	}
	return null;
}

function ae_bs_getSelectedImage(num) {
	var instance=aeObjects[num];
	var sel=ae_bs_sel(instance);
	if(sel.focusNode==sel.anchorNode&&sel.focusNode.nodeName=='IMG')
		return sel.focusNode;
	return null;
}

function ae_bs_closePasteWindow(num) {
	var instance=aeObjects[num];
	var popup=document.getElementById('ae_popup');
	var textarea=document.getElementById('ae_tx_content'+num);
	popup.style.visibility='hidden';
	popup.style.width='0px';
	popup.style.height='0px';
	textarea.style.visibility='hidden';
	textarea.style.width='0px';
	textarea.style.height='0px';
	instance.style.visibility='visible';
}

function ae_bs_finishPasteText(num) {
	var instance=aeObjects[num];
	var textarea=document.getElementById('ae_tx_content'+num);

	var text=textarea.value;
	textarea.value='';
	text=text.replace(/([.\r\n]+)\r?\n\r?\n/mg,'<p>$1</p>\n');
	text=text.replace(/\n/g,'<br/>\n');
	ae_bs_closePasteWindow(num);
	ae_bs_updateSelection(instance,ae_saved_range);
	instance.pasteHTML(text);
}

function ae_bs_popupPasteText(num) {
	var ctrlKey=navigator.platform.indexOf('Mac')!=-1?'Command+V (&#8984;+V)':'Ctrl+V';
	var instance=aeObjects[num];
	var pos=ae_getAbsolutePos(instance);
	var popup=document.getElementById('ae_popup');
	var textarea=document.getElementById('ae_tx_content'+num);

	textarea.style.left=pos.x+15;
	textarea.style.top=pos.y+50;
	textarea.style.width=(instance.offsetWidth-30)+'px';
	textarea.style.height=(instance.offsetHeight-65)+'px';
	
	popup.style.left=pos.x+15;
	popup.style.top=pos.y+15;
	popup.style.width=(instance.offsetWidth-30)+'px';
	popup.style.height=20;
	popup.innerHTML="Paste your text into the box below using "+ctrlKey+". <input type='button' onclick='ae_bs_finishPasteText("+num+");' value='OK'> <input type='button' onClick='ae_bs_closePasteWindow("+num+");' value='Cancel'>";
	popup.style.visibility='visible';
	instance.style.visibility='hidden';
	textarea.focus();
	textarea.select();
}

function ae_bs_cmd_PasteText(num) {
	var instance=aeObjects[num];
	var textarea=document.getElementById("ae_tx_content"+num);
	textarea.style.visibility="visible";
	textarea.value="";
	textarea.focus();

	ae_bs_popupPasteText(num);
}


function ae_bs_blockfmt(num, fmt) {
	if(fmt=='') {
		ae_bs_wrapTag(num, null, ['PRE','ADDRESS','H1','H2',
			'H3','H4','H5','H6','OL',
			'UL','P']);
	} else if(fmt=='OL'||fmt=='UL') {
		ae_bs_wrapTag(num, 'LI', ['LI']);
		ae_bs_wrapTag(num, fmt, ['OL','UL']);
	} else {
		ae_bs_wrapTag(num, fmt, ['PRE','ADDRESS','H1','H2',
			'H3','H4','H5','H6','OL',
			'UL']);
	}
}


function ae_bs_setFontSizeInPoints(instance, size) {
	instance.contentDocument.execCommand('FontSize', false, size+"pt");
}

function ae_bs_getFontSizeInPoints(instance) {
	var fs=instance.contentDocument.queryCommandValue("FontSize");
	if(fs&&fs.length>2) {
		if(fs.substring(fs.length-2,fs.length)=='px') {
			var f=parseFloat(fs.substring(0,fs.length-2));
			return Math.round(f*0.75);
		}	
	}
	return null;
}

function ae_nodeHasAllStyles(node, styles) {
	for(var k in styles) {
		if(node.style[k]!=styles[k]) {
			return false;
		}
	}
	return true;
}	

function ae_bs_proto_classifyText(className) {
	ae_bs_styleOrClassify(this, false, className);
}

function ae_bs_proto_stylizeText(styles) {
	ae_bs_styleOrClassify(this, true, styles);
}

function ae_bs_styleOrClassify(instance,isStyle,value) {
	var range=ae_bs_range(instance);
	var sel=instance.contentWindow.getSelection();
	
	if(range.startContainer.nodeType==TEXT_NODE&&range.startContainer==range.endContainer&&range.startOffset>0&&range.endOffset<range.endContainer.nodeValue.length) {
		var node=range.startContainer;
		var endOffset=range.endOffset;
		var offset=range.startOffset;
		if(offset>0) {
			node.splitText(offset);
			endOffset-=offset;
			node=node.nextSibling;
		}
		if(endOffset<node.nodeValue.length) {
			node.splitText(endOffset);
		}
		var newSpan=instance.contentDocument.createElement('SPAN');
		if(isStyle) {
			for(var k in value) {
				newSpan.style[k]=value[k];
			}
		} else {
			newSpan.className=value;
		}
		node.parentNode.insertBefore(newSpan,node);
		newSpan.appendChild(node);
		range.selectNode(node);
		ae_bs_updateSelection(instance, range);
	}

	if(range.startContainer.nodeType==TEXT_NODE) {
		if(range.startOffset>0 && range.startOffset<range.startContainer.nodeValue.length) {
			var node=range.startContainer;
			node.splitText(range.startOffset);
			range.setStartAfter(node);
		} else {
			if(range.startOffset==0)
				range.setStartBefore(range.startContainer);
			else 
				range.setStartAfter(range.startContainer);
		}
	}

	if(range.endContainer.nodeType==TEXT_NODE) {
		if(range.endOffset>0 &&	range.endOffset<range.endContainer.nodeValue.length) {
			var node=range.endContainer;
			node.splitText(range.endOffset);
			range.setEndAfter(node);
		} else {
			if(range.endOffset==0) 
				range.setEndBefore(range.endContainer);
			else 
				range.setEndAfter(range.endContainer);
		}
	}
	var endContainer=range.endContainer;
	var endOffset=range.endOffset;
	var node=range.startContainer.childNodes[range.startOffset];
	for(;;) {
		if(node.nodeType==TEXT_NODE) {
			if(node.parentNode.nodeName=='SPAN' && 
				( (isStyle && ae_nodeHasAllStyles(node.parentNode, value)) || (!isStyle && node.parentNode.className==value) ) ) {
				//all set
			} else if(node.parentNode.nodeName=='SPAN' &&							node.nextSibling==null &&
					node.previousSibling==null) {
				if(isStyle) {
					for(var k in value) {
						node.parentNode.style[k]=value[k];
					}
				} else {
					node.parentNode.className=value;
				}
			} else {
				var newSpan=instance.contentDocument.createElement('SPAN');
				if(isStyle) {
					for(var k in value) {
						newSpan.style[k]=value[k];
					}
				} else {
					newSpan.className=value;
				}
				node.parentNode.insertBefore(newSpan,node);
				newSpan.appendChild(node);
			}
		}
		
		if(node.firstChild) {
			if(node==endContainer&&endOffset==0) {
				break;
			}
			node=node.firstChild;
		} else if(node.nextSibling) {
			if(node.parentNode==endContainer&&node==node.parentNode.childNodes[endOffset-1]) {
				break;
			}
			node=node.nextSibling;
		} else {
			while(node&&node.nextSibling==null) {
				if(node.parentNode==endContainer&&node==node.parentNode.childNodes[endOffset-1]) {
					return;
				}
				node=node.parentNode;
			}
			if(node==null||(node.parentNode==endContainer&&node==node.parentNode.childNodes[endOffset-1])) {
				break;
			}
			node=node.nextSibling;
		}
	}
	ae_bs_updateSelection(instance, range);
}


function ae_bs_removeTags(node, removeTagArr) {
	var nodeStack=Array();
	var cnode=node.firstChild;
	nodeloop:
	while(cnode!=null) {
		for(var i=0;i<removeTagArr.length;i++) {
			if(cnode.nodeName.toLowerCase()==removeTagArr[i].toLowerCase()) {
				var first=cnode.firstChild;
				var n=first;
				while(n!=null) {
					var next=n.nextSibling;
					cnode.removeChild(n);
					cnode.parentNode.insertBefore(n, cnode);
					n=next;
				}
				var remove=cnode;
				if(first) {
					cnode=first;
				} else if(cnode.nextSibling) {
					cnode=cnode.nextSibling;
				} else {
					while(cnode!=null&&cnode.nextSibling==null) {
						cnode=nodeStack.pop();
						if(cnode!=null && cnode.nextSibling) {
							cnode=cnode.nextSibling;
							break;
						}
					}
				}
				remove.parentNode.removeChild(remove);
				continue nodeloop;
			}
		}
		
		if(cnode.firstChild) {
			nodeStack.push(cnode);
			cnode=cnode.firstChild;
		} else if(cnode.nextSibling) {
			cnode=cnode.nextSibling;
		} else {
			while(cnode!=null&&cnode.nextSibling==null) {
				cnode=nodeStack.pop();
				if(cnode!=null && cnode.nextSibling) {
					cnode=cnode.nextSibling;
					break;
				}
			}
		}
	}
}

function ae_bs_isControlSelection(num) {
	return false;
}

function ae_bs_splitTagAroundRange(node, range) {
	var nodeStack=Array();
	var r1=range.cloneRange();
	var r2=range.cloneRange();
	r1.collapse(true);
	r1.setStartBefore(node);
	r2.collapse(false);
	r2.setEndAfter(node);
	range.selectNode(node);
	var c1,c2,c3;
	if(r1.toString()!='') c1=r1.extractContents();
	if(r2.toString()!='') c2=r2.extractContents();
	c3=range.extractContents();
	var selNode=c3.firstChild;
	if(c2!=null) range.insertNode(c2);
	if(c3!=null) range.insertNode(c3);
	range.insertNode(c1);
	range.selectNode(selNode);
}

function ae_bs_wrapTag(num, tag, removeTags,attributes) {
	var instance=aeObjects[num];
	if(removeTags==null) removeTags=[tag];
	var range=ae_bs_range(instance);
	ae_bs_emptysel(instance);
	var node=range.commonAncestorContainer;
	var onlyRemove=(tag==null);
	var found;
	nodeLoop:
	while(node!=null && ae_isFormatTag(node.nodeName)) {
		if(equalsIgnoreCase(node.nodeName,tag)) {
			var parent=node.parentNode;
			ae_bs_splitTagAroundRange(node, range);
			node=parent;
			onlyRemove=true;
		} else {
			for(var i=0;i<removeTags.length;i++) {
				if(node.nodeName==removeTags[i]) {
					var parent=node.parentNode;
					ae_bs_splitTagAroundRange(node, range);
					node=parent;
					onlyRemove=true;
					continue nodeLoop;
				}
			}
			node=node.parentNode;
		}
	}
	
	var contents=range.extractContents();
	if(!onlyRemove) {
		var first=contents.firstChild;
		if(first.nodeType==Node.TEXT_NODE&&first.nodeValue=="") 
			first=first.nextSibling;
		onlyRemove=first==contents.lastChild && 
			equalsIgnoreCase(first.nodeName,
				tag);
	}
	
	ae_bs_removeTags(contents, removeTags);

	if(onlyRemove) {
		var f=contents.firstChild;
		var l=contents.lastChild;
		range.insertNode(contents);
		range.setStartBefore(f);
		range.setEndAfter(l);
	} else {
		var newNode=instance.contentDocument.createElement(tag);
		if(attributes!=null) {
			for(var attr in attributes) {
				newNode.setAttribute(attr, attributes[attr]);
			}
		}
		newNode.appendChild(contents);
		range.insertNode(newNode);
		range.selectNodeContents(newNode);
	}
	ae_bs_updateSelection(instance, range);
}

function ae_bs_updateSelection(instance, range) {
	var sel=instance.contentWindow.getSelection();

	sel.setBaseAndExtent(range.startContainer, range.startOffset, 
		range.endContainer, range.endOffset);
}

function ae_bs_range(instance) {
	var range=instance.contentDocument.createRange();
	var sel=ae_bs_sel(instance);
	var anode=sel.anchorNode;
	var aoff=sel.anchorOffset;
	var fnode=sel.focusNode;
	var foff=sel.focusOffset;
	var i;
	
	if(fnode.nodeName=='IMG') {
		var i=0; var node=fnode.parentNode.firstChild;
		while(node!=fnode) {
			i++;
			node=node.nextSibling;
		}
		fnode=fnode.parentNode;
		foff=i+1;
	}
	if(anode.nodeName=='IMG') {
		var i=0; var node=anode.parentNode.firstChild;
		while(node!=anode) {
			i++;
			node=node.nextSibling;
		}
		anode=anode.parentNode;
		aoff=i;
	}
	range.setStart(anode, aoff);
	range.setEnd(fnode, foff);
	range.parentElement=new Function("return this.commonAncestorContainer;");
	return range;
}

function ae_bs_getTextContent(instance) {
	range = instance.contentDocument.createRange();
	referenceNode = instance.contentDocument.getElementsByTagName("BODY").item(0);
	range.selectNodeContents(referenceNode);
	return range.toString();
}

function ae_bs_setTextContent(instance, text) {
	var t = document.createTextNode(text);
	instance.contentDocument.body.appendChild(t);
}

function ae_bs_emptysel(instance) {
	instance.contentWindow.getSelection().collapseToStart();
}

function ae_bs_sel(instance) {
	var sel=instance.contentWindow.getSelection();
    if (sel && sel.anchorNode && sel.focusNode && (sel.anchorNode.nodeType == 3) && 
			(sel.anchorNode == sel.focusNode) && (sel.anchorOffset == sel.focusOffset)) {
		var pos = sel.anchorOffset - ("" + sel).length;
		if (pos < 0) pos = 0;
		var found= sel.anchorNode.nodeValue.substring(pos).indexOf(sel);
		var pos2=pos+found + ("" + sel).length;
		var node=sel.anchorNode;
		if (found >= 0) {
			sel.collapseToStart();
			sel.setBaseAndExtent(node,
				pos + found,
				node,
				pos2);
		}
	}	
	return sel;
}

function ae_bs_busycheck(num) {
	return aeObjects[num].contentDocument?false:true;	
}

function ae_bs_init(num) {
	var instance=aeObjects[num];
	thisContentItem=document.getElementById('ae_tx_content'+num);
	thisForm=thisContentItem;
	while(thisForm.parentNode&&thisForm.nodeName!="FORM"&&thisForm.nodeName!="HTML") {
		thisForm=thisForm.parentNode;
	}
	if(thisForm.nodeName!="HTML") {
		//bind onSubmit event to ae_onSubmit()
		thisForm.onsubmit = ae_onSubmit;
	}
	else {
		alert("Activedit must be contained in a form.", "", true);
		return;
	}
}

function ae_bs_load(num) {
	var instance=aeObjects[num];

	thisContentItem=document.getElementById('ae_tx_content'+num);
	
	var html="<HTML><HEAD>";
	html+="<style type='text/css'>\n";
	for(var i=0;i<ae_global_styles.length;i+=2) {
		html+=ae_global_styles[i]+" {"+ae_global_styles[i+1]+"}\n"
	}
	html+="</style>\n";
	if(ae_stylesheet[num].length) {
		html+="<LINK rel='stylesheet' href='"+ae_stylesheet[num]+"' type='text/css'></LINK>";
	}
	html+="</HEAD><BODY></BODY></HTML>";

	instance.contentDocument.write(html);
	
	instance.contentDocument.body.innerHTML=thisContentItem.value;
	instance.contentDocument.designMode = "on";
	instance.contentDocument.oncontextmenu=new Function("e", "ae_contextmenu("+num+",e);");
	instance.contentDocument.onmousedown=new Function("e", "ae_mousedown("+num+",e);");
	instance.contentDocument.onmouseup=new Function("e", "ae_bs_event("+num+", e);");
	instance.contentDocument.onclick=new Function("e", "ae_bs_event("+num+", e);");
	instance.contentDocument.ondragstart=new Function("event",
		"event.preventDefault();");
		//dump(instance.contentDocument.createRange());
	instance.contentDocument.onkeydown=new Function("e", "ae_bs_event("+num+",e);");
	instance.contentDocument.onkeypress=new Function("e", "ae_bs_event("+num+",e);");

	if(oSel=document.getElementById('oQuickFormat'+num)) {
		var arr = ['','PRE','ADDRESS','H1','H2',
			'H3','H4','H5','H6','OL',
			'UL','DIR','MENU','DL',
			'DT','P'];
		for (var i=0;i<arr.length;i++) {
			if (quickformatNameArray[num][i] != "e") {
				oSel.options[oSel.options.length]=new Option(quickformatNameArray[num][i], arr[i]);
			}
		}
	}
		
	
}

var seltimeout=null;
function ae_bs_fixsel(num) {
	var instance=aeObjects[num];
	var sel=window.getSelection();
	if(sel.focusNode==instance&&sel.anchorNode==instance) {
		sel.collapseToStart();
		instance.contentWindow.getSelection().collapseToStart();
		instance.contentWindow.getSelection().setBaseAndExtent(instance.contentDocument.body, 0, instance.contentDocument.body, instance.contentDocument.body.childNodes.length);
		instance.blur();
		instance.focus();
	}
}

function ae_bs_event(num, e) {
	var instance=aeObjects[num];
	switch(e.type) {
	case 'click':
		for (var node=e.target; node && (node.nodeName != "BODY"); node = node.parentNode) {
			if ((node.nodeName == "A") || (node.nodeName == "AREA") || ((node.nodeName == "INPUT") && ((node.type.toUpperCase() == "BUTTON") || (node.type.toUpperCase() == "SUBMIT")))) {
				e.preventDefault();
				e.stopPropagation();
				return false;
			} else if(node.nodeName=='IMG') {
				var range=ae_bs_range(instance);
				ae_bs_selectNode(range, node);
				ae_bs_updateSelection(instance, range);
				ae_bs_range(instance);
				e.preventDefault();
				e.stopPropagation();
				return false;
			}
		}
		ae_onclick(num);
		break;
	case 'keydown':
		window.status=e.keyCode;
		if (e.metaKey && (e.keyCode == 65)) {
			e.preventDefault();
			e.stopPropagation();
			var sel = ae_bs_sel(instance);
			sel.setBaseAndExtent(instance.contentDocument.body, 0, instance.contentDocument.body, instance.contentDocument.body.childNodes.length);
		}
		if(e.keyCode >=37 && e.keyCode<=40) { 
			//arrow keys
			clearTimeout(seltimeout);
			seltimeout=setTimeout("ae_bs_fixsel("+num+")",50);
		}
		
		break;
	case 'keypress':
		if(e.keyCode >=37 && e.keyCode<=40) { 
			//arrow keys
			clearTimeout(seltimeout);
			seltimeout=setTimeout("ae_bs_fixsel("+num+")",50);
		}
		break;
	case 'mousedown': //see if everything is selected
		
		break;
	case 'mouseup': //fix selection problems
		clearTimeout(seltimeout);
		seltimeout=setTimeout("ae_bs_fixsel("+num+")",50);
		ae_onclick(num);
		break;
	default:
		//nothin
	}
}

function ae_bs_command(cmd, num) {
	var instance=aeObjects[num];
	instance.contentDocument.execCommand(cmd, false, null);
}

function ae_bs_getEventSrc(e) {
	return e.srcElement;
}

var simplecmds=['Undo', 'Redo', 'Cut', 'Copy', 'Paste', 'Bold','Italic','Underline','JustifyCenter','JustifyLeft','JustifyRight'];


function ae_bs_getCommandState(num, cid) {
	var instance=aeObjects[num];
	if(ae_isSimpleCommand(cid)) {
		return ae_queryCommandState(num, cid);
	} else {
		return AE_ENABLED;
	}
}

function ae_bs_removeNode(node,fRemoveChildren) {
	if(fRemoveChildren) {
		node.parentNode.removeChild(node);
	} else {
		
		var n=node.firstChild;
		var next;
		while(n!=null) {
			next=n.nextSibling;
			node.parentNode.insertBefore(n, node);
			n=next;
		}
		node.parentNode.removeChild(node);
	}
}


function ae_bs_pasteNode(num, node, range) {
	var instance=aeObjects[num];
	if(range==null) range=ae_bs_range(instance);
	range.extractContents();
	range.insertNode(node);
}

function ae_bs_pasteHTML(num, range, tagname, attributes, contents) {
	var instance=aeObjects[num];
	var el=instance.contentDocument.createElement(tagname);
	for(var attrname in attributes) {
		el.setAttribute(attrname, attributes[attrname]);
	}
	if(contents!=null)
		el.innerHTML=contents;
	range.extractContents();
	range.insertNode(el);
}

function ae_bs_proto_pasteHTML(html) {
	var div = this.contentDocument.createElement("div");
	var range=ae_bs_range(this);
	var node;
	div.innerHTML = html;
	range.deleteContents();
	while (div.lastChild) {
		node=div.removeChild(div.lastChild);
		range.insertNode(node);
	}
}


//</script>
