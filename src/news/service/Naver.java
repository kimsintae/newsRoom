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

public class Naver {
	
	
	private static String url = "";
	
	public Naver(String url) {
		this.url = url;
	}
	
	//�ֿ� ���� ��������
	public Map<String, List<String>> getHotNews(){
				
		Map<String, List<String>> map = new HashMap<String,List<String>>();
		
		List<String> hotNews7 = new ArrayList<String>();//�������
		List<String> links = new ArrayList<String>();//��縵ũ
		String[] ranking = 	
			{".num1",".num2",".num3",".gnum4",".gnum5",".gnum6",".gnum7"};
		Elements news =null;
		try {
			Document doc = Jsoup.connect(url).get();
			
			//System.out.println(doc);
			
			//�ֿ䴺�� 7�� �̱�
			for(int i = 0 ; i<ranking.length ; i++){
				news= doc.select(ranking[i]+" dl a");
				hotNews7.add(news.text());//������	
				//System.out.println(news);
				
				//��ũ�̱�
				for(Element link : news){
					//System.out.println(link.attr("abs:href"));
					links.add(link.attr("abs:href"));//��ũ���
				}
			}//for

/*			for(int i = 0 ; i < hotNews7.size();i++){
				System.out.println("list�� ��� �� ���� - "+hotNews7.get(i));
			}
			
			for(int i = 0 ; i < links.size();i++){
				System.out.println("list�� ��� ��ũ - "+links.get(i));
			}*/
			
			
			map.put("hot_news_title", hotNews7);
			map.put("hot_news_links", links);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return map;
		
	}

	
	//Ÿ�Ժ� ���� ��������
	public Map<String, List<String>> getType(){
		 /*���̹� ���� */
	      Map<String, List<String>> map = new HashMap<String,List<String>>();
	      List<String> newsTitle = new ArrayList<String>();
	      List<String> links = new ArrayList<String>();
	      Elements news = null;
	      
	      try {
	         Document doc = Jsoup.connect(url).get();
	         
	         //System.out.println(doc);
	        	 //sphoto1 ��� �ڽ��� dt�� �ΰ� ���� ���
	        	 //�ι�° dt�� a��Ҹ� ����
	         	//dt�� �ΰ��� ���� �� ?? 
	        	// System.out.println("it�Ͱ���, ����");
	        	 news = doc.select(".slist1 a, .sphoto1 dt:nth-child(2) a,.section_body a");
	         
	         //System.out.println(news.size());
	         for(Element el : news){//���� ���
	            //System.out.println(el.text());
	            newsTitle.add(el.text());
	            links.add(el.attr("abs:href"));
	         }
	         //System.out.println(newsTitle.size()+" //"+links.size());
	         map.put("news_title", newsTitle);
	         map.put("news_links", links);
	         
	         //System.out.println(map.toString());
	      }catch(IOException e){
	    	  e.getMessage();
	      }
		
		return map;
	}
	
	
	// ��� ���� ��������
	public String getContent(){
		
		String html = null;
		try {
			Document doc = Jsoup.connect(url).get();
			Elements els = doc.select("#articleBodyContents");
			html = els.html();

		} catch (IOException e) {
			e.printStackTrace();
		}
		return html;
		
	}
}
