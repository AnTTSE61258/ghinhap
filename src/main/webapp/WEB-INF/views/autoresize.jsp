
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Ghi nháp</title>
<link rel="stylesheet" type="text/css" href="./resources/css/custom.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<script src="./resources/src/ace.js"></script>
<script type="text/javascript" src="./resources/script/setInputColor.js"></script>
<script type="text/javascript" src="./resources/script/shortcut.js"></script>
<script type="text/javascript" src="./resources/script/functions.js"></script>
<script type="text/javascript"
	src="./resources/src/ext-language_tools.js"></script>

</head>
<body>
	<div id="headdiv">
		<div class="input-color">
			<div class="color-box" style="background-color: #FF850A;"></div>
		</div>
		<img id="imglock" onclick="lockClick()" alt="lock"
			src="./resources/img/unlock.png" width="20px" height="20px" /> <img
			id="imgUnlock" onclick="unLockClick()" alt="unlock"
			src="./resources/img/lock.png" width="20px" height="20px" /> <select
			id="typeSelector" onchange="typeChange()">
			<option value="0">Text-default</option>
			<option value="1">HTML</option>
			<option value="2">Java</option>
			<option value="3">C#</option>
			<option value="4">Objective-C</option>
			<option value="5">Javascript</option>
		</select>
	</div>
	<!-- Editor -->
	<pre id="editor"></pre>
	<!-- Short link -->
	<input id="shortLinkcheckBox" type="checkbox" value="check-box" disabled="disabled" onchange="shortLinkCheckBoxOnchange()"/>Rút gọn link
	<div id="loading">
		<img alt="Loading..." src="./resources/img/loading.gif"/>
	</div>
	
	<!-- Short link -->
	<script>
		function shortLinkCheckBoxOnchange(){
			var isCheck = $('#shortLinkcheckBox').prop("checked");
			if(isCheck){
				if ('${isLock}'==='false') {
					var retVal = prompt("Enter your password");
					if (retVal == null || retVal == '') {
						return;
					}
					alert()
					$.ajax({
						type : "POST",
						url : "ajax/setpassword",
						data : {
							noteid : '${noteid}',
							password : retVal

						},
						success : function(data) {
							if (data !== "true") {
								alert(data);
							}
							location.reload();
						},
						error : function(data) {
							alert("Request lock fail. Please try again.")
						}
					});
				}else{
					alert('request tp emter password to confirm');	
				}
				
			}
				
		}
	
		function checkUrl() {
			return true;
		}

		function redirectLink() {
			var url = '${contents}';
			if (checkUrl == false) {
				return;
			}
			$("#loading").show();
			setTimeout(function() {
				window.location.href = url;
			}, 20000);
		}
	</script>
	<script>
		//set up for editor
		var isFirst = true;
		var editor = ace.edit("editor");
		var intervalId;
		editorInit(editor);
		//set up when document ready
		$(document).ready(function() {
			$("#loading").hide();
			setInitParam('${contents}', '${type}', '${isLock}', '${isShortLink}');
			if ('{isShortlink}') {
				redirectLink();
			}
			
		});
		$.sendContentToServer = function sendContentToServer() {
			var type = document.getElementById('typeSelector').value;
			requestUpdateContent(editor.getValue(), '${noteid}', type);
			window.clearInterval(intervalId);
		}

		function lockClick() {
			requestLock('${noteid}');
		}
		function unLockClick() {
			requestUnlock('${noteid}');
		}
	</script>


</body>
</html>
