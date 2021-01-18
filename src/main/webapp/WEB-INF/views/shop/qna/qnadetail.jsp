<%@page import="com.koreait.petshop.model.domain.Board"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	Board board = (Board)request.getAttribute("board");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title  -->
	<%@ include file="../inc/header.jsp" %>
	
	<style type="text/css">
	body {font-family: Arial, Helvetica, sans-serif;}
	* {box-sizing: border-box;}
		
		input[type=text], select, textarea {
		  width: 100%;
		  padding: 12px;
		  border: 1px solid #ccc;
		  border-radius: 4px;
		  box-sizing: border-box;
		  margin-top: 6px;
		  margin-bottom: 16px;
		  resize: vertical;
		}

		input[type=button] {
		  background-color: #252525;
		  color: white;
		  padding: 12px 50px;
		  border: solid white;
		  border-radius: 4px;
		  cursor: pointer;
		  border-radius:9px;
		}
		
		input[type=button]:hover {
		  background-color: gray;
		  
		}
		
		.container2 {
		  border-radius: 9px;
		  background-color: #252525;
		  padding: 20px;
		  overflow: hidden;
		  margin:20px 100px 20px 100px;	/*위오아왼*/
		}

		.reply-list{
			overflow:hidden;
		}
		.reply-list p{
			float:left;
		}
	
	</style>
	
<script type="text/javascript">
	$(function(){
		CKEDITOR.replace("content"); //textarea의 id가 content인 컴포넌트를 편집기 스킨으로 변경
		
		$($("input[type='button']")[0]).click(function(){
			edit();
		});
		$($("input[type='button']")[1]).click(function(){
			del();
		});
		
		getCommentList(); //댓글 목록 비동기로 가져오기!!!
	});
	//글등록 요청
	function 	edit(){
		if(confirm("수정하시겠어요?")){
		$("#formData").attr({
			action:"/shop/qna/edit",
			method:"post"
		});		
		$("#formData").submit();
		}
	}
	
	function 	del(){
		if(confirm("삭제하시겠어요?")){
			
		$("#formData").attr({
			action:"/shop/qna/delete",
			method:"get"	//form태그 안에 있는 히든값인 board_id가 전송됨
		});		
		$("#formData").submit();
		}
	}
	
	function getCommentList(){
		$.ajax({
			url:"/shop/qna/comments/list",
			type:"post",
			data:{
				board_id : <%=board.getBoard_id()%>
			},
			success:function(result){
				//console.log(result);
				//alert(result);
				$("#list-area").html("");
				var tag="";
				for(var i=0;i<result.length;i++){
					var comments = result[i];
					tag+="<div class=\"reply-list\" style=\"border:5px solid black;\">";
					tag+="<p style=\"width:75%\">"+comments.msg+"</p>"; 
					tag+="<p style=\"width:12%\">"+comments.author+"</p>";
					tag+="<p style=\"width:10%\">"+comments.cdate+"</p>"; 
					tag+="</div>";
				}
				$("#list-area").html(tag);  //innerHTML과 동일
				
			}
			
		});
		
	}
	
	function registComment(){
		$.ajax({
			url:"/shop/qna/comment/regist",	
			type:"post",
			data:{ 
				board_id: <%=board.getBoard_id()%>,
				msg:$("input[name='msg']").val(),
				author:$("input[name='author']").val()
			},
			//피드백은 success로 받는다, 즉 서버에서 에러없이 데이터가 결과값이 전송되면
			//success 우측에 명시된 익명함수가 동작하게 된다.. 
			success:function(result){
				//alert("서버로 부터 받은 결과 데이터 "+result);
				var json = JSON.parse(result);
				if(json.result==1){
					getCommentList();
					document.getElementById("msg").value='';
					document.getElementById("author").value='';

				}else{
					alert("등록실패");
				}
			}		
		});
		
	}
	
</script>


</head>

<body>
    	<%@include file="../inc/top.jsp" %>
        <!-- ****** Top Discount Area End ****** -->
	<h3 style="text-align:center">공지 게시판</h3>

<div class="container2">
  <form id="formData">
  	
    <input type="hidden" name="board_id" value="<%=board.getBoard_id()%>">
    <input type="hidden" name="hit" value="<%=board.getHit()%>" >
    <input type="text" name="title" value="<%=board.getTitle()%>" readonly>
    <input type="text" name="writer" value="<%=board.getWriter()%>" readonly>
    <textarea id="content" name="content" style="height:200px" readonly><%=board.getContent() %></textarea>
    
    <input type="button" value="글수정">
    <input type="button" value="글삭제">
    <input type="button" value="목록보기" onClick="location.href='/shop/qna/list'">
	<div class="reply-box" style="background-color :rgb(37,37,37); ">
		<input type="text" name="msg" id="msg" placeholder="댓글 입력.." style="width:70%">
		<input type="text" name="author" id="author" placeholder="작성자 입력.." style="width:12%">
		<input type="button" color="white" onClick="registComment()" value="댓글등록">
	</div> 
	<div id="list-area"  style="background-color :white; margin:50px 0px 20px 0px; " ></div>	   
  </form>
</div>
        <!-- ****** Footer Area Start ****** -->
        <%@ include file="../inc/footer.jsp" %>
        <!-- ****** Footer Area End ****** -->
    <!-- /.wrapper end -->
    <!-- Js Plugins -->
	<%@ include file="../inc/footerscript.jsp" %>
</body>

</html>