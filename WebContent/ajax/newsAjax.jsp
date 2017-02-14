<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="news.service.Nate"%>
<%@page import="news.service.Daum"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="news.service.Naver"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	Map<String,List<String>> map = new HashMap<String,List<String>>();
	String type = request.getParameter("type");
	//System.out.println(type);

	String site = request.getParameter("site");
	//System.out.println(site);

	String url = "";
	
	//사이트별 preURL
    String naverURL = "http://news.naver.com/main/main.nhn?mode=LSD&mid=shm&sid1=";
	String daumURL = "http://media.daum.net/";

	switch (site){
	case "naver" : 
		//네이버 영역
		//네이버 영역
	      if(type.equals("society")){//네이버
	         url = naverURL+"102";
	         //System.out.println("네이버 이고, 사회 선택 하셨습니다.");
	      }else if(type.equals("economy")){
	         url = naverURL+"101";
	         //System.out.println("네이버 이고, 경제 선택 하셨습니다.");
	      }else if(type.equals("politics")){
	         url = naverURL+"100";
	         //System.out.println("네이버이고, 정치 선택 하셨습니다.");
	      }else if(type.equals("entertainment")){
	         url = naverURL+"102";
	         //System.out.println("네이버이고, 연예 선택 하셨습니다.");
	      }else if(type.equals("world")){
	         url = naverURL+"104";
	         //System.out.println("네이버이고, 세계 선택 하셨습니다.");
	      }else if(type.equals("it")){   
	         url = naverURL+"105";
	         //System.out.println("네이버이고, IT 선택 하셨습니다.");
	      }

		Naver naver = new Naver(url);
		map = naver.getType();
		//System.out.println("네이버 주요뉴스 :"+hotMap); 
		break;

	case "daum" :
		//다음영역
		if(type.equals("society")){//다음	
			url=daumURL+"society/";
			//System.out.println("다음 이고, 사회 선택 하셨습니다.");
		}else if(type.equals("economy")){
			url=daumURL+"economic/";
			//System.out.println("다음 이고, 경제 선택 하셨습니다.");
		}else if(type.equals("politics")){
			url=daumURL+"politics/";
			//System.out.println("다음 이고, 정치 선택 하셨습니다.");
		}else if(type.equals("entertainment")){
			url=daumURL+"entertainment/";
			//System.out.println("다음 이고, 연예 선택 하셨습니다.");
		}else if(type.equals("world")){
			url=daumURL+"foreign/";
			//System.out.println("다음 이고, 세계 선택 하셨습니다.");
		}else if(type.equals("it")){
			url=daumURL+"digital/";
			//System.out.println("다음 이고, IT 선택 하셨습니다.");
		} 
		
		Daum daum = new Daum(url);
		map = daum.getType();
		//System.out.println("다음 주요뉴스 :"+hotMap);
		
		break;
		
	case "nate" :
		//네이트영역
		if(type.equals("society")){ 
			url="http://news.nate.com/section?mid=n0400";
			//System.out.println("네이트 이고, 사회 선택 하셨습니다.");
		}else if(type.equals("economy")){
			url="http://news.nate.com/section?mid=n0300";
			//System.out.println("네이트 이고, 경제 선택 하셨습니다.");
		}else if(type.equals("politics")){
			url="http://news.nate.com/section?mid=n0200";
			//System.out.println("네이트 이고, 정치 선택 하셨습니다.");
		}else if(type.equals("entertainment")){
			url="http://news.nate.com/ent/subsection?mid=e1100";
			//System.out.println("네이트 이고, 연예 선택 하셨습니다.");
		}else if(type.equals("world")){
			url="http://news.nate.com/section?mid=n0500";
			//System.out.println("네이트 이고, 세계 선택 하셨습니다.");
		}else if(type.equals("it")){
			url="http://news.nate.com/section?mid=n0600";
			//System.out.println("네이트 이고, IT 선택 하셨습니다.");
		}else{return;}
		
		
		//네이트영역
		Nate nate = new Nate(url);
		map = nate.getType();
		//System.out.println("nate 뉴스 :"+map.toString());
		break;

	}
	
	
	ObjectMapper om = new ObjectMapper();
	String json = om.writeValueAsString(map);
	//System.out.println("type json : "+json);
%>
<%=json%>