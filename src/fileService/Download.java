package fileService;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Download extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public Download() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("doGet 호출");

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost 호출");
		request.setCharacterEncoding("UTF-8");
		String fileName = request.getParameter("fileName");
		System.out.println(fileName);
		if(fileName.indexOf("\"")!= -1){fileName = fileName.replaceAll("\"", "'");}
		if(fileName.indexOf("?")!= -1){fileName = fileName.replaceAll("\\?"," ");}
		
		String realFileName = fileName;
		System.out.println("다운로드 할 파일 명 : "+realFileName);
		String content = request.getParameter("content");
		
		System.out.println("다운로드 할 내용 : "+ content);
		
		//------------------받아온 기사내용을 가지고 서버 storage 폴더내에 txt 파일 생성------------------------------//
		
		String saveDir = this.getServletContext().getRealPath("/storage/");
		System.out.println("saveDir : "+saveDir);
		File file = new File(saveDir + "/" + realFileName+".txt");
		System.out.println("서버에 위치한 저장할 파일의 전체 경로 : " + file);
		
		
		//C:\Users\Administrator\Desktop\개발자\workspace\jsp\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\NewsRoom_ver5\storage\에
		//txt파일 생성
		BufferedWriter bw=null;
		if(file.exists()){
			//같은 파일이 존재하면
			System.out.println("같은 파일 존재");
		}else{
			//같은 파일명이 존재하지 않으면
			System.out.println("파일 생성 함");
			file.createNewFile();		
			//생성된 텍스트 파일에 기사내용 쓰기
			bw = new BufferedWriter(new FileWriter(file));
		}
		
		bw.write(content.trim());
		bw.flush();
		bw.close();
		
		
		//------------------ 서버에 있는 텍스트파일 다운로드 ------------------------------// 
		
		//MIMETYPE 설정하기
		String mimeType = getServletContext().getMimeType(file.toString());
		if(mimeType == null)
		{
			response.setContentType("application/octet-stream");
		}
		
		// 다운로드용 파일명을 설정
		String downName = null;
		if(request.getHeader("user-agent").indexOf("MSIE") == -1){
			downName = new String(fileName.getBytes("UTF-8"), "8859_1");
		}else{
			downName = new String(fileName.getBytes("EUC-KR"), "8859_1");
		}
		
		//txt 확장자로 다운로드하도록 설정
		response.setHeader("Content-Disposition","attachment;filename=\"" + downName +".txt"+ "\";");
		
		// 요청된 파일을 읽어서 클라이언트쪽으로 저장한다.
		// 파일 안에 들어있는 내용을 읽어들인다.
		FileInputStream fileInputStream = new FileInputStream(file);
		ServletOutputStream servletOutputStream = response.getOutputStream();
		
		byte b [] = new byte[1024];
		int data = 0;
		
		//서버에 저장된 txt파일에 내용을 읽기위해
		//-1 더이상 읽을 줄이 없을 때 까지 read 메서드 반복 실행 
		
		while((data=(fileInputStream.read(b, 0, b.length))) != -1){
			servletOutputStream.write(b, 0, data);
			}
		
		servletOutputStream.flush();
		servletOutputStream.close();
		fileInputStream.close();
	}


}
