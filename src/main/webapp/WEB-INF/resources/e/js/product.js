document.write("<script src=\"/e/js/dialog.js\" type=\"text/javascript\"></script>");
var imageindex=0,PicNums=0;
var viewobj,picture,thumbnail,thumbnail_width,thumbnails,thumbnails_li;

$(document).ready(function(){
  thumbnails=$("#thumbnails");
  thumbnails_li=thumbnails.children("ul").children("li");
  PicNums=thumbnails_li.size();
  if(PicNums==0){return;}
  thumbnail_width=thumbnails_li.eq(0).innerWidth();
  thumbnails.children("ul").css("width",thumbnail_width*PicNums);
  thumbnails_li.eq(0).addClass("current");
});


function LoadImg(i)
 {
  if(i-imageindex>0)
   {
     thumbnails.animate({scrollLeft:"+="+thumbnail_width+"px"},"normal");
   }
  else
   {
    thumbnails.animate({scrollLeft:"-="+thumbnail_width+"px"},"normal");
   }
  ShowCurrent(i);
 }

function ShowCurrent(i)
 {
   picture=document.getElementsByName("picture");
   thumbnail=document.getElementsByName("thumbnail");
   HideAllpic();
   picture[i].style.display="inline";
   thumbnails_li.eq(i).addClass("current");
   imageindex=i;
 }

function HideAllpic()
 {
  for(i=0;i<picture.length;i++)
   {
     picture[i].style.display="none";
     thumbnails_li.removeClass("current");
   }
 }

function roll(direction) 
 {
   if(direction=="left")
     {
       thumbnails.animate({scrollLeft:"-="+thumbnail_width+"px"},"normal",function(){imageindex--;if(imageindex<0){imageindex=0};ShowCurrent(imageindex)});
     }
   else
     {
       thumbnails.animate({scrollLeft:"+="+thumbnail_width+"px"},"normal",function(){imageindex++;if(imageindex>=PicNums){imageindex=PicNums-1};ShowCurrent(imageindex)});
     }
 }


function ShowImage()
 {
   var Url=document.getElementsByName("picture")[imageindex].getAttribute('big');
   document.getElementById("currentimage").value=Url;
   var Width=850;
   var Height=550;
   var Left=(window.screen.availWidth-10-Width)/2;
   var Top=(window.screen.availHeight-30-Height)/2;
   var v=window.open("/e/incs/showimage.html","imagesview","width="+Width+",height="+Height+",top="+Top+",left="+Left+",toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no");
 }
