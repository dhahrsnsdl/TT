<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi2.jsp"%>
<jsp:useBean id="dao" class="Guest.GuestDAO" />

<%
    int num = Integer.parseInt(request.getParameter("num"));
	String id = request.getParameter("id");
	String pw = (String)session.getAttribute("pw");
	if(id==null){
		id = (String)session.getAttribute("id"); //메뉴
	}
	Boolean flag = dao.checkPasswd(id, pw);
	Boolean flag2 = dao.checkId(id, num);
    if(flag&&flag2){
    dao.delete(num);
    //자료추가
    }
    else{
    }
    response.sendRedirect("./guestForm.jsp");   
%>
