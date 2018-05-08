<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="member.memberDAO"/>
 
<%
	String id = request.getParameter("id"); //list.jsp
	if(id==null){
		id = (String)session.getAttribute("id"); //메뉴
	}
	memberDTO dto = dao.read(id);
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<script type="text/javascript">
function mdelete(){
	var url = "./deleteForm.jsp";
	url += "?id=<%=id%>";
	
	location.href=url;
}
function mupdate(){
	var url = "./updateForm.jsp";
	url += "?id=<%=id%>";
	
	location.href=url;
}
function updateFile(){
	var url = "./updateFileForm.jsp";
	url += "?id=<%=id%>";
	url += "&oldfile=<%=dto.getUploadBtn()%>"
	
	location.href=url;
}
function pwUpdate(){
	var url = "./pwUpdateForm2.jsp";
	url += "?id=<%=id%>";
	
	wr = window.open(url,"비밀번호 변경","width=600,height=500");
	wr.moveTo((window.screen.width-600)/2, (window.screen.height-500)/2);
}
</script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<style>
@charset "UTF-8";
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

</style>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title"><%=dto.getMname() %>의 회원정보</DIV>
 
  <TABLE>
    <TR>
      <TD colspan="2">
       <p style="text-align: center;">
      <img src="./storage/<%=dto.getUploadBtn() %>" width="240px" height="180px">
      </p>
      </TD>
    </TR>
    <TR>
      <TH>아이디</TH>
      <TD>
		<%=dto.getId()%>
      </TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD>
		<%=dto.getMname()%>
      </TD>
    </TR>
    <TR>
      <TH>전화번호</TH>
      <TD>
		<%=dto.getTel()%>
      </TD>
    </TR>
    <TR>
      <TH>이메일</TH>
      <TD>
		<%=dto.getEmail()%>
      </TD>
    </TR>
    <TR>
      <TH>우편번호</TH>
      <TD>
		<%=Utility.checkNull(dto.getZipcode())%>
      </TD>
    </TR>
    <TR>
      <TH>주소</TH>
      <TD>
		<%=Utility.checkNull(dto.getAddress1())%> <%=Utility.checkNull(dto.getAddress2())%>
      </TD>
    </TR>
    <TR>
      <TH>직업</TH>
      <TD>
		직업코드 : <%=dto.getJob()%> <br>
		직업명 : <%=Utility.getCodeValue(dto.getJob()) %> 
      </TD>
    </TR>
    <TR>
      <TH>가입날짜</TH>
      <TD>
		<%=dto.getMdate()%>
      </TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <button class='button' onclick='mdelete()'>회원탈퇴</button>
    <button class='button' onclick='mupdate()'>정보수정</button>
    <button class='button' onclick='updateFile()'>사진수정</button>
    <button class='button' onclick='pwUpdate()'>비밀번호 변경</button>
    <input type='button' value='다운로드'  
           onclick="location.href='<%=request.getContextPath() %>/download?dir=/member/storage&filename=<%=dto.getUploadBtn()%>'"> 
  </DIV>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
