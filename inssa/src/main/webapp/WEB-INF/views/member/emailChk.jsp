<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이메일 인증</title>
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
//셀렉트박스에 있는 이메일주소를 인풋창에 넣어줌
function checkMail() {
	var email_addr = $('#email_select').val();
	$("#email_addr").val(email_addr);
}

//이메일 인증시간 처리
var auth_time = "" ;
var auth_timer = "";
function timer() {	
	var auth_minite = parseInt(auth_time / 60);
	var auth_second = auth_time % 60;
	if(auth_second.toString().length < 2) {
		console.log("auth_second.length", auth_second.toString().length);
		auth_second = "0" + auth_second.toString();
		console.log("auth_second" , auth_second);
	}
	
	if(auth_time == 0) {
		stopTimer();
	}
	$("#auth_timer").html("유효시간 : " + auth_minite + ":" + auth_second) ;
	auth_time--;
}

function stopTimer() {
	clearInterval(auth_timer);
	is_email_auth = false;
}
var randomCode = "";

//이메일 중복체크 : 중복일시 true
is_email_overlap = true;

//이메일 중복체크 함수
function emailOverlapChk() {
	var email_name = $("#email_name").val();
	var email_addr = $("#email_addr").val();
	if (email_name == "" && email_addr == "") {
		$("#email_status_message").removeClass();
		$("#email_status_message").addClass("alert alert-warning");
		$("#email_status_message").html("이메일 주소를 입력하세요.");
		return;
	} else {
		var email = email_name + "@" + email_addr;
		var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		if (!emailReg.test(email)) {
			$("#email_status_message").removeClass();
			$("#email_status_message").addClass("alert alert-warning");
			$("#email_status_message").html("이메일 주소 형식이 올바르지 않습니다.");
			return;
		} else {
			$.ajax({
				url : "${path}/member/register_email_chk.do?email="+ email,
				type : "post",
				dataType : "json",
				success : function(d) {
					console.log(d);
					//가입되어 있으면 d 는 1
					if (d == 0) {
						is_email_overlap  = false;
						sendAuthCode(); 	
					} else {
						$("#email_status_message").removeClass();
						$("#email_status_message").addClass("alert alert-warning");
						$("#email_status_message").html("사용중인 이메일이 있습니다");
						return;
					}
				}, error : function(e) {

				}
			});
		}
	}
}

//이메일 중복체크 초기화
function resetOverlap() {
	/* emailChk = false; */
	is_email_overlap = true;
	is_email_auth = false;
	email_auth_opener.document.getElementById("overlap_msg").innerHTML = "중복확인이 필요합니다.";
/* 		$('#email_status_message').html("중복 확인이 필요합니다."); */
}

var ajax_running = false;
//인증코드 이메일 전송
function sendAuthCode() {
	if(ajax_running) {
		alert("처리 중 입니다.");
		return ;
	}
	ajax_running =  true;
	stopTimer();
	var email_name = $("#email_name").val();
	var email_addr = $("#email_addr").val();
	var total_email = email_name+ "@"+ email_addr;
	
	$.ajax({
		url : "sendMailAttach.do",
		type : "post",
		data : {email_id : total_email},
		dataType : "json",
		success : function(d) {
			ajax_running = false;
			console.log(d);
			if(d.sendChk == 1) {
				//인증번호
				randomCode = d.randomCode;
				$("#email_status_message").removeClass();
				$("#email_status_message").addClass("alert alert-success");
				$("#email_status_message").html("이메일로 인증코드가 전송되었습니다.");
				is_email_auth = true;
				
				
				var html = "<div class='bo12 size11'>";
				html += "<input class='sizefull s-text7 p-l-5' type='text' name='email_name' id='auth_code_text' placeholder='인증번호 입력'></div>";
				html += "<input type='button' class='btn btn-success' value='인증' onclick='compare_auth_code()' style='margin-left:10px;'>";
				$("#auth_code_div").html(html);
				//$("#auth_code_div").html("<input type=text id=auth_code_text class=form-control placeholder='인증번호 입력'' /><input type=button class='btn btn-success' value=인증 onclick=compare_auth_code()>");
				//인증 가능시간을 설정한다.
				auth_time = 60;
				//인증시간 함수를 1초마다 실행한다.
				auth_timer = setInterval(function(){timer()} , 1000);
			} else {
				alert("인증코드 전송이 실패하였습니다.");
			}
		},
		error : function(e) {
			console.log(e);
		}
	});
}

/* 180820 여기까지 작업함 */
//window.open 의 이메일 인증 버튼을 안눌렀을 시 
is_email_auth = false;
function compare_auth_code() {

	//window.open 의 이메일 인증을 하지 않았을 때 
	if(!is_email_auth) {
		alert("이메일 인증이 필요합니다.");
		return;
	}	
		
	var auth_code_text = $("#auth_code_text").val();
	
	if(auth_code_text == "") {
		alert("인증코드를 입력하세요.");
		return;
	} 
	//메일에 전송된 인증번호와 입력한 인증번호가 일치하면
	if(auth_code_text == randomCode) {
		//인증 유효시간이 유효하지 않을때
		if(auth_time == 0) {
			alert("인증시간이 유효하지 않습니다. 인증번호를 새로 발급받으세요.");
			return;
		} 
		//인증시간이 유효할때
		else {
			alert("인증에 성공하였습니다.");
			$('#email_type1').val($("#email_name").val());
			$('#email_type2').val($("#email_addr").val());
			stopTimer() ;
			$("#auth_timer").html();
			/* $("#email_auth_modal").modal("toggle"); */
		/* 	email_auth_opener.close(); */
			
	        opener.document.getElementById("email_type1").value = document.getElementById("email_name").value;
	        opener.document.getElementById("email_type2").value = document.getElementById("email_addr").value;
			window.close();
		}
	} 
	//메일에 전송된 인증번호와 입력한 인증번호가 일치하지 않으면
	else {
		alert("인증번호가 일치하지 않습니다. 인증번호를 확인하세요.");
		return;
	}
}
</script>
</head>
<body>

<div class="email_body">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<h3 class="m-t-60 m-b-20">이메일 인증</h3>
			<div class="row p-l-15">
				<div class="bo12 size11 m-b-20 col-md-3">
					<input class="sizefull s-text7 p-l-5" type="text" name="email_name" id="email_name" placeholder="이메일">
				</div>
				<div class="col-md-1 p-t-10">
					<span>@</span>
				</div>
				<div class="bo12 size11 m-b-20 col-md-4">
					<input class="sizefull s-text7 p-l-5" type="text" style="float: none" name="email_addr" id="email_addr" placeholder="이메일 주소">
				</div>								
				<div class="form-group col-md-4">
					<select class="form-control" id="email_select" name="email_select" onChange="checkMail()">
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
					<button class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" class="btn btn-success" onclick="emailOverlapChk()">
						인증번호 보내기
					</button>
				</div>
			</div>
			<div id="email_status_message" style="margin-top: 15px;"></div>
			<div class="form-inline">
				<div class="form-group" id="auth_code_div"></div>
			  	<div class="form-group p" id="auth_timer" style="margin-left: 15px;"></div>
			</div>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>


</body>
</html>