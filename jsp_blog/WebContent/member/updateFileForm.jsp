<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 
 
<% 
	String id = request.getParameter("id");
	String oldfile = request.getParameter("oldfile");
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
 
<DIV class="title">사진 수정</DIV>
 
<FORM name='frm' method='POST' action='./updateFileProc.jsp' enctype="multipart/form-data">
  <input type="hidden" name="id" value="<%=id %>">
  <input type="hidden" name="oldfile" value="<%=oldfile %>">
  
  
  <TABLE>
    <TR>
      <TH>원본파일</TH>
      <TD>
      <img src="./storage/<%=oldfile %>" width=240px height=180px><br>
      원본파일명 : <%=oldfile %>
      </TD>
    </TR>
    <TR>
      <TH>변경파일</TH>
      <TD>
      <input type="file" name="uploadbtn" accept=".jpg,.gif,.png">
      </TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <button class='button'>사진 변경</button>
    <button class='button' onclick="history.back()">취소</button>
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
