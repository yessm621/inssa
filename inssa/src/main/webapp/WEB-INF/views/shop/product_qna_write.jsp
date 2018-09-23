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
		event.preventDefault();

		var files=event.originalEvent.dataTransfer.files;
		var file=files[0];
		var formData=new FormData(); 
		formData.append("file",file);

		$.ajax({
			type: "post",
			url: "${path}/upload/uploadAjax",
			data: formData,
			dataType: "text",
			processData: false,
			contentType: false,
			success: function(data,status,req){
				
				var str="";
				if(checkImageType(data)){ 
					str="<div><a href='${path}/upload/displayFile?fileName="+getImageLink(data)+"'>";
					str+="<img src='${path}/upload/displayFile?fileName="+data+"'></a>";
					str+="<input type='hidden' class='file' value='"+data+"'>";
				}else{ 
					alert("이미지를 등록해주세요.");
					return;
				}
				str+="<span data-src="+data+">[삭제]</span></div>";
				$(".uploadedList").append(str);
			}
		});
	}); 

	$(".uploadedList").on("click","span",function(event){

		var that=$(this);
			
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
		if(checkImageType(fileName)){
			return;
		}
		var idx=fileName.indexOf("_")+1;
		return fileName.substr(idx);
	}
	function getImageLink(fileName){
		if(!checkImageType(fileName)){
			return;
		}
		
		var front=fileName.substr(0,1);
		var end=fileName.substr(3);

		return front+end;
	}
	function checkImageType(fileName){
		var pattern=/jpg|png|jpeg/i;
		return fileName.match(pattern);
	}
	$("#btnSave").click(function(){
		
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
				<form id="form1" name="form1" class="leave-comment" method="post" action="${path}/shop/product/qna_insert.do">
					
					<h2 class="m-text4 p-b-20">상품문의 작성하기</h2>
					
					<div class="bo12 size16 m-b-20">
						<input class="sizefull s-text7 p-l-18 p-r-18" type="text" id="title" name="title" placeholder="제목 *">
					</div>
					<textarea class="dis-block s-text7 size18 bo12 p-l-18 p-r-18 p-t-13 m-b-5" id="content" name="content" placeholder="내용 *"></textarea>
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
					<div class="uploadedList m-b-30"></div>
					
					<div class="row">
						<div class="col-md-1"></div>
						<div class="w-size24 col-md-5">
							<button class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" onclick="history.back();">
								취소
							</button>
						</div>
						<div class="w-size24 col-md-5">
							<input type="hidden" name="code" value="${pro_code}">
							<button type="button" id="btnSave" class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4">
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