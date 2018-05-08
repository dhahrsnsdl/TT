<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi2.jsp" %> 
<jsp:useBean id="dao" class="memo.MemoDAO"/>
<jsp:useBean id="dto" class="memo.MemoDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%
	Map map = new HashMap();
	map.put("grpno", dto.getGrpno());
	map.put("ansnum", dto.getAnsnum());
	
	dao.upAnsnum(map);
	
	boolean flag = dao.createReply(dto);
%>


<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<script type = "text/javascript">
function mlist(){
	var url = "list.jsp";
	url += "?col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	
	location.href=url;
	
}
</script>
<link href = "../css/style.css" rel="stylesheet">
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
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">답변 확인</DIV>
<DIV class="content">
<%
	if(flag){
		out.print("답변을 생성했습니다.");
	}else{
		out.print("답변 쓰기를 실패했습니다.");
	}
%>

</DIV> 
  
  <DIV class='bottom'>
    <input class='button' value='목록' onclick="mlist()">
  </DIV> 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
