<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file = "/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="bbs.BbsDAO"/>
 
<%	
	//검색 관련-------------------------------
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	
	if(col.equals("total")) word="";

	//paging 관련
	int nowPage = 1;//현재 보고 있는 페이지
	if(request.getParameter("nowPage")!=null){
		nowPage=Integer.parseInt(request.getParameter("nowPage"));
	}
	int recordPerPage = 5; //한 페이지 당 보여줄 레코드 갯수
	
	int startno = ((nowPage-1) * recordPerPage)+1;
	int endno = nowPage * recordPerPage;
	
	
	//---------------------------------------
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("startno", startno);
	map.put("endno", endno);
	
	
	List<BbsDTO> list = dao.list(map);
	//전체 레코드 갯수 가져오기
	int totalRecord = dao.total(map);
%> 

<!-- total을 선택하면 col,word 값 없이 넘긴다. checknull() null 값을 0으로 바꾼다. checknull static 메소드 매개변수-->
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title>
<!-- 
<style>
@charset "UTF-8";
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

*{
	font-family: 'Nanum Pen Script' !important;
	font-size: 28px;
}
.search{
	width: 80%;
	margin: 2px auto;
	text-align : center;
}
html {
	background: url(bbs.jpg) no-repeat center center fixed;
	background-size:cover;
	-ms-filter:"progid:DXImageTransform.Microsoft.AlphaImageLoader(src='bbs.jpg', sizingMethod='scale')";
}
.button {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 5px 10px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-family: 'Nanum Pen Script' !important;
    font-size: 18px;
}
</style>
 <link href="../css/style.css" rel="Stylesheet" type="text/css" />
  -->
<script>

function fileDown(filename){
	var url = "<%=root%>/download";
	url+= "?filename="+filename;
	url += "&dir=/bbs/storage"
	location.href = url;
}
function bcreate(){
	var url = "./createForm.jsp";
	location.href=url;
}

function read(bbsno){
	var url = "./read.jsp";
	url += "?bbsno="+bbsno; //js변수
	
	url += "&col=<%=col%>";
	url += "&word=<%=word%>"; //jsp 변수
	url += "&nowPage=<%=nowPage%>";
	location.href=url;
}

</script>
<!-- JSP 자바 등에서 사용하려면 표현식을 써 주어야 한다. -->


</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="search">
<form action="./list.jsp" method="post">
<select name="col"><!-- 검색할 Column -->
	<option value="wname" 
	<%if(col.equals("wname")) out.print("selected"); %>
	>성명</option>
	<option value="title"  
	<%if(col.equals("title")) out.print("selected"); %>
	>제목</option>
	<option value="content"  
	<%if(col.equals("content")) out.print("selected"); %>
	>내용</option>
	<option value="total"
	<%if(col.equals("total")) out.print("selected"); %>
	>전체출력</option>
	<!-- 검색한 조건을 where절에 주고 가져온다. -->
</select>
<input type="search" name="word" value="<%=word %>" required><!-- 검색어 -->
<button class = "button">검색</button>
<button class="button" onclick="bcreate()">메모 등록</button>
</form>
</DIV> 
 <div class="container">
<h2> <span class="glyphicon glyphicon-th-list"></span> 게시판목록 </h2>
  <TABLE class="table table-hover">
  	<thead>
    <TR>
      <TH>번호</TH>
      <TH>성명</TH>
      <TH>제목</TH>
      <TH>등록날짜</TH>
      <TH>조회수</TH>
      <TH>파일명</TH>
      
   </TR>
	  </thead> 
    
<%if(list.size()==0){ %>
	<tbody>
	<tr>
		<td colspan = "6">
		등록된 글이 없습니다.
		</td>
	</tr>
	</tbody>
	
<%}else{ 
	for(int i=0; i<list.size(); i++){
	BbsDTO dto = list.get(i);
%>

	<tbody>
    <tr>
    	<td><%=dto.getBbsno()%> </td>
    	<td><%=dto.getWname()%> </td>
    	<td>

<% if(dto.getIndent()>0) { %>
    	<% 
    		for(int r=0; r<dto.getIndent();r++){
    			out.print("&nbsp;&nbsp;");
    		}
    	out.print("<img src='../images/re.jpg'>");
		} %>
    	
    	<a href="javascript:read('<%=dto.getBbsno()%>')"><%=dto.getTitle()%></a>
    	<%
    		if(Utility.compareDay(dto.getWdate())){ %>
    			<img src="../images/new.gif">
    	<%	} %>
    	</td>
    	<td><%=dto.getWdate()%></td>
    	<td><%=dto.getViewcnt()%></td>
    	<td><% if(dto.getFilename()==null){
    		out.print("파일없음");
    		}else{%>
    		<a href="javascript:fileDown('<%=dto.getFilename() %>')"><%=dto.getFilename() %></a>
    		<%}%>
	</td>
    </tr>
   </tbody>
<% }  //for-end
} //if-end
%>
  </TABLE>
  
  <DIV class='bottom'>
	<%=Utility.paging3(totalRecord, nowPage, recordPerPage, col, word) %>
  </DIV>
 </div>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
