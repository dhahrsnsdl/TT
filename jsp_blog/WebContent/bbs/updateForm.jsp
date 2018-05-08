<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %>
<jsp:useBean id ="dao" class= "bbs.BbsDAO"/>

<% 
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	BbsDTO dto = dao.read(bbsno);
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style>
@charset "UTF-8";
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

*{
	font-family: 'Nanum Pen Script' !important;
	font-size: 28px;
}
.search{
	width: 80%;
	margin: 2px auto;
	text-align : center;
}
html {
	background: url(bbs.jpg) no-repeat center center fixed;
	background-size:cover;
	-ms-filter:"progid:DXImageTransform.Microsoft.AlphaImageLoader(src='bbs.jpg', sizingMethod='scale')";
}
</style>
 <link href="../css/style.css" rel="Stylesheet" type="text/css" />
<script type="text/javascript">
function incheck(){
	
	var f = document.frm;
	
	if(f.wname.value==""){
		alert("이름을 입력하세요");
		f.wname.focus();
		
		return;
		
	}
	if(f.title.value==""){
		alert("제목을 입력하세요");
		f.title.focus();
		
		return;
		
	}
	if(f.content.value==""){
		alert("내용을 입력하세요");
		f.content.focus();
		
		return;
		
	}
	if(f.passwd.value==""){
		alert("비번을 입력하세요");
		f.passwd.focus();
		
		return;
		
	}
	
	f.submit();
	
}

</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">수정</DIV>
 
<FORM name='frm' 
	  method='POST' 
	  action='./updateProc.jsp'
	  enctype="multipart/form-data">
	  <input type ="hidden" name ="bbsno" value ="<%=dto.getBbsno()%>">
	  <input type ="hidden" name ="col" value ="<%=request.getParameter("col")%>">
	  <input type ="hidden" name ="word" value ="<%=request.getParameter("word")%>">
	  <input type ="hidden" name ="nowPage" value ="<%=request.getParameter("nowPage")%>">
	  <input type ="hidden" name ="oldfile" value ="<%=dto.getFilename()%>">
  <TABLE>
    <TR>
      <TH>성명</TH>
      <TD><input type="text" name="wname" value="<%=dto.getWname()%>"></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" value="<%=dto.getTitle()%>"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><textarea rows="10" cols="45" name="content"><%=dto.getContent()%></textarea></TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd"></TD>
    </TR>
    <TR>
      <TH>파일명</TH>
      <TD><input type="file" name="filename">(<%=Utility.checkNull(dto.getFilename()) %>)</TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='수정' onclick="incheck()">
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html>