<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi2.jsp"%>
<jsp:useBean id="dao" class="Guest.GuestDAO" />


<%
	int num = Integer.parseInt(request.getParameter("num"));
	String id = request.getParameter("id");
	String pw = (String)session.getAttribute("pw");
	if(id==null){
		id = (String)session.getAttribute("id"); //메뉴
	}
	Boolean flag = dao.checkPasswd(id, pw);
	Boolean flag2 = dao.checkId(id, num);
	GuestDTO dto = dao.read(num);
	
	System.out.println("checkPasswd(id, pw) : " + flag);
	System.out.println("checkId(id, num) : " + flag2);
	//System.out.println(id);
	//System.out.println(pw);
	//System.out.println(num);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/style.css" rel="stylesheet" />
<script>
	function incheck() {

		var f = document.frm;

		if (f.title.value == "") {
			alert("제목을 입력하세요")
			f.title.focus();
			return;
		}
		if (f.content.value == "") {
			alert("내용을 입력하세요")
			f.content.focus();
			return;
		}

		f.submit();
	}
</script>
<link href="../css/style.css" rel="stylesheet">
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);

</style>
</head>

<body>
<%	if(flag&&flag2){%>
	<jsp:include page="/menu/top.jsp" />
	<div class="title">방명록 수정</div>

	<form name="frm" action="updateProc.jsp" method="POST">
		<input type="hidden" name="num" value="<%=dto.getNum()%>"> <input
			type="hidden" name="id" value="<%=dto.getId()%>">
		<table>
			<tr>
				<th>글번호  ,  아이디</th>
				<td><%=num %>  ,  <%=id%></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="30" name="content"><%=dto.getContent()%></textarea>
				</td>
			</tr>

		</table>



		<div class="bottom">
			<button class="button" onclick="incheck()">전송</button>
		</div>
	</form>
	<jsp:include page="/menu/bottom.jsp" />
<%
	}else{%>
	<jsp:include page="/menu/top.jsp" />
	<br>
	<br>
	<div class = "content">
	회원님이 등록하신 글이 아닙니다.<br><br>
    <button class='button' onclick="location.href='./guestForm.jsp'">돌아가기</button>
	</div>
	<jsp:include page="/menu/bottom.jsp" />

<%}%>
</body>
</html>
