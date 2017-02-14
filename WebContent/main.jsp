<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>newsroom</title>
    <link rel="stylesheet" href="css/main.css"/>
    <link rel="stylesheet" href="css/font-awesome.min.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>
    
    <style>
        /*높이 100% , 스크롤바 없애기*/
        body,html{height: 100%; overflow: hidden;}
        .titleBox{margin-bottom: 5px;}
        .back{
            display: inline-block;
            position: absolute;
            color: black;
            right: 20px;
        }
        .back:hover{color: red;}
        .genreListBox{ height: 88%;}

        .genreList{margin-bottom: 30px;}
        .genreList a{font-size: 18px;}
        .selectGenre{font-weight: 900; text-align: center;}
        .newsRoom{
            font-size: 55px;
            font-weight: 700;
            border-bottom: 1px solid #424242;
        }
        
        .articleContentWrap{
			margin-left:20px;
			width:800px;
			height: 88%;		
		}
        .articleContentBox{
            /*background: red;*/
            width: 750px;
            height: 88%;
			margin:auto;
            overflow-y: scroll;
            background: white;
        }
        
        .loading{
        	background: white;
        	display:none;
        	position: absolute;
        	right: 50%;
        	top: 50%;
        	z-index: 1;
		}
        .articleList{list-style: none;}
        .articleList li{position: relative;}
        .originalText{
			display:inline-block;
			position:absolute;
            width: 30px;
            height: 30px;
            right: 10px;
            top: 8px;
            text-align: center;
        }
        .fa-google{color: black; font-size: 25px;}
        .articleList .list-group-item{
            color: black;
            font-size: 17px;
            font-weight: 600;
        }
        .articleListBox{width:500px ; height: 88%;overflow-y: scroll;}
        .articleContentTitle{display:inline-block; width: 600px;}
		.text-danger{font-size: 20px;}
		.scrap:hover{
			cursor: pointer;
		}
		.scrapWrap{
			background: rgba(0,0,0,.3);
			position: fixed;
			width:750px;
			height: 700px;
			display: none;
			text-align: center;
		}
		.scrapWrap h3{
			color: white;
			font-weight: 800;
		}
		.scrapWrap textarea{
			width: 500px;
			height: 550px;
			border: 5px solid #424242;
		}
		.scrapBtn{
			margin-left: 50px;
			margin-right: 50px;
		}
		.subFunc{
			display:none; 
			width: 130px; 
			position:absolute; 
			font-size: 30px;
			top: 20px; 
			text-align: right;
			letter-spacing: 10px;
			
		}
        .mainArticle{list-style: none;border: 1px solid #424242;}
        /*주요 뉴스 1위만 빨간색으로 강조*/
        .mainArticle li:nth-child(1) a{ color: red;font-weight: 800;}
        
        /*텍스트 오버시 생략기호 */
        .mainArticle a{
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
        .mainArticle a{
            color: black;
            font-size: 15px;
            text-decoration: none;
        }
        .reloadMainArticle{
            display: inline-block;
            position: absolute;
            right: 20px;
            color: black;
        }
        .reloadMainArticle:hover{color:red;}

		#reloadMsg{
			color: #87bdd8;
			font-size: 10px;
		}
		#reloadMsg strong{font-size:12px;}
		
		<!-- 기사 관련 css -->
        .articleContentBox a{color: black;}
        .articleContentBox img {display:block;margin: auto;}
        .txt_caption{color: silver;font-style: italic;}
        .showMore{font-size: 20px;}
		
    </style>
</head>
<body>
    <div class="container col-sm-12 titleBox">
        <h1 class="newsRoom"><strong class="siteName">${param.site}</strong> NEWS ROOM!
            <a href="selectSite.jsp" class="back" title="사이트 선택하러 가기">
                <i class="fa fa-reply" aria-hidden="true"></i>
            </a>
        </h1>
    </div>
    <div class="container col-sm-2 genreListBox">
        
        <!--장르 목록-->
        <h3>장르</h3>
        <div class="list-group genreList">
              <a href="#" class="list-group-item" name="society">사회</a>
              <a href="#" class="list-group-item" name="economy">경제</a>
              <a href="#" class="list-group-item" name="politics">정치</a>
              <a href="#" class="list-group-item" name="entertainment">연예</a>
              <a href="#" class="list-group-item" name="world">세계</a>
              <a href="#" class="list-group-item" name="it">IT</a>
        </div>
        
        <!--주요 뉴스 7선-->
        <h3>주요뉴스
        	<span id="reloadMsg"><strong id="reloadTime"></strong> 갱신됨</span>
            <a href="#" class="reloadMainArticle" onclick="hotNews()"><i class="fa fa-refresh fa-spin fa-1x fa-fw"></i></a>
        </h3>
        <ul class="list-group mainArticle">
        </ul>  

    </div><!--//genreListBox-->

    <!--기사 목록 -->
    <div class="well col-sm-5 articleListBox">
        <h3 class="articleListTitle">기사목록</h3>
        <ul class="list-group articleList">

        </ul>
       
    </div><!--//articleList-->

    <!--기사 내용 -->
    <div class="col-sm-5 articleContentWrap">
		<div class="loading"><img src="img/loading.gif"/></div>
		
        <h3 class="col-sm-5 articleContentTitle">
            본문  -<strong class="text-danger articleTitle"></strong>
        </h3>
        <div class="subFunc"><i class="fa fa-cloud-download scrap" aria-hidden="true" title="스크랩하기"></i> <a class="openLink" target="_blank" href="#" title="사이트에서 보기"><i class="fa fa-link" aria-hidden="true"></i></a></div>
    
    <div class="well col-sm-4 articleContentBox">

	</div><!--//articleContent-->
	<div class="scrapWrap">
		<h3>스크랩할 기사내용</h3>
		<form class="scrapForm" action="" method="post">
		<textarea class="scrapContents" name="content" rows="" cols=""></textarea><br/>
		</form>
		<div><button class="btn-default btn-lg scrapBtn save" onclick="save()">저장</button><button class="btn-default btn-lg scrapBtn cancel">취소</button></div>
		
	</div>
	
	
	</div><!-- //articleContentWrap -->


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
//********************************** 변수 선언 구역 *********************//		
//스크립트에서 EL사용시 ''로 묶어주자
var site = '${param.site}';
var $reloadMainArticle = $(".reloadMainArticle");//리로딩
var $originalText = $(".originalText");// 사이트로 보기  
var $articleList = $(".articleList");//기사 목록
var $articleContentBox = $(".articleContentBox");//본문
var hotnewsURL = '';
var $mainArticle = $(".mainArticle");
//**********************************// 변수 선언 구역 *********************//	

/***************************** 부분 ajax 기능 *****************************************/


//------------------------------css, 속성 / 함수 -----------------------------------------//
hotNews(); //주요 뉴스
$(".siteName").text(site.toUpperCase());

//10분마다 주요 뉴스 갱신 
$(document).ready(function() {
setInterval("hotNews()", 600000);// 10분 마다 hotNews() 함수를 실행
});

//기사목록에서 기사 클릭햇을 때
$(".articleList").on('click','li a',function(){
 // window.open($(this).attr("name"));
 var textURL = $(this).attr("name");
 var title = $(this).text();
 
 //본문에 제목 보여주기
 $(".text-danger").text(title);
 
 //기사 링크 달기
 $(".openLink").attr("href",textURL);
 
 //스크랩, 링크열기 기능 보여주기
 $(".subFunc").css("display","inline-block");
 getArticleText(textURL);
})

//스크랩 기능 선택시 
$(".scrap").click(function(){
	$(".scrapContents").text("");
	$(".scrapWrap").show();
	$(".scrapContents").text($articleContentBox.text());
})

//스크랩 취소 눌렀을 때
$(".cancel").click(function(){
	$(".scrapWrap").hide();
})

//스크랩 저장 눌렀을 때
function save(){
	var title = $(".articleTitle").text();

		$(".scrapForm").attr("action","/Download?fileName="+encodeURIComponent(title));
		$(".scrapForm").submit();
		$(".scrapWrap").hide();


}

//------------------------ 사이트 별 주요 뉴스 링크 ---------------------------------------//


var d = null;
var h = null;
var m = null;
var time =null;
function hotNews(){

	$(".mainArticle").empty();
	d = new Date();
	h = d.getHours();
	m = d.getMinutes();

	time = h+":"+m;
	
	$("#reloadTime").text(time);
	//alert("리로딩 시작");
	$.ajax({
		  type:"POST",
		  url: "ajax/hotNewsAjax.jsp",
		  dataType:"json",
		  data:{"site":site},
		  error:function(xhr,error,code){
			  alert("에러!");
		  }
		  ,
		  success: function( json ) {
			//alert("성공!");
			if(json.hot_news_title==null){
				$("<li><a class='list-group-item' href='#'>랭킹 뉴스를 준비 중...</a></li>").appendTo($mainArticle);
			}else{
				for(var i = 0 ; i<7 ; i++){			
					$("<li><a class='list-group-item' title='"+json.hot_news_title[i]+"' href='"+json.hot_news_links[i]+"' target='_blank'>"+json.hot_news_title[i]+"</a></li>").appendTo($mainArticle);
				}
				
			}

		  }
		});//ajax
	
}//hotNews()

//------------------------ 사이트 별 뉴스  ---------------------------------------//    

var startNum;
var endNum;
var showNum;// 더보기 클릭시 보여줄 게시글 수
var articles = [];
$(".genreList").on('click','a',function(){
	var type = $(this).attr("name");
	
	//장르 선택시 효과
	$(".selectGenre").removeClass("selectGenre");
	$(this).addClass("selectGenre");
	//alert(type);
	$articleList.empty();
	$(".showMore").remove();
	$.ajax({
		  type:"POST",
		  url: "ajax/newsAjax.jsp",
		  dataType:"json",
		  data:{"type":type,"site":site},
		  error:function(xhr,error,code){alert("에러!");},
		  success: function( json ) {
			  //alert(json.news_title.length);	  
			  //배열에 기사 담기 
			  articles = []; //카테고리 클릭시 배열 초기화
			    
		      //카테고리 클릭시 변수 초기화
			  startNum = 0;// 게시글 가져올 시작 번지
			  endNum = 10;//게시글 가져올 마지막 번지
			  showNum = 5;// 더보기 클릭시 보여줄 게시글 수
			  $(".disabled").removeClass("disabled");//버튼 active로 초기화
			  
			  
			  for(var a = 0 ; a < json.news_title.length ; a++){
				  var obj = {
						  title : json.news_title[a],
						  link : json.news_links[a]
				  }
				  //기사 객체 담기
				  articles.push(obj);
			  }
			    //alert("title : "+articles.length);

			 
			  if(json.news_title==null){
				  $("<li><a class='list-group-item' href='#'>"+articles[i].title+"</a></li>").appendTo($articleList);
				}else{
					for(var i = 0 ; i < 10 ; i++){	//최초 10개 기사 보여줌		
						$("<li><a class='list-group-item' href='#' name='"+articles[i].link+"'>"+articles[i].title+"</a></li>").appendTo($articleList);	
					}
					//더보기 버튼
				    $("<button type='button' class='btn btn-default showMore col-sm-12' onclick='moreArticle("+articles.length+")'>more <strong class='articleNum'>"+endNum+"</strong> / <span class='totalArticleNum'>"+articles.length+"</span></button>").appendTo($(".articleListBox"));
				}
		  }
		});//ajax
	
});    

function moreArticle(total){
	//alert("test : "+total);

	more();
	
	function more(){
	    startNum = endNum;
	    endNum += showNum;
	    $(".articleNum").text(endNum);
		//alert("endNum - "+endNum + " / total - "+total);
		
	        if(endNum < total){//게시글 보여주기
	        	//alert("총 게시글 보다 낮음"+endNum);
	             for(var i = startNum ; i < endNum ; i++){
	            	$("<li><a class='list-group-item' href='#' name='"+articles[i].link+"'>"+articles[i].title+"</a></li>").appendTo($articleList);
	            }
	
	      	    }else{//남은 게시글 보여주기
	        	//alert("총 게시글 보다 높음"+"startNum : "+startNum + " // " +"articles : "+articles.length);
	
	             for(var j = startNum ; j < articles.length ; j++){
	            	$("<li><a class='list-group-item' href='#' name='"+articles[j].link+"'>"+articles[j].title+"</a></li>").appendTo($articleList);

	             }	
	            	
	            	endNum+=articles.length;	
	        		$(".showMore").addClass("disabled").text("Not exist any article more");
	            }//if

          
      }//more()

	}//moreArticle

	
//------------------------ 기사 본문 뽑기   ---------------------------------------// 

function getArticleText(url){
	 $(".loading").show(); 

	//alert(url);
	
	$articleContentBox.empty();

	$.ajax({
		  type:"POST",
		  url: "ajax/articleTextAjax.jsp",
		  dataType:"json",
		  data:{"url":url,"site":site},
		  error:function(xhr,error,code){alert("에러!");},
		  success: function( json ) {
				
			 $(".openLink").attr("href");
			//alert("성공");
			  $articleContentBox.html(json);
			  $(".figure_frm").append("<br/>");
			 
				$(".loading").hide();
		  }
		});//ajax

}

</script>

</body>
</html>