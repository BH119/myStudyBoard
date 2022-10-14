<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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



<div class="container1">
	<form action="one2oneWriteAction2?one2one_idx=${dto.one2one_idx }" method="post" name="" >
		아아아아아아아${dto.one2one_content }
	  <div class="form-group">
	    <label for="exampleFormControlInput1">글쓴이</label>
	    <input type="text" name="one2oneName"class="form-control" id="exampleFormControlInput1" value="${member_id}" readonly="readonly">
	  </div>
	  <div class="form-group">
	    <label for="exampleFormControlInput1">글제목</label>
	    <input type="text" name="one2oneTitle"class="form-control" id="exampleFormControlInput1" placeholder="글 제목">
	  </div>
	  <div class="form-group">
	    <label for="exampleFormControlTextarea1">글 내용</label>
	    <textarea name="one2oneContent" class="form-control" id="exampleFormControlTextarea1" placeholder="글 내용" rows="6"></textarea>
	  </div>
  	  <button id="write"type="submit" value="submit" name="write1" class="btn btn-outline-primary">글쓰기</button>
  	  <button type="button" onclick="location.href='one2one/one2one'" class="btn btn-outline-primary">취소하기</button>
	  
	</form>

</div>

</body>
</html>