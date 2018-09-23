<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>My Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../include/head.jsp" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>
<%@ include file="../include/header_menu.jsp" %>


<div id="member_info_div">
	<form name="member_info_form" action="${path}/member/modifyMemberInfo" method="post" onsubmit="return submitChk()">
		<section class="register-block">
  			<div class="container">
				<div class="row">
					<div class="col-md-3"></div>
					<div class="col-md-6">
						<div class="row m-b-20">
							<div class="col-md-3"></div>
							<div class="col-md-6">
								<div class="row">
									<div>
										<button type="button" onclick="location.href='${path}/shop/order/buyList'" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4" style="width:80px; height:35px;">
											구매내역
										</button>
									</div>
									<div class="m-l-30">
										<button type="button" onclick="location.href='${path}/shop/product/reviewQna'" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4" style="width:80px; height:35px;">
											문의
										</button>
									</div>
									<div class="m-l-30">
										<button type="button" onclick="location.href='${path}/member/mypage'" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4" style="width:80px; height:35px;">
											개인정보
										</button>
									</div>
								</div>
							</div>
							<div class="col-md-3"></div>
						</div>
						<div id="personalInfo">
							<h2 class="text-center">개인정보</h2>
						
							<hr style="border-top-width: 2px; padding-top: 10px;">
							
							<!-- 아이디 -->
							<div class="form-group">
								<label for="exampleInputName1" class="text-uppercase">아이디</label>
								<div class="bo12 size16 m-b-20">
									<input class="sizefull s-text7 p-l-18 p-r-18" id="member_id" name="member_id" value="${sessionScope.member_id}" readonly="readonly">
								</div>
							</div>
										  	
							<!-- 비밀번호 -->
							<div class="form-group">
								<label for="exampleInputAddress1" class="text-uppercase">비밀번호</label>
								<div class="bo12 size16 m-b-20">
									<input class="sizefull s-text7 p-l-18 p-r-18" type="password" name="passwd" id="passwd" onkeyup="pwPattern()" placeholder="비밀번호를 입력하세요.">
								</div>
							</div>
							<div id="pw_status_message"></div>
							<div class="form-group">
								<label for="exampleInputAddress2" class="text-uppercase">비밀번호 확인</label>
								<div class="bo12 size16 m-b-20">
									<input class="sizefull s-text7 p-l-18 p-r-18" type="password" name="passwd_check" id="passwd_check" onkeyup="chkMatchingPw()" placeholder="비밀번호를 입력하세요.">
								</div>
							</div>
							<div id="pw_chk_status_message"></div>
							
							<div class="form-group">
										    
								<!-- 이름 -->
								<label for="exampleInputTown1" class="text-uppercase">이름</label>
								<div class="bo12 size16 m-b-20">
									<input class="sizefull s-text7 p-l-18 p-r-18" name="name" id="name" onkeyup="validateName()" placeholder="이름을 입력하세요.">
								</div>
								<div id="name_status_message"></div>
								
								<!-- 생년월일 -->
								<div class="form-group">
									<label for="exampleInputCountry1" class="text-uppercase" style="display : block">생년월일</label>
									<select id="birth_year" name="birth_year" class="form-control"  style="display : inline ; width : 32%">
										<c:set var="now" value="<%=new java.util.Date()%>" />
										<c:set var="sysYear">
											<fmt:formatDate value="${now}" pattern="yyyy" />
										</c:set>
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
								
								<!-- 성별 -->
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
												
								<!-- 우편번호/주소 -->
								<div class="form-group" style="display:inline;">
									<label for="exampleInputPassword1" class="text-uppercase">우편번호</label>
									<div class="row p-l-15 p-r-15">
										<div class="bo12 size11 m-b-20 col-md-4">
											<input class="sizefull s-text7 p-l-18 p-r-18 m-r-10" type="text" name="postcode" id="postcode" size="2" readonly="readonly" placeholder="우편번호 찾기를 선택하세요.">
										</div>
										<div class="w-size24 col-md-4">
											<span class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" id="btnPostCode">
												우편번호 찾기
											</span>
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputPassword1" class="text-uppercase">주소</label>
									<div class="bo12 size16 m-b-20">
										<input class="sizefull s-text7 p-l-18 p-r-18" name="addr" id="addr" placeholder="주소" readonly="readonly">
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputPassword1" class="text-uppercase">상세주소</label>
									<div class="bo12 size16 m-b-20">
										<input class="sizefull s-text7 p-l-18 p-r-18" name="detail_addr" id="datail_addr" placeholder="상세주소" onfocus="addrEmptyChk()">
									</div>
								</div>
								
								<!-- 이메일 -->
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
	<script>
	var openWin;
	
	function openChild(){
		window.name = "parentForm";
		openWin = window.open("emailChk.do", "childForm", "width=800, height=500, left=100, top=50"); 
	}
	</script>
	
										<div class="col-md-4">
											<div class="w-size21">
												<button type="button" class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" id="emailAuthBtn" onclick="openChild();">
													이메일 인증
												</button>
											</div>
										</div>
									</div>
								</div>
										  
								<!-- 연락처 -->
								<div class="form-group">
									<label for="exampleInputPassword1" class="text-uppercase">연락처</label>
									<div class="bo12 size16 m-b-20">
										<input class="sizefull s-text7 p-l-18 p-r-18" name="phone" id="phone" placeholder="'-' 없이 입력하세요" onkeyup="validatePhone()" class="form-control">
									</div>
								</div>
								<div id="phone_status_message"></div>
										  		
								<!-- sns연동 -->
								<table class="table">
									<thead class="thead-dark">
										<tr>
											<th scope="col" style="text-align: center;">SNS</th>
											<th scope="col" style="text-align: center;">연결</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th scope="row" class="social_name_td" style="text-align: center; padding-top: 20px;">카카오</th>
											<td class="social_link_td" style="text-align: center;">
												<a class="social_link_a btn btn-warning" id="kakao-login-btn" type="kakao" style="background-color: #ffb632; color: white;">연결하기</a>
											</td>
										</tr>
									</tbody>
								</table>
								
								<hr style="border-top-width: 2px; padding-bottom: 10px;">
								
								<!-- 수정버튼 -->
								<div class="form-check">
									<div class="row">
										<div class="col-md-4"></div>
										<div class="w-size24 col-md-4">
											<button type="button" id="memberDel" class="btn btn-register flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" style="background-color: #E65540;">
												회원탈퇴
											</button>
										</div>
										<div class="w-size24 col-md-4">
											<!-- <button type="button" class="btn btn-register flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" style="background-color: #E65540;" onclick="submitChk()"> -->
											<button type="submit" class="btn btn-register flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" style="background-color: black;">
												수정
											</button>
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
	</form>		
</div>
<script>
$(function(){
	$("#memberDel").click(function(){
		if(confirm("회원탈퇴하시겠습니까?")){
			$.ajax({
				type: "post",
				url: "${path}/member/memberDel.do"
			});
			
			alert("회원탈퇴 하였습니다.");
			document.location.href="${path}/";
		}else{
			return;
		}
	});
});
</script>
</body>
<script>
	var modify_chk = "${modifyMemberChk}";
	if(modify_chk != "" && modify_chk != 0) {
		alert("정보가 변경되었습니다.");
		document.location.href="${path}/";
	}
	
	/* 아이디로 회원정보 가져옴 */
	var member_id = "${sessionScope.member_id}";
	$.ajax({
		url : "getMemberInfo",
		type : "get",
		async : false,
		data :  {
			"member_id" : member_id
		},
		dataType : "json",
		success : function(d) {
			$("#name").val(d.name);
			
		    $("#birth_year").val(d.birth.substring(0,4));
		    if(d.birth.substring(4,5) == 0) {
		    	$("#birth_month").val(d.birth.substring(5,6));
		    } else {
		    	$("#birth_month").val(d.birth.substring(4,6));
		    }
		    if(d.birth.substring(6,7) == 0) {
		    	$("#birth_day").val(d.birth.substring(7,8));
		    } else {
		    	$("#birth_day").val(d.birth.substring(6,8));
		    }
			
		    var male = $("#male").val();
		    var female = $("#female").val();
		    if(male == d.gender){
		    	$("#male").prop('checked', true);
		    }else{
		    	$("#female").prop('checked', true);
		    }

			$("#postcode").val(d.postcode);
			$("#addr").val(d.addr);
			$("#detail_addr").val(d.detail_addr);
			
			$("#email_type1").val(d.email.split("@")[0]);
			$("#email_type2").val(d.email.split("@")[1]);

			$("#phone").val(d.phone);
		}, error : function(e) {
			
		}
	});
	
	//sns 연동 유무 체크
 	$.ajax({
		url : "getMemberSocialInfo",
		type : "get",
		data : {
			"member_id" : member_id
		},
		dataType : "json",
		success : function(d) {
			$(".social_name_td").each(function(index){
				  for(var i in d) {
					  if($(this).text() == d[i].NAME) {
						  if(d[i].EXIST == 0) {
							  $(".social_link_td:eq(" + index + ") a").text("연결하기");
						  } else if(d[i].EXIST == 1) {
							  $(".social_link_td:eq(" + index + ") a").text("연결해지");
							  $(".social_link_td:eq(" + index + ") a").addClass("social_linked");
						  }
					  }
				  }
			});
		},
		error : function(e) {
			console.log(e);
		}
	}); 
	
	/* sns 연동, 해제 */
	Kakao.init('4d972f16a08f330c1b8fc14aca12aee6');
 	$(".social_link_a").click(function() {
		var social_type = $(this).attr("type");
		var idx = $(".social_link_a").index(this);
		//소셜 연동이 되어 있으면 해제
		if($(this).hasClass("social_linked")) {
			var social_linked = true;
			$.ajax({
				url : "${path}/member/social_link.do",
				type : "post",
				data : {"member_id" : $("#member_id").val()
						   ,"social_type" : social_type
						   ,"social_linked" : social_linked},	
				dataType : "json",
				success : function(d) {
					alert("연결이 해지되었습니다.");
					$(".social_link_a:eq(" + idx +")").removeClass("social_linked");
					console.log($(this).text());
					$(".social_link_a:eq(" + idx +")").text("연결하기");
					Kakao.Auth.logout();
				}
			});
		} 
		//연동하기
		else {
			Kakao.Auth.login({
		        success: function(authObj) {
		        	Kakao.API.request({
						url: '/v1/user/me',
						success: function(res) {
							console.log(res);
							var id = JSON.stringify(res.id);
							social_type = "kakao";
							var social_linked = false;
							//로그인한 계정이 이미 가입되어 있는지 체크한다.
							$.ajax({
								url : "${path}/member/sns_register_chk.do?id="+id + "&type=" + social_type,
						        type : "post",
						        dataType : "json",
						        success : function(d) {
						        	//가입되어 있으면 d 는 1
						        	if(d == 0) {
						        		$.ajax({
						        			url : "${path}/member/social_link.do",
						        			type : "post",
						        			data : {"member_id" : $("#member_id").val()
						        					 , "social_id" : id 
						        					 , "social_type" : social_type
						        					 , "social_linked" : social_linked},	
						        			dataType : "json",
						        			success : function(d) {
						        				alert("연동되었습니다.");
						        				$(".social_link_a:eq(" + idx +")").addClass("social_linked");
						        				$(".social_link_a:eq(" + idx +")").text("연결해제");
						        			}
						        		});
						        	} else  {
						        		alert("이미 가입되어 있습니다.");
						        	}
						        }, error : function(e) {
						        	
						        }
							});
						}, fail: function(error) {
							alert(JSON.stringify(error));
						}
					});
		        }, fail: function(err) {
		          alert(JSON.stringify(err));
		        }
			});
		}
	});
	 
	
	/* 수정버튼 눌렀을 경우 */
	var  pwChk = false, nameChk = true, addrChk = true, emailChk = true, phoneChk = true;
	function submitChk() {
		var datail_addr = $('#datail_addr').val();
		if (datail_addr != "") {
			addrChk = true;
		}
		
		if($('#email_type1').val() == "" && $('#email_type2').val() == "" ) {
			alert("이메일 인증이 필요합니다.");
			return false;
		}  else if(!pwChk) {
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

		/* var param = {
					"member_id" : $("#member_id").val(), 
					"passwd" : $("#passwd").val(),
					"passwd_check" : $("#passwd_check").val(),
					"name" : $("#name").val(),
					"birth_year" : $("#birth_year").val(),
					"birth_month" : $("#birth_month").val(),
					"birth_day" : $("#birth_day").val(),
					"member_id" : $("#member_id").val(),
					"member_id" : $("#member_id").val(),
					};
		
		console.log(param); */
		//document.location.href="${path}/member/modifyMemberInfo";
	}
	
	/* 우편번호찾기 API */
	$(function() {
		$("#btnPostCode").click(function() {
			new daum.Postcode({
				oncomplete : function(data) {
					if (data.buildingName == "") {
						$("#addr").val(data.address);
					} else {
						$("#addr").val(data.address + " (" + data.buildingName + ")");
					}
					$("#postcode").val(data.zonecode);
					$("#addr").val(d.addr);
					$("#detail_addr").focus();
				}
			}).open();
		});
	});
	
	//비밀번호 유효성 체크
	function pwPattern() {
		var regExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}/;
		/* 	var regExp = /^[a-z0-9_]{4,12}$/;
		 */if (!regExp.test($('#passwd').val())) {
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
	function fn_DayOfMonth(){
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
</script>
</html>