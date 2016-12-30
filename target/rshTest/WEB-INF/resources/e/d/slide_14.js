var Show_Style=3;
var Image_14=new Array();
var Pics="/e/images/banner/m_banner.jpg";
var Links="";
var Titles="";
var Alts="";
var Apic14=Pics.split('|');
var ALink14=Links.split('|');
var ATitle14=Titles.split('|');
var AAlts14=Alts.split('|');
var Show_Text=0;
for(i=0;i<Apic14.length;i++)
  {
   Image_14.src = Apic14[i]; 
  }



  var FHTML='<div id="js_slide_focus_14" class="slide_focus focus_style3" style="height:300px">';
  FHTML+='<ul class="inner">';
  for(var i=0;i<Apic14.length;i++)
   {
     if(ALink14.length<(i+1) || ALink14[i]=="")
      {
       ALink14[i]="javascript:void(0)";
      }
     if(AAlts14.length<(i+1))
      {
       AAlts14[i]="";
      }
     if(ATitle14.length<(i+1))
      {
       ATitle14[i]="";
      }
    FHTML+='<li><a href="'+ALink14[i]+'" target="_self" title="'+AAlts14[i]+'"><img src="'+Apic14[i]+'">';
    FHTML+='<em>'+ATitle14[i]+'</em>';
    FHTML+='</a></li>';
   }
 FHTML+='</ul>';
 FHTML+='</div>';
 document.write(FHTML);
$(function(){Slide_Focus("js_slide_focus_14",1,5,600,300,true);});
