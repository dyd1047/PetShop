<%@page import="com.koreait.petshop.model.domain.Board"%>
<%@page import="java.util.List"%>
<%@page import="com.koreait.petshop.model.common.Pager"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	Pager pager = (Pager)request.getAttribute("pager");
	List<Board> boardList = pager.getList();
	
%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

	<%@ include file="../inc/header.jsp" %>
	
	<style type="text/css">
		table {
	  	border-collapse: collapse;
	  	border-spacing: 0;
	 	 width: 100%;
	  	border: 1px solid #ddd;
		}
	
		th, td {
		  text-align: left;
		  padding: 16px;
		}
		
		tr:nth-child(even) {
		  background-color: #f2f2f2;
		}	
		
	.pageNum{
	font-size:15pt;
	color:red;
	font-weight:bold;
	</style>
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>
    
    <!-- Header Section Begin -->
   <%@include file="../inc/top.jsp" %>
    <!-- Header End -->
	

<table>
  <tr>
    <th>No</th>
    <th>제목</th>
    <th>작성자</th>
    <th>등록일</th>
    <th>조회수</th>
  </tr>
  
    <%int num = pager.getNum(); %>
	  	  <%int curPos = pager.getCurPos(); %>
	  	  
		  <%for(int i=0;i<pager.getPageSize();i++){ %>
		  <%if(num<1) break; %>
		  <%Board board = boardList.get(curPos++); %>
		  <tr>
		    <td><%=num-- %></td>
		    <td><a href="/shop/qna/detail?board_id=<%=board.getBoard_id()%>"><%=board.getTitle() %></a>  [<%= board.getCnt()%>]</td>
		    <td><%=board.getWriter() %></td>
		    <td><%=board.getRegdate().substring(0,10) %></td>
		    <td><%=board.getHit() %></td>
		  </tr>
		  <%} %>
		  <tr>
		<td colspan="5" style="text-align:center">

		<%if((pager.getFirstPage()-1)>=1){   //페이지가 있다면%> 
		<a href="/shop/qna/list?currentPage=<%=pager.getFirstPage()-1%>">◀</a>
		<%}else{ %>
		<a href="javascript:alert('처음 페이지입니다');">◀</a>
		<%} %>
		
			<%for(int i=pager.getFirstPage();i<=pager.getLastPage();i++){ %>
				<%if(i>pager.getTotalPage()) break; //페이지를 출력하는i가 총페이지수에 도달하면 반복문 탈출 %>
			<a href="/shop/qna/list?currentPage=<%=i%>" <%if(pager.getCurrentPage()==i){ %> class="pageNum" <%} %>>[<%=i %>]</a>
			
			<%} %>
			<%if((pager.getLastPage()+1)<pager.getTotalPage()){ %>
			<a href="/shop/qna/list?currentPage=<%=pager.getLastPage()+1%>">▶</a>
			<%}else{ %>
				<a href="javascript:alert('마지막 페이지입니다');">▶</a>		
			<%} %>		
		</td>
	</tr>
    
    
     <tr>
    <td colspan="6" style="text-align:center">
		<button onClick="location.href='/shop/qna/qnaregistForm';">글등록</button>
    </td>
  </tr>
</table>

    
    <!-- Partner Logo Section End -->
    <%@ include file="../inc/footer.jsp" %>
    <!-- Footer Section End -->

    <!-- Js Plugins -->
	<%@ include file="../inc/footerscript.jsp" %>
</body>

</html>