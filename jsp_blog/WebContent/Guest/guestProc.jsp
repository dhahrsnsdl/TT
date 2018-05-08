<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 

<jsp:useBean id="dao" class="Guest.GuestDAO"/>
<jsp:useBean id="dto" class="Guest.GuestDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%
    //게시물의 최대값 가져오기
    int maxNum = dao.getMaxNum();
	String id = request.getParameter("id");
	String pw = (String)session.getAttribute("pw");
	if(id==null){
		id = (String)session.getAttribute("id"); //메뉴
	}
    dto.setNum(maxNum + 1);
    dto.setIpAddr(request.getRemoteAddr());
    
	Boolean flag2 = dao.checkPasswd(id, pw);
    
    if(id==null||id.equals("null")||flag2==false){
    //자료추가
    }
    else{
    boolean flag = dao.create(dto);
    }
	response.sendRedirect("./guestForm.jsp");
    //방명록 페이지로 리다이렉트(추가, 수정, 삭제, 로그인, 로그아웃후에는 리다이렉트)
    //response.sendRedirect(root + "/member/guestForm.jsp");
    


%>
