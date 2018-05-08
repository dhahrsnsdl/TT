<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="member.memberDAO" />

<%	
	String id = request.getParameter("id");	
	String npasswd = request.getParameter("npasswd");	
	String chkNpasswd = request.getParameter("chkNpasswd");
	
	boolean flag = false;
	
	if(npasswd.equals(chkNpasswd)){
	flag = dao.updatePasswd(id, npasswd);
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
 
<DIV class="content">입력된 아이디 : <%=id %><br>

<br>

<%
	if(flag){
		out.print("비밀번호를 변경했습니다.<br>");
	}else {
		out.print("변경할 비밀번호가 일치하지 않습니다.<br>");
	}
%>
</DIV> 
 
  <DIV class='bottom'>
    <button class='button' onclick="location.href='./pwUpdateForm2.jsp?id=<%=id%>'">다시 시도</button>
    <button class='button' onclick='window.close()'>창 닫기</button>
  </DIV>
</body>
<!-- *********************************************** -->
</html> 
