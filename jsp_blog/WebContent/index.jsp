<%@ page contentType="text/html; charset=UTF-8" %> 
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ include file="/ssi/ssi.jsp"%>

<%
String id = (String)session.getAttribute("id");
String grade = (String)session.getAttribute("grade");
String title = "나의 여행 블로그";
if(id!=null && grade.equals("A")){
	title = "관리자 페이지입니다.";
}
String str = null;

if(id==null){
	str = "메인 페이지 입니다.";
}else{
	str = "안녕하세요 " +id+"님!";
}

%>
 
<!DOCTYPE html> 
 <html> 
 <head> 
 <meta charset="UTF-8"> 
 <title></title> 

 <style type="text/css">

 

 

        @import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

 

        * {

            font-family: 'Nanum Pen Script', sans-serif;

        }

    </style>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 </head> 
 <body>
<jsp:include page="/menu/top.jsp" /> 
<div class="container" >
<div class="center-block" style="text-align: center;">

<%=title %><br>

<%=str %><br>
<img src="images/main.jpg" width=300px height=225px><br><br>
<%if(id==null){ %>
<button type="button" class="btn btn-primary" onclick="location.href='member/loginForm.jsp'">로그인</button>
<%}else{ %>
<button type="button" class="btn btn-primary" onclick="location.href='member/logout.jsp'">로그아웃</button>
<%}  %>

 </div>
 </div>
<jsp:include page="/menu/bottom.jsp" />
</body> 
 </html> 