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
	var code = $("#pro_code").val();
	var idx = $("#board_idx").val();
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
		var btnName = $("#btnUpdate").text();
		
		if(btnName.indexOf("완료") < 0){
			$("input[name='title']").attr("readonly", false);
			$("textarea[name='content']").attr("readonly", false);
			
			var title_x = document.getElementById("title");
			var content_x = document.getElementById("content");

			title_x.style.backgroundColor = "#f1f2d3";
			content_x.style.backgroundColor = "#f1f2d3";
			
			$("#btnUpdate").text("수정완료");
			
			$("div.file").show();
		}else{
			if(confirm("수정하시겠습니까?")){
				var str = "";
				$("#uploadedList .file").each(function(i){
					str += "<input type='hidden' name='files["+i+"]' value='"+$(this).val()+"'>";
				});
				//폼에 hidden 태그들을 추가
				$("#form1").append(str);
				
				document.form1.action="${path}/shop/product/qna_modify.do";
				document.form1.submit();
			}else{
				return;
			}
		}
	});
	
	$("#btnDelete").click(function(){
		//태그.each( function(){} ) 모든 태그 반복
		if(confirm("해당 글을 삭제하시겠습니까?")){
			var str = "";
			$("#uploadedList .file").each(function(i){
				str += "<input type='hidden' name='files["+i+"]' value='"+$(this).val()+"'>";
			});
			//폼에 hidden 태그들을 추가
			$("#form1").append(str);
			
			document.form1.action="${path}/shop/product/qna_delete.do";
			document.form1.submit();
		}
	});
	
	listAttach();//첨부파일 목록 로딩
	
	//첨부파일 삭제
	$("#uploadedList").on("click", ".file_del", function(e){
		var that=$(this);//클릭한 태그
		console.log(that);
		var btnName = $("#btnUpdate").text();
		if(btnName.indexOf("완료") < 0){
			console.log("view");
			alert("수정 버튼 클릭 후 이미지를 삭제해주세요.");
			return;
		}else{
			console.log("수정화면");
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
		}
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
				
					<h2 class="m-text4 p-b-20">상품문의</h2>
					<hr class="b-t-2">
					<div class="row m-b-5">
						<div class="col-md-3 s-text8" style="text-align: center;"><strong>상품이름</strong></div>
						<div class="col-md-8">
							<span id="pro_name" class="s-text8 p-l-18 p-r-18" style="color: black;">${qna_detail_list.name}</span>
						</div>
					</div>
					
					<div class="row m-b-5">
						<div class="col-md-3 s-text8" style="text-align: center;"><strong>작성자</strong></div>
						<div class="col-md-8">
							<span id="member" class="s-text8 p-l-18 p-r-18" style="color: black;">${qna_detail_list.member_name}(${qna_detail_list.member_id})</span>
						</div>
					</div>
					
					<div class="row m-b-5">
						<div class="col-md-3 s-text8" style="text-align: center;"><strong>작성날짜</strong></div>
						<div class="col-md-8">
							<span id="board_time" class="s-text8 p-l-18 p-r-18" style="color: black;"><fmt:formatDate value="${qna_detail_list.board_modified_time}" pattern="yyyy-MM-dd hh:mm:ss" /></span>
						</div>
					</div>
					<hr class="b-t-2">
					<form id="form1" name="form1" class="leave-comment" method="post">
						<p class="s-text8 p-b-5"><strong>제목</strong></p>
						<div class="bo12 size16 m-b-20">
							<input class="sizefull s-text7 p-l-18 p-r-18" type="text" id="title" name="title" value="${qna_detail_list.title}" readonly>
						</div>
						<p class="s-text8 p-b-5"><strong>본문</strong></p>
						<textarea class="dis-block s-text7 size18 bo12 p-l-18 p-r-18 p-t-13 m-b-5" id="content" name="content" readonly>${qna_detail_list.content}</textarea>
						
						<div class="file" style="display: none;">
							<div class="fileDrop">
								<div class="bo12 of-hidden size18 m-b-5">
								
								</div>
							</div>
							<p class="s-text8 p-b-10">
								업로드 할 이미지를 마우스로 끌어다 놓을 수 있습니다.
							</p>
						</div>
						
						<div id="uploadedList" class="m-b-30"></div>
						
						<input type="hidden" id="pro_code" name="pro_code" value="${qna_detail_list.code}">
						<input type="hidden" id="board_idx" name="board_idx" value="${qna_detail_list.board_idx}">
						<input type="hidden" id="board_type" name="board_type" value="Q">
					</form>
					
					
					<c:choose>
						<c:when test="${sessionScope.member_id == qna_detail_list.member_id}">
							<div class="row">
								<div class="col-md-3"></div>
								<div class="w-size22 col-md-2">
									<button class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" onclick="history.back();">
										목록
									</button>
								</div>
								<div class="w-size22 col-md-2">
									<button id="btnUpdate" class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4">
										수정
									</button>
								</div>
								<div class="w-size22 col-md-2">
									<button id="btnDelete" class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4">
										삭제
									</button>
								</div>
								<div class="col-md-3"></div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="row">
								<div class="w-size24" style="margin: auto;">
									<button class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" onclick="history.back();">
										목록
									</button>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				
				
				<hr>

				<script>
function changeDate(date){
	var d = new Date(date);
	var strDate = [d.getFullYear(), (d.getMonth()+1).padLeft(), d.getDate().padLeft()].join('-') + ' ' 
					+ [d.getHours().padLeft(), d.getMinutes().padLeft(), d.getSeconds().padLeft()].join(':');
	return strDate;
}
Number.prototype.padLeft = function(base,chr){
    var  len = (String(base || 10).length - String(this).length)+1;
    return len > 0? new Array(len).join(chr || '0')+this : this;
}
$(function(){
	listReply();//json리턴방식
	
	/* 댓글작성버튼 */
	$("#btnReply").click(function(){
		var replyer = $("#replyer").val();
		if(replyer != ""){
			var replytext = $("#replytext").val();
			var pro_code = $("#pro_code").val();
			var board_idx = $("#board_idx").val();
			var param = {"replytext" : replytext, "product_code" : pro_code, "replyer": replyer, "board_idx" : board_idx};

			$.ajax({
				type: "post",
				url: "${path}/reply/reply_insert.do",
				data: param,
				success: function(){
					alert("댓글이 등록되었습니다.");
					listReply();
				}
			});
		}else{
			alert("로그인 후 댓글을 작성해주세요.");
			$("#replyer").focus();
			return;
		}
		$("#replytext").val("");
	});
	
	$(document).on('click', 'span.reply_update', function(){
		var idx = $(this).index('span.reply_update');
		var text = $("span.reply_update:eq("+idx+")").text();
		var replytext = $("input#replytext:eq("+idx+")").val();
		if(text == "수정"){
			$("span.reply_update:eq("+idx+")").remove();
			$("span.replytext:eq("+idx+")").remove();
			var output1 = "<span class='reply_update' style='cursor:pointer; font-size: 0.8em;'>수정취소</span>";
			var output2 = "<span class='replytext'><p class='replytext'>";
			output2 += "<textarea class='dis-block s-text7 size18 bo12 p-l-18 p-r-18 p-t-13 m-b-5'>"+replytext+"</textarea>";
			output2 += "<input type='hidden' id='replytext' name='replytext' value='"+replytext+"'>";
			output2 += "<div class='row'><div class='col-md-9'></div><div class='col-md-3'>"; 
			output2 += "<button id='btnRreply' class='flex-c-m bg1 bo-rad-23 hov1 s-text1 trans-0-4 m-l-20' style='background-color:#E65540;'>";
			output2 += "<span class='m-t-3 m-b-3 m-l-8 m-r-8' style='font-size: 0.8em;'>수정하기</span></button></div></div></p></span>";

			$("span.gubun:eq("+idx+")").before(output1);
			$("div.reply_info:eq("+idx+")").append(output2);
		}else if(text == "수정취소"){
			$("span.reply_update:eq("+idx+")").remove();
			$("span.replytext:eq("+idx+")").remove();
			
			var output1 = "<span class='reply_update' style='cursor:pointer; font-size: 0.8em;'>수정</span>";
			var output2 = "<span class='replytext'><p class='replytext'>"+replytext+"<textarea rows='5' cols='60' style='display:none'></textarea></p>";
			output2 += "<input type='hidden' id='replytext' name='replytext' value='"+replytext+"'>";
			output2 += "<div class='row' style='display:none;'><div class='col-md-9'></div><div class='col-md-3'>"; 
			output2 += "<button id='btnRreply' class='flex-c-m bg1 bo-rad-23 hov1 s-text1 trans-0-4 m-l-20' style='background-color:#E65540;'>";
			output2 += "<span class='m-t-3 m-b-3 m-l-8 m-r-8' style='font-size: 0.8em;'>수정하기</span></button></div></span>";
			
			$("span.gubun:eq("+idx+")").before(output1);
			$("div.reply_info:eq("+idx+")").append(output2);
		}
	});
	
	/* 댓글 수정하기 */
	$(document).on('click', 'button#btnRreply.flex-c-m.bg1.bo-rad-23.hov1.s-text1.trans-0-4.m-l-20', function(){
		var idx = $(this).index('button#btnRreply.flex-c-m.bg1.bo-rad-23.hov1.s-text1.trans-0-4.m-l-20');

		var replytext = $("p.replytext textarea:eq("+idx+")").val();
		var reply_idx = $("input#reply_idx:eq("+idx+")").val();
		var board_idx = $("#board_idx").val();
		var product_code = $("#pro_code").val();
		var modified_time = new Date();

		var param = {"reply_idx" : reply_idx, "replytext" : replytext, 
					"board_idx" : board_idx, "product_code" : product_code, "modified_time" : modified_time};
		
		$.ajax({
			type: "post",
			url: "${path}/reply/reply_update.do",
			data: param,
			dataType: "json",
			success: function(result){
				$("div.reply:eq("+idx+")").remove();
				
				var output = "<div class='reply'><div class='member_info'><span class='member'>"+result.name+"("+result.replyer+")</span>";
				output += "<span class='date'>"+changeDate(result.modified_time)+"</span></div>";
				
					output += "<div class='modify_info'><span class='reply_update' style='cursor:pointer; font-size: 0.8em;'>수정</span>";
					output += "<span class='gubun'>&nbsp;|&nbsp;</span>";
					output += "<span class='reply_delete' style='cursor:pointer; font-size: 0.8em;'>삭제</span></div>";
				
				output += "<div class='reply_info'><span class='idx'><input type='hidden' id='reply_idx' name='reply_idx' value='"+result.reply_idx+"'></span>";
				output += "<span class='replytext'><p class='replytext'>"+result.replytext+"<textarea rows='5' cols='60' style='display:none'></textarea></p>";
				output += "<input type='hidden' id='replytext' name='replytext' value='"+result.replytext+"'>";
				output += "<div class='row' style='display:none;'><div class='col-md-9'></div><div class='col-md-3'>"; 
				output += "<button id='btnRreply' class='flex-c-m bg1 bo-rad-23 hov1 s-text1 trans-0-4 m-l-20' style='background-color:#E65540;'>";
				output += "<span class='m-t-3 m-b-3 m-l-8 m-r-8' style='font-size: 0.8em;'>수정하기</span></button></div></span></div></div>";
				
				$("li.reply:eq("+idx+")").append(output);
			}
		});
	});
	
	$(document).on('click', 'span.reply_delete', function(){
		if(confirm("상품문의를 삭제하시겠습니까?")){
			var idx = $(this).index('span.reply_delete');
			var reply_idx = $("input#reply_idx:eq("+idx+")").val();
			var board_idx = $("#board_idx").val();
			var show_type = "Y";
			var param = {"reply_idx" : reply_idx, "board_idx" : board_idx, "show_type" : show_type};
			$.ajax({
				type: "post",
				url: "${path}/reply/reply_delete.do",
				data: param,
				dataType: "json",
				success: function(result){
					alert("상품문의를 삭제하였습니다.");
					listReply();
				}
			});
		}
	});
});

/* 댓글목록 */
function listReply(){
	var replyer = $("#replyer").val();
	var pro_code = $("#pro_code").val();
	var board_idx = $("#board_idx").val();
	var param = {"pro_code" : pro_code, "board_idx" : board_idx};
	$.ajax({
		type: "post",
		url: "${path}/reply/replyList.do",
		data: param,
		dataType: "json",//전송할 데이터 타입, dataType: 서버로부터 수신할 데이터 타입
		success: function(result){
			var output = "<ul>";
			for(var i=0; i<result.length; i++){
				output += "<li class='reply'><div class='reply'><div class='member_info'><span class='member'>"+result[i].name+"("+result[i].replyer+")</span><br>";
				output += "<span class='date' style='font-size: 0.8em;'>"+changeDate(result[i].modified_time)+"</span></div>";
				if(result[i].show_type == "N"){
					if(replyer == result[i].replyer){
						output += "<div class='modify_info'><span class='reply_update' style='cursor:pointer; font-size: 0.8em;'>수정</span>";
						output += "<span class='gubun'>&nbsp;|&nbsp;</span>";
						output += "<span class='reply_delete' style='cursor:pointer; font-size: 0.8em;'>삭제</span></div>";
					}
					output += "<div class='reply_info'><span class='idx'><input type='hidden' id='reply_idx' name='reply_idx' value='"+result[i].reply_idx+"'></span>";
					output += "<span class='replytext'><p class='replytext'>"+result[i].replytext+"<textarea rows='5' cols='60' style='display:none'></textarea></p>";
				}else{
					if(replyer == result[i].replyer){
						output += "<div class='modify_info' style='display:none'><span class='reply_update' style='cursor:pointer; font-size: 0.8em;'>수정</span>";
						output += "<span class='gubun'>&nbsp;|&nbsp;</span>";
						output += "<span class='reply_delete' style='cursor:pointer; font-size: 0.8em;'>삭제</span></div>";
					}
					output += "<div class='reply_info'><span class='idx'><input type='hidden' id='reply_idx' name='reply_idx' value='"+result[i].reply_idx+"'></span>";
					output += "<span class='replytext'><p class='replytext'>사용자의 요청에 의해 삭제되었습니다.<textarea rows='5' cols='60' style='display:none'></textarea></p>";
				}
				output += "<input type='hidden' id='replytext' name='replytext' value='"+result[i].replytext+"'>";
				output += "<div class='row' style='display:none;'><div class='col-md-9'></div><div class='col-md-3'>"; 
				output += "<button id='btnRreply' class='flex-c-m bg1 bo-rad-23 hov1 s-text1 trans-0-4 m-l-20' style='background-color:#E65540;'>";
				output += "<span class='m-t-3 m-b-3 m-l-8 m-r-8' style='font-size: 0.8em;'>수정하기</span></button></div></span></div></div></li><hr>";
			}
			output += "</ul>";
			
			$("#listReply").html(output);
		}
	});
}
</script>
				<p class="s-text8 p-b-5"><strong>댓글작성</strong></p>
				<textarea class="dis-block s-text7 size18 bo12 p-l-18 p-r-18 p-t-13 m-b-5" id="replytext" name="replytext" placeholder="댓글을 작성해주세요."></textarea>
				<input type="hidden" id="replyer" name="replyer" value="${sessionScope.member_id}">
				<div class="row">
					<div class="col-md-9"></div>
					<div class="w-size24 col-md-3" style="text-align: right;">
						<button id="btnReply" class="flex-c-m size1 bg1 bo-rad-20 hov1 s-text1 trans-0-4" style="background-color: #e65540;">
							댓글작성
						</button>
					</div>
				</div>
				<div id="listReply"></div>
			</div>
			<div class="col-md-3"></div>
		</div>
	</div>
</section>

<%@ include file="../include/body_footer.jsp" %>
</body>
</html>