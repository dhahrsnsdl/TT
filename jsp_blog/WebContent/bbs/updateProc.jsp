<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi2.jsp" %> 
<jsp:useBean id="dao" class="bbs.BbsDAO"/>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>

 
<%	
	UploadSave upload = new UploadSave(request,-1,-1,tempDir2);
	dto.setWname(UploadSave.encode(upload.getParameter("wname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));

	dto.setBbsno(Integer.parseInt(upload.getParameter("bbsno")));
	
	String nowPage = upload.getParameter("nowPage");
	String col = upload.getParameter("col");
	String word = (UploadSave.encode(upload.getParameter("word")));
	String oldfile = (UploadSave.encode(upload.getParameter("oldfile")));
	
	FileItem fileItem = upload.getFileItem("filename");
	int size = (int)fileItem.getSize();
	String filename = null;

	if(size>0){
		UploadSave.deleteFile(upDir2, oldfile);
		filename=UploadSave.saveFile(fileItem, upDir2);
	}
	dto.setFilesize(size);
	dto.setFilename(filename);
	
	Map map = new HashMap();
	map.put("passwd", dto.getPasswd());
	map.put("bbsno", dto.getBbsno());
	
	
	
	boolean pflag = dao.passCheck(map);
	boolean flag = false;
	
	if(pflag){
		flag = dao.update(dto);
	}
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
	url += "?col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href=url;
	
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title"> 수정확인 </DIV>
 
<div class="content">
<%
if(pflag==false){
	out.print("비밀번호가 잘못되었습니다.");
	out.print("<button type='button' onclick='history.back()'>다시 시도</button>");
}else if(flag){
	out.print("글 수정을 성공했습니다.");
}else{
	out.print("글 수정을 실패했습니다.");
}
%>


</div> 
 
<FORM name='frm' method='POST' action='./.do'>
  <TABLE>
    <TR>
      <TH></TH>
      <TD></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='목록' onclick="blist()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
