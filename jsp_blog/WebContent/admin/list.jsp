<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="member.memberDAO"/>
 
<%
	//검색관련
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	if(col.equals("total")) word="";
	//페이징관련
	int nowPage = 1;
	int recordPerPage=10;
	if(request.getParameter("nowPage")!=null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	//DB에서 가져올 순번
	int sno = ((nowPage - 1) * recordPerPage) + 1;
	int eno = nowPage * recordPerPage;
	//DAO 메소드 호출
	Map map = new HashMap();
	map.put("col",col);
	map.put("word",word);
	map.put("sno",sno);
	map.put("eno", eno);
	List<memberDTO> list = dao.list(map);

	int totalRecord = dao.total(map);
	//페이징 출력메소드 호출
	String paging=Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);

%> 
<!DOCTYPE html> 
<html> 
<head> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function read(id){
	var url ="<%=root%>/member/read.jsp";
	url+= "?id="+id;
	
	location.href=url;
}
</script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->


<form method="post" action="./list.jsp">
<select name="col">
	<option value="mname"<%if(col.equals("mname")) out.print(" selected"); %>>성명</option>
	<option value="id"
	<%if(col.equals("id")) out.print(" selected"); %>
	>아이디</option>
	<option value="email"
	<%if(col.equals("email")) out.print(" selected"); %>
	>이메일</option>
	<option value="total">전체출력</option>
	
</select>
<input type="search" name="word" value="<%=word %>" required>
<button class="button">검색</button>
<button class="button" onclick="location.href='<%=root%>/member/createForm.jsp'">회원가입</button>
</form>

<div class="container">
<h2> <span class="glyphicon glyphicon-th-list"></span> 회원목록 </h2>
</DIV>
<% for(int i=0; i<list.size(); i++){ 

	memberDTO dto = list.get(i);
%>
<table class="table table-hover">
<tr>
	<td rowspan="5" width="20%"><img src="<%=root%>/member/storage/<%=dto.getUploadBtn()%>" width=240px, height=180px></td>
	<th width="20%">아이디</th>
	<td width="60%"><a href="javascript:read('<%=dto.getId() %>')"> <%=dto.getId() %></a></td>
</tr>
<tr>
	<th>성명</th>
	<td><%=dto.getMname() %></td>
</tr>
<tr>
	<th>전화번호</th>
	<td><%=Utility.checkNull(dto.getTel())%></td>
</tr>
<tr>
	<th>이메일</th>
	<td><%=dto.getEmail() %></td>
</tr>

<tr>
	<th>주소</th>
	<td><%=Utility.checkNull(dto.getAddress1())%> <%=Utility.checkNull(dto.getAddress2()) %></td>
</tr>
</table>
<%} %>

  <DIV class='bottom'>
	<%=paging %>
  </DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
