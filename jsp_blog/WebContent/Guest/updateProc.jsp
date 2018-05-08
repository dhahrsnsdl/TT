<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi2.jsp" %>
<jsp:useBean id="dto" class="Guest.GuestDTO" />
<jsp:useBean id="dao" class="Guest.GuestDAO" />
<jsp:setProperty property="*" name="dto"/>

<% 		
	String id = request.getParameter("id");
	if(id==null){
		id = (String)session.getAttribute("id"); //메뉴
	}
	String pw = (String)session.getAttribute("pw");
	boolean flag = false;
	boolean flag2 = dao.checkPasswd(id, pw);
	if(flag2){
	flag = dao.update(dto);
	}
%> 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<link href = "../css/style.css" rel="stylesheet">
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
<script type = "text/javascript">
function mlist(){
	var url = "guestForm.jsp";
	location.href=url;
}
</script>
</head> 
<body> 
<jsp:include page="/menu/top.jsp" />

<div class="content">
<%
if(flag){
	out.print("방명록를 수정했습니다.");
} else {
	out.print("방명록 수정을 실패했습니다.");
}
%>
<br>
<button class = "button" onclick = "mlist()"> 목록 </button>
</div>
</body> 
</html> 