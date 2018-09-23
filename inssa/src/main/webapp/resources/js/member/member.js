//비밀번호 유효성 체크
	function pwPattern() {
		var regExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}/;
		/* 	var regExp = /^[a-z0-9_]{4,12}$/;
		 */if (!regExp.test($('#passwd').val())) {
			$('#pw_status_message').html("6-16자리 영문, 숫자, 특수문자 조합으로 입력하세요.");
			pwChk = false;
			return false;
		} else {
			$('#pw_status_message').html("사용이 가능합니다.");
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
			$('#pw_chk_status_message').html("비밀번호를 확인하세요");
		} else {
			if (temp_pw != origin_pw) {
				$('#pw_chk_status_message').html("비밀번호가 일치하지 않습니다.");
				pwChk = false;
			} else {
				$('#pw_chk_status_message').html("비밀번호가 일치합니다.");
				pwChk = true;
			}
		}

	}
	
	//이름 유효성 체크
	function validateName() {

		var pattern = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
		if (!pattern.test($('#name').val())) {
			$('#name_status_message')
					.html(
							"한글은 2 ~ 4글자(공백 없음) , 영문은 Firstname(2 ~ 10글자) (space) Lastname(2 ~10글자)로 입력해 주세요.");
			nameChk = false;
		} else {
			$('#name_status_message').html("사용가능한 형식입니다.");
			nameChk = true;
		}
	}
	
	//월별 날짜 구하기
	function fn_DayOfMonth()
	{
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
	
	//이메일 중복체크 초기화
	function resetOverlap() {
		/* emailChk = false; */
		is_email_overlap = true;
		is_email_auth = false;
		email_auth_opener.document.getElementById("overlap_msg").innerHTML = "중복확인이 필요합니다.";
/* 		$('#email_status_message').html("중복 확인이 필요합니다."); */
	}
	
var email_auth_opener = "";


//회원가입 이메일 인증
function emailAuth() {
		
		if(!email_auth_opener.closed && email_auth_opener) {
			alert("같은 창이 이미 떠있습니다.");
			return;
		}
			
			
			var email_input = '	<input name="child_email_type1" id="child_email_type1" placeholder="이메일" onkeyup="window.opener.resetOverlap()"> @ <input name="child_email_type2" id="child_email_type2" placeholder="이메일 주소" onkeyup="window.opener.resetOverlap()">';
			      email_input += '<select name="email_select" onChange="checkMail()">';
			      email_input += '<option value="" selected>직접 입력</option><option value="naver.com">naver.com</option><option value="gmail.com">gmail.com</option><option value="hanmail.net">hanmail.net</option><option value="nate.com">nate.com</option></select> ';
			      email_input +='<input type="button" id="email_overlap_btn" value="중복확인" onclick="window.opener.emailOverlapChk()"/>';
			email_auth_opener = window.open("", "이메일인증" , "width=800,height=300");
			email_auth_opener.document.clear();
			email_auth_opener.document.write(email_input );
		    email_auth_opener.document.write("<span id='overlap_msg'></span>");
			email_auth_opener.document.write("<div id='email_auth_div'><input type='button' style='width: 50%' value='이메일 인증' id='email_overlap_btn' onclick='window.opener.sendAuthCode()'/>");
			email_auth_opener.document.write("<span id='auth_code_div'><input type=text id=auth_code_text placeholder=인증번호 /><input type=button value=인증 onclick=window.opener.compare_auth_code()></span></div>");
			email_auth_opener.document.write("<div id='auth_timer'></div>");
			

		
	}



var ajax_running = false;
//인증코드 이메일 전송
function sendAuthCode() {
	email_auth_opener.alert(ajax_running);
	if(ajax_running) {
		email_auth_opener.alert("처리 중 입니다.");
		return ;
	}
	
	ajax_running =  true;
	//중복된 이메일이 있거나 중복체크를 안했을 시 
	if(is_email_overlap) {
		email_auth_opener.alert("이메일 중복확인을 하세요");
		return;
	}
	stopTimer();
	var child_email1 = email_auth_opener.document.getElementById("child_email_type1").value;
	var child_email2 = email_auth_opener.document.getElementById("child_email_type2").value;
	
	var total_email = child_email1+ "@"+ child_email2;
	
	$.ajax({
		url : "sendMailAttach.do",
		type : "post",
		data : {email_id : total_email
			
		},
		dataType : "json",
		success : function(d) {
			ajax_running = false;
			console.log(d);
			if(d.sendChk == 1) {
				//인증번호
				randomCode = d.randomCode;
				 email_auth_opener.alert("인증코드가 전송되었습니다. 전송된 인증코드를 확인하세요.");
				is_email_auth = true;
				var auth_code_input   = "<input type=text id=auth_code_text placeholder=인증번호를 입력하세요. /><input type=button value=인증 onclick=window.opener.compare_auth_code()>";
				email_auth_opener.document.getElementById("auth_code_div").innerHTML =auth_code_input;
				//인증 가능시간을 설정한다.
				auth_time = 60;
				//인증시간 함수를 1초마다 실행한다.
				auth_timer = setInterval(function(){timer()} , 1000);
			} else {
				email_auth_opener.alert("인증코드 전송이 실패하였습니다.");
			}
		},
		error : function(e) {
			console.log(e);
		}
	});
	
}

//window.open 의 이메일 인증 버튼을 안눌렀을 시 
var is_email_auth = false;
function compare_auth_code() {

//window.open 의 이메일 인증을 하지 않았을 때 
if(!is_email_auth) {
	email_auth_opener.alert("이메일 인증이 필요합니다.");
	return;
}	
	
var child_auth_code = email_auth_opener.document.getElementById("auth_code_text").value;

if(child_auth_code == "") {
	email_auth_opener.alert("인증코드를 입력하세요.");
	return;
} 
//메일에 전송된 인증번호와 입력한 인증번호가 일치하면
 if(child_auth_code == randomCode) {
	//인증 유효시간이 유효하지 않을때
	if(auth_time == 0) {
		email_auth_opener.alert("인증시간이 유효하지 않습니다. 인증번호를 새로 발급받으세요.");
		return;
	} 
	//인증시간이 유효할때
	else {
		email_auth_opener.alert("인증에 성공하였습니다.");
		$('#email_type1').val(email_auth_opener.document.getElementById("child_email_type1").value);
		$('#email_type2').val(email_auth_opener.document.getElementById("child_email_type2").value);
		stopTimer() ;
		email_auth_opener.document.getElementById("auth_timer").innerHTML = "";
		email_auth_opener.close();
		
	}
} 
 //메일에 전송된 인증번호와 입력한 인증번호가 일치하지 않으면
 else {
	 email_auth_opener.alert("인증번호가 일치하지 않습니다. 인증번호를 확인하세요.");
	 return;
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
		console.log("auth_second.length", auth_second.toString().length);
		auth_second = "0" + auth_second.toString();
		console.log("auth_second" , auth_second);
	}
	
	if(auth_time == 0) {
		stopTimer();
	}
	email_auth_opener.document.getElementById("auth_timer").innerHTML =auth_minite + ":" + auth_second ;
	auth_time--;
}


//타이머 멈추기
function stopTimer() {
	clearInterval(auth_timer);
	is_email_auth = false;
}
var randomCode = "";

//이메일 중복체크 : 중복일시 true
is_email_overlap = true;

//이메일 중복체크 함수
function emailOverlapChk() {
/* 	var email1 = $('#email_type1').val();
	var email2 = $('#email_type2').val(); */
	
	var child_email1 = email_auth_opener.document.getElementById("child_email_type1").value;
	var child_email2 = email_auth_opener.document.getElementById("child_email_type2").value;

	if (child_email1 == "" && child_email2 == "") {
		email_auth_opener.document.getElementById("overlap_msg").innerHTML = "이메일 주소를 입력하세요.";
	} else {
		/* var email = email1 + "@" + email2; */
		var email = child_email1 + "@" + child_email2;
		var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		if (!emailReg.test(email)) {
			email_auth_opener.document.getElementById("overlap_msg").innerHTML = "이메일 주소 형식이 올바르지 않습니다.";
			/* $('#email_status_message').html("이메일 주소 형식이 올바르지 않습니다."); */
		} else {

			$.ajax({
						url : path + "/member/register_email_chk.do?email="+ email,
						type : "post",
						dataType : "json",
						success : function(d) {
							console.log(d);
							//가입되어 있으면 d 는 1
							if (d == 0) {
/* 									$('#email_status_message')
										.html("사용 가능합니다."); */
								email_auth_opener.document.getElementById("overlap_msg").innerHTML = "사용이 가능합니다.";
								is_email_overlap  = false;
/* 									email_auth_opener.document.getElementById("email_auth_div").innerHTML = "<input type='button' style='width: 100%' value='이메일 인증' id='email_overlap_btn' onclick='window.opener.sendAuthCode()'/>";
*/									/* emailChk = true; */
							} else {
							/* 	$('#email_status_message').html(
										"중복된 메일주소가 있습니다."); */
								email_auth_opener.document.getElementById("overlap_msg").innerHTML ="사용중인 이메일이 있습니다.";
							/* 	is_email_overlap  = true; */
								/* emailChk = false; */
							}
						},
						error : function(e) {

						}
					});

		}

	}
}

function checkMail() {
	if (form1.email_select.value == "") {
		form1.email_type2.readOnly = false;
		form1.email_type2.value = "";
		form1.email_type2.focus();
	} else {
		form1.email_type2.readOnly = true;
		form1.email_type2.value = form1.email_select.value;
	}
}

//휴대폰번호 유효성 체크
function validatePhone() {

	var regExp = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;

	if (!regExp.test($('#phone').val())) {
		$('#phone_status_message').html("휴대폰 번호 형식이 올바르지 않습니다.");
		phoneChk = false;
	} else {
		$('#phone_status_message').html("사용 가능한 휴대폰 번호입니다.");
		phoneChk = true;
	}

}

//이름 유효성 체크
function validateName() {

	var pattern = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
	if (!pattern.test($('#name').val())) {
		$('#name_status_message')
				.html(
						"한글은 2 ~ 4글자(공백 없음) , 영문은 Firstname(2 ~ 10글자) (space) Lastname(2 ~10글자)로 입력해 주세요.");
		nameChk = false;
	} else {
		$('#name_status_message').html("사용가능한 형식입니다.");
		nameChk = true;
	}
}
	
$(function(){
	
	$("#btnPostCode").click(
			function() {
				new daum.Postcode({
					oncomplete : function(data) {
						if (data.buildingName == "") {
							form1.addr.value = data.address;
						} else {
							form1.addr.value = data.address + " ("
									+ data.buildingName + ")";
						}
						form1.postcode.value = data.zonecode;
						form1.detail_address.focus();
					}
				}).open();
			});
	
});

/*=======================로그인 페이지 아이디 비밀번호 찾기 ==================================*/

var find_type = "";
//아이디, 비밀번호 찾기 팝업창 띄우기
function findByEmail(type) {
	find_type = type;
	if(!email_auth_opener.closed && email_auth_opener) {
/* 		alert("같은 창이 이미 떠있습니다."); */
		id_find_opener.close();

	}
	
	var email_input = '<input name="child_email_type1" id="child_email_type1" placeholder="이메일"> @ <input name="child_email_type2" id="child_email_type2" placeholder="이메일 주소">';
email_input += '<select name="email_select" onChange="checkMail()">';
email_input += '<option value="" selected>직접 입력</option><option value="naver.com">naver.com</option><option value="gmail.com">gmail.com</option><option value="hanmail.net">hanmail.net</option><option value="nate.com">nate.com</option></select> ';
email_input +='<input type="button" id="email_overlap_btn" value="이메일인증" onclick="window.opener.email_auth(\''+ find_type + '\')"/>';

email_auth_opener = window.open("" , "계정 정보 찾기" , "width=600,height=400");
email_auth_opener.document.write("<div id='child_opener'></div>");
email_auth_opener.document.write("<div id='modify_pwd_area'></div>");
email_auth_opener.document.getElementById("child_opener").innerHTML += email_input;
email_auth_opener.document.getElementById("child_opener").innerHTML +=  "<span id='auth_code_div'><input type=text id=auth_code_text placeholder=인증번호 /><input type=button value=인증 onclick=window.opener.compare_auth_code()></span></div>";
email_auth_opener.document.getElementById("child_opener").innerHTML += "<div id='auth_timer'></div>";

}

function email_auth(type) {
	var email1 = id_find_opener.document.getElementById("child_email_type1").value;
	var email2 = id_find_opener.document.getElementById("child_email_type2").value;
	
	if(email1 != "" && email2 != "") {
		
		var email  = email1 + "@" + email2;
		
		
		if(ajax_running) {
			id_find_opener.alert("인증번호 전송중입니다.");
			return;
		}
		
		ajax_running = true;
		$.ajax({
			url : "${path}/member/sendMailAttach.do",
			type : "post",
			data : {"email_id" : email,
					   "type" : type},
			dataType : "json",
			success : function(d) {
					
					ajax_running = false;
					console.log(d);
					if(d.exist == 0) {
						id_find_opener.alert("등록된 이메일이 없습니다.");
						return;
					}
					
					if(d.sendChk == 1) {
						//인증번호
						randomCode = d.randomCode;
						id_find_opener.alert("인증코드가 전송되었습니다. 전송된 인증코드를 확인하세요.");
						is_email_auth = true;
						var auth_code_input   = "<input type=text id=auth_code_text placeholder=인증번호를 입력하세요. /><input type=button value=인증 onclick=window.opener.compare_auth_code()>";
						id_find_opener.document.getElementById("auth_code_div").innerHTML =auth_code_input;
						//인증 가능시간을 설정한다.
						auth_time = 60;
						//인증시간 함수를 1초마다 실행한다.
						stopTimer() ;
						auth_timer = setInterval(function(){timer()} , 1000);
					} else {
						id_find_opener.alert("인증코드 전송이 실패하였습니다.");
					}
			},
			error : function(e) {
				console.log(e);
			}
		});

	} else {
		id_find_opener.alert("이메일을 정확히 입력하세요.");
	}
	
}

//이메일로 비밀번호 변경 
function modifyPwd() {
		if(!pwChk) {
			id_find_opener.alert("비밀번호를 확인하세요.");
			return;
		} else {
			
			var email1 = id_find_opener.document.getElementById("child_email_type1").value;
			var email2 = id_find_opener.document.getElementById("child_email_type2").value;
			var pwd = id_find_opener.document.getElementById("passwd").value;
			var email  = email1 + "@" + email2;
			
			$.ajax({
				url : "modifyPwdByEmail",
				type : "post",
				data : {
					"email" : email,
					"pwd" :  pwd
				},
				success : function(d) {
					
								id_find_opener.alert("비밀번호가 변경되었습니다.");
								id_find_opener.close();
								is_email_auth = false;
								pwChk = false;
				},
				error : function(e) {
						console.log(e);
				}
				
			});
			
		}
}

function compare_auth_code() {

	//window.open 의 이메일 인증을 하지 않았을 때 
	if(!is_email_auth) {
		id_find_opener.alert("이메일 인증이 필요합니다.");
		return;
	}	
		
	var child_auth_code = id_find_opener.document.getElementById("auth_code_text").value;

	if(child_auth_code == "") {
		id_find_opener.alert("인증코드를 입력하세요.");
		return;
	} 
	//메일에 전송된 인증번호와 입력한 인증번호가 일치하면
	 if(child_auth_code == randomCode) {
		//인증 유효시간이 유효하지 않을때
		if(auth_time == 0) {
			id_find_opener.alert("인증시간이 유효하지 않습니다. 인증번호를 새로 발급받으세요.");
			return;
		} 
		//인증시간이 유효할때
		else {
			id_find_opener.alert("인증에 성공하였습니다.");
			stopTimer() ;
			id_find_opener.document.getElementById("auth_timer").innerHTML = "";
			
			
			var email1 = id_find_opener.document.getElementById("child_email_type1").value;
			var email2 = id_find_opener.document.getElementById("child_email_type2").value;
			var email  = email1 + "@" + email2;
			
			if(find_type == "findId") {
				$.ajax({
					url : "findIdByEmail",
					type : "post",
					data : {
						"email" : email 
					},
					dataType : "json",
					success : function(d) {
						console.log(d);
						var idInfo = "<h3>고객님의 계정정보 입니다.</h3>";
						idInfo += "아이디 :" + d.ID;
						 id_find_opener.document.getElementById("child_opener").innerHTML = idInfo;
						
						
					},
					error : function(e) {
						console.log(e);
					}
				})
			} else if(find_type == "findPwd") {
				 id_find_opener.document.getElementById("child_opener").style.display = "none";
				var pwd_input = '<div><input type="password" name="passwd" id="passwd" onkeyup="window.opener.pwPattern()"><span id="pw_status_message"></span></div>';
				pwd_input += '<div><input type="password" name="passwd_check" id="passwd_check" onkeyup="window.opener.chkMatchingPw()"><span id="pw_chk_status_message"></span>';
				pwd_input += '<div><button type="button" onclick="window.opener.modifyPwd()">변경하기</button><div>';
				
				 id_find_opener.document.getElementById("modify_pwd_area").innerHTML += pwd_input;

			}
			
			
		}
	} 
	 //메일에 전송된 인증번호와 입력한 인증번호가 일치하지 않으면
	 else {
		 id_find_opener.alert("인증번호가 일치하지 않습니다. 인증번호를 확인하세요.");
		 return;
	}


		
	}


	