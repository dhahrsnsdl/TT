<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file ="/ssi/ssi2.jsp" %>
<jsp:useBean id="dao" class="memo.MemoDAO" />


<%
	int memono = Integer.parseInt(request.getParameter("memono"));
	// 조회
	dao.upViewcnt(memono); // 조회수 증가
	MemoDTO dto = dao.read(memono); // 조회
	
	String content = dto.getContent();
	if(content !=null)
		content = content.replaceAll("\r\n", "<br>");
	else
		content = " ";
%>

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<link href = "../css/style.css" rel="stylesheet">
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
* {
	font-family: 'Nanum Pen Script' !important;
	font-size : 28px;
}html {
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
<script type="text/javascript">

function mreply(memono){
	var url="replyForm.jsp";
	url += "?memono="+memono;
	url += "&col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	location.href=url;
}

function mcreate(){
	var url="memoCreate.jsp";
	location.href=url;
}
function mlist(){
	var url="list.jsp";
	url += "?col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	location.href=url;
}
function mupdate(memono){
	var url = "updateForm.jsp";
	url += "?memono="+memono;
	url += "&col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	location.href=url;
	// 띄어쓰기 과다 사용 금지
}
function mdelete(memono){
	var url	= "deleteForm.jsp";
	url += "?memono="+memono;
	url += "&col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	location.href=url;
}

</script>
</head> 
<body>
<jsp:include page="/menu/top.jsp"/>
<div class="title">조회</div>
<table>
	<tr>
		<th>제목</th>
		<td><%=dto.getTitle()%></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><%=content%></td>
	</tr>
	<tr>
		<th>조회수</th>
		<td><%=dto.getViewcnt()%></td>
	</tr>
	<tr>
		<th>등록일</th>
		<td><%=dto.getWdate()%></td>
</table>
<div class="bottom">
	<button class="button" onclick="mcreate()">등록</button>
	<button class="button" onclick="mreply('<%=memono%>')">답변</button>
	<button class="button" onclick="mupdate('<%=memono%>')">수정</button>
	<button class="button" onclick="mdelete('<%=memono%>')">삭제</button>
	<button class="button" onclick="mlist()">목록</button>
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 
<!-- 내용을 보여주기 위해 -->