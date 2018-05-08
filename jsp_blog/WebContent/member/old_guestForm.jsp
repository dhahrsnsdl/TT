<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi2.jsp"%>
<jsp:useBean id="dao" class="Guest.GuestDAO" />
<jsp:useBean id="dto" class="Guest.GuestDTO" />


<%	
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total")) word="";
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
	map.put("sno",sno);
	map.put("eno", eno);
	map.put("col",col);
	map.put("word",word);
	List<GuestDTO> list = dao.list(map);

	
	int totalRecord = dao.total(map);
	//페이징 출력메소드 호출
	String paging=Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);
%>

<!DOCTYPE html>
<html> 
<head> 
<meta charset="UTF-8"> 
<tItle>방명록</tItlE>
<LINK reL="stylesheet" href="<%=root%>/data/css/style.css"
	type="text/css" />

<Script>
    function sendIt()
    {
        var f = document.myForm;
       
        if(!f.name.value)
        {
            alert("이름을 입력하세요!!!");
            f.name.focus();
            return;
        }
       
        if(!f.content.value)
        {
            alert("내용을 입력하세요!!!");
            f.content.focus();
            return;
        }
       
        f.action = "./guestProc.jsp";
        f.submit();
    }
   
    function isDelete(num)  {
        if (confirm("위 자료를 삭제하시겠습니까 ?")) {
            location.href = "<%=root%>/delete.jsp?num=" + num;
		}
	}
    
</scrIpt>
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
 
<DIV class="title">방명록</DIV>

	<fOrm naME="myForm" meThoD=post acTIoN="">
		<taBLe>
			<Tr>
				<TD></Td>
			<TR>
				<tD>작성자</Td>
				<td><inpuT tYPE="text" NAME=name sIZE="35" mAxLeNGth=20>
				</tD>
			<Tr>
				<Td>
			</tR>
			<TR>
				<tD>내용</td>
				<TD><texTaREA NamE=content rOwS=3 cOLs="84"
						sTyLE="height: 50px;"></TexTArEa></tD>
			</TR>

			<Tr>
				<TD></tD>
			<tR>
				<tD><inpuT TYpE=button VaLue=등록하기 OnClICk="sendIt()"> <inpUt
					tYPE="reset" VALuE=" 다시입력 " OnClICK=document.myForm.name.focus();
					>
			</tr>
		</taBlE>
	</FoRm>

	<BR>
	<% for(int i=0; i<list.size(); i++){ 
		dto = list.get(i);
		%>
	
	<tABLe>
		<TR>
			<TD>No.<%=dto.getNum()%>&nbsp;&nbsp;이름:<%=dto.getName()%>
			<TD><%=dto.getCreated()%>&nbsp;&nbsp;<A
				href="javascript:isDelete('<%=dto.getNum()%>')">삭제</A>
		<Tr>
			<TD></TD>
		<tR>
			<Td><prE><%=dto.getContent()%></pre></tD>
		</Tr>
		<Tr>
			<td></tD>
		</tR>
		<%
			}
		%>

	</TABLe>
  <DIV class='bottom'>
	<%=paging %>
  </DIV>

<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 


