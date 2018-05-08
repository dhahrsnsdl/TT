<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi2.jsp"%>
<jsp:useBean id="dao" class="Guest.GuestDAO" />


<%
	String id = request.getParameter("id"); //list.jsp
	if (id == null) {
		id = (String) session.getAttribute("id"); //메뉴
	}
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));

	if (col.equals("total")) word = "";
	int nowPage = 1;
	int recordPerPage = 10;
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}

	//DB에서 가져올 순번
	int sno = ((nowPage - 1) * recordPerPage) + 1;
	int eno = nowPage * recordPerPage;
	//DAO 메소드 호출

	Map map = new HashMap();
	map.put("sno", sno);
	map.put("eno", eno);
	map.put("col", col);
	map.put("word", word);
	List<GuestDTO> list = dao.list(map);

	int totalRecord = dao.total(map);
	//페이징 출력메소드 호출
	String paging = Utility.paging4(totalRecord, nowPage, recordPerPage, col, word);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<tItle>방명록</tItlE>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">

<Script>
    function sendIt()
    {
        var f = document.myForm;
       
        if(!f.content.value)
        {
            alert("내용을 입력하세요");
            f.content.focus();
            return;
        }
       
        f.action = "./guestProc.jsp";
        f.submit();
    }
   
    function isUpdate(num)  {
        if (confirm("방명록을 수정하시겠습니까 ?")) {
            location.href = "updateForm.jsp?num=" + num;
		}
    }
    
    function isDelete(num)  {
        if (confirm("방명록을 삭제하시겠습니까 ?")) {
            location.href = "delete.jsp?num=" + num;
		}
        
	}
    
</scrIpt>
<style>
@charset "UTF-8";

@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

table.table1 {
	width : 550px;
}
table.table2 {
	width : 550px;
}
td.td1 {
	text-indent : 20px;
	background-color:#DDEBFF;
	text-align: left;
}

td.td2 {
	text-align: right;
	padding: 10px;
	padding-right: 2px;

}

td.td3 {
	vertical-align: center;
}
p.p {
    font-size: 10px;
}
</style>
</head>
<!-- *********************************************** -->
<body>
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->

	<DIV class="title">방명록</DIV>
<% if(id==null||id.equals("null")){
%>	<DIV class="content">
	로그인 후 방명록을 남겨주세요
	</DIV>
	
<%	
}else{ %>
	<fOrm naME="myForm" meThoD=post acTIoN="">
	  <input type="hidden" name="id" value="<%=id %>">
	
		<taBLe class="table1">
			<TR>
				<tD>아이디</Td>
				<td> <%=id %> <!--inpuT tYPE="text" NAME=name sIZE="35" mAxLeNGth=20-->
				</tD>
			<TR>
				<tD>내용</td>
				<TD><TEXTAREA rows="4" cols="50" name=content placeholder="방명록 작성 시 타인에 대한 배려와 책임을 담아주세요"></TexTArEa></tD>
			</TR>
			<tr>
				<tD class= "td3" colspan = "2"><button class=button OnClICk="sendIt()">등록하기</button>
				<inpUt tYPE="reset" VALuE=" 다시입력 " OnClICK=document.myForm.content.focus();>
				</tD>
			</tr>
		</taBlE>
	</FoRm>
	<%
		for (int i = 0; i < list.size(); i++) {
			GuestDTO dto = list.get(i);
	%>

	<tABLe class="table2">
		<TR>
			<TD class = "td1">No.<%=dto.getNum()%>&nbsp;&nbsp;&nbsp;<strong><%=dto.getId()%></strong>
			&nbsp;&nbsp;&nbsp;<%=dto.getMdate()%>&nbsp;&nbsp;&nbsp;<A
				href="javascript:isUpdate('<%=dto.getNum()%>')">수정</A>&nbsp;&nbsp;&nbsp;<A
				href="javascript:isDelete('<%=dto.getNum()%>')">삭제</A>
			</TD>
		<TR>
			<Td class = "td2"><PRE><%=dto.getContent()%></pre></tD>
		</Tr>
		<%
			}
		%>

	</TABLe>
	
	
	
	<DIV class='bottom'>
		<%=paging%><% } %>
	</DIV>

	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
</html>


