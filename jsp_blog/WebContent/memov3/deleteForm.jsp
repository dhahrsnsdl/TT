<%@ page contentType="text/html; charset=UTF-8"%>
<<jsp:useBean id="dao" class="memo.MemoDAO" />
<%
	request.setCharacterEncoding("utf-8");
	int memono = Integer.parseInt(request.getParameter("memono"));
	boolean flag = dao.checkRefnum(memono);
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
<link href="../css/style.css" rel="stylesheet">
<script type="text/javascript">
	function mlist() {
		var url = "list.jsp";
		location.href = url;
	}
</script>
</head>
<body>

<% if(flag){ %>
<DIV class="content">
부모글이므로 삭제가 불가능합니다.
</DIV>
<DIV class="bottom">
<button class="button" onclick="mlist()">목록</button>
<%}else{ %>
	<jsp:include page="/menu/top.jsp" />
	<div class="title">삭제 확인</div>

	<div class="content">
		<form method="post" action="deleteProc.jsp">
			<input type="hidden" name="memono" value="<%=memono%>"> <br>
			삭제를 하면 복구가 될 수 없습니다.<br> 삭제하려면 삭제버튼을 클릭하세요.<br> 취소는 목록 버튼을
			누르세요 <br> <br>
			<button class="button">삭제처리</button>
			<button class="button" onclick="mlist()">목록</button>
		</form>
<%} %>
	</div>
	<jsp:include page="/menu/bottom.jsp" />
</body>
</html>
