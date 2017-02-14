package news.service;

import java.io.BufferedReader;
import java.io.File;
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
import org.w3c.dom.stylesheets.LinkStyle;

public class Test {

	public static void main(String[] args) {

 /*���� �̱�*/
		
		  Map<String, List<String>> map = new HashMap<String,List<String>>();
	      List<String> newsTitle = new ArrayList<String>();
	      List<String> links = new ArrayList<String>();
	      Elements replies = null;

	      try {
	    	  
	    	  //m_view=1 �Ķ���� �ָ� ��ü���
	         Document doc = Jsoup.connect("http://news.naver.com/main/hotissue/read.nhn?mid=hot&sid1=100&cid=1051768&iid=1164086&oid=001&aid=0008952428&ptype=052&m_view=1").get();
	         
	         System.out.println(doc);

	        	 replies = doc.select("#cbox_module");
	       
	        	 System.out.println(replies);
	        	 
	        	 
	        	 

	         //System.out.println(newsTitle.size()+" //"+links.size());
	         map.put("news_title", newsTitle);
	         map.put("news_links", links);
	         
	         //System.out.println(map.toString());
	      }catch(IOException e){
	    	  e.getMessage();
	      }


	      
	      
	}//main
}
