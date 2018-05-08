<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="member.memberDAO"/>
<jsp:useBean id="dto" class="member.memberDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%
	boolean flag = dao.update(dto);

%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function read(){
	var url = "./read.jsp";
	url += "?id=<%=dto.getId()%>";
	location.href=url;
}
</script>
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
 
<DIV class="title">정보 수정</DIV>
 
<DIV class="content">
<%
	if(flag){
		out.print("정보수정 완료했습니다. <br> <br>");
	}else{
		out.print("정보수정을 실패했습니다.");
	}
%>
</DIV> 
 
  <DIV class='bottom'>
    <button class='button' onclick="read()">정보 확인</button>
  </DIV>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
