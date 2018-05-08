<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.memberDAO"/>
<%  UploadSave upload = new UploadSave(request,-1,-1,tempDir); 
	String id = upload.getParameter("id");
	String email = upload.getParameter("email");
	
	String str = ""; //메세지를 담을 문자열
	
	if(dao.duplicateId(id)){
		str = "중복된 아이디 입니다. 아이디 중복 확인을 하세요";
	}else if(dao.duplicateEmail(email)){
		str = "중복된 이메일 입니다. 이메일 중복 확인을 하세요";		
	}else{
		request.setAttribute("upload",upload);
%>
		<jsp:forward page="/member/createProc.jsp" />
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
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">중복 확인</DIV>
<DIV class="content"> <%=str %></DIV>

  <DIV class='bottom'>

    <button class='button' onclick="history.back()">다시 시도</button>
  </DIV>

<!-- location.href response.sendRedirect --> 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
