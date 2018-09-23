<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<%@ include file="../include/head.jsp" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<style>
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
         .tx-tfm{
         text-transform:uppercase;
         }
         .mybtn{
         border-radius:50px;
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
<body>
<%@ include file="../include/header_menu.jsp" %>

<script type='text/javascript'>
var social_type = "";
    Kakao.init('4d972f16a08f330c1b8fc14aca12aee6');
	
	function loginWithKakao() {
	      // 로그인 창을 띄웁니다.
	      Kakao.Auth.login({
	        success: function(res) {
	        	console.log(res);
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
			         		document.location.href="${path}/member/registerForm.do?id="+id + "&type=" + social_type ; 
			        	} else  {
			        		alert("이미 가입되어 있습니다.");
			        	}
			        },
			        error : function(e) {
			        	
			        }
				});
	        },
	        fail: function(err) {
	          alert(JSON.stringify(err));
	        }
	      });
	    };
</script>

<!-- 네이버아이디로로그인 버튼 노출 영역 -->
<div id="naver_id_login"></div>
<!-- //네이버아이디로로그인 버튼 노출 영역 -->
<!-- <script type="text/javascript">
	var naver_id_login = new naver_id_login("Zet9pfvkdWZP4Xmfc9Ja", "http://localhost:8080/inssa/member/register.do");
	var state = naver_id_login.getUniqState();
	naver_id_login.setButton("white", 2,40);
	naver_id_login.setDomain("http://localhost:8080/inssa/member/register.do");
	naver_id_login.setState(state);
	naver_id_login.setPopup();
	naver_id_login.init_naver_id_login();
	
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	function naverSignInCallback() {
		console.log(naver_id_login);
		alert(naver_id_login.getProfileData('email'));
	}
</script> -->
<div class="container">
<div class="col-md-8 col-md-offset-2" >
			<div id="first">
<div class="myform form ">
	<div class="col-md-10 col-md-offset-1">
					 <div class="logo mb-3">
						 <div class="col-md-12 text-center">
							<h1>회원가입</h1>
						 </div>
					</div>
                           <div class="form-group">
                              <p class="text-center">
                              		<button type="button" class="btn btn-success"  onclick="location.href='${path}/member/registerForm.do?type=normal'">일반 회원가입</button>
                              		<button type="button" class="btn btn-warning" onclick="loginWithKakao()">kakao로 회원가입</button>
                              	</p>
                           </div>
                 
				</div>
				</div>
				</div>
				</div>
</div>

<%@ include file="../include/body_footer.jsp" %>
</body>
</html>