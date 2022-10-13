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
<script type="text/javascript">





$(function(){
	$("#id").keyup(function(){
// 		alert($(this).val()); 
		$("#id").val($("#id").val().trim());
		
		var member_id = $("#id").val();
		
		if( $("#id").val().length >= 4 ) {
			$.ajax({
   				url: '/joinForm/idChkAjax?member_id='+member_id,	
   	    		type: 'get',
   	    		success: function(data) {
   	    			console.log('통신 성공, data:' + data);
   	    			
   	    			var data_num = Number( data );
   	    			if( data_num >= 1 ) {
   	    				//아이디가 중복됨.
   	    				$("#idChkMsg").html('<small style="padding: 4px;bottom: -6px; " class="alert alert-danger">아이디가 중복됩니다 다른아이디를 입력해 주세요.</small>');
   	    				$("#idChked").val("no");
   	    				console.log('idChked:' + $("#idChked").val());
   	    			}else{
   	    				//아이디가 중복 안됨. 사용 가능.
   	    				$("#idChkMsg").html('<small style="padding: 4px;bottom: -6px; " class="alert alert-success">아이디 사용이 가능한 아이디 입니다..</small>');
   	    				$("#idChked").val("yes")
   	    				console.log('idChked:' + $("#idChked").val());
   	    			}
   	    		}
   			});//ajax
		}
		else{
			$("#idChkMsg").html('<small style="padding: 4px;bottom: -6px; " class="alert alert-danger">아이디는 4자 이상적어주세요.</small>');
		};
	}); //키업이벤트

	//인증번호 전송
	$("#EmNum").click(function(){
		var member_em =  $("#member_email").val();
		console.log(member_em)
		$.ajax({
	            url : "/joinForm/emailAction",
	            type : 'post',
	            data : {member_em:member_em},
	            success : function(data) {
	            	console.log("data : " +  data);
	            	$("#member_email").attr('readonly' , true);
					alert('인증번호가 전송되었습니다.')
	            	$("#EmNum").html('재전송');
					
					
	            	$("#ChkNum").click(function(){
            			var ChkNumVal =  $("#ChkNumVal").val();
            			console.log(ChkNumVal)
            			
            			if(ChkNumVal === data){
            				alert('인증번호가 일치합니다.')
            				$("#ChkNumed").val("yes");
            				$("#ChkNumVal").attr('readonly' , true);
            				$("#EmNum").attr('disabled' , true);
            				console.log($("#ChkNumed").val());
	            		}
            			else{
            				alert('인증번호가 일치하지 않습니다.')
            				$("#ChkNumed").val("no");
	            		}
            		
	            	}) //인증번호확인클릭액션
				} //통신성공
		}); // ajax
	});	// 이메일전송클릭액션
});	//온로드


	function checkValue(){
		
		if(!$("#member_name").val()){
			alert("이름을 입력해주세요")
			return false;
		}
		if($("#id").val().length < 4){
			alert("아이디가 4자 이하입니다.")
			return false;
		}			
		if($("#member_pw").val() != $("#member_pwChk").val()){
			alert("비밀번호가 다릅니다.")
			return false;
		}
		if(!$("#member_pw").val()){
			alert("비밀번호를 입력해주세요")
			return false;
		}
		if(!$("#member_email").val()){
			alert("이메일을 입력해주세요")
			return false;
		}
		if($("#ChkNumed").val() == "no"){
			alert("이메일 인증번호확인이 필요합니다.")
			return false;
		}
		return true;
	}

</script>


</head>
<body>

<div class="container1" style="width: 28%; margin-top: 100px">
	<form action="joinAction" method="post" onsubmit="return checkValue();">
	  <input type="hidden" id=idChked value="no">
	  
	   이름<input name="member_name" id=member_name  type="text" class="form-control"  placeholder="이름">
	  
	  <div class="form-group"  >
	   아이디<input name="member_id" id=id  type="text" class="form-control" placeholder="아이디">
	    	<div id="idChkMsg" >
	    		<small style="padding: 4px;bottom: -6px; " class="alert alert-danger">아이디는 4자 이상 입력하세요.</small>
	    	</div>
	  </div>
	    
	  비밀번호 <input id="member_pw" name="member_pw" type="password" class="form-control" placeholder="비밀번호">
	  
	  비밀번호 확인 <input id="member_pwChk" type="password" class="form-control" id="exampleInputPassword1" placeholder="비밀번호 확인">
	  
	   이메일
	  <div class="form-group" style="display: flex; justify-content: space-between;">
	    <input id="member_email" style="width: 75%" name="member_email" type="email" class="form-control"  placeholder="이메일"><br>
	    <button type="button" id="EmNum" style="width: 130px" class="btn btn-outline-primary">인증번호 전송</button>
	  </div>
	  
	  <div class="form-group" style="display: flex">
	  <input  type="text" style="width: 200px" id ="ChkNumVal" name="ChkNumVal" class="form-control"  placeholder="인증번호 확인"> <br>
	  <button id="ChkNum" type="button" style="width: 130px; margin-left: 10px" class="btn btn-outline-primary">인증번호 확인</button>
	  <input type="hidden" id=ChkNumed value="no">
	  </div>
	  
	  <button id=joinButton type="submit" class="btn btn-primary">회원가입</button>
	  <button type="button" onclick="location.href='/'" class="btn btn-primary">취소하기</button>
	</form>
</div>
</body>
</html>