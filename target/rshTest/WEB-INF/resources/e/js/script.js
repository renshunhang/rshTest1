
$(document).ready(function(){   
  if (document.documentMode <=8){$(".page_style").css({"min-width":"1200px"});}
  else
  {
	$("head").append('<meta name="viewport" content="width=device-width,initial-scale=1">');
    FunNavigation2(1,"menu_box","&#xf0025","static")
	FunNavigation2(1,"nav_menu","&#xf0025","static") 
    FunNavigation2(2,"menu_box","&#xf016d","absolute")
	FunNavigation2(2,"nav_menu","&#xf016d","absolute")
	WowS("fadedown","fadeInDown");
	WowS("fadeleft","fadeInLeft");
	WowS("faderight","fadeInRight");
	WowS("fadeup","fadeInUp");
	Wows("zxyhhd","fadeInDown",4);
	Wows("syhd","fadeInUp",5);
	Wows("bigpic","fadeInUp",4);
	Wows("zspic","fadeInUp",3);
    //ZDZJheight();
  }
  if($(".nav_menu").children("ul").children("li").length<=1){$(".nav_menu").children("ul").css({"display":"none"});};
  var $jjyc_yc_com=$(".jjyc").children("li.yc_com");
  $jjyc_yc_com.eq(0).addClass("current").children(".tits").children(".s1").text("-");
  $jjyc_yc_com.each(function(i){
	  $(this).children(".tits").click(function(){
		  $(this).children(".s1").text("-").parents("li.yc_com").siblings().find(".s1").text("+");
		  $(this).siblings(".coms").slideDown().parent("li").siblings().children(".coms").slideUp();
		  $(this).parent("li").addClass("current").siblings().removeClass("current");
	  });
  });
});


 /*$(window).resize(function(){     放大缩小时判断
  ZDZJheight();
});*/



/*图片居中*/
$(document).ready(function(){
var jz=$(".mk_twjj_box li a.pic").children("img");
var jzh=$(".mk_twjj_box li a.pic").children("img").height();
var ph=$(".mk_twjj_box li a.pic").height();
jz.css({"top":-(jzh-ph)/2,"position":"relative"});

})



/*function ZDZJheight()                   
{
  var $windows=$(window).innerWidth();
  if (document.documentMode <=8){$(".nav_menu").children("ul").children("li").children("ul").hide();return;}
  if($windows<1000){$(".nav_menu").children("ul").children("li").children("ul").css({"display":"block"});}
  else{$(".nav_menu").children("ul").children("li").children("ul").css({"display":"none"});}
  $(".nav_menu").children("ul").children("li").each(function(j){
	 if($(this).children("a").attr("href").indexOf(Sublanmu_Id)>0)
	 {
       if($(".nav_menu").children("ul").children("li").children("ul").size()>0)
	   {
	     var $this_ulhei=$(this).children("ul").innerHeight();
		 $(".nav_box").animate({"padding-bottom":$this_ulhei+"px"});
		 $(this).children("ul").css({"display":"block"});
	   }
	 }
  });
}
*/



function FunNavigation2(Series,ClassName,Lab,PosiTion){       /*Series 1为一级栏目 分类 2为二级栏目 分类*/
    switch(Series)
	{
		case 1:
		    if($("."+ClassName).size()>0){
			var navigation = responsiveNav("."+ClassName+"",{ // Selector: The ID of the wrapper
				animate: true, // Boolean: 是否启动CSS过渡效果（transitions）， true 或 false
				transition: 0, // Integer: 过渡效果的执行速度，以毫秒（millisecond）为单位
				label: "<i class='iconfont'>"+Lab+"</i>", // String: Label for the navigation toggle
				insert: "after", // String: Insert the toggle before or after the navigation
				customToggle: "", // Selector: Specify the ID of a custom toggle
				openPos: PosiTion, // String: Position of the opened nav, relative or static
				jsClass: "js", // String: 'JS enabled' class which is added to <html> el
				debug: false, // Boolean: Log debug messages to console, true 或 false
				init: function(){}, // Function: Init callback
				open: function(){}, // Function: Open callback
				close: function(){} // Function: Close callback
			});
			}
		break;
		case 2:
		  if($("."+ClassName).size()>0){
			$("."+ClassName).children("ul").children("li").children("ul").each(function(i){ 
				$(this).addClass(ClassName+i);
				var navigation = responsiveNav("."+ClassName+i,{ // Selector: The ID of the wrapper
					animate: true, // Boolean: 是否启动CSS过渡效果（transitions）， true 或 false
					transition: 0, // Integer: 过渡效果的执行速度，以毫秒（millisecond）为单位
					label: "<i class='iconfont'>"+Lab+"</i>", // String: Label for the navigation toggle
					insert: "after", // String: Insert the toggle before or after the navigation
					customToggle: "", // Selector: Specify the ID of a custom toggle
					openPos: PosiTion, // String: Position of the opened nav, relative or static
					jsClass: "js", // String: 'JS enabled' class which is added to <html> el
					debug: false, // Boolean: Log debug messages to console, true 或 false
					init: function(){}, // Function: Init callback
					open: function(){}, // Function: Open callback
					close: function(){} // Function: Close callback
				});
			});
		  };
		break;
	}
}

function WowS(BoxClassName,Fadehdfx){    /*首页滑动效果*/
    var wow = new WOW({
      boxClass:BoxClassName,
      animateClass:'animated '+Fadehdfx,
      offset: 0,
      mobile: true,
      live: true
    });
    wow.init();
}

function Wows(classname,hdclassname,cout)/*classname执行动画元素 hdclassname执行动画的方式 cout 每行排几个*/
{
  var $classname=$("."+classname);
  $classname.each(function(i){
	  if(i%cout==0){$(this).attr({"data-wow-delay":"0.2s"});}
	  else if(i%cout==1){$(this).attr({"data-wow-delay":"0.4s"});}
	  else if(i%cout==2){$(this).attr({"data-wow-delay":"0.6s"});}
	  else if(i%cout==3){$(this).attr({"data-wow-delay":"0.8s"});}
	  else if(i%cout==4){$(this).attr({"data-wow-delay":"0.9s"});}
	  else if(i%cout==5){$(this).attr({"data-wow-delay":"1s"});}
	  else if(i%cout==6){$(this).attr({"data-wow-delay":"1.1s"});}
	  else if(i%cout==7){$(this).attr({"data-wow-delay":"1.2s"});}
	  else if(i%cout==8){$(this).attr({"data-wow-delay":"1.3s"});}
	  else if(i%cout==9){$(this).attr({"data-wow-delay":"1.4s"});}
  });
  var wow = new WOW({
    boxClass:classname,
    animateClass: 'animated '+hdclassname,
    offset: 80,
    mobile: true,
    live: true
  });
  wow.init();
}



function ShowSubMenu(id) //显示下拉
 {
   var $Menu=$("#Menu");
   if($Menu.size()!=1){return;}
   var $MenuItem=$Menu.children("ul").children("li");
   var $CurrentMenuItem=$("#MenuItem"+id);
   if($MenuItem.size()<=1){return;}
   if(typeof(submenu_style)=="undefined")
    {
      submenu_style=1;  //1表示纵向下拉，2表示横向下拉,0则关闭
    }
   var classname="menu_current";
   switch(submenu_style)
    {
     case 2:
       $MenuItem.children("ul").hide();
       document.write('<link rel="stylesheet" type="text/css" href="/e/css/submenu.css" />');
       $CurrentMenuItem.children("ul").show();
       $CurrentMenuItem.addClass(classname).siblings().removeClass(classname);
       $MenuItem.mouseenter(function(){$(this).addClass(classname).children("ul").show();$(this).siblings().removeClass(classname).children("ul").hide();});
     break;

     case 1:
	   var ck_widths=document.documentElement.clientWidth;
	   document.write('<link rel="stylesheet" type="text/css" href="/e/css/dropmenu.css" />');
	   function Dhxl(ck_widths)
	   {
         $MenuItem.children("ul").hide();
         $MenuItem.mouseenter(function(){$(this).addClass(classname).siblings().removeClass(classname);});
         $MenuItem.mouseleave(function(){$(this).removeClass(classname);});
         $MenuItem.mouseenter(function(){$(this).children("ul").stop().slideDown("fast");});
         $MenuItem.mouseleave(function(){$(this).children("ul").stop().slideUp("fast");});
		 if(typeof(Lanmu_Id)!="undefined")
         {
           $Menu.bind('mouseleave',function(){$CurrentMenuItem.addClass(classname);});
         }
	   };
	   if (document.documentMode <=8) 
       {
	   }
	   else
	   {
	     if(ck_widths>=1000){Dhxl();}else{$MenuItem.unbind();$MenuItem.children("ul").show();};
	     $(window).resize(function(){
		  // $(".nav-toggle").remove();
	       var ck_width=document.documentElement.clientWidth;
	       if(ck_width>=1000){Dhxl();}else{$MenuItem.unbind();$MenuItem.children("ul").show();};
	     });
	   }
      break;
   }
 }
function ShowSubMenu(id) //显示下拉
 {
   var $Menu=$("#Menu");
   if($Menu.size()!=1){return;}
   var $MenuItem=$Menu.children("ul").children("li");
   var $CurrentMenuItem=$("#MenuItem"+id);
   if($MenuItem.size()<=1){return;}
   if(typeof(submenu_style)=="undefined")
    {
      submenu_style=1;  //1表示纵向下拉，2表示横向下拉,0则关闭
    }
   var classname="menu_current";
   switch(submenu_style)
    {
     case 2:
       $MenuItem.children("ul").hide();
       document.write('<link rel="stylesheet" type="text/css" href="/e/css/submenu.css" />');
       $CurrentMenuItem.children("ul").show();
       $CurrentMenuItem.addClass(classname).siblings().removeClass(classname);
       $MenuItem.mouseenter(function(){$(this).addClass(classname).children("ul").show();$(this).siblings().removeClass(classname).children("ul").hide();});
     break;

     case 1:
	   var ck_widths=document.documentElement.clientWidth;
	   document.write('<link rel="stylesheet" type="text/css" href="/e/css/dropmenu.css" />');
	   function Dhxl(ck_widths)
	   {
         $MenuItem.children("ul").hide();
         $MenuItem.mouseenter(function(){$(this).addClass(classname).siblings().removeClass(classname);});
         $MenuItem.mouseleave(function(){$(this).removeClass(classname);});
         $MenuItem.mouseenter(function(){$(this).children("ul").stop().slideDown("fast");});
         $MenuItem.mouseleave(function(){$(this).children("ul").stop().slideUp("fast");});
		 if(typeof(Lanmu_Id)!="undefined")
         {
           $Menu.bind('mouseleave',function(){$CurrentMenuItem.addClass(classname);});
         }
	   };
	   if (document.documentMode <=8) 
       {
	   }
	   else
	   {
	     if(ck_widths>=1000){Dhxl();}else{$MenuItem.unbind();$MenuItem.children("ul").show();};
	     $(window).resize(function(){
		  // $(".nav-toggle").remove();
	       var ck_width=document.documentElement.clientWidth;
	       if(ck_width>=1000){Dhxl();}else{$MenuItem.unbind();$MenuItem.children("ul").show();};
	     });
	   }
      break;
   }
 }






//无下拉的菜单取消hover样式
$(function(){
 var $menuli=$("#Menu").children("ul").children("li");
 if($menuli.size()==0){return;}
 $menuli.bind('mouseenter',function(){
   if($(this).children("ul").size()==0)
    {
     $(this).removeClass("hover");
    }
 });
});

//右侧返回顶部图标
$(function(){
     var icon='<a class="gotoptop_icon" id="gotoptop_icon" href="#" title="返回顶部"></a>';
     $("body").append(icon);
     var $window=$(window);
     var $gotoptop_icon=$("#gotoptop_icon");
     var $body = (window.opera) ? (document.compatMode == "CSS1Compat" ? $('html') : $('body')) : $('html,body'); // opera fix
     $(window).bind('scroll resize',function(){
        if($window.scrollTop()>0)
         {
          $gotoptop_icon.show();
         }
        else
         {
          $gotoptop_icon.hide();
         }
     });
     $gotoptop_icon.bind('click',function(){
        $body.animate({scrollTop:'0px'},"fast");
         return false;
     });
});


function goto(id)
  {
     var pos=0;
     var obj=$(id);
     if(obj.size()==0){return;}
     pos=obj.offset().top;
     pos=pos-137;
     var $body = (window.opera) ? (document.compatMode == "CSS1Compat" ? $('html') : $('body')) : $('html,body'); // opera fix
     $body.animate({scrollTop:pos+'px'});
 }





