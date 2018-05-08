<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp"%>

<%
	Cookie cookie = new Cookie("windowOpen", "close");
	cookie.setMaxAge(1*60);
	response.addCookie(cookie);
%>

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title>접속 환영</title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
	window.close();
</script>

</head> 
<!-- *********************************************** -->
<body style = "background-color: #55FF55">
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 