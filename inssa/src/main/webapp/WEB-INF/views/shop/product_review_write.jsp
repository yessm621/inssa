<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/head.jsp" %>
<script>
$(function(){
	$(".fileDrop").on("dragenter dragover", function(event){
		event.preventDefault();
	});
	$(".fileDrop").on("drop",function(event){
		//drop이 될 때 기본 효과를 막음
		event.preventDefault();
		//첨부파일 배열
		var files=event.originalEvent.dataTransfer.files;
		var file=files[0]; //첫번째 첨부파일
		var formData=new FormData(); //폼 객체
		formData.append("file",file); //폼에 file 변수 추가
		//서버에 파일 업로드(백그라운드에서 실행됨)
		$.ajax({
			type: "post",
			url: "${path}/upload/uploadAjax",
			data: formData,
			dataType: "text",
			processData: false,//processData: false => post 방식(파일을 어떻게 보낼건지)
			contentType: false,// contentType: false => multipart/form-data로 처리됨
			success: function(data,status,req){
				console.log("data:"+data); //업로드된 파일 이름
				console.log("status:"+status); //성공,실패 여부
				console.log("req:"+req.status);//요청코드값
				var str="";
				if(checkImageType(data)){ //이미지 파일
					str="<div><a href='${path}/upload/displayFile?fileName="+getImageLink(data)+"'>";
					str+="<img src='${path}/upload/displayFile?fileName="+data+"'></a>";
					str+="<input type='hidden' class='file' value='"+data+"'>";
				}else{ //이미지가 아닌 경우
					alert("이미지를 등록해주세요.");
					return;
				}
				str+="<span data-src="+data+">[삭제]</span></div>";
				$(".uploadedList").append(str);//class="uploadedList"인 곳에 추가한다.
			}
		});
	}); //fileDrop 함수
	//첨부파일 삭제 함수
	$(".uploadedList").on("click","span",function(event){
		//현재 클릭한 태그
		var that=$(this);
		//data: "fileName="+$(this).attr("data-src"),		
		$.ajax({
			url: "${path}/upload/deleteFile",
			type: "post",
			data: {
				fileName: $(this).attr("data-src")
			},
			dataType: "text",
			success: function(result){
				if(result=="deleted"){
					that.parent("div").remove();
				}
			}
		});
	});
	
	function getOriginalName(fileName){
		if(checkImageType(fileName)){ //이미지 파일이면 skip
			return;
		}
		var idx=fileName.indexOf("_")+1; //uuid를 제외한 파일이름
		return fileName.substr(idx);
	}
	function getImageLink(fileName){
		if(!checkImageType(fileName)){//이미지 파일이 아니면 skip
			return;//함수 종료
		}
		//이미지 파일이면
		var front=fileName.substr(0,1);
		var end=fileName.substr(3);// s_ 제거

		return front+end;
	}
	function checkImageType(fileName){
		var pattern=/jpg|png|jpeg/i; //정규표현식(대소문자 무시)
		return fileName.match(pattern); //규칙에 맞으면 true
	}
	$("#btnSave").click(function(){
		//태그.each( function(){} ) 모든 태그 반복
		var title = $("#title").val();
		
		if(title == ""){
			alert("제목을 입력하세요.");
			$("#title").focus();
			return;
		}
		var str = "";
		$(".uploadedList .file").each(function(i){
			str += "<input type='hidden' name='files["+i+"]' value='"+$(this).val()+"'>";
		});
		//폼에 hidden 태그들을 추가
		$("#form1").append(str);
		document.form1.submit();
	});
});
</script>
</head>
<body>
<%@ include file="../include/header_menu.jsp" %>

<section>
	<div class="container">
		<div class="row m-t-60 m-b-10">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<form id="form1" name="form1" class="leave-comment" method="post" action="${path}/shop/product/review_insert.do">
					
					<h2 class="m-text4 p-b-20">상품후기 작성하기</h2>
					
					<div class="bo12 size16 m-b-20">
						<input class="sizefull s-text7 p-l-18 p-r-18" type="text" id="title" name="title" placeholder="제목 *">
					</div>
					<textarea class="dis-block s-text7 size18 bo12 p-l-18 p-r-18 p-t-13 m-b-5" id="content" name="content" placeholder="내용 *"></textarea>
					<p class="s-text8 p-b-40">
						구매후기는 한글 기준 5자 이상 600자 이하로 가능합니다.
					</p>
					<input type="hidden" name="idx" value="${review_requiredInfo[0].idx}">
					<input type="hidden" name="code" value="${review_requiredInfo[0].code}">
					<input type="hidden" name="color" value="${review_requiredInfo[0].color}">
					
					<div class="fileDrop">
						<div class="bo12 of-hidden size18 m-b-5">
						
						</div>
					</div>
					
					<p class="s-text8 p-b-10">
						업로드 할 이미지를 마우스로 끌어다 놓을 수 있습니다.
					</p>
					<div class="uploadedList m-b-30"></div>
					
					<div class="row">
						<div class="col-md-1"></div>
						<div class="w-size24 col-md-5">
							<button class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" onclick="history.back();">
								취소
							</button>
						</div>
						<div class="w-size24 col-md-5">
							<button id="btnSave" class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4">
								확인
							</button>
						</div>
						<div class="col-md-1"></div>
					</div>
					
				</form>
			</div>
			<div class="col-md-3"></div>
		</div>
	</div>
</section>

<%@ include file="../include/body_footer.jsp" %>
</body>
</html>