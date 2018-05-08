<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="member.memberDAO" />


<%
	String id = request.getParameter("id");
	if(id==null) {
		id=(String)session.getAttribute("id");
	}
	String uploadbtn = dao.getUploadBtn(id);

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
 
<DIV class="title"></DIV>
 
<FORM name='frm' method='POST' action='./deleteProc.jsp'>
<input type="hidden" name="id" value="<%=id %>">
<input type="hidden" name="uploadbtn" value="<%=uploadbtn %>">
  <DIV class="content">
탈퇴를 하시면 더이상 컨텐츠를 제공받을 수 없습니다.<br>
그래도 탈퇴를 원하시면 아래 탈퇴버튼을 클릭하세요.<br>    
   </DIV>
  
  <DIV class='bottom'>
    <button class='button'>탈퇴</button>
    <button class='button' onclick='history.back()'>취소</button>
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
