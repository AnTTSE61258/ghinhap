
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
	src="./resources/script/jquery-2.1.4.min.js"></script>
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
			src="./resources/img/lock.png" width="20px" height="20px" /> 
		<!-- Short link -->
		<input id="shortLinkcheckBox" type="checkbox" value="check-box" disabled="disabled" onchange="shortLinkCheckBoxOnchange()"/>Rút gọn link	
			
			
			
			<select
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
	
	<div id="buttonRedirectNow" hidden="true">
		<input type="button" value="Chuyển link" onclick="redirectLink()"/>
	</div>
	
	<div id="loading">
		<img alt="Loading..." src="./resources/img/loading.gif"/>
	</div>
	
	
	<!-- Short link -->
	<script>
		function shortLinkCheckBoxOnchange(){
			var isCheck = $('#shortLinkcheckBox').prop("checked");
			if(isCheck){
				if ('${isLock}'==='false') {
					var retVal = prompt("Nhập mật khẩu để thực hiện rút gọn link");
					if (retVal == null || retVal == '') {
						$('#shortLinkcheckBox').prop('checked',false);
						return;
					}
					$.ajax({
						type : "POST",
						url : "ajax/setpasswordAndMakeShortLink",
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
					alert('Bạn không thể tạo short link khi ghi chú còn đang khóa. Err: 01');	
				}
				
			}else{
				$.ajax({
					type : "POST",
					url : "ajax/unsetShortLink",
					data : {
						noteid : '${noteid}'
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
			}
				
		}
	
		function checkUrl() {
			return true;
		}

		function redirectLink() {
			if('${isShortLink}'==='false'){
				return;
			}
			
			
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
