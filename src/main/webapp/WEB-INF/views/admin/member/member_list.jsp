<%@page import="com.koreait.petshop.model.domain.Member"%>
<%@page import="com.koreait.petshop.model.common.Pager"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
   List<Member> memberList =(List)request.getAttribute("memberList");

   Pager pager = new Pager();
   pager.init(request,memberList);   //페이지에 대한 계산
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../../shop/inc/header.jsp" %>
<script>
$(function(){
   $("button").click(function(){
      location.href="/admin/product/registform"; //글쓰기 폼 요청
   });
});
</script>
<style type="text/css">
table {
   border-collapse: collapse;
   border-spacing: 0;
   width: 100%;
   border: 1px solid #ddd;
   border-radius: 9px;
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
}

   .container2 {
        border-radius: 20px;
        background-color: white;
        padding: 20px;
        overflow: hidden;
        margin:20px 100px 20px 100px;   /*위오아왼*/
      }
</style>
</head>
<body>

<%@ include file="../../shop/inc/top.jsp" %>

<h3 style="text-align:center">회원목록</h3>
<div class="container2">
   <table>
      <tr>
         <th>No</th>
         <th>회원ID</th>
         <th>회원이름</th>
         <th>회원번호</th>
         <th>회원이메일</th>
         <th>회원주소</th>
         <th>회원등록일</th>
      </tr>
       <%int num = pager.getNum(); %>
     <%int curPos = pager.getCurPos(); %>
      <%for(int i=1;i<=pager.getPageSize();i++){%>
       <%if(num<1) break; %>
      <%Member member = memberList.get(curPos++); %>
      <tr>
         <td><%=num-- %></td>
         <td><%=member.getUser_id() %></td>
         <td><%=member.getName() %></td>
         <td><%=member.getPhone() %></td>
         <td><%=member.getEmail_id() +"@"+ member.getEmail_server() %></td>
         <td><%=member.getAddr() %></td>
         <td><%=member.getRegdate() %></td>
      </tr>
      <%}%>
      <tr>
      <td colspan="7" style="text-align:center">

   <%if((pager.getFirstPage()-1)>=1){   //페이지가 있다면%> 
      <a href="/petshop/member/list?currentPage=<%=pager.getFirstPage()-1%>">◀</a>
      <%}else{ %>
      <a href="javascript:alert('처음 페이지입니다');">◀</a>
      <%} %>
      
         <%for(int i=pager.getFirstPage();i<=pager.getLastPage();i++){ %>
            <%if(i>pager.getTotalPage()) break; //페이지를 출력하는i가 총페이지수에 도달하면 반복문 탈출 %>
         <a href="/petshop/member/list?currentPage=<%=i%>" <%if(pager.getCurrentPage()==i){ %> class="pageNum" <%} %>>[<%=i %>]</a>
         
         <%} %>
         <%if((pager.getLastPage()+1)<pager.getTotalPage()){ %>
         <a href="/petshop/member/list?currentPage=<%=pager.getLastPage()+1%>">▶</a>
         <%}else{ %>
            <a href="javascript:alert('마지막 페이지입니다');">▶</a>      
            <%} %>      
      </td>
   </tr>
   </table>   
</div>
<%@ include file="../../shop/inc/footer.jsp" %>
<%@ include file="../../shop/inc/footerscript.jsp" %>
</body>
</html>