		function ActivSpellClass() {
			this.init();	
		}

		ActivSpellClass.prototype = new Object();
		ActivSpellClass.prototype.init = function() {
			this.argsIndex = -1;
			this.fieldRefs = new Array();
			this.ignore = new Array();
			this.change = new Array();
			this.changeto = new Array();
			this.replacements = new Array();
		}
		
		ActivSpell = new ActivSpellClass();
		
		function nextField() {

		}
	
		function spell() 
		{	
		
		 	if(typeof(ActivSpellWin) != "undefined" && ActivSpellWin.close) {
				ActivSpellWin.close();
			}
			
			ActivSpell.fieldRefs = arguments;
			
			//override nextField since registering onpropertychange fires itself
			nextField = function() {
				ActivSpell.argsIndex++;
				
				if(ActivSpell.argsIndex < ActivSpell.fieldRefs.length) {
				
					if (eval(ActivSpell.fieldRefs[ActivSpell.argsIndex]).length == 0) {
						nextField();
					}
					
					ActivSpellWin = window.open(ae_inc + "spellchecker/window.cfm?jsvar=" + ActivSpell.fieldRefs[ActivSpell.argsIndex], "ActivSpellWin", "height=230,width=450,status=no,toolbar=no,menubar=no,location=no");
					} else {
						spellCheckComplete();
					}
			}
			
			//index ActivSpell.argsIndex
			ActivSpell.argsIndex++;
			if (eval(ActivSpell.fieldRefs[ActivSpell.argsIndex]).length == 0) {
				nextField();
			}
			
			//send the first field to spellcheck
			if(typeof(ActivSpellWin) == "undefined" || ActivSpellWin.closed) {
				ActivSpell.argsIndex = -1;
				ActivSpell.argsIndex++;
				
				if (eval(ActivSpell.fieldRefs[ActivSpell.argsIndex]).length == 0) {
					nextField();
				}
				
				ActivSpellWin = window.open(ae_inc + "spellchecker/window.cfm?jsvar=" + ActivSpell.fieldRefs[0], "ActivSpellWin", "height=230,width=450,status=no,toolbar=no,menubar=no,location=no");	
			}
			ActivSpellWin.focus();	
		}
		
		function spellCheckComplete() {
			alert("Spell Check Complete!");
			
			ActivSpell.argsIndex = -1;
			nextField = function() {}
			ActivSpellWin.close();
		}
