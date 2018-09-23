<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 찾기</title>
<%@ include file="../include/head.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
	<link rel="icon" type="image/png" href="${path}/images/icons/favicon.png"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/fonts/themify/themify-icons.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/fonts/elegant-font/html-css/style.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/animate/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/slick/slick.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/lightbox2/css/lightbox.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/css/util.css">
	<link rel="stylesheet" type="text/css" href="${path}/css/main.css">
<!--===============================================================================================-->
<script>
function checkMail() {
	var email_addr = $('#email_select').val();
	$("#child_email_type2").val(email_addr);
}

var auth_time = "" ;
var auth_timer = "";
function timer() {	
	$(".auth_timer").remove();
	var auth_minite = parseInt(auth_time / 60);
	var auth_second = auth_time % 60;
	
	if(auth_second.toString().length < 2) {
		auth_second = "0" + auth_second.toString();
	}
	
	if(auth_time == 0) {
		stopTimer();
		is_email_auth = false;
	}
	$("#auth_timer").append("<div class='auth_timer m-l-20'>" + auth_minite + ":" + auth_second + "</div>");
	auth_time--;
}

function stopTimer() {
	clearInterval(auth_timer);
	if(auth_time == 0)  {
		is_email_auth = false;
	}
}

/* 이메일인증 */
var randomCode = "";
var ajax_running  = false;
function email_auth(type) {
	var email1 = document.getElementById("child_email_type1").value;
	var email2 = document.getElementById("child_email_type2").value;
	
	if(email1 != "" && email2 != "") {
		var email  = email1 + "@" + email2;
		if(ajax_running) {
			alert("인증번호 전송중입니다.");
			return;
		}
		ajax_running = true;
		$.ajax({
			url : "${path}/member/sendMailAttach.do",
			type : "post",
			data : {"email_id" : email, "type" : type},
			dataType : "json",
			success : function(d) {
				ajax_running = false;
				//console.log(d);
				if(d.exist == 0) {
					alert("등록된 이메일이 없습니다.");
					return;
				}
				if(d.sendChk == 1) {
					//인증번호
					randomCode = d.randomCode;
					alert("인증코드가 전송되었습니다. 전송된 인증코드를 확인하세요.");
					is_email_auth = true;
					var auth_code_input = "<div class='bo12 size11 m-b-20 col-md-3'>";
					auth_code_input += "<input class='sizefull s-text7 p-l-5' type='text' name='auth_code_text' id='auth_code_text' placeholder='인증번호를 입력하세요'></div>";
					auth_code_input += "<div class='w-size22 m-l-10'>";
					auth_code_input += "<button type='button' class='flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4' class='btn btn-success' onclick='compare_auth_code()'>";
					auth_code_input += "인증</button></div>";
					
					$("#auth_timer").before(auth_code_input);
					
					//인증 가능시간을 설정한다.
					auth_time = 60;
					//인증시간 함수를 1초마다 실행한다.
					stopTimer() ;
					auth_timer = setInterval(function(){timer()} , 1000);
				} else {
					alert("인증코드 전송이 실패하였습니다.");
				}
			}, error : function(e) {
				//console.log(e);
			}
		});
	} else {
		alert("이메일을 정확히 입력하세요.");
	}
}

/* 인증버튼 */
var is_email_auth = false;
function compare_auth_code() {
	if(!is_email_auth) {
		alert("이메일 인증이 필요합니다.");
		return;
	}	
	
	var child_auth_code = $("#auth_code_text").val();	
	if(child_auth_code == "") {
		alert("인증코드를 입력하세요.");
		return;
	} 
	
	if(child_auth_code == randomCode) {
		if(auth_time == 0) {
			alert("인증시간이 유효하지 않습니다. 인증번호를 새로 발급받으세요.");
			return;
		}else {
			alert("인증에 성공하였습니다.");
			stopTimer() ;
			
			$(".auth_timer").remove();			
			
			var email1 = $("#child_email_type1").val();
			var email2 = $("#child_email_type2").val();
			var email  = email1 + "@" + email2;
			
			$(".child_opener").css('display', 'none');
			
			var pwd_input = "<h3 class='m-t-60 m-b-20'>비밀번호 찾기</h3><div class='bo12 size11 m-b-20'>";
			pwd_input += "<input class='sizefull s-text7 p-l-5' type='password' name='passwd' id='passwd' onkeyup='pwPattern()' placeholder='비밀번호'>";
			pwd_input += "<span id='pw_status_message' class='m-t-5' style='font-size: 0.8em; color: #312f2f;'></span></div><div class='bo12 size11 m-b-20'>";
			pwd_input += "<input class='sizefull s-text7 p-l-5' type='password' name='passwd_check' id='passwd_check' onkeyup='chkMatchingPw()' placeholder='비밀번호 확인'>";
			pwd_input += "<span id='pw_chk_status_message' class='m-t-5' style='font-size: 0.8em; color: #312f2f;'></span></div><div class='w-size21'>";
			pwd_input += "<button type='button' id='email_overlap_btn' class='flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4' class='btn btn-success' onclick='modifyPwd()'>";
			pwd_input += "변경하기</button></div>";
			
			$("#modify_pwd_area").append(pwd_input);
		}
	}else {
		 alert("인증번호가 일치하지 않습니다. 인증번호를 확인하세요.");
		 return;
	}
}

//비밀번호 유효성 체크 변수(true : 체크 완료)
var pwChk = false;

//비밀번호 유효성 체크
function pwPattern() {
	var regExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}/;
	/* 	var regExp = /^[a-z0-9_]{4,12}$/;
	 */
	 var pwd =  document.getElementById("passwd").value;
	 if (!regExp.test(pwd)) {
		 document.getElementById("pw_status_message").innerHTML = "6-16자리 영문, 숫자, 특수문자 조합으로 입력하세요.";
		pwChk = false;
		return false;
	} else {
		document.getElementById("pw_status_message").innerHTML = "사용이 가능합니다.";
		pwChk = false;
		return true;
	}
}

//비밀번호 재입력 확인
function chkMatchingPw() {
	var temp_pw = document.getElementById("passwd_check").value;
	var origin_pw = document.getElementById("passwd").value;

	var regExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}/;

	if (!regExp.test(temp_pw)) {
		document.getElementById("pw_chk_status_message").innerHTML = "비밀번호를 확인하세요";
	} else {
		if (temp_pw != origin_pw) {
			document.getElementById("pw_chk_status_message").innerHTML = "비밀번호가 일치하지 않습니다.";
			pwChk = false;
		} else {
			document.getElementById("pw_chk_status_message").innerHTML = "비밀번호가 일치합니다.";
			pwChk = true;
		}
	}

}

//이메일로 비밀번호 변경 
function modifyPwd() {
	if(!pwChk) {
		alert("비밀번호를 확인하세요.");
		return;
	} else {
		var email1 = document.getElementById("child_email_type1").value;
		var email2 = document.getElementById("child_email_type2").value;
		var pwd = document.getElementById("passwd").value;
		var email  = email1 + "@" + email2;
			
		$.ajax({
			url : "modifyPwdByEmail",
			type : "post",
			data : {"email" : email, "pwd" :  pwd},
			success : function(d) {
				alert("비밀번호가 변경되었습니다.");
				close();
				is_email_auth = false;
				pwChk = false;
			}, error : function(e) {
				//console.log(e);
			}
		});
	}
}
</script>
</head>
<body>

<div class="passwdFind">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<div class="child_opener">
				<h3 class="m-t-60 m-b-20">비밀번호 찾기</h3>
				<div class="row p-l-15">
					<div class="bo12 size11 m-b-20 col-md-3">
						<input class="sizefull s-text7 p-l-5" type="text" name="child_email_type1" id="child_email_type1" placeholder="이메일">
					</div>
					<div class="col-md-1 p-t-10">
						<span>@</span>
					</div>
					<div class="bo12 size11 m-b-20 col-md-4">
						<input class="sizefull s-text7 p-l-5" type="text" style="float: none" name="child_email_type2" id="child_email_type2" placeholder="이메일 주소">
					</div>								
					<div class="form-group col-md-4">
						<select class="form-control" id="email_select" name="email_select" onChange="checkMail();">
							<option value=""  selected="selected">직접 입력</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
						</select>
					</div>
				</div>	
				<div style="text-align: center">
					<div class="w-size21">
						<button type="button" id="email_overlap_btn" class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" class="btn btn-success" onclick="email_auth()">
							이메일 인증
						</button>
					</div>
				</div>
				<div id="auth_code_div" class="row m-t-30 p-l-15">
					
					<div id="auth_timer">
						<span class="auth_timer"></span>
					</div>
				</div>
			</div>
			<div id="modify_pwd_area"></div>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>
</body>
</html>