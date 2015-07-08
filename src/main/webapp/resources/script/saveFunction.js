/**
 * 
 */
		$.ctrl = function(key, callback, args) {
		    var isCtrl = false;
		    $(document).keydown(function(e) {
		        if(!args) args=[]; 
		        if(e.ctrlKey) isCtrl = true;
		        if(e.keyCode == key.charCodeAt(0) && isCtrl) {
		            callback.apply(this, args);
		            return false;
		        }
		    }).keyup(function(e) {
		        if(e.ctrlKey) isCtrl = false;
		    });        
		};
		$.ctrl('S',function(){
			window.clearInterval(intervalId);
			intervalId = (setTime(1000));
		});