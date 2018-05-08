<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 

<jsp:useBean id="dao" class="Guest.GuestDAO"/>
<jsp:useBean id="dto" class="Guest.GuestDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%
    //게시물의 최대값 가져오기
    int maxNum = dao.getMaxNum();
   
    dto.setNum(maxNum + 1);
    dto.setIpAddr(request.getRemoteAddr());
   
    //자료추가
    boolean flag = dao.create(dto);
   
    //방명록 페이지로 리다이렉트(추가, 수정, 삭제, 로그인, 로그아웃후에는 리다이렉트)
    //response.sendRedirect(root + "/member/guestForm.jsp");
%>
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