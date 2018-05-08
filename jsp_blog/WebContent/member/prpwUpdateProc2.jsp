<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="member.memberDAO" />
<jsp:useBean id="dto" class="member.memberDTO" />
<jsp:setProperty name="dto" property="*"/>

<%
	String id = request.getParameter("id");	
	String chkpasswd = request.getParameter("chkpasswd");	
	
	String str = "";
	Boolean flag = dao.checkPasswd(id, chkpasswd);
	
	if(flag==false){
		str = "아이디가 존재하지 않거나, <br> 비밀번호가 잘못되었습니다.";
	}else{
%>
		<jsp:forward page="/member/pwUpdateProc2.jsp" />
<%
	return;
	}
%>	

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<style>
@charset "UTF-8";
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
</style>
</head> 
<!-- *********************************************** -->
<body>
<!-- *********************************************** -->

<DIV class="title">중복 확인</DIV>
 
<DIV class="content">
<%=str %>
</DIV> 
 
  <DIV class='bottom'>
    <button class='button' onclick="location.href='./pwUpdateForm2.jsp?id=<%=id%>'">다시 시도</button>
    <button class='button' onclick='window.close()'>창 닫기</button>
  </DIV>
</body>
<!-- *********************************************** -->
</html> 
