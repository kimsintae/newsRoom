<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="news.service.Nate"%>
<%@page import="news.service.Daum"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.List"%>
<%@page import="news.service.Naver"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String site = request.getParameter("site");
String hotnewsURL ="";
//System.out.println("사이트 : "+site);
Map<String,List<String>> hotMap = new HashMap<String,List<String>>();

Date date = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
String today = sdf.format(date);

switch (site){
case "naver" : 
   //네이버 영역
   hotnewsURL="http://news.naver.com/main/ranking/popularDay.nhn?rankingType=popular_day&sectionId=000&date="+today;
   Naver naver = new Naver(hotnewsURL);
   hotMap = naver.getHotNews();
   //System.out.println("네이버 주요뉴스 :"+hotMap); 
   break;

case "daum" :
   //다음영역
   hotnewsURL="http://media.daum.net/ranking/";
   Daum daum = new Daum(hotnewsURL);
   hotMap = daum.getHotNews();
   //System.out.println("다음 주요뉴스 :"+hotMap);
   
   break;
case "nate" :
   //네이트영역
   hotnewsURL="http://news.nate.com/rank/pop?sc=all&p=day&date="+today;
   Nate nate = new Nate(hotnewsURL);
   hotMap = nate.getHotNews();
   //System.out.println("nate 주요뉴스 :"+hotMap);
   break;
case "cnn" :
   //cnn영역
   hotnewsURL="http://edition.cnn.com/";
   
   break;
}


ObjectMapper om = new ObjectMapper();
String json = om.writeValueAsString(hotMap);
//System.out.println("주요 뉴스 링크 제이슨 : "+json);
%>
<%=json%>