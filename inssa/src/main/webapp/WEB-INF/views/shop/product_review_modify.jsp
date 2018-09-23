<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/head.jsp" %>
<script>
function checkImageType(fileName){
	var pattern=/jpg|gif|png|jpeg/;
	return fileName.match(pattern);
}
function getFileInfo(fullName){
	var fileName, imgsrc, getLink, fileLink;
	if(checkImageType(fullName)){ //이미지 파일인 경우
		imgsrc="/inssa/upload/displayFile?fileName="+fullName;
		fileLink=fullName.substr(3); //14 인덱스~끝
		var end=fullName.substr(3);
		getLink="/inssa/upload/displayFile?fileName=/"+end;
	}else{
		alert("이미지를 등록해주세요.");
		return;
	}
	// uuid_filename
	fileName=fileLink.substr(fileLink.indexOf("_")+1);
	return {fileName: fileName, imgsrc: imgsrc,
			getLink: getLink, fullName:fullName };
}
function listAttach(){
	var code = $("#code").val();
	var idx = $("#idx").val();
	var board_type = $("#board_type").val();
	var data = {"pro_code" : code, "board_idx" : idx, "board_type" : board_type};

	$.ajax({
		type: "post",
		url: "${path}/shop/product/getAttach.do",
		data: data,
		dataType: "json",
		success: function(list){
			for(var i=0; i<list.length; i++){
				var fileInfo = getFileInfo(list[i].original_name);
				var html = "<div><img src='"+fileInfo.imgsrc+"'>";
				html += "<input type='hidden' class='file' value='"+fileInfo.fullName+"'>";
				html += "<a href='#' class='file_del' data-src='"+fileInfo.fullName+"'>[삭제]</a></div>";
				$("#uploadedList").append(html);
			}
		}
	})
}
$(function(){
	//드래그 기본효과 막음
	$(".fileDrop").on("dragenter dragover", function(e){
		e.preventDefault();
	});
	$(".fileDrop").on("drop", function(e){
		e.preventDefault();
		//드롭한 파일을 폼데이터에 추가함
		var files = e.originalEvent.dataTransfer.files;
		var file = files[0];
		var formData = new FormData();
		//폼데이터에 추가(아래의 form태그안에 input태그를 사용한 것이 아니기 때문에 form태그와 따로 놀게되므로 formData를 선언해줌)
		formData.append("file", file);
		$.ajax({
			url: "${path}/upload/uploadAjax",
			data: formData,
			dataType: "text",
			processData: false,
			contentType: false,
			type: "post",
			success: function(data){
				var fileInfo=getFileInfo(data);
				var html = "<div><img src='"+fileInfo.imgsrc+"'>";
				html += "<input type='hidden' class='file' value='"+fileInfo.fullName+"'>";
				html += "<a href='#' class='file_del' data-src='"+fileInfo.fullName+"'>[삭제]</a></div>";
				$("#uploadedList").append(html);
			}
		});
	});
	
	$("#btnUpdate").click(function(){
		//태그.each( function(){} ) 모든 태그 반복
		var str = "";
		$("#uploadedList .file").each(function(i){
			str += "<input type='hidden' name='files["+i+"]' value='"+$(this).val()+"'>";
		});
		//폼에 hidden 태그들을 추가
		$("#form1").append(str);
		
		document.form1.action="${path}/shop/product/review_modify.do";
		document.form1.submit();
	});
	
	listAttach();//첨부파일 목록 로딩
	
	//첨부파일 삭제
	$("#uploadedList").on("click", ".file_del", function(e){
		var that=$(this);//클릭한 태그
		$.ajax({
			type: "post",
			url: "${path}/upload/deleteFile",
			data: {fileName:$(this).attr("data-src")},
			dataType: "text",
			success: function(result){
				if(result == "deleted"){
					that.parent("div").remove();
				}
			}
		});
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
				<form id="form1" name="form1" class="leave-comment" method="post">
					
					<h2 class="m-text4 p-b-20">상품후기 수정하기</h2>
					
					<p class="s-text8 p-b-5"><strong>제목</strong></p>
					<div class="bo12 size16 m-b-20">
						<input type="hidden" id="idx" name="idx" value="${review_list.board_idx}">
						<input type="hidden" id="code" name="code" value="${review_list.code}">
						<input type="hidden" id="board_type" name="board_type" value="R">
						<input class="sizefull s-text7 p-l-18 p-r-18" type="text" id="title" name="title" value="${review_list.title}">
					</div>
					
					<p class="s-text8 p-b-5"><strong>본문</strong></p>
					<textarea class="dis-block s-text7 size18 bo12 p-l-18 p-r-18 p-t-13 m-b-5" id="content" name="content">${review_list.content}</textarea>
					<p class="s-text8 p-b-40">
						구매후기는 한글 기준 5자 이상 600자 이하로 가능합니다.
					</p>
					
					<div class="fileDrop">
						<div class="bo12 of-hidden size18 m-b-5">
						
						</div>
					</div>
					
					<p class="s-text8 p-b-10">
						업로드 할 이미지를 마우스로 끌어다 놓을 수 있습니다.
					</p>
					<div id="uploadedList" class="m-b-30"></div>
					
					<div class="row">
						<div class="col-md-1"></div>
						<div class="w-size24 col-md-5">
							<button class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" onclick="history.back();">
								취소
							</button>
						</div>
						<div class="w-size24 col-md-5">
							<button id="btnUpdate" class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4">
								수정
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