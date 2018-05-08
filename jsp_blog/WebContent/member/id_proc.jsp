<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="member.memberDAO" />

<%
	String id = request.getParameter("id");
	Boolean flag = dao.duplicateId(id);

%>

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function use(){
	opener.frm.id.value='<%=id%>';
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
<!-- *********************************************** -->
 
<DIV class="title">중복 확인</DIV>
 
<DIV class="content">입력된 아이디 : <%=id %><br>

<%
	if(flag){
		out.print("중복되어 사용할 수 없습니다.<br>");
	}else{
		out.print("중복아님. 사용 가능합니다.<br>");
		out.print("<button class = 'button' onclick='use()'>사용</button>");
	}
%>
</DIV> 
 
  <DIV class='bottom'>
    <button class='button' onclick="location.href='./id_form.jsp'">다시 시도</button>
    <button class='button' onclick='window.close()'>창 닫기</button>
  </DIV>
</body>
<!-- *********************************************** -->
</html> 
