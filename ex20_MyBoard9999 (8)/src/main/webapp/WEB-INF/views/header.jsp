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


<script type="text/javascript">


$(function(){
	$("#loginAction").click(function(){
	    var idVal =$("#idVal").val();
		var pwVal =$("#pwVal").val();
		console.log('aaaa' );
		$.ajax({
			url:'loginAction',
			type:'post',
			data : {        
				member_id: idVal,        
				member_pw: pwVal    
				},
			success: function(data) {
				console.log('통신 성공, data:' + data);
				if(data == 1){
					alert('로그인 성공');
					window.location.href = '/';
				}
				else{
					alert('로그인 실패');
				}
				
			}//통신성공
		})//ajax
	})//로그인액션
});//온로드




</script>





</head>
<body>

<div  class="container">
	<nav  class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand" href="#">HOME</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item active">
	        <a class="nav-link" href="/imgBoard1">이미지1 <span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="/one2one">1:1문의</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="/chat">채팅방</a>
	      </li>
	    </ul>
	    <c:if test="${ empty member_id }">
	    <form style="display: flex;" class="form-inline my-2 my-lg-0">
		    <div id="">
		      <input id="idVal" class="form-control mr-sm-1" type="search" placeholder="아이디" aria-label="Search">
		    </div >
		    <div id="bindingId">
		      <input id="pwVal" class="form-control mr-sm-1" type="search" placeholder="비밀번호" aria-label="Search">
		    </div>
	      <button id=loginAction class="btn btn-outline-success my-2 my-sm-0"  type="button">로그인</button>
	      <button class="btn btn-outline-success my-2 my-sm-0" onclick="location.href='joinForm'" style="margin-left: 10px" type="button">회원가입</button>
	      <div style="display: flex; flex-direction: column;">
		    <button  class="btn btn-outline-success my-2 my-sm-0" onclick="location.href='idFind'" style="margin-left: 10px; padding-top: 1px; padding-bottom: 1px; font-size: 10px;" type="button">ID찾기</button>
		    <button  class="btn btn-outline-success my-2 my-sm-0" onclick="location.href='pwFind'" style="margin-left: 10px; padding-top: 1px; padding-bottom: 1px; font-size: 10px;" type="button">비밀번호찾기</button>
	      </div>
	    </form>
	      </c:if>
	     
	     
	    <c:choose>
	     <c:when test="${ not empty member_id && member_id != 'admin'}">
		   	<span style="margin-right: 20px; height: 30px; font-size: 20px;" class="badge badge-pill badge-info">${member_id} 님 반갑습니다!!</span>
		   	<button style="margin-right: 10px;" onclick="location.href='logoutAction'" name=logout1 id=logout class="btn btn-outline-success my-2 my-sm-0"  type="button">로그아웃</button>
		   	<button name=mypage id=mypage  class="btn btn-outline-success my-2 my-sm-0"  type="button">마이페이지</button>
		   		
	     </c:when>	
	   	
	     <c:when test="${member_id == 'admin' }"> 
		   	<span style="margin-right: 20px; height: 30px; font-size: 20px;" class="badge badge-pill badge-info">${member_id} 님 반갑습니다!!</span>
		   	<button style="margin-right: 10px;" onclick="location.href='logoutAction'" name=logout2 id=logout class="btn btn-outline-success my-2 my-sm-0"  type="button">로그아웃</button>
		   	<button name=mypage id=mypage   class="btn btn-outline-success my-2 my-sm-0"  type="button">관리자페이지</button>
	   	 </c:when>
	   	</c:choose>
	  </div>
	</nav>
</div>
</body>
</html>