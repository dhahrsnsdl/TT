<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); %> 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 

table{
	margin:20px auto;
}

table,th,td{
	 align:center;
	 padding:20px;
	 border-spacing:5px;
	 border : 1px solid black;
}

</style> 
</head> 
<body> 
<TABLE>
  <TR>
    <TH> </TH>
    <TH> </TH>
    <TH> </TH>
    <TH> </TH>
    <TH> </TH>
    <TH rowspan='5' bgcolor='#AAFFAA'> 6% </TH>    
  </TR>
  <TR>
    <TH> </TH>
    <TH> </TH>
    <TH> </TH>
    <TH> </TH>
    <TH rowspan='4' bgcolor='#AAFFAA'> 5% </TH>
  </TR>
  <TR>
    <TH> </TH>
    <TH> </TH>
    <TH rowspan='3' bgcolor='#AAFFAA'> 3% </TH>
    <TH> </TH>
   
  </TR>
  <TR>
    <TH> </TH>
    <TH rowspan='2' bgcolor='#AAFFAA'> 2% </TH>
    <TH rowspan='2' bgcolor='#AAFFAA'> 4% </TH>
  </TR>
  <TR>
    <TH rowspan='1' bgcolor='#AAFFAA'> 1% </TH>
  </TR>

</TABLE>

<!-- 전체 행은 5개 있음. 첫번째 행에서는 열이 5개 있고 6번째에는 세로로 병합하고 있다.(rowspan) 두번째 행에는 열이 4개 있고 5번째에서는 세로로 병합하고 있다.(rowspan)
세번째 행에는 총 3개가 있어야 하지만 46번째 rowspan 줄은 없어지는 것이다. 네번째 행에는 2행 동안의 열이 없어야 한다. 마지막 행에서는 하나의 값으로 인식하면 된다. 
colspan 가로로 병합, rowspan 세로로 병합 병합한것 밑으로는 열이 없어진다.-->

</body> 
</html> 