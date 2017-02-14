package news.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Nate {

	
	private static String url = "";
	
	public Nate(String url) {
		this.url = url;
	}
	
	
	public Map<String, List<String>> getHotNews(){

		Map<String, List<String>> map = new HashMap<String,List<String>>();
		Elements news = null;
		
		List<String> hotNews7 = new ArrayList<String>();
		List<String> links = new ArrayList<String>();
		
		try {
			Document doc = Jsoup.connect(url).get();
		//  System.out.println(doc);
			
			news = doc.select(".mlt01 .tit,.mduRankSubject a");
			
			//System.out.println(news);
			//제목 담기
			int i = 0;
			for (Element arti : news) {
				hotNews7.add(arti.text());
				i++;
				if(i>6)break;
			}
						
			//링크 담기
			news = doc.select(".mlt01 a,.mduRankSubject a");
			int j =0;
			for (Element arti : news) {
				links.add(arti.attr("abs:href"));
				j++;
				if(j>6)break;
			}
			//System.out.println(hotNews7.size());

			//System.out.println(links.size());
						
			map.put("hot_news_title", hotNews7);
			map.put("hot_news_links", links);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return map;
	}
	
	
	//장르별 뉴스
	public Map<String, List<String>> getType(){
		
		Map<String, List<String>> typeMap = new HashMap<String,List<String>>();
		List<String> newsTitle = new ArrayList<String>();
		List<String> links = new ArrayList<String>();
		Elements news = null;
		try {
			Document doc = Jsoup.connect(url).get();
			//System.out.println(doc);
			news = doc.select(".mduList1 a,.lt1 .tit");
			//System.out.println(news.text());
			
			for(Element el : news){
				//System.out.println(el.text());
				newsTitle.add(el.text());//제목 담기
			}
			
			news = doc.select(".mduList1 a,.lt1");
			
			for(Element el : news){
				//System.out.println(el.attr("abs:href"));
				links.add(el.attr("abs:href"));
			}
			
			typeMap.put("news_title",newsTitle);
			typeMap.put("news_links", links);
			
			//System.out.println(typeMap);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return typeMap;
	}
	
	public String getContent(){
		String html = null;
		try {
			Document doc = Jsoup.connect(url).get();
			html  = doc.select("#articleContetns").html();

			//System.out.println(html);
		} catch (IOException e) {
			e.getStackTrace();
		}
		
		return html;
	}
}
