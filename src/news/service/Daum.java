package news.service;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Daum {

	
	private static String url = "";
	
	public Daum(String url) {
		this.url = url;
	}
	
	
	public Map<String, List<String>> getHotNews(){
		
		Map<String, List<String>> map = new HashMap<String,List<String>>();
		Elements news = null;
		List<String> hotNews7 = new ArrayList<String>();
		List<String> links =  new ArrayList<String>();
		try {
			Document doc = Jsoup.connect(url).get();
		//  System.out.println(doc);
			
			news = doc.select(".tit_thumb a");
			//System.out.println("요소 "+news);
			
			//제목 뽑기
			int i= 0;
			for(Element hot : news){
				//System.out.println(i+hot.text());
				hotNews7.add(hot.text());//제목담기
				i++;
				links.add(hot.attr("abs:href"));//링크담기
				if(i>6)break;
			}
			
			//System.out.println("list 결과 :"+hotNews7.toString());
			//System.out.println("링크 :"+links.toString());

			
			map.put("hot_news_title", hotNews7);
			map.put("hot_news_links", links);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return map;
	}
	
	
	public Map<String, List<String>> getType(){
	      Map<String, List<String>> map = new HashMap<String,List<String>>();
	      
	      List<String> newsTitle = new ArrayList<String>();
	      List<String> links = new ArrayList<String>();
	      
	      
	      try {
	         Document doc = Jsoup.connect(url).get();
	         Elements news = doc.select(".list_news .tit_thumb .link_txt,.list_news .item_relate a");
	        // System.out.println(doc);
	         
	         
	         for(Element el : news){
	            //System.out.println("- "+el.text()+" -");
	            //System.out.println(el.attr("abs:href"));
	            newsTitle.add(el.text());
	            links.add(el.attr("abs:href"));
	         }
	         
	         map.put("news_title", newsTitle);
	         map.put("news_links", links);
	         
	         //System.out.println(map.toString());
	         
	         
	      } catch (IOException e) {
	         // TODO: handle exception
	      }
		return map;
	}
	
	
	public String getContent(){
		
		 /*본문 뽑기*/
		String html = null;
		try {
			Document doc = Jsoup.connect(url).get();
			Elements els  = doc.select(".article_view section");
			html = els.html();
		}catch (IOException e) {
			e.getStackTrace();
		}
		return html;
	}//getContent()
}
