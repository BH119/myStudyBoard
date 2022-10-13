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
<c:import url="./header.jsp" />


<style type="text/css">


@import url('https://fonts.googleapis.com/css2?family=Raleway:wght@400;700&display=swap');

}
body{
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background: #050801;
    font-family: 'Raleway', sans-serif;
    font-weight: bold;
}
#sandPwNum{
    position: relative;
    display: inline-block;
    color: #03e9f4;
    text-decoration: none;
    text-transform: uppercase;
    transition: 0.5s;
    overflow: hidden;
   
}
#sandPwNum:hover{
    background: #03e9f4;
    color: #050801;
    box-shadow: 0 0 5px #03e9f4,
                0 0 25px #03e9f4,
                0 0 50px #03e9f4,
                0 0 200px #03e9f4;
     -webkit-box-reflect:below 1px linear-gradient(transparent, #0005);
}
#sandPwNum:nth-child(1){
    filter: hue-rotate(270deg);
}
#sandPwNum:nth-child(2){
    filter: hue-rotate(110deg);
}
#sandPwNum span{
    position: absolute;
    display: block;
}
#sandPwNum span:nth-child(1){
    top: 0;
    left: 0;
    width: 100%;
    height: 2px;
    background: linear-gradient(90deg,transparent,#03e9f4);
    animation: animate1 1s linear infinite;
}
@keyframes animate1{
    0%{
        left: -100%;
    }
    50%,100%{
        left: 100%;
    }
}
#sandPwNum span:nth-child(2){
    top: -100%;
    right: 0;
    width: 2px;
    height: 100%;
    background: linear-gradient(180deg,transparent,#03e9f4);
    animation: animate2 1s linear infinite;
    animation-delay: 0.25s;
}
@keyframes animate2{
    0%{
        top: -100%;
    }
    50%,100%{
        top: 100%;
    }
}
#sandPwNum span:nth-child(3){
    bottom: 0;
    right: 0;
    width: 100%;
    height: 2px;
    background: linear-gradient(270deg,transparent,#03e9f4);
    animation: animate3 1s linear infinite;
    animation-delay: 0.50s;
}
@keyframes animate3{
    0%{
        right: -100%;
    }
    50%,100%{
        right: 100%;
    }
}


#sandPwNum span:nth-child(4){
    bottom: -100%;
    left: 0;
    width: 2px;
    height: 100%;
    background: linear-gradient(360deg,transparent,#03e9f4);
    animation: animate4 1s linear infinite;
    animation-delay: 0.75s;
}
@keyframes animate4{
    0%{
        bottom: -100%;
    }
    50%,100%{
        bottom: 100%;
    }
}



</style>






<script type="text/javascript">
$(function(){

	//이름 아이디 교집합체크
	$("#nextStep").click(function(){
		var member_name =  $("#member_name").val();
		var member_id =  $("#member_id").val();
		console.log(member_name)
		console.log(member_id)
		$.ajax({
	            url : "pwFindNextStep",
	            type : 'post',
	            data : {
		            	member_name:member_name,
		            	member_id:member_id
	            	   },
	            success : function(data) {
	            	if(data == "1"){ //db쪽 namd,id값 일치
		            	console.log("data : " +  data);
		            	$("#emSendForm").removeAttr('style')
		            	$("#member_name").attr('readonly' , true);
		            	$("#member_id").attr('readonly' , true);
		            	$("#chkMSG").html('<div class="alert alert-primary">가입된 이메일을 입력해주세요.</div>');
	            	}
	            	else{//db쪽 namd,id값 불일치
	            		$("#chkMSG").html('<div class="alert alert-primary">일치하는 값이 없습니다.</div>');
	            	}
				} //통신성공
		}); // ajax
	});	// 다음으로액션
	
	// 이메일 발송 액션
	$("#sandPwNum").click(function(){
		var member_name =  $("#member_name").val();
		var member_id =  $("#member_id").val();
		var member_email = $("#member_email").val();
		$.ajax({
	            url : "PwEmailAction",
	            type : 'post',
	            data : {
		            	member_name:member_name,
		            	member_id:member_id,
		            	member_email:member_email
	            	   },
	            success : function(data) {
	            	if(data == "1"){
		            	console.log("data : " +  data);
		            	alert("비밀번호가 전송되었습니다.")
		            	$("#member_email").attr('readonly' , true);
		            	$("#sandPwNum").attr('disabled' , true);
		            	$("#chkEmMSG").html('<div class="alert alert-primary">이메일이 일치합니다!</div>');
		            	$("#nextStep").attr('style',"display:none;") 
	            	}
	            	else{
	            		$("#chkEmMSG").html('<div class="alert alert-primary">이메일이 틀립니다..</div>');
	            	}
				} //통신성공
		}); // ajax
	});//이메일클릭액션
});	//온로드



</script>


</head>
<body>

<div class="container1" style="width: 28%; margin-top: 100px">
	<form action="pwFindAction1" method="post">
	  
	   이름<input name="member_name" id=member_name  type="text" class="form-control"  placeholder="이름">
	  
	  <div class="form-group"  >
	   아이디<input name="member_id" id=member_id  type="text" class="form-control" placeholder="아이디">
	  </div>
	  <div id="chkMSG">
	 	<div class="alert alert-primary">이름과 아이디를 입력해주세요.</div>
	  </div>
	  <div id="emSendForm" style="display: none;">
	   이메일
		  <div class="form-group" style="display: flex; justify-content: space-between;">
		    <input id="member_email" style="width: 75%" name="member_email" type="email" class="form-control"  placeholder="이메일"><br>
		    <button type="button" id="sandPwNum" style="width: 130px" class="btn btn-outline-primary">비밀번호전송</button>
		  </div>
		  
		  

		  
		  
		  
		  
		  
		  
		  
		  
		  
		  <div id="chkEmMSG">
	  	  </div>
	  </div>
	  <button type="button" id="nextStep" class="btn btn-primary">다음으로</button>
	  <button type="button" onclick="location.href='/'" class="btn btn-primary">목록가기</button>
	</form>
</div>
</body>
</html>