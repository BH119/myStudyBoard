<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/all.css" >
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" >
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>



<script type="text/javascript">

$(function(){ 
	//수정하기버튼 클릭시 이벤트발생
	$("button[name='modifyBtn']").click(function () { 
		
		//멀티플 
		if( $("#filename").val() != "" ){ 
			var files=$('#filename')[0].files; // 오브젝트를 변형시킴
		    console.log("원시데이터오브젝트가 출력된다:"+$('#filename')[0]); 
		    console.log("파일리스트오브젝트가 출력된다:"+files);
	        for(var i= 0; i<files.length; i++){
	            console.log('file_name :'+files[i].name);
				var ext = files[i].name.split('.').pop().toLowerCase(); //확장자명만 자르기
				
				//배열 내의 값을 찾아서 인덱스를 반환합니다.(요소가 없을 경우 -1을 반환).
				if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) { 
				 	alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
				 	return false;      
	            }
			}
		}
		var maxSize = 5 * 1024 * 1024; // 5MB
		var fileSize = $("#filename")[0].files[0].size;
		
		if(fileSize > maxSize){
			alert("첨부파일 사이즈는 5MB 이내로 등록 가능합니다.");
			$("#filename").val("");
			return false;
		}
	});
});	
	


</script>​ 









</head>
<body>

<!-- 수정하기폼 -->
<div class="container1">
	<form action="modifyAction" method="post" enctype="multipart/form-data">
	<input type="hidden" name="filename1" value="${dto.filename1 }">
	<input type="hidden" name="filename2" value="${dto.filename2 }">
	<input type="hidden" name="filename3" value="${dto.filename3 }">
	<input type="hidden" name="boardIdx" value="${dto.board_idx }">
	<h2>글번호 :${dto.board_idx }</h2>
	  <div class="form-group">
	    <label for="exampleFormControlInput1">글 제목 </label>
	    <input type="text" value="${dto.board_title }" name="boardTitle"class="form-control" id="exampleFormControlInput1" placeholder="글 제목">
	  </div>
	  <div class="form-group">
	    <label for="exampleFormControlInput1">글쓴이</label>
	    <input type="text" value="${dto.board_name }" name="boardName"class="form-control" id="exampleFormControlInput1" readonly="readonly" value="" placeholder="글 제목">
	  </div>
	  <div class="form-group">
	    <label for="exampleFormControlInput1">조회수</label>
	    <input type="text" value="${dto.board_hit }" class="form-control" id="exampleFormControlInput1" disabled="disabled">
	  </div>
	  <div class="form-group">
	    <label for="exampleFormControlInput1">작성일</label>
	    <input type="text"  class="form-control" id="exampleFormControlInput1" disabled="disabled" value="${dto.board_date }">
	  </div>
	  <div class="form-group">
	    <label for="exampleFormControlInput1">이미지</label>
	    <div class="card mb-3" style="max-width: 760px;">
		  <div class="row no-gutters">
		      <img style="width: 150px; height: 150px;" src="${ dto.filepath }${dto.filename1}" alt="...">
		      <img style="width: 150px; height: 150px;" src="${ dto.filepath }${dto.filename2}" alt="...">
		      <img style="width: 150px; height: 150px;" src="${ dto.filepath }${dto.filename3}" alt="...">
		      ${ dto.filepath }${dto.filename1}<br>
		      ${ dto.filepath }${dto.filename2}<br>
		      ${ dto.filepath }${dto.filename3}
		    <div class="col-md-8">
		      <div class="card-body">
		      </div>	
		    </div>
		  </div>
		</div>
	  </div>
	 <!-- 파일업로드 -->
	  <input type="file" id="filename" name="filenames" multiple="multiple" >		
	  <button type="button" onclick="location.href='imgDelete?board_idx=${dto.board_idx }&filename1=${dto.filename1}&filename2=${dto.filename2}&filename3=${dto.filename3}'" class="btn btn-outline-primary">이미지 삭제하기</button>

	  <div class="form-group">
	    <label for="exampleFormControlTextarea1">글 내용</label>
	    <textarea name="boardContent" class="form-control" id="exampleFormControlTextarea1"  rows="6">${dto.board_content }</textarea>
	  </div>
	  
	  <c:if test="${member_id == dto.board_name}">
  	  <button type="submit" name="modifyBtn" class="btn btn-outline-primary">수정하기</button>
  	  <button type="button" onclick="location.href='listDelete?board_idx=${dto.board_idx }&filename1=${dto.filename1}&filename2=${dto.filename2}&filename3=${dto.filename3}'" class="btn btn-outline-primary">삭제하기</button>
	  </c:if>
  	  <button type="button" onclick="location.href='/'" class="btn btn-outline-primary">목록가기</button>
	</form>
	
	<!-- 댓글 작성 폼 -->
	<form action="replyAction" method="post"  class="form-inline" style="margin-top: 40px" enctype="multipart/form-data">
		<input type="hidden" name="reply_board_idx" value="${dto.board_idx }">
		<div class="input-group mb-2 mr-sm-2">
				<input type="text" name="reply_name" class="form-control mb-1 mr-sm-1"
					id="inlineFormInputName2" value="${member_id}" readonly="readonly">
		</div>
		<div class="input-group mb-2 mr-sm-2">
			<div class="input-group-prepend">
				<div class="input-group-text">내용</div>
			</div>
			<textarea name="reply_content" class="form-control" id="inlineFormInputGroupUsername2"
				placeholder="내용"></textarea>
		</div>
		<button type="submit" class="btn btn-primary mb-2">댓글달기</button>
	</form>
	
	<!-- 댓글리스트 -->
	<table class="table">
	  <thead>
	    <tr>
	      <th scope="col">번호</th>
	      <th scope="col">이름</th>
	      <th scope="col">내용</th>
	      <th scope="col">작성일</th>
	      <th scope="col">삭제하기</th>
	    </tr>
	  </thead>
	  <tbody>
		<c:forEach var="dto1" items="${list}">
			<tr>
				<th scope="row">${ dto1.reply_idx }</th>
				<td>${ dto1.reply_name }</td>
				<td style="width: 50%;">${ dto1.reply_content }</td>
				<td><c:set var="dateVar" value="${ dto1.reply_date }" /> <fmt:formatDate
						value="${dateVar}" pattern="yyyy-MM-dd" /></td>
				<c:if test="${member_id == dto1.reply_name}">		
					<td> <button type="button" onclick="location.href='replyDelete?reply_idx=${ dto1.reply_idx }&reply_board_idx=${dto1.reply_board_idx }'"
					class="btn btn-outline-primary">삭제하기</button> </td>
				</c:if>
			</tr>
		</c:forEach>
	</tbody>
	</table>
	</div>

</body>
</html>