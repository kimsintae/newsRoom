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


//------------------------------함수 / 메서드-----------------------------------------//
hotNews(); //주요 뉴스
$(".siteName").text(site.toUpperCase());

//10분마다 주요 뉴스 갱신 
$(document).ready(function() {
setInterval("hotNews()", 600000);// 10분 마다 hotNews() 함수를 실행
});


$(".articleList").on('click','li a',function(){
   // window.open($(this).attr("name"));
   var textURL = $(this).attr("name");
   var title = $(this).text();
   $(".text-danger").text(title);
   getArticleText(textURL);
 })


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
			  showNum = 10;// 더보기 클릭시 보여줄 게시글 수
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
				   
			//alert("성공");
			  $articleContentBox.html(json);
			  $(".vod_area").remove();//네이버 영상 제거
			  $(".figure_frm").append("<br/>");
			 
				$(".loading").hide();
		  }
		});//ajax

}