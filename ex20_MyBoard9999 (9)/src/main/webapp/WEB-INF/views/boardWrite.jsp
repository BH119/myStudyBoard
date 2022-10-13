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
<script type="text/javascript">

// $(function(){ 
// 	//글쓰기버튼 클릭시 이벤트발생
// 	$("button[name='write1']").click(function () { 
		
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



<div class="container1">
	<form action="boardWriteAction" method="post" name="" enctype="multipart/form-data">
	  <div class="form-group">
	    <label for="exampleFormControlInput1">글쓴이</label>
	    <input type="text" name="boardName"class="form-control" id="exampleFormControlInput1" value="${member_id}" readonly="readonly">
	  </div>
	  <div class="form-group">
	    <label for="exampleFormControlInput1">글제목</label>
	    <input type="text" name="boardTitle"class="form-control" id="exampleFormControlInput1" placeholder="글 제목">
	  </div>
	  <div class="form-group">
	    <label for="exampleFormControlTextarea1">글 내용</label>
	    <textarea name="boardContent" class="form-control" id="exampleFormControlTextarea1" placeholder="글 내용" rows="6"></textarea>
	  </div>
	  <div class="form-group">
	    <label for="exampleFormControlInput1">이미지 첨부</label>
		    <input type="file" name="filename" id="filename" multiple="multiple" class="form-control" >
<!-- 		    <input type="file" name="filename" id="filename1" class="form-control" id="exampleFormControlInput1"> -->
<!-- 		    <input type="file" name="filename" class="form-control" id="exampleFormControlInput1"> -->
<!-- 		    <input type="file" name="filename" class="form-control" id="exampleFormControlInput1"> -->
	  </div>
  	  <button id="write"type="submit" value="submit" name="write1" class="btn btn-outline-primary">글쓰기</button>
  	  <button type="button" onclick="location.href='/'" class="btn btn-outline-primary">취소하기</button>
	  
	</form>

</div>

</body>
</html>