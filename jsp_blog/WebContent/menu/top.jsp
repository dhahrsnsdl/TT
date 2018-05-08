<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>

<%
String id = (String)session.getAttribute("id");
String grade = (String)session.getAttribute("grade");
String str = null;

if(id==null){
	str = "";
}else{
	str = id;
}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
 <style type="text/css">

 

 

        @import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

 

        * {

            font-family: 'Nanum Pen Script', sans-serif;
			font-size: 20px;
        }

    </style>
<!-- <style type="text/css">
/*@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

		* {
			margin:0;
			padding:0;
		}

		.clearfix:before,
		.clearfix:after {
			content: "";
			display: table;
		}

		.clearfix:after {
			clear: both;
		}

		.clearfix {
			zoom: 1;
		}

        body {
            background: url('windmill.jpg') no-repeat center center fixed;
            background-size:cover;
        }

		nav {
			height: 40px;
			width: 100%;
			background: #7998b7;
			font-size: 1em;
			font-family: 'Nanum Pen Script' !important;
			font-weight: bold;
			position: relative;
			border-bottom: 2px solid #34495e;
		}

			nav ul {
				padding: 0;
				margin: 0 auto;
				width: 800px;
				height: 40px;
			}

			nav li {
				display: inline;
				float: left;
			}

			nav a {
				color: #fff;
				display: inline-block;
				width: 100px;
				text-align: center;
				text-decoration: none;
				line-height: 40px;
				text-shadow: 1px 1px 0px #283744;
			}

			nav li a {
				border-right: 1px solid #576979;
				box-sizing: border-box;
				-moz-box-sizing: border-box;
				-webkit-box-sizing: border-box;
			}

			nav li:last-child a {
				border-right: 0;
			}

			nav a:hover, nav a:active {
				background-color: #8c99a4;
			}

			nav a#trigger {
				display: none;
			}


		@media screen and (max-width: 600px) {
			nav {
				height: auto;
			}

				nav ul {
					width: 100%;
					display: block;
					height: auto;
				}

				nav li {
					width: 50%;
					float: left;
					position: relative;
				}

					nav li a {
						border-bottom: 1px solid #576979;
						border-right: 1px solid #576979;
					}

				nav a {
					text-align: left;
					width: 100%;
					text-indent: 25px;
				}
		}

		@media only screen and (max-width : 320px) {
			nav {
				border-bottom: 0;
			}

				nav ul {
					display: none;
					height: auto;
				}

				nav li {
					display: block;
					float: none;
					width: 100%;
				}

					nav li a {
						border-bottom: 1px solid #576979;
					}

				nav a#trigger {
					display: block;
					background: #7998b7;
					width: 100%;
					position: relative;
				}

					nav a#trigger:after {
						content: "";
						background: url('nav.png') no-repeat;
						width: 30px;
						height: 30px;
						display: inline-block;
						position: absolute;
						right: 15px;
						top: 10px;
					}
		}
*/
</style> -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<script>
	$(function() {
		var trigger = $('#trigger');
		var menu = $('nav ul');
		$(trigger).on('click', function(e) {
			e.preventDefault();
			menu.slideToggle();
		});
		$(window).resize(function() {
			var w = $(window).width();
			if (w > 320 && menu.is(':hidden')) {
				menu.removeAttr('style');
			}
		});
	});
</script>
<body>
<div class="container">
	<!-- 상단 메뉴 -->
<div class="center-block">
		<table class="table">
			<tr>
				<td class="td"><img src="<%=root%>/menu/images/main-03.jpg"
					width='100%' height='100%'></td>
			</tr>

		</table>

		<nav class="navbar navbar-inverse">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="<%=root%>/index.jsp">블로그</a>
				</div>
				<ul class="nav navbar-nav">
					<li class="active"><a href="<%=root%>/index.jsp">홈</a></li>
					<li class="dropdown">
															<%
					if (id == null) {
				%>
					<a class="dropdown-toggle"
						data-toggle="dropdown" href="#">로그인이 필요합니다<span class="caret"></span></a>
						<ul class="dropdown-menu">

							<li><a href="<%=root%>/member/agreement.jsp">&nbsp;회원가입</a></li>
							<li><a href="<%=root%>/member/loginForm.jsp">&nbsp;로그인</a></li>
							</ul></li>
						</ul>
		</li>
	  <ul class="nav navbar-nav navbar-right">
      <li><a href="<%=root%>/member/agreement.jsp"><span class="glyphicon glyphicon-user"></span>&nbsp;회원 가입</a></li>
      <li><a href="<%=root%>/member/loginForm.jsp"><span class="glyphicon glyphicon-log-in"></span>&nbsp;로그인</a></li>
  	  </ul>
				
				<%
					} else {
				%>
				<a class="dropdown-toggle" data-toggle="dropdown" href="#"><%=str %>님 환영합니다
				<span class="caret"></span></a>
						<ul class="dropdown-menu">

							<li><a href="<%=root%>/member/deleteForm.jsp">회원탈퇴</a></li>
						</ul></li>
					<li><a href="<%=root%>/Guest/guestForm.jsp">방명록</a></li>
					<li><a href="<%=root%>/bbs/list.jsp">게시판</a></li>
					<li><a href="<%=root%>/memov3/list.jsp">메모</a></li>
					<%if(id!=null && grade.equals("A")){ %>
     				<li><a href="<%=root %>/admin/list.jsp"><span class="glyphicon glyphicon-log-lock"></span>회원목록</a></li>
    				<%} %>
				</ul>

		</li>
	  <ul class="nav navbar-nav navbar-right">
      <li><a href="<%=root%>/member/read.jsp"><span class="glyphicon glyphicon-user"></span>&nbsp;내 정보</a></li>
      <li><a href="<%=root%>/member/logout.jsp"><span class="glyphicon glyphicon-log-out"></span>&nbsp;로그아웃</a></li>
  	  </ul>
		<%
					}
		%>
		</div>
		</nav>
</div>
</div>

	<!-- 상단 메뉴 끝 -->



	<!-- 내용 시작 -->

</body>
</html>
