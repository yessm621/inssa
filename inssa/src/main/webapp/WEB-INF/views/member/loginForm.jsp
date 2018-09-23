<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Login</title>
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@ include file="../include/head.jsp" %>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<style>
		.myform{
			position: relative;
			display: -ms-flexbox;
			display: flex;
			padding: 1rem;
			-ms-flex-direction: column;
			flex-direction: column;
			width: 100%;
			pointer-events: auto;
			background-color: #fff;
			background-clip: padding-box;
			border: 1px solid rgba(0,0,0,.2);
			border-radius: 1.1rem;
			outline: 0;
		 }
        
        
         .login-or {
	         position: relative;
	         color: #aaa;
	         margin-top: 10px;
	         margin-bottom: 10px;
	         padding-top: 10px;
	         padding-bottom: 10px;
	     }
         .span-or {
	         display: block;
	         position: absolute;
	         left: 50%;
	         top: -2px;
	         margin-left: -25px;
	         background-color: #fff;
	         width: 50px;
	         text-align: center;
         }
         .hr-or {
	         height: 1px;
	         margin-top: 0px !important;
	         margin-bottom: 0px !important;
         }
         .google {
	         color:#666;
	         width:100%;
	         height:40px;
	         text-align:center;
	         outline:none;
	         border: 1px solid lightgrey;
         }
         form .error {
         	color: #ff0000;
         }
		#second{display:none;}
	</style>
</head>
<body class="animsition">
<%@ include file="../include/header_menu.jsp" %>

<!-- Title Page -->
	<!-- content page -->
	<section class="bgwhite p-t-66 p-b-60">
		<div class="container" style="padding-left: 300px;">
			<div class="col-md-8 col-md-offset-2">
				<div id="first">
					
					<div class="myform form">
						<div class="row">
							<div class="col-md-4"></div>
							<div class="col-md-4">
								<img src="${path}/image/login.png" width= "160px;">
							</div>
							<div class="col-md-4"></div>
						</div>
						
						<div class="form-group">
							<label for="member_id">ID</label>
							<div class="bo4 of-hidden size15 m-b-20">
								<input type="text" name="member_id" id="member_id"class="form-control sizefull s-text7 p-l-22 p-r-22" placeholder="아이디를 입력하세요.">
							</div>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Password</label>
							<div class="bo4 of-hidden size15 m-b-20">
								<input type="password"  name="passwd" id="passwd"  class="form-control sizefull s-text7 p-l-22 p-r-22" placeholder="비밀번호를 입력하세요.">
							</div>
						</div>
						<div class="col-md-12 text-center ">
							<button type="button" id="login_btn" class="flex-c-m size2 bg1 bo-rad-23 hov1 m-text3 trans-0-4">Login</button>
						</div>
						<div class="col-md-12 ">
							<div class="login-or">
								<hr class="hr-or">
								<span class="span-or">or</span>
							</div>
						</div>
						<div class="col-md-12 mb-3">
							<p class="text-center">
								<a id="kakao-login-btn"></a>
							</p>
						</div>
						<div class="form-group">
							<p class="text-center">
								<button type="button" class="btn btn-success" onclick="loginFind();">아이디 찾기</button>
								<button type="button" class="btn btn-warning" onclick="passwdFind();" style="color: white;">비밀번호 찾기</button>
							</p>
						</div>
						<div class="form-group">
							<p class="text-center">회원이 아니신가요? <a href="${path}/member/registerForm.do" id="signup">회원가입</a></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>


<script>
var openWin;
	
function loginFind(){
	window.name = "parentForm";
	openWin = window.open("loginFind.do", "childForm", "width=800, height=500, left=100, top=50"); 
}

function passwdFind(){
	window.name = "parentForm";
	openWin = window.open("passwdFind.do", "childForm", "width=800, height=500, left=100, top=50");
}
</script>

<%@ include file="../include/footer.jsp" %>
<%@ include file="../include/body_footer.jsp" %>
</body>
<script>
$(function(){
	$('#login_btn').click(function(){
		var member_id = $('#member_id').val();
		var passwd = $('#passwd').val();
	
		if(member_id == "") {
			alert("아이디를 입력하세요");
			return;
		} else if(passwd == "") {
			alert("비밀번호를 입력하세요");
			return
		}
	
		$.ajax({
			url : "login.do",
			type : "post",
			data : {"member_id" : member_id, "passwd" : passwd},
			dataType : "json",
			success : function(d) {
			   //로그인 정보가 맞으면 1 틀리면 0
			   if(d.success == 0) {
				   alert(d.loginMsg)
			   } 
			   else if(d.success == 1){
				   location.href = d.prev_url;
			   }
			}, error : function(e) {
				
			}
		});
	});
});
</script>

<script type='text/javascript'>
var social_type = "";
    Kakao.init('4d972f16a08f330c1b8fc14aca12aee6');

	Kakao.Auth.createLoginButton({
		container: '#kakao-login-btn',
		success: function(authObj) {
			Kakao.API.request({
				url: '/v1/user/me',
				success: function(res) {
					//console.log(res);
					var id = JSON.stringify(res.id);
					social_type = "kakao";
					//var name = JSON.stringify(res.properties.nickname);
					
					//로그인한 계정이 이미 가입되어 있는지 체크한다.
					$.ajax({
						url : "${path}/member/sns_register_chk.do?id="+id + "&type=" + social_type,
				        type : "post",
				        dataType : "json",
				        success : function(d) {
				        	//가입되어 있으면 d 는 1
				        	if(d == 0) {
				        		alert("가입 내역이 없어 회원가입 페이지로 넘어갑니다.");
				         		document.location.href="${path}/member/registerForm.do?id="+id + "&type=" + social_type ; 
				        	} else  {
				        		document.location.href="${path}/member/sns_login.do?social_id="+id + "&social_type=" + social_type ; 
				        	}
				        },
				        error : function(e) {
				        	
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
	
</script>
</html>
