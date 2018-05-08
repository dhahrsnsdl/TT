<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="member.memberDAO" />

<%
	String email = request.getParameter("email");
	Boolean flag = dao.duplicateEmail(email);

%>

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function use(){
	opener.frm.email.value='<%=email%>';
	self.close();
}
</script>
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
<DIV class="title"> 이메일 중복 확인</DIV>
 
<DIV class="content"> 입력된 이메일 : <%=email %><br><br>

<%
	if(flag){
		out.print("중복되어 사용할 수 없습니다.<br><br>");
	}else{
		out.print("중복아님. 사용 가능합니다.<br><br>");
		out.print("<button class = 'button' onclick='use()'>사용</button>");
	}


%>

</DIV> 
 
  <DIV class='bottom'>
    <button class='button' onclick="location.href='./email_form.jsp'">다시 시도</button>
    <button class='button' onclick='window.close()'>창 닫기</button>

  </DIV>
</body>
<!-- *********************************************** -->
</html> 
