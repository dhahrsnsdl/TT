<%@ page contentType="text/html; charset=UTF-8" %> 

<%@ page import = "java.util.*" %>
<%@ page import = "bbs.*" %>
<%@ page import = "Guest.*" %>
<%@ page import = "member.*" %>
<%@ page import = "memo.*" %>
<%@ page import = "utility.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>


<%  
	request.setCharacterEncoding("utf-8");
	String root = request.getContextPath();
    
    String tempDir = "/member/temp";
    String upDir = "/member/storage";

    tempDir = application.getRealPath(tempDir);
    upDir = application.getRealPath(upDir);
    
%> 