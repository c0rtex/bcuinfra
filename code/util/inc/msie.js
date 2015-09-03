//<script>
function ae_bs_saveRange(num) {}

function ae_bs_restoreRange(num) {}

function ae_bs_cmd_PasteText(num) {
	var instance=aeObjects[num];
	var range=ae_bs_range(instance);
	var textarea=document.getElementById("ae_tx_content"+num);
	textarea.style.visibility = "visible";
	textarea.value="";
	textarea.focus();
	var taRange=document.selection.createRange();
	taRange.execCommand('paste');
	textarea.style.visibility='hidden';
	var text=textarea.value;
	textarea.value='';
	text=text.replace(/([.\r\n]+)\r?\n\r?\n/mg,'<p>$1</p>\n');
	text=text.replace(/\n/g,'<br/>\n');
	range.pasteHTML(text);
	/*
	range.pasteHTML("<div id='ae_paste_track' style='display:none;'>&nbsp;</div>");
	var track=instance.contentDocument.getElementById('ae_paste_track');
	range.moveToElementText(track);
	range.select();
	instance.contentDocument.execCommand('Paste');
	var text=track.innerText;
	text=text.replace(/([.\r\n]+)\r?\n\r?\n/mg,'<p>$1</p>\n');
	text=text.replace(/\n/g,'<br/>\n');
	track.outerHTML=text;
	*/
}

function ae_bs_blockfmt(num, fmt) {
	var instance=aeObjects[num];
	instance.contentDocument.execCommand('FormatBlock', false, fmt);
}

function ae_bs_updateSelection(instance, range) {
	
}

function ae_bs_isControlSelection(num) {
	return ae_bs_sel(aeObjects[num]).type=='control';
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
	for(var k in styles)
		if(node.style[k]!=styles[k])
			return false;
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
	if(range.startContainer.nodeType==TEXT_NODE&&range.startContainer==range.endContainer&&range.startOffset>0&&range.endOffset<range.endContainer.nodeValue.length) {
		var parent=range.startContainer.parentNode;
		if(parent.nodeName=='SPAN') {
			if(parent.style[attribute]==value) {
				return;
			} else if(range.startOffset==0 && range.endOffset==range.startContainer.nodeValue.length) {
				parent.style[attribute]=value;
				return;
			}
		}
		var newSpan=instance.contentWindow.document.createElement('SPAN');
		if(isStyle) {
			for(var k in value) {
				newSpan.style[k]=value[k];
			}
		} else {
			newSpan.className=value;
		}
		newSpan.innerHTML=range.text;
		instance.pasteHTML(newSpan.outerHTML,true);
		return;
	} 
	
	if(range.startContainer.nodeType==TEXT_NODE) {
		var i=0;
		if(range.startOffset>0 && range.startOffset<range.startContainer.nodeValue.length) {
			var data=range.startContainer.nodeValue.substring(0,range.startOffset);
			var newNode=instance.contentDocument.createTextNode(data);
			if(range.startContainer==range.endContainer) 
				range.endOffset+=range.startOffset;
			range.startContainer.parentNode.insertBefore(newNode,range.startContainer);
			range.startContainer.deleteData(0,range.startOffset);
		} else if(range.startOffset!=0) {
			i=1;
		}
		var tnode=range.startContainer.previousSibling;
		while(tnode!=null) {
			tnode=tnode.previousSibling;
			i++;
		}
		
		range.startContainer=range.startContainer.parentNode;
		range.startOffset=i;
		if(range.startContainer==range.endContainer) range.endOffset++;
	}

	if(range.endContainer.nodeType==TEXT_NODE) {
		var i=0;
		if(range.endOffset>0 &&	range.endOffset<range.endContainer.nodeValue.length) {
			var data=range.endContainer.nodeValue.substring(range.endOffset,range.endContainer.nodeValue.length);
			var newNode=instance.contentDocument.createTextNode(data);
			if(range.endContainer.nextSibling) {
				range.endContainer.parentNode.insertBefore(newNode,range.endContainer.nextSibling);
			} else {
				range.endContainer.parentNode.appendChild(newNode);
			}
			range.endContainer.deleteData(range.endOffset,range.endContainer.nodeValue.length-range.endOffset);
			i=1;
		} else if(range.endOffset!=0) {
			i=1;
		}
		var tnode=range.endContainer;
		while(tnode.previousSibling!=null) {
			tnode=tnode.previousSibling;
			i++;
		}
		range.endContainer=range.endContainer.parentNode;
		range.endOffset=i;
	}
	var node=range.startContainer.childNodes[range.startOffset];
	for(;;) {
		if(node.nodeType==TEXT_NODE) {
			if(node.parentNode.nodeName=='SPAN' && 
				((isStyle && ae_nodeHasAllStyles(node.parentNode, value)) || (!isStyle && node.parentNode.className==value) ) ) {
				//all set
			} else if(node.parentNode.nodeName=='SPAN' && 
					node.nextSibling==null &&
					node.previousSibling==null ) {
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
			if(node==range.endContainer&&range.endOffset==0)
				break;
			node=node.firstChild;
		} else if(node.nextSibling) {
			if(node.parentNode==range.endContainer&&node==node.parentNode.childNodes[range.endOffset-1])
				break;
			node=node.nextSibling;
		} else {
			while(node&&node.nextSibling==null) {
				if(node.parentNode==range.endContainer&&node==node.parentNode.childNodes[range.endOffset-1])
					return;
				node=node.parentNode;
			}
			if(node==null||(node.parentNode==range.endContainer&&node==node.parentNode.childNodes[range.endOffset-1]))
				break;
			node=node.nextSibling;
		}
	}
}


function ae_bs_getTextContent(instance) {
	return instance.contentDocument.body.createTextRange().text;
}

function ae_bs_setTextContent(instance, text) {
	instance.contentDocument.body.createTextRange().text=text;
}

function ae_bs_emptysel(instance) {
	instance.contentDocument.selection.empty();
}

function ae_bs_wrapTag(num, tag, removetags, attributes) {
	var instance = aeObjects[num];
	var textRange=ae_bs_range(instance);
	var parent = textRange.parentElement();
	var outermostElement = null;
	selectionInnerText = textRange.text;
	//search for any tags that are parent of this.
	while (true) {
		if (parent.tagName == tag) {
			//remove the tag
			parent.removeNode(false);
			return;
		} else if(removetags!=null) {
			for(var n in removetags)	 {
				if(parent.tagName==n) {
					parent.removeNode(false);
				}	
			}
		}
		if (parent.innerText == selectionInnerText && selectionInnerText!='') {
			outermostElement = parent;
		}
		else { break; }
		if (parent.tagName == "BODY") {
			break;
		}
		parent = parent.parentElement;
	}
	if (textRange.compareEndPoints("StartToEnd",textRange)!=0) {
		if (outermostElement != null) {
			var html="<" + tag;
			if(attributes!=null) {
				for(var attr in attributes) {
					html+=" "+attr+"=\""+attributes[attr]+"\"";
				}
			}
			html+=">"+outermostElement.innerHTML+"</"+tag+">";
			outermostElement.innerHTML = html;
			textRange.moveToElementText(outermostElement);
			
		}	
		else {
			var html="<" + tag;
			if(attributes!=null) {
				for(var attr in attributes) {
					html+=" "+attr+"=\""+attributes[attr]+"\"";
				}
			}
			html+=">"+textRange.htmlText+"</"+tag+">";
			textRange.pasteHTML(html);
		}
		textRange.select();
	}
}

function ae_bs_sel(instance) {
	return instance.contentDocument.selection;
}

function ae_controlParent() {
	return this.startContainer.parentNode;
}

function ae_bs_range(instance) {
	var sel=instance.contentDocument.selection;
	var range=sel.createRange();
	if(sel.type!='Control') {
		var el=range.parentElement();
		while(el.nodeName!="BODY") el=el.parentNode;
		if(el==document.body) {
		        range=instance.contentDocument.body.createTextRange();
		        range.collapse();
		        range.select();
		}
		return ae_bs_standardify_range(instance,range);
	} else {
		var node=range.item(0);
		var i=0;
		range.startContainer=node.parentNode;
		range.endContainer=node.parentNode;
		while(node.previousSibling) {
			i++;
			node=node.previousSibling;
		}
		range.startOffset=i;
		range.endOffset=i+1;
		range.parentElement=ae_controlParent;
		return range;		
	}
}

function ae_bs_standardify_range(instance,range) {
	
	var rstart=range.duplicate();
	var rend=range.duplicate();
	var collapsed=range.compareEndPoints("StartToEnd",range)==0;
	rstart.collapse(true);
	rend.collapse(false);
	rstart.pasteHTML('<span id=\'ae_find_start\'></span>');
	if(!collapsed)
		rend.pasteHTML('<span id=\'ae_find_end\'></span>');
	var node=instance.contentDocument.getElementById('ae_find_start');
	if(node.previousSibling && node.previousSibling.nodeType == TEXT_NODE) {
		range.startOffset=node.previousSibling.nodeValue.length;
		range.startContainer=node.previousSibling;
		if(node.nextSibling && node.nextSibling.nodeType == TEXT_NODE) {
			var t2=node.nextSibling;
			var t1=node.previousSibling;
			rstart.moveToElementText(node);
			rstart.move('character',-range.startOffset);
			node.parentNode.removeChild(node);
			t1.appendData(t2.nodeValue);
			t2.parentNode.removeChild(t2);
			rstart.move('character',range.startOffset);
			range.setEndPoint('StartToStart',rstart);
		} else {
			node.parentNode.removeChild(node);
		}
	} else if(node.nextSibling && ( node.nextSibling.nodeType == TEXT_NODE ||
			( node.nextSibling.id=='ae_find_end' &&
			node.nextSibling.nextSibling && 
			node.nextSibling.nextSibling.nodeType == TEXT_NODE)
			)) {
		range.startOffset=0;
		if(node.nextSibling.id=='ae_find_end') {
			range.startContainer=node.nextSibling.nextSibling;
		} else {
			range.startContainer=node.nextSibling;
		}
		node.parentNode.removeChild(node);
	} else {
		var i=0;
		var n=node;
		range.startContainer=node.parentNode;
		while(n.previousSibling) {
			i++;
			n=n.previousSibling;
		}
		range.startOffset=i;
		node.parentNode.removeChild(node);
	}
	if(collapsed) {
		range.endContainer=range.startContainer;
		range.endOffset=range.startOffset;
		range.collapse(true);
		range.select();
		return range;
	}
	
	var node=instance.contentDocument.getElementById('ae_find_end');
	if(node.previousSibling && node.previousSibling.nodeType == TEXT_NODE) {
		range.endOffset=node.previousSibling.nodeValue.length;
		range.endContainer=node.previousSibling;
		if(node.nextSibling && node.nextSibling.nodeType == TEXT_NODE) {
			var t2=node.nextSibling;
			var t1=node.previousSibling;
			rend.moveToElementText(node);
			rend.move('character',-range.endOffset);
			node.parentNode.removeChild(node);
			t1.appendData(t2.nodeValue);
			t2.parentNode.removeChild(t2);
			rend.move('character',range.endOffset);
			range.setEndPoint('EndToStart',rend);
		} else {
			node.parentNode.removeChild(node);
		}
	} else if(node.nextSibling && node.nextSibling.nodeType == TEXT_NODE) {
		range.endOffset=0;
		range.endContainer=node.nextSibling;
		node.parentNode.removeChild(node);
	} else {
		var i=0;
		var n=node;
		range.endContainer=node.parentNode;
		while(n.previousSibling) {
			i++;
			n=n.previousSibling;
		}
		range.endOffset=i;
		node.parentNode.removeChild(node);
	}
	
	range.select();	
	return range;
}

function ae_bs_busycheck(num) {
	return aeObjects[num].contentWindow.document.readyState!="complete";
}

function ae_bs_pasteHTML(num, range, tagname, attributes, contents) {
	var instance=aeObjects[num];
	var html="<"+tagname;
	if(attributes!=null) {
		for(var k in attributes) {
			html+=" "+k+"=\""+attributes[k]+"\"";
		}
	}
	if(contents!=null)
		html+='>'+contents+'</'+tagname+'>';
	else 
		html+=" />";
	range.pasteHTML(html);
}

function ae_bs_init(num) {
	instance=aeObjects[num];
	instance.contentWindow.document.designMode = "on";
	instance.contentDocument=instance.contentWindow.document;
}

function ae_bs_onkeypress(num) {
	var sel;
	var instance=aeObjects[num];
	if(ae_breakonenter[num]||ae_sourceview) {
		//make enter insert <br> and ctrl+enter insert <p>
		switch(instance.contentWindow.event.keyCode) {
			case 10:
				instance.contentWindow.event.keyCode = 13;			
				break;
			case 13:
				if(ae_bs_getCommandState(instance,"UnorderedList")!=AE_LATCHED) {
					instance.contentWindow.event.returnValue = false;		
					sel = instance.contentDocument.selection.createRange();
					sel.pasteHTML("<BR>");
					sel.collapse(false);
					sel.select();
				}
				break;
			default:
				break;
		}
	}
}

function ae_bs_load(num) {
	var instance=aeObjects[num];
	content=document.getElementById('ae_tx_content'+num).value;


	if(!content.length) 
		content=" ";
	
	instance.contentDocument=instance.contentWindow.document;
	if(ae_baseurl[num]!='') {
		var base=instance.contentDocument.createElement('BASE');
		base.setAttribute('href',ae_baseurl[num]);
		instance.contentDocument.getElementsByTagName('HEAD')[0].appendChild(base);
	}
	instance.contentDocument.body.innerHTML = content;
	
	instance.contentDocument.oncontextmenu=new Function("return ae_contextmenu("+num+", aeObjects["+num+"].contentWindow.event);");
	instance.contentDocument.onmousedown=new Function("return ae_mousedown("+num+");");
	instance.contentDocument.onclick=new Function("return ae_onclick("+num+");");
	instance.contentDocument.onkeypress=new Function("ae_bs_onkeypress("+num+");");

	if(ae_stylesheet[num].length) {
		instance.contentDocument.createStyleSheet(ae_stylesheet[num]);
	}

	if(instance.contentDocument.styleSheets.length==0) {
		instance.contentDocument.createStyleSheet('');
	}
	var lastStyle=instance.contentDocument.styleSheets[instance.contentDocument.styleSheets.length-1];
	for(var i=0;i<ae_global_styles.length;i+=2) {
		lastStyle.addRule(ae_global_styles[i],ae_global_styles[i+1]);
	}
	
	
	if(oSel=document.getElementById('oQuickFormat'+num)) {
		var arr = ['Normal','Formatted','Address','Heading 1','Heading 2',
			'Heading 3','Heading 4','Heading 5','Heading 6','Numbered List',
			'Bulleted List','Directory List','Menu List','Definition Term',
			'Definition','Paragraph'];
		for (var i=0;i<arr.length;i++) {
			if (quickformatNameArray[num][i] != "e") {
				oSel.options[oSel.options.length]=new Option(quickformatNameArray[num][i], arr[i]);
			}
		}
	}
}

function ae_bs_getEventSrc(e) {
	return e.srcElement;
}

function ae_bs_command(cmd, num) {
	var instance=aeObjects[num];
	instance.contentDocument.execCommand(cmd, false, null);
}
var simplecmds=['Undo', 'Redo', 'Cut', 'Copy', 'Paste', 'Bold','Italic','Underline','JustifyCenter','JustifyLeft','JustifyRight',
	'InsertUnorderedList','InsertOrderedList','RemoveFormat'];


function ae_bs_getCommandState(num, cid) {
	var instance=aeObjects[num];
	if(ae_isSimpleCommand(cid)) {
		return ae_queryCommandState(num, cid);
	} else {
		return AE_ENABLED;
	}
}

function ae_bs_refreshToolbar(num) {
	var pbtn;
	var cid;
	var state;
	var instance=aeObjects[num];
	ae_tbar=eval("ae_tbar"+num);
	if(instance.QueryStatus(5002)!=instance.QueryStatus(5003)) return;
	for(var i=0;i<ae_tbar.all.length;i++) {
		pbtn= ae_tbar.all(i);
		cid=pbtn.cid;
		var iecid=ae_cmdmap[cid];
		if(iecid!=null&&cid!="Hyperlink") {
			if (!is_ie4) pbtn.style.visibility="visible";
			state=instance.QueryStatus(iecid)
	   		if(state == DECMDF_DISABLED || state == DECMDF_NOTSUPPORTED) {
				if(pbtn.state&&pbtn.state!=0) {
						pbtn.className = "disabled";
						pbtn.state = 0;
				}
			}
			else if(state == DECMDF_ENABLED || state == DECMDF_NINCHED){
				if(pbtn.state&&pbtn.state!=1) {
					pbtn.className = "flat";
					pbtn.state = 1;
				}
			}
			else {   //latched
				if(pbtn.state&&pbtn.state!=2) {
					pbtn.className = "latched";
					pbtn.state = 2;
				}
			}
		}
		else if(cid=="ToggleDetails") {
			if(instance.ShowDetails) {
				if(pbtn.state&&pbtn.state!=2) {
					pbtn.className = "latched";
					pbtn.state = 2;
				}
			}
			else {
				if(pbtn.state&&pbtn.state!=1) {
					pbtn.className = "flat";
					pbtn.state = 1;
				}
			}
		}
		
		if(instance.QueryStatus(ae_cmdmap['SetBlockFormat'])!=DECMDF_DISABLED&&instance.DOM.selection.type!="control") {			
			if(cid=="Strike") {
				if (hasParentTag(num,"STRIKE")) {
					if (pbtn.state&&pbtn.state!=2) {
						pbtn.className="latched";
						pbtn.state=2;
					}
				}
				else if (pbtn.state&&pbtn.state!=1) {
					pbtn.className="flat";
					pbtn.state=1
				}
			}
			else if (cid =="Subscript") {
				if (hasParentTag(num,"SUB")) {
					if (pbtn.state&&pbtn.state!=2) {
						pbtn.className="latched";
						pbtn.state=2;
					}
				}
				else if (pbtn.state&&pbtn.state!=1) {
					pbtn.className="flat";
					pbtn.state=1
				}
			}	
			else if (cid == "Superscript") {
				if (hasParentTag(num,"SUP")) {
					if (pbtn.state&&pbtn.state!=2) {
						pbtn.className="latched";
						pbtn.state=2;
					}
				}
				else if (pbtn.state&&pbtn.state!=1) {
					pbtn.className="flat";
					pbtn.state=1
				}
			}
			else if (cid == "Highlight") {
				instance = aeObjects[num];
				var parentElm = instance.DOM.selection.createRange().parentElement();
				while (parentElm != null) {
					if (parentElm.tagName == "SPAN" && parentElm.style.backgroundColor == "yellow") {
						if (pbtn.state&&pbtn.state!=2) {
							pbtn.className="latched";
							pbtn.state=2;	
						}
						break;
					}
					if (parentElm.tagName == "BODY") {
						if (pbtn.state&&pbtn.state!=1) {
							pbtn.className="flat";
							pbtn.state=1;
						}
						break;
					}
					parentElm = parentElm.parentElement;
				}
			}
		}
	}
	if(oSel=eval('document.all.oQuickFont'+num)){
		if(instance.QueryStatus(ae_cmdmap['SetFontName'])!=DECMDF_DISABLED&&instance.DOM.selection.type!="control") {
			if(oSel.disabled) oSel.disabled=false;
			fontname=instance.ExecCommand(ae_cmdmap['GetFontName']);
			if(fontname!=""&&fontname!=null) {
				fCreateNew=true;
				for(i=0;i<oSel.options.length;i++) {
					if(oSel.options[i].name==fontname) {
						if(!oSel.options[i].selected)
							oSel.options[i].selected=true;
						fCreateNew=false;
					}
				}
				if(fCreateNew) {
					var oOption = document.createElement("OPTION");
					oSel.options.add(oOption,0);
					oOption.text = fontname;
					oOption.name = fontname;
					oOption.selected=true;
				}
			}
			else {
				oSel.selectedIndex=-1;
			}
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}
	if(oSel=eval('document.all.oQuickFontSize'+num)){
		if(instance.QueryStatus(ae_cmdmap['SetFontSize'])!=DECMDF_DISABLED&&instance.DOM.selection.type!="control") {
			if(oSel.disabled) oSel.disabled=false; 
			fs=instance.ExecCommand(ae_cmdmap['GetFontSize']);
			if(fs!=null&&fs!="") {
				for(i=0;i<oSel.options.length;i++) {
					if(oSel.options[i].name=="ae_fs"+fs&&!oSel.options[i].selected)
						oSel.options[i].selected=true;
				}
			}
			else {
				oSel.selectedIndex=-1;
			}
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}	
	if(oSel=eval('document.all.oQuickFormat'+num)){
		if(instance.QueryStatus(ae_cmdmap['SetBlockFormat'])!=DECMDF_DISABLED&&instance.DOM.selection.type!="control") {
			if(oSel.disabled) oSel.disabled=false;
			fmt=instance.ExecCommand(ae_cmdmap['GetBlockFormat']);
			if(fmt!=""&&fmt!=null) {
				for(i=0;i<oSel.options.length;i++) {
					if(oSel.options[i].name==fmt&&!oSel.options[i].selected)
						oSel.options[i].selected=true;
				}
			}
			else {
				oSel.selectedIndex=-1;
			}
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}	
	if (oSel=eval('document.all.oQuickStyle'+num)) {
		if(instance.QueryStatus(ae_cmdmap['SetBlockFormat'])!=DECMDF_DISABLED&&instance.DOM.selection.type!="control") {
			if(oSel.disabled) oSel.disabled=false;
			//fmt=instance.ExecCommand(DECMD_GETBLOCKFMT);
			var cssClass = instance.DOM.selection.createRange().parentElement().className;
			if(cssClass!=""&&cssClass!=null) {
				for(i=0;i<oSel.options.length;i++) {
					if(oSel.options[i].name==cssClass&&!oSel.options[i].selected)
						oSel.options[i].selected=true;
				}
			}
			else {
				oSel.selectedIndex=0;
			}
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}
	if (oSel=eval('document.all.oQuickFontColors'+num)) {
		if(instance.QueryStatus(ae_cmdmap['SetBlockFormat'])!=DECMDF_DISABLED&&instance.DOM.selection.type!="control") {
			if(oSel.disabled) oSel.disabled=false;
			//fmt=instance.ExecCommand(DECMD_GETBLOCKFMT);
			var cssColor = instance.DOM.selection.createRange().parentElement().style.color;
			if(cssColor!=""&&cssClass!=null) {
				for(i=0;i<oSel.options.length;i++) {
					if(cssColor.toLowerCase()==(oSel.options[i].name.toLowerCase())  &&!oSel.options[i].selected)
						oSel.options[i].selected=true;
				}
			}
			else {
				oSel.selectedIndex=0;
			}
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}
}

function ae_bs_selectNode(range, node) {
	range.moveToElementText(node);
}

function ae_bs_getFirstSelectedTag(num, tagname) {
	var instance=aeObjects[num];
	var range=ae_bs_range(instance);
	var tagrange=instance.contentDocument.body.createTextRange();
	var tags=instance.contentDocument.getElementsByTagName(tagname);
	var tag;

	for(var i=0;i<tags.length;i++) {
		tag=tags[i];
		tagrange.moveToElementText(tag);
		
		if((range.compareEndPoints("StartToStart",tagrange)<=0 &&
				range.compareEndPoints("EndToStart",tagrange)>=0) ||
			(range.compareEndPoints("StartToStart",tagrange)>=0 &&
				range.compareEndPoints("EndToEnd",tagrange)<=0) || 
			(range.compareEndPoints("StartToEnd",tagrange)<=0 &&
				range.compareEndPoints("EndToEnd",tagrange)>=0) ) {
			return tag;
		}
	}
	return null;
}

function ae_bs_getTableSelection(num) {
	var instance=aeObjects[num];
	var sel=instance.contentDocument.selection;
	var info=null;
	
	if (sel.type == "Control") {
		var controlRange = sel.createRange();
		for (i = 0; i < controlRange.length; i++) {
			if (controlRange.item(i).tagName == "TABLE") {
				var tbl=controlRange.item(i);
				info=new Object();
				info['tableNode']=tbl;
				info['startColumn']=0;
				info['startRow']=0;
				info['endRow']=tbl.rows.length-1;
				info['endColumn']=tbl.rows[tbl.rows.length-1].cells.length-1;
				return info;
			}
		}

	} else {
		var range=ae_bs_range(instance);
		var node=range.parentElement();
		
		var tableNode=null;
		while(node!=null&&node.nodeName!='BODY') {
			if(node.nodeName=='TABLE') {
				tableNode=node;
				break;
			}
			node=node.parentNode;
		}
		if(tableNode==null) return null;
		
		info=new Object();
		info['tableNode']=tableNode;
	
		var cellRange=instance.contentDocument.body.createTextRange();
		for(var r=0;r<tableNode.rows.length;r++) {
			for(var c=0;c<tableNode.rows[r].cells.length;c++) {
				cellRange.moveToElementText(tableNode.rows[r].cells[c]);
				if(range.compareEndPoints("StartToStart",cellRange)>=0 &&
						range.compareEndPoints("StartToEnd",cellRange)<=0) {
					info['startColumn']=c;
					info['startRow']=r;
				}
				if(range.compareEndPoints("EndToStart",cellRange)>=0 &&
						range.compareEndPoints("EndToEnd",cellRange)<=0) {
					info['endColumn']=c;
					info['endRow']=r;
				}
			}
		}
	}
	return info;
}

function ae_bs_getSelectedImage(num) {
	var sel=instance.contentDocument.selection;
	if (sel.type == "Control") {
		var controlRange = sel.createRange();
		for (i = 0; i < controlRange.length; i++) {
			if (controlRange.item(i).tagName == "IMG") {
				return controlRange.item(i);
			}
		}
	}
	return null;
}

function ae_bs_removeNode(node,fRemoveChildren) {
	node.removeNode(fRemoveChildren);
}

function ae_bs_pasteNode(num, node, range) {
	var instance=aeObjects[num];
	
	if(range==null)
		range=ae_bs_range(instance);
	if(node.nodeType==TEXT_NODE) {
		range.pasteHTML(node.nodeValue);
	} else {
		if(range.startContainer==range.endContainer&&
			range.startOffset==range.endOffset-1) {
			var el=range.startContainer.childNodes[range.startOffset];
			el.parentNode.insertBefore(node,el);
			el.parentNode.removeChild(el);
		} else {
			range.pasteHTML(node.outerHTML);
		}
	}
}

function ae_bs_proto_pasteHTML(html, select) {
	var range=ae_bs_range(this);
	var startRange;
	if(select) {
		startRange=range.duplicate();
		startRange.collapse(true);
	}
	range.pasteHTML(html);
	if(select) {
		range.setEndPoint("StartToStart", startRange);
	} else {
		range.collapse();
	}
	range.select();
}

//</script>
