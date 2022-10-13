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
<title>커뮤니티 게시판</title>

</head>
<body>

<div class="container">

<c:import url="./header.jsp" />
	<h2>게시물 개수:${listCount}</h2>
	
	
	<!-- 리스트 출력  -->
	<table class="table">
	  <thead>
	    <tr>
	      <th scope="col">번호</th>
	      <th scope="col">이름</th>
	      <th scope="col">이미지</th>
	      <th scope="col">제목</th>
	      <th scope="col">작성일</th>
	      <th scope="col"><button type="button" onclick="location.href='/?orderHit=orderHit'" 
	      				   class="btn btn-secondary" name="orderHit">조회수순</button></th>
	    </tr>
	  </thead>
	  <tbody>
	  <c:forEach var="dto" items="${list}">
	    <tr>
	      <th scope="row">${ dto.board_idx }</th>
	      <td>${ dto.board_name }</td>
	      <td> <img style="width: 80px; height: 80px;" src="${ dto.filepath }${dto.filename1}"> </td>
	      <td><a href="modifyForm?board_idx=${ dto.board_idx }">${ dto.board_title }</a></td>
	      <td><c:set var="dateVar" value="${ dto.board_date }" />
			<fmt:formatDate value="${dateVar}" pattern="yyyy-MM-dd"/></td>
	      <td>${ dto.board_hit }</td>
			
	    </tr>
	  </c:forEach>
	  <c:choose>
	  	<c:when test="${ not empty member_id }">
		    <tr>
			    <td colspan='6'>
			   		<button type="button" onclick="location.href='boardWrite'" class="btn btn-outline-primary">글쓰기</button>
			 	</td>
		    </tr>
	  	</c:when>
    	<c:otherwise>
    		<tr>
			    <td colspan='6'>
			   		<button type="button" onclick="location.href='boardWrite'" class="btn btn-outline-primary" disabled="disabled">글쓰기</button>
			 	</td>
		    </tr>
   		</c:otherwise>
   	  </c:choose> 
	 </tbody>
	</table>
<!-- 검색 옵션 설정 -->	
<form action="/" method="get">
  <div class="form-row" style="justify-content: center;">
    <div class="form-group">
      <select name="selectList"  id="inputState" class="form-control" style="width: 100%;">
        <option value="title">제목</option>
        <option value="write">글쓴이</option>
      </select>
    </div>
    <div class="form-group">
      <input type="text" name="keyword" class="form-control" id="inputZip">
    </div>
  <button type="submit" class="btn btn-primary" style=" height:38px" >검색</button>
  </div>
  
</form>



<!-- 페이지네비  -->
<div>
  <ul class="pagination justify-content-center">
  <c:choose>
  	<c:when test="${page > 1}">
  		<li><button class="page-link" 
  		onclick='location.href="/?page=${page-1}&selectList=${ selectList}&keyword=${keyword}&orderHit=${orderHit}"'>Previous</button></li>
    </c:when>
    <c:otherwise>
    	<li><button class="page-link" 
    	onclick='location.href="/?page=${page-1}&selectList=${ selectList}&keyword=${keyword}&orderHit=${orderHit}"' disabled="disabled">Previous</button></li>
    </c:otherwise>
   </c:choose> 
    
   	<c:forEach var="i" begin="${ startPage}" end="${ endPage}">
   		<li><a class="page-link" 
   		
   		href="/?page=${i}&selectList=${ selectList}&keyword=${keyword}&orderHit=${orderHit}">${i}</a></li>
  	  </c:forEach>
    
   <c:choose>
  	<c:when test="${page < totalPage}">
  		<li><button class="page-link" onclick='location.href="/?page=${page+1}&selectList=${selectList}&keyword=${keyword}&orderHit=${orderHit}"'>Next</button></li>
    </c:when>
    <c:otherwise>
    	<li><button class="page-link" 
    	onclick='location.href="/?page=${page+1}&selectList=${selectList}&keyword=${keyword}&orderHit=${orderHit}"' disabled="disabled">Next</button></li>
    </c:otherwise>
   </c:choose>
  </ul>
</div>
 


</div>
</body>
</html>