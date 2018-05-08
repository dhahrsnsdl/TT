<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="member.memberDAO"/> 

<%
	String uploadbtn = null;
	UploadSave upload = new UploadSave(request,-1,-1,tempDir);

	String id = upload.getParameter("id");
	String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
	
	FileItem fileItem = upload.getFileItem("uploadbtn");
	
	int size = (int)fileItem.getSize();
	

	
	if(size>0){
		if(oldfile!=null && !oldfile.equals("member.jpg"))
		UploadSave.deleteFile(upDir, oldfile);
		
		uploadbtn = UploadSave.saveFile(fileItem, upDir);
		
	}
	
	Map<String,String>map = new HashMap<String,String>();
	map.put("id", id);
	map.put("uploadbtn", uploadbtn);
	
	boolean flag = dao.updateFile(map);
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function read(){
	var url = "./read.jsp";
	url += "?id=<%=id%>";
	
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
 
<DIV class="title">사진 변경</DIV>
<DIV class="content">
<%

	if(flag){
		out.print("사진을 변경했습니다.");
	}else{
		out.print("사진 변경을 실패했습니다.");
	}

%>

</DIV>

<DIV class='bottom'>
	<button class='button' onclick="read()">나의 정보 보기</button>
</DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
