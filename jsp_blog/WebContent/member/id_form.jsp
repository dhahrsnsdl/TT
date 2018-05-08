<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<style>
@charset "UTF-8";
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
*{
	font-family: 'Nanum Pen Script' !important;
	font-size: 20px;
	text-align: center;
}
</style>
</head> 
<!-- *********************************************** -->
<body>
<DIV class="title">ID 중복확인</DIV>
 
<DIV class="content"> 
<FORM name='frm' method='POST' action='./id_proc.jsp'>
ID를 입력하세요<br><br>
  <TABLE>
    <TR>
      <TH>아이디</TH>
      <TD><input type="text" name="id" size="20" required></TD>
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
