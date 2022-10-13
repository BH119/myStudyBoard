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

<c:import url="../header.jsp" />
	<div style="display: flex; justify-content: space-between; margin-top: 20px;">
			<h2>게시물 개수:${listCount}</h2>
		<div>	
			<!-- 원두,콜드브루,조회수 정렬  -->
			<button type="button" onclick="location.href='imgBoard1?recent=3'" 
	      				   class="btn btn-outline-info" name="beans">최신순</button>
			<button type="button" onclick="location.href='imgBoard1?beans=1'" 
	      				   class="btn btn-outline-info" name="beans">원두</button>
			<button type="button" onclick="location.href='imgBoard1?coldBrew=2'" 
	      				   class="btn btn-outline-info" name="coldBrew">콜드브루</button>
			<button type="button" onclick="location.href='imgBoard1?orderHit=orderHit'" 
	      				   class="btn btn-outline-info" name="orderHit">조회수순</button>
	    </div>  				   
	</div>      				   
<div class="row row-cols-1 row-cols-md-4">
 <c:forEach var="dto" items="${list}">
	<div class="col mb-3">
	  <div class="card h-100">
	    <img src="${dto.img_board_filepath }${dto.img_board_filename1 }" class="card-img-top" alt="...">
	    <div style="display: flex; justify-content: space-between; padding: 5px 10px 0px 10px;" class="card-body">
	      <h5 class="card-title"><a href="imgView?img_board_idx=${dto.img_board_idx }">${dto.img_board_title}</a></h5>
	       <p class="card-text">조회수 : ${dto.img_board_hit }</p>
	     </div>
<!-- 	     <div style="display: flex; justify-content: space-between; padding: 5px 10px 0px 10px;" class="card-body"> -->
<%-- 	       <p class="card-title"><c:set var="dateVar" value="${ dto.img_board_date }" /> --%>
<%-- 			<fmt:formatDate value="${dateVar}" pattern="yyyy-MM-dd"/></p> --%>
<%-- 	       <p class="card-text">추천수 : ${dto.img_board_rm }</p> --%>
<!-- 	     </div> -->
	  </div>
	</div>
  </c:forEach>
</div>
<button type="button" onclick="location.href='imgBoardWrite'" class="btn btn-outline-primary">글쓰기</button>
	
	
<!-- 검색 옵션 설정 -->
<form action="imgBoard1" method="get">
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
  		onclick='location.href="imgBoard1?page=${page-1}&recent=${recent}&selectList=${ selectList}&keyword=${keyword}&coldBrew=${coldBrew}&beans=${beans}&orderHit=${orderHit}"'>Previous</button></li>
    </c:when>
    <c:otherwise>
    	<li><button class="page-link" 
    	onclick='location.href="imgBoard1?page=${page-1}&recent=${recent}&selectList=${ selectList}&keyword=${keyword}&coldBrew=${coldBrew}&beans=${beans}&orderHit=${orderHit}"' disabled="disabled">Previous</button></li>
    </c:otherwise>
   </c:choose> 
    
   	<c:forEach var="i" begin="${ startPage}" end="${ endPage}">
   		<li><a class="page-link" 
   		
   		href="imgBoard1?page=${i}&recent=${recent}&selectList=${ selectList}&keyword=${keyword}&coldBrew=${coldBrew}&beans=${beans}&orderHit=${orderHit}">${i}</a></li>
  	  </c:forEach>
    
   <c:choose>
  	<c:when test="${page < totalPage}">
  		<li><button class="page-link" onclick='location.href="imgBoard1?page=${page+1}&recent=${recent}&selectList=${selectList}&keyword=${keyword}&coldBrew=${coldBrew}&beans=${beans}&orderHit=${orderHit}"'>Next</button></li>
    </c:when>
    <c:otherwise>
    	<li><button class="page-link" 
    	onclick='location.href="imgBoard1?page=${page+1}&recent=${recent}&selectList=${selectList}&keyword=${keyword}&coldBrew=${coldBrew}&beans=${beans}&orderHit=${orderHit}"' disabled="disabled">Next</button></li>
    </c:otherwise>
   </c:choose>
  </ul>
</div>
 


</div>
</body>
</html>