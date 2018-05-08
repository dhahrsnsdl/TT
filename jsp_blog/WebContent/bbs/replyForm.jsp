<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="bbs.BbsDAO"/>


<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	//부모의 grpno, 부모의 indent, 부모의 ansnum이 필요하다.
	BbsDTO dto = dao.readReply(bbsno);
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
function blist(){
	var url = "list.jsp";
	url += "?col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	
	location.href=url;
	
}
function incheck(f){
	if(f.wname.value==""){
		alert("이름을 입력하세요");
		f.wname.focus();
		
		return false;
		
	}
	if(f.title.value==""){
		alert("제목을 입력하세요");
		f.title.focus();
		
		return false;
		
	}
	if(f.content.value==""){
		alert("내용을 입력하세요");
		f.content.focus();
		
		return false;
		
	}
	if(f.passwd.value==""){
		alert("비번을 입력하세요");
		f.passwd.focus();
		
		return false;
		
	}
	
}

</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">답변</DIV>
 
<FORM name='frm' 
	  method='POST' 
	  action='./replyProc.jsp'
	  onsubmit="return incheck(this)"
	  enctype="multipart/form-data">

<input type="hidden" name="bbsno" value="<%=bbsno %>">
<input type="hidden" name="col" value="<%=request.getParameter("col") %>">
<input type="hidden" name="word" value="<%=request.getParameter("word") %>">
<input type="hidden" name="grpno" value="<%=dto.getGrpno() %>">
<input type="hidden" name="indent" value="<%=dto.getIndent() %>">
<input type="hidden" name="ansnum" value="<%=dto.getAnsnum() %>">
<input type="hidden" name="nowpage" value="<%=request.getParameter("nowPage")%>">

  <TABLE>
    <TR>
      <TH>성명</TH>
      <TD><input type="text" name="wname"></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" value="<%=dto.getTitle()%>"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><textarea rows="10" cols="45" name="content"></textarea></TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd"></TD>
    </TR>
    <TR>
      <TH>파일명</TH>
      <TD><input type="file" name="filename"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='답변'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html>