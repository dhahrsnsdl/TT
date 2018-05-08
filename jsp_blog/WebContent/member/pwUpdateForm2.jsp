<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 

<% 
	String id = request.getParameter("id");
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

<DIV class="title">패스워드 변경</DIV>
 
<DIV class="content"> 
<FORM name='frm' method='POST' action='./prpwUpdateProc2.jsp'>
ID와 현재 비밀번호를 입력하고, 변경할 비밀번호를 2번 입력하세요<br>
  <TABLE>
    <TR>
      <TH>아이디</TH>
      <TD><input type="text" name="id" size="20" value="<%=id %>" required></TD>
    </TR>
    <TR>
      <TH>기존 비밀번호</TH>
      <TD><input type="password" name="chkpasswd" size="20" required></TD>
    </TR>
    <TR>
      <TH>변경할 비밀번호</TH>
      <TD><input type="password" name="npasswd" size="20" required></TD>
    </TR>
    <TR>
      <TH>변경할 비밀번호 재입력</TH>
      <TD><input type="password" name="chkNpasswd" size="20" required></TD>
    </TR>
  </TABLE>
  <DIV class='bottom'>
    <button class='button'>중복확인</button>
    <button class='button' onclick="window.close()">취소</button>
 </DIV>
</FORM>
</div>
</body>
<!-- *********************************************** -->
</html> 
