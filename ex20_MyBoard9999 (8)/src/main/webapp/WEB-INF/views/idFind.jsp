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
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="./header.jsp" />
<script type="text/javascript">





$(function(){

	//인증번호 전송
	$("#idfindBtn").click(function(){
		var member_emVal =  $("#member_email").val();
		var member_nameVal =  $("#member_name").val();
		
		$.ajax({
	            url : "/idFind/idFindAction",
	            type : 'post',
	            data : {
	            	member_emVal : member_emVal,
	            	member_nameVal : member_nameVal
	            	},
	            dataType: "json", 	// 아니 t를 대문자로 써야하는걸 어케알아!!!
	            success : function(date) {
	            	console.log(date)
	            	console.log(date[1].member_id+"ddddddd")
	            	if(date != "0"){
	                    var str = "";
		            	 // .each는 제이쿼리식 json배열로 들어온 값을 하나씩 출력해줌
	                 	$("#idFindResult").attr('style',"display:none;")
		            	 $.each(date, function(i){                  
		                        str += date[i].member_id +  '<p style ="opacity: 0.5;">'+moment(date[i].member_joindate).format("YYYY-MM-DD")+'</p>' ;
		                       
		                 	$("#idFindResult").html('<div class="alert alert-primary">'+str+'</div>');
		                 	
		                 });//each문
		                 $("#idFindResult").animate({
	                 	      height: 'toggle'
	                 	 });//애니메이트
	            	}
	            	else{
	            		$("#idFindResult").attr('style',"display:none;") 
	            		 $("#idFindResult").html('<div class="alert alert-primary">일치하는 값이 없습니다.</div>');
	            		 $("#idFindResult").animate({
	                 	      height: 'toggle'
	                 	 });//애니메이트
	            	}
	            	
				} //통신성공
		}); // ajax
	});	// 이메일전송클릭액션
});	//온로드





</script>


</head>
<body>
<div class="container1" style="width: 28%; margin-top: 100px">
	<form action="idFindAction" method="post" >
	  <input type="hidden" id=idChked value="no">
	  이름
	  <input name="member_name" id=member_name  type="text" class="form-control"  placeholder="이름">
	  
	  이메일
	  <div class="form-group" style="display: flex">
	  <input id="member_email" style="width: 75%" name="member_email" type="email" class="form-control"  placeholder="이메일"><br>
	  <button id="idfindBtn" type="button" style="width: 130px; margin-left: 10px" class="btn btn-outline-primary">아이디 찾기</button>
	  </div>
	  <div id="idFindResult">
	  	<div class="alert alert-primary">이름과 이메일을 입력해주세요.</div>
	  </div>
	  <button type="button" onclick="location.href='/'" class="btn btn-primary">취소하기</button>
	</form>
</div>
</body>
</html>