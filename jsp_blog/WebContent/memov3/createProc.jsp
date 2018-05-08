<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/ssi/ssi2.jsp" %>
<jsp:useBean id="dao" class="memo.MemoDAO" />
<jsp:useBean id="dto" class="memo.MemoDTO" />
<!-- dao, dto 객체 2개를 생성했다. 범위가 있다. -->

<jsp:setProperty name="dto" property="*"/>

<!-- dto에는 setter getter가 있는데 setter를 호출 할 수 있다. setter가 호출되었다. 그리고 request.getParameter를 포함하고 있다. 변수명이 다를때는 param(parameter)를 추가한다. 
	* asterisk로 모든 변수 등록 가능하다. -->

<%
	boolean flag = dao.create(dto);
%>

<!-- createPROC는 직접 브라우저에서 호출하면 안된다. 폼에서 submit을 통해서 액션 값을 호출하고 있기 때문에 form action은 submit에 대해서 자연스럽게 호출되고 응답한다. -->

<!--  NAME 속성을 써야 넘어온다. 코딩 중 가끔 실수하는 것이 폼에서 텍스트에어리어 같은 경우에는 네임 속성이 자동으로 만들어지지 않는다. 그래서
name tag를 만들지 않으면 데이터가 넘어가지 않는다. 이름을 반드시 써 줘야한다. 그래야 파라메터 값으로 데이터를 받을 수 있다. -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
* {
	font-family: 'Nanum Pen Script' !important;
	font-size : 28px;
}
body{
font-family: 'Nanum Pen Script' !important;
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

div {
	text-align: center;
}

</style>
</head>
<body>
<!-- 스크립틀릿으로 if문을 써준다. -->
	<div>
	
	<%
	if(flag) {
		out.print("메모를 등록했습니다.");
	}else{
		out.print("메모 등록을 실패했습니다.");
		
	}
	%>
	
	<br>
	<button class = "button" onclick="location.href='./memoCreate.jsp'"> 계속 등록 </button>
	<button class = "button" onclick="location.href='./list.jsp'"> 목록 </button>
	</div>
	<!-- on으로 시작하는 것 이벤트 설정 이벤트 설정은 자바스크립트가 해준다. -->
</body>
</html>