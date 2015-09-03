//<script>

function ae_bs_saveRange(num) {}

function ae_bs_restoreRange(num) {}

function ae_bs_blockfmt(num, fmt) {
	var instance=aeObjects[num];
	switch(fmt) {
	case '':
		instance.contentDocument.execCommand('RemoveFormat', false, null);
	case 'UL':
		instance.contentDocument.execCommand('InsertUnorderedList', false, null);
		break;
	case 'OL':
		instance.contentDocument.execCommand('InsertOrderedList', false, null);
		break;
	default:
		instance.contentDocument.execCommand('FormatBlock', false, fmt);
		break;
	}
}

var fontmap=[8,10,12,14,18,24,36];

function ae_bs_setFontSizeInPoints(instance, size) {
	for(var i=0;i<6;i++) {
		if(i==6||size<fontmap[i+1]) {
			instance.contentDocument.execCommand('FontSize', false, i+1);
			return;
		}
	}
}

function ae_bs_getFontSizeInPoints(instance) {
	var fs=instance.contentDocument.queryCommandValue("FontSize");
	if(fs>0) {
		return fontmap[fs-1];
	}
}

function ae_nodeHasAllStyles(node, styles) {
	for(var k in styles) {
		if(node.style[k]!=styles[k]) {
			return false;
		}
	}
	return true;
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
	ae_bs_updateSelection(instance,ae_savedrange);
	instance.pasteHTML(text);
	ae_bs_closePasteWindow(num);
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
	textarea.style.visibility='visible';

	popup.style.left=pos.x+15;
	popup.style.top=pos.y+15;
	popup.style.width=(instance.offsetWidth-30)+'px';
	popup.style.height=20;
	popup.innerHTML="Paste your text into the box below using "+ctrlKey+". <input type='button' onclick='ae_bs_finishPasteText("+num+");' value='OK'> <input type='button' onClick='ae_bs_closePasteWindow("+num+");' value='Cancel'>";
	popup.style.visibility='visible';
	instance.style.visibility='hidden';
	ae_savedrange=ae_bs_range(instance);
	textarea.focus();
	textarea.select();
}

function ae_bs_cmd_PasteText(num) {
	var instance=aeObjects[num];
	var range=ae_bs_range(instance);
	var textarea=document.getElementById("ae_tx_content"+num);
	textarea.style.visibility="visible";
	textarea.value="";
	textarea.focus();

	try {
		document.execCommand('paste');
	} catch(e) {
		ae_bs_popupPasteText(num);
		return;
	}
	
	var text=textarea.value;
	textarea.value='';
	text=text.replace(/([.\r\n]+)\r?\n\r?\n/mg,'<p>$1</p>\n');
	text=text.replace(/\n/g,'<br/>\n');
	alert(text);
	range.pasteHTML(text);
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
	sel.removeAllRanges();
	
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


function ae_bs_selectNode(range, node) {
	range.selectNodeContents(node);
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

function ae_bs_wrapTag(num, tag, removeTags, attributes) {
	var instance=aeObjects[num];
	if(removeTags==null) removeTags=[tag];
	var range=ae_bs_range(instance);
	ae_bs_emptysel(instance);
	var node=range.commonAncestorContainer;
	var onlyRemove=tag==null;
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
		onlyRemove=equalsIgnoreCase(contents.firstChild.nodeName.toLowerCase(),tag.toLowerCase())&&contents.firstChild==contents.lastChild;
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
		range.selectNode(newNode);
	}
	ae_bs_updateSelection(instance, range)
}

function ae_bs_updateSelection(instance, range) {
	instance.contentWindow.getSelection().removeAllRanges();
	instance.contentWindow.getSelection().addRange(range);
}

function ae_bs_emptysel(instance) {
	instance.contentWindow.getSelection().removeAllRanges();
}

function ae_bs_getTextContent(instance) {
	return instance.contentDocument.body.textContent;
}

function ae_bs_setTextContent(instance, text) {
	instance.contentDocument.body.textContent=text;
}

function ae_bs_removetags(node, remove) {
	var n=node.firstChild;
	while(n!=null) {
		if(n.nodeType==Node.ELEMENT_NODE) {
			if(n.nodeName==remove) {
				var n1=n;
				while(n1.firstChild) {
					node.insertBefore(ae_bs_removetags(n1.removeChild(n1.firstChild), remove), n1);
				}
				n=n1.nextSibling();
				node.removeChild(n1);
			} else {
				ae_bs_removetags(n, remove);
			}
		} else {
			n=n.nextSibling;
		}
	}
	return node;
}

function ae_bs_range(instance) {
	var sel=instance.contentWindow.getSelection();
	var range=sel.getRangeAt(0);
	range.parentElement=new Function("return this.commonAncestorContainer;");
	return range;
}

function ae_bs_sel(instance) {
	var sel=instance.contentWindow.getSelection();
	return sel;
}

function ae_bs_busycheck(num) {
	return false;	
}

function ae_bs_init(num) {
	var instance=aeObjects[num];
}

function ae_bs_load(num) {
	var instance=aeObjects[num];
	var d=instance.contentDocument;
	if(ae_stylesheet[num].length) {
		var objCSS = d.createElement('link');
		objCSS.rel = 'stylesheet';
		objCSS.href = ae_stylesheet[num];
		objCSS.type = 'text/css';
		d.getElementsByTagName('head')[0].appendChild(objCSS);
	}
	
	var globalstyles=d.createElement('style');
	var styletext='';
	for(var i=0;i<ae_global_styles.length;i+=2) {
		styletext+=ae_global_styles[i]+" {"+ae_global_styles[i+1]+"}\n"
	}
	globalstyles.appendChild(d.createTextNode(styletext));
	d.getElementsByTagName('head')[0].appendChild(globalstyles);
								
	thisContentItem=document.getElementById('ae_tx_content'+num);
	d.body.innerHTML=thisContentItem.value;
	d.designMode = "on";
	instance.contentDocument.addEventListener("contextmenu",new Function("e", "ae_contextmenu("+num+",e)"), true);
	instance.contentDocument.addEventListener("mousedown",new Function("e", "ae_mousedown("+num+",e)"), true);
	instance.contentDocument.addEventListener("click",new Function("ae_refreshToolbar("+num+");"), true);
	instance.contentDocument.addEventListener("mouseup",new Function("ae_refreshToolbar("+num+");"), true);
	instance.contentDocument.addEventListener("keypress",new Function("ae_refreshToolbar("+num+");"), true);

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

function ae_bs_command(cmd, num) {
	var instance=aeObjects[num];
	instance.contentDocument.execCommand(cmd, false, null);
}

function ae_bs_getEventSrc(e) {
	return e.originalTarget;
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


function ae_bs_getFirstSelectedTag(num, tagname) {
	var instance=aeObjects[num];
	var range=ae_bs_range(instance);
	var tagrange;
	var tag;
	
	var tags=instance.contentDocument.getElementsByTagName(tagname);
	for(var i=0;i<tags.length;i++) {
		tag=tags[i];
		if(range.intersectsNode(tag)) {
			return tag;
		}
	}
	return null;
}

function ae_bs_getSelectedImage(num) {
	var instance=aeObjects[num];
	var nodeStack=Array();
	var range=ae_bs_range(instance);
	var imgs=instance.contentDocument.body.getElementsByTagName('IMG');
	for(var i=0;i<imgs.length;i++) {
		if(range.intersectsNode(imgs[i])) {
			return imgs[i];
		}
	}
	return null;
}

function ae_bs_removeNode(node,fRemoveChildren) {
	if(fRemoveChildren) {
		node.parentNode.removeChild(node);
	} else {
		var n=node.firstChild;
		var next;
		while(n!=null) {
			next=n.nextSibling;
			node.parentNode.insertBefore(node.removeChild(n), node);
			n=next;
		}
		node.parentNode.removeChild(node);
	}
}

var simplecmds=['Undo', 'Redo', 'Cut', 'Copy', 'Paste', 'Bold','Italic','Underline','JustifyCenter','JustifyLeft','JustifyRight',
	'InsertUnorderedList','InsertOrderedList'];

function ae_bs_getCommandState(num, cid) {
	var instance=aeObjects[num];
	if(ae_isSimpleCommand(cid)) {
		return ae_queryCommandState(num, cid);
	} else {
		return AE_ENABLED;
	}
}


	
//</script>
