<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="bbs.BbsDAO" />

<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));

	dao.upViewcnt(bbsno); //조회수 증가
	BbsDTO dto = dao.read(bbsno);

	String content = dto.getContent();
	content = content.replaceAll("\r\n", "<br>");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
function fileDown(filename){
	var url = "<%=root%>/download";
	url+= "?filename="+filename;
	url += "&dir=/bbs/storage"
	location.href = url;
}
function reply(bbsno){
	var url = "./replyForm.jsp";
	url += "?bbsno="+bbsno;
	url += "&col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	location.href=url;
}

function bdel(){
	var url = "./deleteForm.jsp";
	url += "?bbsno=<%=bbsno%>";
	url += "&oldfile=<%=dto.getFilename()%>";
	url += "&col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	
	location.href=url;
}
function bupdate(bbsno){
	var url ="./updateForm.jsp";
	url += "?bbsno="+bbsno;
	url += "&col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	
	location.href=url;
}
function blist(){
	var url = "./list.jsp";
	url += "?col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";

		location.href = url;
	}
</script>

<style>
@charset "UTF-8";

@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

* {
	font-family: 'Nanum Pen Script' !important;
	font-size: 28px;
}

.search {
	width: 80%;
	margin: 2px auto;
	text-align: center;
}

html {
	background: url(bbs.jpg) no-repeat center center fixed;
	background-size: cover;
	-ms-filter:
		"progid:DXImageTransform.Microsoft.AlphaImageLoader(src='bbs.jpg', sizingMethod='scale')";
}
</style>

</head>
<!-- *********************************************** -->
<body>
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->
	<div class="container">
	<h2><span class="glyphicon glyphicon-pencil"></span>답변</h2>

	  <TABLE class="table table-bordered">
		<TR>
			<TH>성명</TH>
			<TD><%=dto.getWname()%></TD>
		</TR>
		<TR>
			<TH>제목</TH>
			<TD><%=dto.getTitle()%></TD>
		</TR>
		<TR>
			<TH>내용</TH>
			<TD><%=content%></TD>
		</TR>
		<TR>
			<TH>조회수</TH>
			<TD><%=dto.getViewcnt()%></TD>
		</TR>
		<TR>
			<TH>등록날짜</TH>
			<TD><%=dto.getWdate()%></TD>
		</TR>
		<TR>
			<TH>파일명</TH>
			<TD><% if(dto.getFilename()==null){
    		out.print("파일없음");
    		}else{%>
    		<a href="javascript:fileDown('<%=dto.getFilename() %>')"><%=dto.getFilename() %></a> <br>파일용량 : <%=dto.getFilesize()/1024 %>KB
    		<%}%></TD>
		</TR>
	</TABLE>


		<button type='button' onclick="reply('<%=dto.getBbsno()%>')">답변</button>
		<button type='button' onclick="bdel()">삭제</button>
		<input type='button' value='수정'
			onclick="bupdate('<%=dto.getBbsno()%>')"> <input
			type='button' value='목록' onclick="blist()">
	</div>

<div class="shop-items blocky">
        <div class="container">
          
         <div class="row">
            <!-- Item #1 -->
            <div class="col-md-2">
              <div class="item">

                <!-- Item image -->
                <div class="item-image">
                  <a href="<%=root%>/item/foods/item_potatocrisp.jsp"><img src="img/items/sweets.png" alt=""  class="img-responsive"/></a>
                </div>
                <!-- Item details -->
                <div class="item-details">
                  <!-- Name -->
                  <h5><a href="<%=root%>/item/foods/item_potatocrisp.jsp">인기 수입과자</a></h5>
                  <!-- Para. Note more than 2 lines. -->
                  <p>26종 인기 수입과자 묶음판매</p>
                  <hr />
                  <!-- Price -->
                  <h3><span class="label label-default">특가</span>&nbsp;&nbsp;&nbsp;29,900원</h3>
                  <!-- Add to cart -->
                  <div class="clearfix"></div>
                </div>
              </div>
            </div>

            <div class="col-md-2">
              <div class="item">
               <div class="item-icon"><span>HOT</span></div>
                <!-- Item image -->
                <div class="item-image">
                  <a href="<%=root%>/item/foods/item_potatocrisp.jsp"><img src="img/items/almonds.png" alt=""  class="img-responsive"/></a>
                </div>
                <!-- Item details -->
                <div class="item-details">
                  <!-- Name -->
                  <h5><a href="<%=root%>/item/foods/item_potatocrisp.jsp">아몬드</a></h5>
                  <!-- Para. Note more than 2 lines. -->
                  <p>생아몬드 500g+500g</p>
                  <hr />
                  <!-- Price -->
                  <h3><span class="label label-default">오늘만</span>&nbsp;&nbsp;&nbsp;11,900원</h3>
                  <!-- Add to cart -->
                  <div class="clearfix"></div>
                </div>
              </div>
            </div>

            <div class="col-md-2">
              <div class="item">
                <!-- Item image -->
                <div class="item-image">
                  <a href="<%=root%>/item/foods/item_potatocrisp.jsp"><img src="img/items/humidifier_iriver.jpg" alt=""  class="img-responsive"/></a>
                </div>
                <!-- Item details -->
                <div class="item-details">
                  <!-- Name -->
                  <h5><a href="<%=root%>/item/foods/item_potatocrisp.jsp">미니 가습기</a></h5>
                  <!-- Para. Note more than 2 lines. -->
                  <p>아이리버 MH-30C 탁상용 가습기</p>
                  <hr />
                  <!-- Price -->
                  <h3><span class="label label-default">특가</span>&nbsp;&nbsp;&nbsp;20,900원</h3>
                  <!-- Add to cart -->
                  <div class="clearfix"></div>
                </div>
              </div>
            </div>

            <div class="col-md-2">
              <div class="item">
                <!-- Item image -->
                <div class="item-image">
                  <a href="<%=root%>/item/foods/item_potatocrisp.jsp"><img src="img/items/AirCleaner ALLO A7.jpg" alt=""  class="img-responsive"/></a>
                </div>
                <!-- Item details -->
                <div class="item-details">
                  <!-- Name -->
                  <h5><a href="<%=root%>/item/foods/item_potatocrisp.jsp">알로 공기청정기</a></h5>
                  <!-- Para. Note more than 2 lines. -->
                  <p>복합 공기청정기 알로 A7</p>
                  <hr />
                  <!-- Price -->
                  <h3><span class="label label-default">특가</span>&nbsp;&nbsp;&nbsp;87,900원</h3>
                  <!-- Add to cart -->
                  <div class="clearfix"></div>
                </div>
              </div>
            </div>
            
            <div class="col-md-2">
              <div class="item">
                <!-- Item image -->
                <div class="item-image">
                  <a href="<%=root%>/item/foods/item_potatocrisp.jsp"><img src="img/items/AirCleaner ALLO A7.jpg" alt=""  class="img-responsive"/></a>
                </div>
                <!-- Item details -->
                <div class="item-details">
                  <!-- Name -->
                  <h5><a href="<%=root%>/item/foods/item_potatocrisp.jsp">알로 공기청정기</a></h5>
                  <!-- Para. Note more than 2 lines. -->
                  <p>복합 공기청정기 알로 A7</p>
                  <hr />
                  <!-- Price -->
                  <h3><span class="label label-default">특가</span>&nbsp;&nbsp;&nbsp;87,900원</h3>
                  <!-- Add to cart -->
                  <div class="clearfix"></div>
                </div>
              </div>
            </div>                                                                        

          </div>
        </div>
      </div>





	
	     
	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
</html>
