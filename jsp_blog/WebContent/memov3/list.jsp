<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi2.jsp"%>
<jsp:useBean id="dao" class="memo.MemoDAO" />
<%
	//검색 관련
	//dao가 걕체를 생성해 주어야 한다.
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));

	if (col.equals("total"))
		word = " ";

	//페이징 관련
	int nowPage = 1;
	int recordPerPage = 5;

	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}

	int sno = ((nowPage - 1) * recordPerPage) + 1;
	int eno = nowPage * recordPerPage;

	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);

	List<MemoDTO> list = dao.list(map);

	int totalRecord = dao.total(map);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<script type="text/javascript">
	function read(memono) {
		//alert(memono);
		var url = "read.jsp";
		url += "?memono=" + memono;
		
		url += "&col=<%=col%>";
		url += "&word=<%=word%>";
		url += "&nowPage=<%=nowPage%>";
		
		location.href = url;
	}
	/*JSP 코드 상에서 자바스크립트 변수는 직접적으로 사용 불가능하다. 그러므로 자바스크립트에서 따로 표시를 해줘야한다. 매개변수 선언 시
	 타입을 표시해주지 않는다.
	 링크에 색깔을 기본 파란색이 아닌 검정색으로 입히기 위해 a:link,visited 등을 사용했다
	 var로 변수 선언하고 url를 만들었다. location.href=url;은 get 방식이다. http://localhost:8000/jsptest/memo/read.jsp?memono=13 이런식으로 memono=13으로 가게된다.
	 */
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="title">메모 목록</div>
	<div class="search">
		<form action="./list.jsp" method="post">
			<select name="col">
				<option value="title"
					<%if (col.equals("title")) {
				out.print("selected");
			}%>>제목</option>
				<option value="content"
					<%if (col.equals("title")) {
				out.print("selected");
			}%>>내용</option>
				<option value="total">전체출력</option>
			</select> <input type="search" name="word" value="<%=word%>" required>
			<button class="button">검색</button>
			<button class="button" onclick="location.href='memoCreate.jsp'">
				등록</button>
		</form>
	</div>
 <div class="container">
<h2> <span class="glyphicon glyphicon-th-list"></span> 메모목록 </h2>
	<table class ="table table-hover">
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>날짜</th>
			<th>조회수</th>
			<th>grpno</th>
			<th>indent</th>
			<th>ansnum</th>
		</tr>
	</thead>
		<!-- tr은 행, th가 열을 생성한다.-->
		<%
			if (list.size() == 0) {
		%>
		<tbody>
		<tr>
			<!-- resultset select dql 했을 때 결과값을 받아오는 것 처음에는 Column을 가리키고 있다가 rs.next하면 다음 행을 가리킨다.-->
			<td colspan="7">등록된 메모가 없습니다.</td>
			<!-- rs.next가 없을 때까지 확인하고 가로로 병합한다. -->
		</tr>
		</tbody>
		<%
			} else {
				for (int i = 0; i < list.size(); i++) {
					MemoDTO dto = list.get(i);
		%>
		<tbody>
		<tr>
			<td><%=dto.getMemono()%></td>
			<td>
				<%
					if (dto.getIndent() > 0) {
								for (int r = 0; r < dto.getIndent(); r++) {
									out.print("&nbsp;&nbsp;");
								}
								out.print("<img src='../images/re.jpg' >");
				%> <%
 	}
 %><a href="javascript:read('<%=dto.getMemono()%>')"> <%=dto.getTitle()%></a>
 <%	
 	if(Utility.compareDay(dto.getWdate())){
 %>	<img src = "../images/new.gif">
 <%} %>
			</td>
			<td><%=dto.getWdate()%></td>
			<td><%=dto.getViewcnt()%></td>
			<td><%=dto.getGrpno()%></td>
			<td><%=dto.getIndent()%></td>
			<td><%=dto.getAnsnum()%></td>
		</tr>
		</tbody>
		<%
			}
			} //if-end
		%>
	</table>
	<!-- do-while 문은 무조건 1번은 실행하는 반복문. %=는 표현식(out.print 개념으로 브라우저에 출력) 계속 테이블을 만들다가 false면 반복문.. 테이블을 빠져나온다.-->
	<DIV class='bottom'>
		<%=Utility.paging3(totalRecord, nowPage, recordPerPage, col, word) %>

	</DIV>
	</div>
	<jsp:include page="/menu/bottom.jsp" />

</body>
</html>
<!--
if(rs!=null)rs.close();
    if(pstmt!=null)pstmt.close();
    if(con!=null)con.close();
beans로 객체 닫아 주는 것을 배울 것이기 때문에 여기서는 쓰지 않는다-->