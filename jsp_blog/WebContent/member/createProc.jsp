<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="member.memberDAO" />
<jsp:useBean id="dto" class="member.memberDTO" />
<%
	String upDir4 = request.getSession().getServletContext().getRealPath("/administrator/product/storage");
	String tempDir4 = request.getSession().getServletContext().getRealPath("/administrator/product/temp");
	UploadSave upload = new UploadSave(request, -1, -1, tempDir4);

	dto.setMname(UploadSave.encode(upload.getParameter("mname")));
	dto.setId(UploadSave.encode(upload.getParameter("id")));
	dto.setAddress1(UploadSave.encode(upload.getParameter("address1")));
	dto.setAddress2(UploadSave.encode(upload.getParameter("address2")));
	dto.setZipcode(upload.getParameter("zipcode"));
	dto.setEmail(upload.getParameter("email"));
	dto.setJob(upload.getParameter("job"));
	dto.setPasswd(upload.getParameter("passwd"));
	dto.setTel(upload.getParameter("tel"));

	FileItem fileItem = upload.getFileItem("uploadBtn");
	String uploadBtn = "member.jpg";
	int size = (int) fileItem.getSize();

	if (size > 0) {
		uploadBtn = UploadSave.saveFile(fileItem, upDir);
	}

	dto.setUploadBtn(uploadBtn);
	boolean flag = dao.create(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
function login(){
	var url = "./loginForm.jsp";
	location.href=url;
}
</script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<style>
@charset "UTF-8";

@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

* {
	font-family: 'Nanum Pen Script' !important;
	font-size: 20px;
	text-align: center;
}
</style>
</head>
<!-- *********************************************** -->
<body>
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->

	<DIV class="title">회원가입 처리</DIV>

	<DIV class="content">
		<%
			if (flag) {
				out.print("회원가입을 했습니다. <br> <br>");
				out.print("<button class='button' onclick='login()'>로그인</button>");
			} else {
				out.print("회원가입을 실패했습니다.");
			}
		%>

	</DIV>

	<DIV class='bottom'>
		<button class='button' onclick="location.href='../index.jsp'">홈</button>
	</DIV>
	</FORM>


	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
</html>
