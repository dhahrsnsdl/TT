<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi2.jsp" %> 
<jsp:useBean id="dao" class="memo.MemoDAO"/>  
   
<%
	int memono = Integer.parseInt(request.getParameter("memono"));
	
	MemoDTO dto = dao.read(memono);

 %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href = "../css/style.css" rel = "stylesheet"/>
<script>
function incheck(){
	
	var f = document.frm;
	
	if(f.title.value==""){
		alert("제목을 입력하세요")
		f.title.focus();
		return;
	}
	if(f.content.value==""){
		alert("내용을 입력하세요")
		f.content.focus();
		return;
	}
	
	f.submit();
}
</script>
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
</head>

<body>
<jsp:include page="/menu/top.jsp" /> 
<div class="title">
수정
</div>

<form name = "frm" action="updateProc.jsp" method="POST">
<input type ="hidden" name ="memono" value ="<%=dto.getMemono()%>">
<table>
	<tr>
	<th>제목</th>
	<td><input type="text" name="title" size="30" value='<%=dto.getTitle()%>'>
	</td>
	</tr>
	<tr>
	<th>내용</th>
	<td><textarea rows="10" cols="30" name="content"><%=dto.getContent()%></textarea>
	</td>
	</tr>
	
	</table>


<div class="bottom">
<button class="button" onclick="incheck()"> 전송 </button>
</div>
</form>
<jsp:include page="/menu/bottom.jsp"/>
</body>
</html>
