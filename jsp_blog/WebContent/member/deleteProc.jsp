<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="member.memberDAO"/>
<%
	String id = request.getParameter("id");
	String uploadbtn = request.getParameter("uploadbtn");
	
	boolean flag = dao.delete(id);
	
	if(flag){
		if(uploadbtn!=null && !uploadbtn.equals("member.jpg")){
		UploadSave.deleteFile(upDir, uploadbtn);}
		
		session.invalidate();
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
 
<DIV class="title">탈퇴 확인</DIV>

<DIV class="content">
<%
	if(flag){
		out.print("탈퇴되었습니다. 자동 로그아웃 되었습니다.");
	}else{
		out.print("탈퇴가 실패하였습니다.");
	}
%>
</DIV> 
  
  <DIV class='bottom'>
    <button class='button' onclick="location.href='../index.jsp'">홈</button>
    <button class='button' onclick="history.back()">다시시도</button>
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
