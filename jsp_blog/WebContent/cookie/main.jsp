<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp"%>
 
<%
String windowOpen = "open";

Cookie[] cookies = request.getCookies(); //요청지로부터 쿠키값을 읽어온다.
Cookie cookie = null;

if(cookies != null){ // 배열이 null이 아닐 때만
	for(int i = 0; i<cookies.length; i++){
		cookie = cookies[i]; //쿠키의 값을 읽어온다.
		
	if(cookie.getName().equals("windowOpen")){ //windowOpen이라는 값을 가지고 있다면
		windowOpen = cookie.getValue();
	}
	}
}
%> 

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title>main</title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<!-- 윈도우가 열리는 시점에서 notice 메소드가 호출된다. -->

<script type="text/javascript">
window.onload = function() {
	notice();
}

function notice(){
	if("<%=windowOpen%>"=="close"){
		// alert("공지사항 창을 열지 않습니다.");
	}else{
		// alert("공지사항 창을 엽니다.");
		var url = "./notice.jsp";
		window.open(url, '공지사항', "left=10, top=40, width=450, height=300");
		
	}
}
  function openNotice(){ 
	    var url = "./notice.jsp"; 
		    window.open(url, '공지사항', "left=10,top=40,width=450,height=300"); 
		  } 

</script>
<!-- window.open 새창으로 열려진다. -->
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="content">
오늘은 수요일 입니다. <br></br>
평창 동계 올림픽 오늘 발표! 17:00 투표 시작 <br> </br>
국민 여러분 많은 성원 바랍니다. <br> </br>
[<a href='javascript:openNotice()'> 새로운 공지사항 보기 </a>]
</DIV>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 