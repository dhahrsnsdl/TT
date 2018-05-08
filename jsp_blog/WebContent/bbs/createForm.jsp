<%@ page contentType="text/html; charset=UTF-8" %> 
<%  request.setCharacterEncoding("utf-8");
    String root = request.getContextPath();
%> 

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style>
@charset "UTF-8";
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
</style>
<script type="text/javascript">
function incheck(f){
	if(f.wname.value==""){
		alert("이름을 입력하세요");
		f.wname.focus();
		
		return false;
	}
	if(f.title.value==""){
		alert("제목을 입력하세요");
		f.title.focus();
		
		return false;
		
	}
	if(f.content.value==""){
		alert("내용을 입력하세요");
		f.content.focus();
		
		return false;
	}
	if(f.passwd.value==""){
		alert("비번을 입력하세요");
		f.passwd.focus();
		
		return false;
	}
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 <div class="container">
<h2><span class="glyphicon glyphicon-pencil"></span>등록</h2>
<FORM name='frm' 
	  method='POST' 
	  action='./createProc.jsp'
	  onsubmit="return incheck(this)"
	  enctype="multipart/form-data">

  <TABLE class="table table-bordered">
    <TR>
      <TH>성명</TH>
      <TD><input type="text" name="wname"></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><textarea rows="10" cols="45" name="content"></textarea></TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd"></TD>
    </TR>
    <TR>
      <TH>파일</TH>
      <TD><input type="file" name="filename"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' class="btn btn-success" value='등록'>
    <input type='button' class="btn btn-danger" value='취소' onclick="history.back()">
  </DIV>
</FORM>
 </div>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html>