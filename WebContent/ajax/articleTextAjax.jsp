<%@page import="news.service.Nate"%>
<%@page import="news.service.Naver"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="news.service.Daum"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%

	String textURL = request.getParameter("url");
	String site = request.getParameter("site");
	//System.out.println(textURL);

	String content = "";
	
	switch(site){
	case "naver" :
		Naver naver = new Naver(textURL);
		//System.out.println("네이버 받아온 기사내용 : "+naver.getContent());
		content = naver.getContent();
		break;
	case "daum" :
		Daum daum = new Daum(textURL);
		//System.out.println("다음 받아온 기사내용 : "+daum.getContent());
		content = daum.getContent();
		break;
	case "nate" :
		Nate nate = new Nate(textURL);
		content = nate.getContent();
		//System.out.println("네이트 받아온 기사내용 : "+nate.getContent());
		break;
	
	}
	
	ObjectMapper om = new ObjectMapper();
	String json = om.writeValueAsString(content);
	//System.out.println("json = "+json);
%>
<%=json%>