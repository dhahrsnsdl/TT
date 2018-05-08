<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="bbs.BbsDAO" />
 
<% 
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	boolean flag = dao.checkRefnum(bbsno);
	
	
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
<script type = "text/javascript">
function blist(){
	var url = "list.jsp";
	url += "?col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	
	location.href=url;
	
}
</script>
 <link href="../css/style.css" rel="Stylesheet" type="text/css" />
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 <% if(flag){ %>
<DIV class="content"> 
부모글이므로 삭제가 불가능합니다.
</DIV>
<DIV class='bottom'>
<input type='button' value='뒤로가기' onclick="history.back()">
<input type='button' value='목록' onclick="blist()">
</DIV>
<%}else{ %>
<DIV class="title">비밀번호 입력</DIV>
 
<FORM name='frm' method='POST' action='deleteProc.jsp'>
<input type="hidden" name="bbsno" value="<%=bbsno%>"> 
<input type="hidden" name="col" value="<%=request.getParameter("col")%>">
<input type="hidden" name="word" value="<%=request.getParameter("word")%>">
<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>">
<input type="hidden" name="oldfile" value="<%=request.getParameter("oldfile")%>">
  <TABLE>
    <TR>
      <TH>패스워드</TH>
      <TD><input type="password" name="passwd" placeholder="비밀번호를 입력하세요" required></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='삭제'>
    <input type='button' value='목록' onclick="blist()">
    <%}%>
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
