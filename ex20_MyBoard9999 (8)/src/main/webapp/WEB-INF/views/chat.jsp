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
	$("#chatWriteBtn").click(function(){
		var member_nameVal =  $("#member_name").val();
		var chat_contentVal =  $("#chat_content").val();
		
		
		$.ajax({
	            url : "/chatAction",
	            type : 'post',
	            data : {
	            	member_nameVal : member_nameVal,
	            	chat_contentVal : chat_contentVal
	            	},
	            success : function(date) { 
				} //통신성공
		}); // ajax
	});	// 이메일전송클릭액션
});	//온로드

function chatview(){
	$.ajax({
        url : "/chatview",
        dataType: "json",
        success : function(date) { 
        	var str = "";
        	console.log(date);
        	 $.each(date, function(i){                  
                    str +='<p>'+ date[i].chat_name + ':'+ date[i].chat_content +'</p>' ;
                   
             	$("#chatting").html('<div class="alert alert-primary">'+str+'</div>');
             	
             });//each문
		} //통신성공
}); // ajax
}

setInterval(chatview,1000);



</script>


</head>
<body>
<div class="container1" style="width: 28%; margin-top: 100px">
	<form action="chatAction1" method="post" >
	  이름
	  <input name="member_name" id=member_name  type="text" class="form-control">
	  
	  내용
	  <div class="form-group" style="display: flex">
	  <input id="chat_content" style="width: 75%" name="chat_content" type="text" class="form-control"><br>
	  <button id="chatWriteBtn" type="button" style="width: 130px; margin-left: 10px" class="btn btn-outline-primary">전송</button>
	  </div>
	  <div id="chatResult">
	  	<div class="alert alert-primary">유봉현님의 채팅방 입니다
	  		<div id="chatting">
	  		</div>
	  	</div>
	  </div>
	  <button type="button" onclick="location.href='/'" class="btn btn-primary">홈으로..</button>
	</form>
</div>
</body>
</html>