<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file = "/ssi/ssi2.jsp" %>
<jsp:useBean id="dao" class="memo.MemoDAO" />

<% request.setCharacterEncoding("utf-8"); 
	int memono = Integer.parseInt(request.getParameter("memono"));
	
	boolean flag = dao.delete(memono);

%> 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
* {
	font-family: 'Nanum Pen Script' !important;
	font-size : 28px;
}
html {
	background: url(memo.jpg) no-repeat center center fixed;
	background-size:cover;
	-ms-filter:"progid:DXImageTransform.Microsoft.AlphaImageLoader(src='memo.jpg', sizingMethod='scale')";
}
.search{
	width: 80%;
	text-align: center;
	margin: 2px auto;
}
.button {
    background-color: #555555;
    border: none;
    padding: 5px 10px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-family: 'Nanum Pen Script' !important;
    font-size: 18px;
}

</style>
<link href = "../css/style.css" rel="stylesheet">
<script type="text/javascript">
function mlist(){
	var url = "list.jsp"
	location.href=url;	
}
</script>

</head> 
<body>
<div class="content">
<%
if(flag){
	out.print("메모를 삭제했습니다.");
}else{
	out.print("메모 삭제를 실패했습니다.");
}
%>
<br>
<button class ="button" onclick="mlist()"> 목록</button>
</div> 
</body> 
</html> 