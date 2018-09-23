<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/head.jsp"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
var idChk, pwChk, nameChk, addrChk, emailChk, phoneChk = false;
function submitChk() {
	var datail_addr = $('#datail_addr').val();

	if (datail_addr != "") {
		addrChk = true;
	}
	
	if($('#email_type1').val() == "" && $('#email_type2').val() == "" ) {
		alert("이메일 인증이 필요합니다.");
		return false;
	} else if(!idChk) {
		alert("아이디를 확인하세요.");
		return false;
	} else if(!pwChk) {
		alert("비밀번호를 확인하세요.");
		return false;
	} else if(!nameChk) {
		alert("이름을 확인하세요.");
		return false;
	} else if(!addrChk) {
		alert("주소를 확인하세요.");
		return false;
	} else if(!phoneChk) {
		alert("연락처를 확인하세요.");
		return false;
	}
	return true;
}

$(function() {
	
	$("#btnPostCode").click(
		function() {
			new daum.Postcode({
				oncomplete : function(data) {
					if (data.buildingName == "") {
						form1.addr.value = data.address;
					} else {
						form1.addr.value = data.address + " (" + data.buildingName + ")";
					}
					form1.postcode.value = data.zonecode;
					form1.detail_address.focus();
				}
			}).open();
		});
	});

	function checkMail() {
		var email_addr = $('#email_select').val();
		$("#email_addr").val(email_addr);
	}

	function validateId() {
		var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;
		if (!idReg.test($('#member_id').val())) {
			$("#id_status_message").removeClass();
			$("#id_status_message").addClass("alert alert-warning");
			$('#id_status_message').html("영문자로 시작하는 6~20자 영문자 또는 숫자로 입력하세요."); 
					 
			idChk = false;
			return false;
		} else {
			$("#id_status_message").removeClass();
			$("#id_status_message").addClass("alert alert-success");
			$('#id_status_message').html("사용 가능한 아이디 형식입니다."); 
			idChk = false;
 			return true;
		}
	}
	
	function idOverlapChk() {
		var member_id = $('#member_id').val();
		
		var validId = validateId();
		if (validId) {
			$.ajax({
				url : "${path}/member/register_id_chk.do?member_id=" + member_id,
				type : "post",
				dataType : "json",
				success : function(d) {
					//console.log(d);
				 	var $toastContainer = $('#toast-container');
					var $errorToastr = $toastContainer.find('.toast-success');
				
					//가입되어 있으면 d 는 1
					if (d == 0) {
						$("#id_status_message").removeClass();
						$("#id_status_message").addClass("alert alert-success");
						$('#id_status_message').html("사용 가능한 아이디 입니다.");
						
						idChk = true;
					} else {
						$("#id_status_message").removeClass();
						$("#id_status_message").addClass("alert alert-warning");
						$('#id_status_message').html("중복된 아이디가 있습니다.");
						idChk = false;
					}
				}, error : function(e) {

				}
			});
		} else {
			$("#id_status_message").removeClass();
			$("#id_status_message").addClass("alert alert-warning");
			$('#id_status_message').html("아이디 형식을 확인하세요.");
		}
	}
	
	//비밀번호 유효성 체크
	function pwPattern() {
		var regExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}/;
		/* 	var regExp = /^[a-z0-9_]{4,12}$/; */
		if (!regExp.test($('#passwd').val())) {
			$("#pw_status_message").removeClass();
			$("#pw_status_message").addClass("alert alert-warning");
			$('#pw_status_message').html("6-16자리 영문, 숫자, 특수문자 조합으로 입력하세요.");
			pwChk = false;
			return false;
		} else {
			$("#pw_status_message").removeClass();
			$("#pw_status_message").addClass("alert alert-success");
			$('#pw_status_message').html("사용 가능한 비밀번호 형식입니다.");
			pwChk = false;
			return true;
		}
	}

	//비밀번호 재입력 확인
	function chkMatchingPw() {
		var temp_pw = $('#passwd_check').val();
		var origin_pw = $('#passwd').val();

		var regExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}/;

		if (!regExp.test(temp_pw)) {
			$("#pw_chk_status_message").removeClass();
			$("#pw_chk_status_message").addClass("alert alert-warning");
			$('#pw_chk_status_message').html("6-16자리 영문, 숫자, 특수문자 조합으로 입력하세요.");
		} else {
			if (temp_pw != origin_pw) {
				$("#pw_chk_status_message").removeClass();
				$("#pw_chk_status_message").addClass("alert alert-warning");
				$('#pw_chk_status_message').html("비밀번호가 일치하지 않습니다.");
				pwChk = false;
			} else {
				$("#pw_chk_status_message").removeClass();
				$("#pw_chk_status_message").addClass("alert alert-success");
				$('#pw_chk_status_message').html("비밀번호가 일치합니다.");
				pwChk = true;
			}
		}
	}

	//이름 유효성 체크
	function validateName() {
		var pattern = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
		if (!pattern.test($('#name').val())) {
			$("#name_status_message").removeClass();
			$("#name_status_message").addClass("alert alert-warning");
			$('#name_status_message').html("한글은 2 ~ 4글자(공백 없음) , 영문은 Firstname(2 ~ 10글자) (space) Lastname(2 ~10글자)로 입력해 주세요.");
			nameChk = false;
		} else {
			$("#name_status_message").removeClass();
			$("#name_status_message").addClass("alert alert-success");
			$('#name_status_message').html("사용가능한 형식입니다.");
			nameChk = true;
		}
	}
	
	//휴대폰번호 유효성 체크
	function validatePhone() {
		var regExp = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;

		if (!regExp.test($('#phone').val())) {
			$("#phone_status_message").removeClass();
			$("#phone_status_message").addClass("alert alert-warning");
			$('#phone_status_message').html("휴대폰 번호 형식이 올바르지 않습니다.");
			phoneChk = false;
		} else {
			$("#phone_status_message").removeClass();
			$("#phone_status_message").addClass("alert alert-success");
			$('#phone_status_message').html("사용 가능한 휴대폰 번호입니다.");
			phoneChk = true;
		}
	}
	
	//월별 날짜 구하기
	function fn_DayOfMonth() {
		var year = $('#birth_year').val();
		var month = $('#birth_month').val();
	    //month 는 0 부터 시작해서..
	    if(month != "") {
	    var day =  32 - new Date(year, month-1, 32).getDate();
	        $("#birth_day").empty();
	    	for(var i = 1; i <= day ; i++ ) {
	    		$('#birth_day').append("<option value="+ i +">" + i + "</option>");
	    	}
	    }
	}

	//주소 입력 확인
	function addrEmptyChk() {
		var postCode = $('#postcode').val();
		var addr = $('#addr').val();

		if (postCode != "" && addr != "") {
			return;
		} else {
			$('#datail_addr').blur();
			$('#btnPostCode').trigger('click');
		}
	}

	var auth_time = "" ;
	var auth_timer = "";
	
	//이메일 인증시간 처리
	function timer() {	
		//시간:분
		var auth_minite = parseInt(auth_time / 60);
		//시간:초
		var auth_second = auth_time % 60;
		
		if(auth_second.toString().length < 2) {
			//console.log("auth_second.length", auth_second.toString().length);
			auth_second = "0" + auth_second.toString();
			//console.log("auth_second" , auth_second);
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
						//console.log(d);
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
				//console.log(d);
				if(d.sendChk == 1) {
					//인증번호
					randomCode = d.randomCode;
					$("#email_status_message").removeClass();
					$("#email_status_message").addClass("alert alert-success");
					$("#email_status_message").html("이메일로 인증코드가 전송되었습니다.");
					is_email_auth = true;
					
					var auth_code = "<div class='row m-b-20'><div class='bo12 size16 col-md-8'>";
					auth_code += "<input class='form-control sizefull s-text7 p-l-18 p-r-18' id='auth_code_text' placeholder='인증번호 입력'></div>";
					auth_code += "<div class='col-md-3 m-l-10 m-t-5'>";
					auth_code += "<input type='button' class='btn btn-success' value='인증' onclick='compare_auth_code()'></div></div>";
					
					$("#auth_code_div").html(auth_code);
					//인증 가능시간을 설정한다.
					auth_time = 60;
					//인증시간 함수를 1초마다 실행한다.
					auth_timer = setInterval(function(){timer()} , 1000);
				} else {
					alert("인증코드 전송이 실패하였습니다.");
				}
			},
			error : function(e) {
				//console.log(e);
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
			$("#email_auth_modal").modal("toggle");
		/* 	email_auth_opener.close(); */
		}
	} else {
		 alert("인증번호가 일치하지 않습니다. 인증번호를 확인하세요.");
		 return;
	}
}
</script>
</head>
<body>
<%@ include file="../include/header_menu.jsp"%>

<div id="member_info_div">
	<form name="form1" method="post" action="${path}/member/signUp.do" onsubmit="return submitChk()">
		<section class="register-block">
  			<div class="container">
				<div class="row">
					<div class="col-md-3"></div>
					<div class="col-md-6 m-t-60 m-b-60">
						<div id="personalInfo">
							<h2 class="text-center">개인정보</h2>
						
							<hr style="border-top-width: 2px; padding-top: 10px;">
							
							<div class="form-group">
							    <label for="exampleInputName1" class="text-uppercase">아이디</label>
							    <div class="bo12 size16 m-b-20">
									<input class="form-control sizefull s-text7 p-l-18 p-r-18" id="member_id" name="member_id" onblur="idOverlapChk()" onkeyup="validateId()" placeholder="아이디를 입력하세요.">
								</div>
							</div>
							<div id="id_status_message"></div>
							
							<div class="form-group">
							    <label for="exampleInputAddress1" class="text-uppercase">비밀번호</label>
							    <div class="bo12 size16 m-b-20">
									<input type="password" class="form-control sizefull s-text7 p-l-18 p-r-18" id="passwd" name="passwd" onkeyup="pwPattern()" placeholder="비밀번호를 입력하세요.">
								</div>
							</div>
							<div id="pw_status_message"></div>
							
							<div class="form-group">
							    <label for="exampleInputAddress2" class="text-uppercase">비밀번호 확인</label>
							    <div class="bo12 size16 m-b-20">
									<input type="password" class="form-control sizefull s-text7 p-l-18 p-r-18" id="passwd_check" name="passwd_check" onkeyup="chkMatchingPw()" placeholder="비밀번호를 입력하세요.">
								</div>
							</div>
							<div id="pw_chk_status_message"></div>
							  
							<div class="form-group">
							    <label for="exampleInputTown1" class="text-uppercase">이름</label>
							    <div class="bo12 size16 m-b-20">
									<input class="form-control sizefull s-text7 p-l-18 p-r-18" type="text" name="name" id="name" onkeyup="validateName()" placeholder="이름을 입력하세요.">
								</div>
								<div id="name_status_message"></div>
								
								<div class="form-group">
								    <label for="exampleInputCountry1" class="text-uppercase" style="display : block">생년월일</label>
								    <select id="birth_year" name="birth_year" class="form-control"  style="display : inline ; width : 32%">
										<c:set var="now" value="<%=new java.util.Date()%>" />
										<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
										<c:forEach var="i" begin="${sysYear - 80 }" end="${sysYear }" varStatus="status">
						 					<c:set var="yearOption" value="${sysYear- status.count + 1}" />
											<option value="${yearOption}" <c:if test="${status.count -1 eq 0 }">selected="selected"</c:if>>${yearOption }</option>
										</c:forEach>
									</select>
									<select id="birth_month" name="birth_month" onchange="fn_DayOfMonth()"  class="form-control"  style="display : inline ; width : 32%">
										<c:forEach var="i" begin="1" end="12">
										<option value="${i }" <c:if test="${ i eq 1 }">selected="selected"</c:if>>${i }</option>
										</c:forEach>
									</select>
									<select id="birth_day" name="birth_day"  class="form-control"  style="display : inline ; width : 32%">
										<c:forEach var="i" begin="1" end="31" varStatus="status">
										<option value="${i }">${i }</option>
										</c:forEach>
	    							</select>
								</div>
								<div id="birth_status_message"></div>
								
								<div class="form-group">
									<label for="exampleInputPostCode1" class="text-uppercase m-r-50">성별</label>
									<div class="form-check-inline">
										<label class="customradio">
											<span class="radiotextsty">남</span>
											<input type="radio" id="male" name="gender" value="M" checked="checked">
											<span class="checkmark"></span>
										</label>        
										<label class="customradio">
											<span class="radiotextsty">여</span>
											<input type="radio" id="female" name="gender" value="F">
											<span class="checkmark"></span>
										</label>
									</div>
								</div>
								<div id="gender_status_message"></div>
								
								<div class="form-group" style="display:inline;">
	        						<label for="exampleInputPassword1" class="text-uppercase">우편번호</label>
	        						<div class="row p-l-15 p-r-15">
										<div class="bo12 size16 m-b-20 col-md-5">
											<input class="sizefull s-text7 p-l-18 p-r-18" type="text" name="postcode" id="postcode" size="2" readonly="readonly" placeholder="우편번호 찾기를 선택하세요.">
										</div>
										<div class="w-size24 col-md-4">
											<span class="input-group-addon flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" id="btnPostCode">
												우편번호 찾기
											</span>
										</div>
									</div>
	        					</div>
								<div class="form-group">
									<label for="exampleInputPassword1" class="text-uppercase">주소</label>
									<div class="bo12 size16 m-b-20">
										<input class="sizefull s-text7 p-l-18 p-r-18" type="text" name="addr" id="addr" placeholder="주소" readonly="readonly">
									</div>
								</div>
								<div class="form-group">
								    <label for="exampleInputPassword1" class="text-uppercase">상세주소</label>
								    <div class="bo12 size16 m-b-20">
										<input class="form-control sizefull s-text7 p-l-18 p-r-18" type="text" name="detail_addr" id="datail_addr" placeholder="상세주소" onfocus="addrEmptyChk()">
									</div>
								</div>
								
	  							<div class="form-group" style="display:inline;">
									<label for="exampleInputPassword1" class="text-uppercase">이메일</label>
									<div class="row p-l-15 p-r-15">
										<div class="bo12 size11 m-b-20 col-md-3">
											<input class="sizefull s-text7 p-l-5" type="text" name="email_type1" id="email_type1" placeholder="이메일"  onkeyup="resetOverlap()" readonly="readonly">
										</div>
										<div class="col-md-1 p-t-10">
											<span>@</span>
										</div>
										<div class="bo12 size11 m-b-20 col-md-4">
											<input class="sizefull s-text7 p-l-5" type="text" style="float: none" name="email_type2" id="email_type2" placeholder="이메일 주소" readonly="readonly">
										</div>								
										<div class="col-md-4">
											<div class="w-size21">
												<span class="input-group-addon flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" id="emailAuthBtn" data-toggle="modal" data-target="#email_auth_modal">
													이메일 인증
												</span>
											</div>
										</div>
									</div>
								</div>
						
								<div class="form-group">
									<label for="exampleInputPassword1" class="text-uppercase">연락처</label>
									<div class="bo12 size16 m-b-20">
										<input class="form-control sizefull s-text7 p-l-18 p-r-18" type="text" name="phone" id="phone" placeholder="'-' 없이 입력하세요" onkeyup="validatePhone()">
									</div>
								</div>
								<div id="phone_status_message"></div>
								
								<div class="form-check m-t-30">
									<div class="row">
										<div class="col-md-8"></div>
										<div class="col-md-4">
											<button type="submit" class="btn btn-register float-right flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" style="background-color: #E65540;">회원가입</button>
										</div>
									</div>
								</div>				  
							</div>
						</div>
					</div>
					<div class="col-md-3"></div>
				</div>
			</div>
		</section>

		<div id="email_auth_modal" class="modal fade" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">이메일 인증</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<div class="row form-inline m-b-20">
							<div class="bo12 size11 m-l-40 col-md-2">
								<input class="sizefull s-text7 p-l-5" type="text" name="email_name" id="email_name" placeholder="이메일">
							</div>
							<div style="text-align: center;">
								<span>&nbsp;&nbsp;&nbsp;@&nbsp;&nbsp;&nbsp;</span>
							</div>
							<div class="bo12 size11 col-md-2">
								<input class="sizefull s-text7" type="text" style="float: none" name="email_addr" id="email_addr" placeholder="이메일 주소">
							</div>								
							<div class="form-group col-md-3 p-l-20">
								<select class="form-control" id="email_select" name="email_select" onChange="checkMail()">
									<option value=""  selected="selected">직접 입력</option>
									<option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="nate.com">nate.com</option>
								</select>
							</div>
							<div class="w-size21 col-md-3">
								<button type="button" class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" class="btn btn-success" onclick="emailOverlapChk()">
									인증번호 보내기
								</button>
							</div>
						</div>
						<div id="email_status_message"></div>
						<div class="row form-inline p-l-40">
							<div class="form-group col-md-6" id="auth_code_div"></div>
							<div class="form-group col-md-3" id="auth_timer" style="padding-bottom: 20px; padding-left: 0px;"></div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>	


<%@ include file="../include/body_footer.jsp"%>
</body>

</html>