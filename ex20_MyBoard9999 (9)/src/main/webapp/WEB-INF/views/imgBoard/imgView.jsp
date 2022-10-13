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


</head>
<body>

<!-- 수정하기폼 -->
<div class="container1">
	<form action="" method="post" enctype="multipart/form-data">
	<input type="hidden" name="img_board_idx" value="${dto.img_board_idx }">
	<h2>글번호 :${dto.img_board_idx }</h2>
	  <div class="form-group">
	    <label for="exampleFormControlInput1">글 제목 </label>
	    <input type="text" value="${dto.img_board_title }" name="boardTitle"class="form-control" id="exampleFormControlInput1" placeholder="글 제목">
	  </div>
	  <div class="form-group">
	    <label for="exampleFormControlInput1">글쓴이</label>
	    <input type="text" value="${dto.img_board_name }" name="boardName"class="form-control" id="exampleFormControlInput1" readonly="readonly" value="" placeholder="글 제목">
	  </div>
	  <div class="form-group">
	    <label for="exampleFormControlInput1">조회수</label>
	    <input type="text" value="${dto.img_board_hit }" class="form-control" id="exampleFormControlInput1" disabled="disabled">
	  </div>
	  <div class="form-group">
	    <label for="exampleFormControlInput1">작성일</label>
	    <input type="text"  class="form-control" id="exampleFormControlInput1" disabled="disabled" value="${dto.img_board_date }">
	  </div>
	  <div class="form-group">
	    <label for="exampleFormControlInput1">이미지</label>
	    <div class="card mb-3" style="max-width: 760px;">
		  <div class="row no-gutters">
		      <img style="width: 150px; height: 150px;" src="${ dto.img_board_filepath }${dto.img_board_filename1}" alt="...">
		      <img style="width: 150px; height: 150px;" src="${ dto.img_board_filepath }${dto.img_board_filename2}" alt="...">
		      <img style="width: 150px; height: 150px;" src="${ dto.img_board_filepath }${dto.img_board_filename3}" alt="...">
		      ${ dto.img_board_filepath }${dto.img_board_filename1}<br>
		      ${ dto.img_board_filepath }${dto.img_board_filename2}<br>
		      ${ dto.img_board_filepath }${dto.img_board_filename3}
		    <div class="col-md-8">
		      <div class="card-body">
		      </div>	
		    </div>
		  </div>
		</div>
	  </div>

	  <div class="form-group">
	    <label for="exampleFormControlTextarea1">글 내용</label>
	    <textarea name="boardContent" class="form-control" id="exampleFormControlTextarea1"  rows="6">${dto.img_board_content }</textarea>
	  </div>
	  
  	  <button type="button" onclick="location.href='/'" class="btn btn-outline-primary">목록가기</button>
	</form>
	
	<!-- 댓글 작성 폼 -->
	<form action="imgReplyAction" method="post"  class="form-inline" style="margin-top: 40px" enctype="multipart/form-data">
		<input type="hidden" name="reply_img_board_idx" value="${dto.img_board_idx }">
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