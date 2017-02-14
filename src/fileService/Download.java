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
		System.out.println("doGet ȣ��");

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost ȣ��");
		request.setCharacterEncoding("UTF-8");
		String fileName = request.getParameter("fileName");
		System.out.println(fileName);
		if(fileName.indexOf("\"")!= -1){fileName = fileName.replaceAll("\"", "'");}
		if(fileName.indexOf("?")!= -1){fileName = fileName.replaceAll("\\?"," ");}
		
		String realFileName = fileName;
		System.out.println("�ٿ�ε� �� ���� �� : "+realFileName);
		String content = request.getParameter("content");
		
		System.out.println("�ٿ�ε� �� ���� : "+ content);
		
		//------------------�޾ƿ� ��系���� ������ ���� storage �������� txt ���� ����------------------------------//
		
		String saveDir = this.getServletContext().getRealPath("/storage/");
		System.out.println("saveDir : "+saveDir);
		File file = new File(saveDir + "/" + realFileName+".txt");
		System.out.println("������ ��ġ�� ������ ������ ��ü ��� : " + file);
		
		
		//C:\Users\Administrator\Desktop\������\workspace\jsp\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\NewsRoom_ver5\storage\��
		//txt���� ����
		BufferedWriter bw=null;
		if(file.exists()){
			//���� ������ �����ϸ�
			System.out.println("���� ���� ����");
		}else{
			//���� ���ϸ��� �������� ������
			System.out.println("���� ���� ��");
			file.createNewFile();		
			//������ �ؽ�Ʈ ���Ͽ� ��系�� ����
			bw = new BufferedWriter(new FileWriter(file));
		}
		
		bw.write(content.trim());
		bw.flush();
		bw.close();
		
		
		//------------------ ������ �ִ� �ؽ�Ʈ���� �ٿ�ε� ------------------------------// 
		
		//MIMETYPE �����ϱ�
		String mimeType = getServletContext().getMimeType(file.toString());
		if(mimeType == null)
		{
			response.setContentType("application/octet-stream");
		}
		
		// �ٿ�ε�� ���ϸ��� ����
		String downName = null;
		if(request.getHeader("user-agent").indexOf("MSIE") == -1){
			downName = new String(fileName.getBytes("UTF-8"), "8859_1");
		}else{
			downName = new String(fileName.getBytes("EUC-KR"), "8859_1");
		}
		
		//txt Ȯ���ڷ� �ٿ�ε��ϵ��� ����
		response.setHeader("Content-Disposition","attachment;filename=\"" + downName +".txt"+ "\";");
		
		// ��û�� ������ �о Ŭ���̾�Ʈ������ �����Ѵ�.
		// ���� �ȿ� ����ִ� ������ �о���δ�.
		FileInputStream fileInputStream = new FileInputStream(file);
		ServletOutputStream servletOutputStream = response.getOutputStream();
		
		byte b [] = new byte[1024];
		int data = 0;
		
		//������ ����� txt���Ͽ� ������ �б�����
		//-1 ���̻� ���� ���� ���� �� ���� read �޼��� �ݺ� ���� 
		
		while((data=(fileInputStream.read(b, 0, b.length))) != -1){
			servletOutputStream.write(b, 0, data);
			}
		
		servletOutputStream.flush();
		servletOutputStream.close();
		fileInputStream.close();
	}


}
