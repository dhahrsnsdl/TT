<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.memberDAO"/>
 
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	Map map = new HashMap();
	
	map.put("id",id);
	map.put("pw",pw);
	
	boolean flag = dao.loginCheck(map);
	String grade = null;
	if(flag){
		grade = dao.getGrade(id);
		session.setAttribute("id", id);
		session.setAttribute("pw", pw);
		session.setAttribute("grade", grade);
	}
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<style>
@charset "UTF-8";
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
*{
	font-family: 'Nanum Pen Script' !important;
	font-size: 20px;
	text-align: center;
}
</style>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">로그인 처리</DIV>
<DIV class="content">
<%
if(flag){
	out.print("로그인 되었습니다.");
    Cookie cookie = null; 
    
    String c_id = request.getParameter("c_id"); // Y, 아이디 저장 여부 
       
    if (c_id != null){  // 처음에는 값이 없음으로 null 체크로 처리
      cookie = new Cookie("c_id", "Y");    // 아이디 저장 여부 쿠키 
      cookie.setMaxAge(120);               // 2 분 유지 
      response.addCookie(cookie);          // 쿠키 기록 
   
      cookie = new Cookie("c_id_val", id); // 아이디 값 저장 쿠키  
      cookie.setMaxAge(120);               // 2 분 유지 
      response.addCookie(cookie);          // 쿠키 기록  
         
    }else{ 
      cookie = new Cookie("c_id", "");     // 쿠키 삭제 
      cookie.setMaxAge(0); 
      response.addCookie(cookie); 
         
      cookie = new Cookie("c_id_val", ""); // 쿠키 삭제 
      cookie.setMaxAge(0); 
      response.addCookie(cookie); 
    } 
}else{
	out.print("등록되지 않은 아이디거나<br>");
	out.print("아이디/비밀번호를 다시 확인하세요");
}
%>
</DIV>  
  <DIV class='bottom'>
    <button class='button' onclick="location.href='../index.jsp'">홈</button>
    <button class='button' onclick="history.back()">다시 시도</button>
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
