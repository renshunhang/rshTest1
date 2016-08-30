function General_Set(Title,Url)//通用弹出窗口
 {
  IDialog(Title,Url,"95%","90%");
 }

function Open_Editor(Table,Field,Id,ObjId,Title)
 {
  IDialog(Title,"fckeditor.aspx?table="+Table+"&field="+Field+"&id="+Id+"&objid="+ObjId,"95%","90%");
 }

function Js_Code(Id,Style,Type)
 {
  var Width=750;
  var Height="90%";
  if(Type!="vote")
   {
    var Width=700;
    var Height=240;
   }
  IDialog("获取调用代码","js_view.aspx?id="+Id+"&style="+Style+"&type="+Type,Width,Height);
 }

function Sort_Set(Id,Table)
 {
   IDialog("类别设置","sort_set.aspx?id="+Id+"&table="+Table,700,400);
   return false;
 }

function Issue_Data(Table,DetailId,Wid,xuhao) //签发信息
 {
    var Url="/e/member/issue.aspx?table="+Table+"&detailid="+DetailId+"&workid="+Wid+"&from=master&xuhao="+xuhao;
    IDialog("签发信息",Url,700,"90%");
 }

function Sign_Data(Table,DetailId) //签收信息
  {
   var Url="/e/member/sign.aspx?table="+Table+"&detailid="+DetailId+"&ismaster=1";
   IDialog("信息签收",Url,700,"90%");
  } 

function open_calendar(Id,showtime)
 {
  var ObjId=document.getElementById(Id);
  if(showtime==1)
   {
    SelectDate(ObjId,'yyyy-MM-dd hh:mm:ss');
   }
  else
   {
    SelectDate(ObjId,'yyyy-MM-dd');
   }
 }

function open_ztlist(ismultiple,objid)
 {
  if(typeof(objid)=="undefined"){objid="zt_list";}
  IDialog("选择专题","zt_select.aspx?multiple="+ismultiple+"&objid="+objid,"90%","90%");
 }

function foreColor(id,Addstr){
  if(!Error())	return;
  var arr = showModalDialog("/e/incs/color.html", "foreColor", "dialogWidth:18.5em; dialogHeight:17.5em;status:0;help:no;resizable:no;");
  if (arr != null) 
  document.getElementById(id).value=Addstr+arr;
}

function Iframe_ReFresh(iframeid)
 {
   var obj=window.frames[iframeid];
   obj.location.href=obj.location.href;
 }

function Iframe_Submit(iframeid,actfrom)
 {
   if(arguments.length==1)
    {
     actfrom="0";
    }
   var obj=window.frames[iframeid];
   if(obj==null){return;}
   obj.autosubmit(actfrom);
 }

function ShowObj(id)
 {
    var obj=document.getElementById(id);
    if(obj.style.display=="none")
     {
      obj.style.display="";
     }
   else
     {
      obj.style.display="none";
     }
 }

function hideall(Obj)
   {
    var h=0;
    for(h=0;h<Obj.length;h++)
     {
      if(Obj[h]!=null)
      Obj[h].style.display="none";
    }
  }

function startpost()
 {
  document.getElementById("post_area").style.display="none";
  document.getElementById("post_loading").style.display="";
  setTimeout(GetIframeContent,3000);
 }

function GetIframeContent()
 {
     var doc=document.getElementById("post_iframe").contentDocument;
     var content="";
     if(doc==null)
      {
       doc=document.frames["post_iframe"].document;
      }
     if(doc==null){return;}
     content=doc.body.innerHTML;
     if(doc.readyState=="complete")
      {
       if(content.length>0)
        {
          document.write("<style>html,body,table,td,div,p{font-size:13px}</style><br><span style='color:#ff0000'>对不起，提交出错！</span>错误信息如下所示，如您需要提供协助或解决方法，请登录到<a href='http://bbs.pageadmin.net/' target='_blank'>PageAdmin网站管理系统官方论坛</a>提交此问题。"+content);
        }
       return;
      }
     else
      {
        setTimeout(GetIframeContent,3000);
      }
 }  


function postover(text,to) //提交完毕回调方法
 {
  alert(text);
  document.getElementById("post_area").style.display="";
  document.getElementById("post_loading").style.display="none";
  if(to=="refresh")
   {
    location.href=location.href;
   }
  else if(to=="p_refresh")
   {
    parent.location.reload();
   }
  else if(to!=null && to!="")
   {
    location.href=to;
   }
  else
   {

   }
 }

function data_postove(text,posttype,cs) //信息发布页专用的回调方法
 {
  alert(text);
  document.getElementById("post_area").style.display="";
  document.getElementById("post_loading").style.display="none";
  if(posttype=="add")
   {
    location.href=cs;
   }
  else
   {
      var titlepic=cs.replace("titlepic=","");
      var objtitlepic=document.getElementById("titlepic");
      if(titlepic!="" && objtitlepic!=null)
       {
         objtitlepic.value=titlepic;
         document.getElementById("upload_titlepic").style.display="none";
         document.getElementById("delete_titlepic").style.display="";
       }
   }

 }

function showtab(num)
 {
    var Obj=document.getElementsByName("tabcontent");
    var Obj1=document.getElementsByName("tab");
    if(document.getElementById("tab")==null){return;}
    if(num>Obj1.length-1){return;}
    hideall(Obj);
    var k=0;
     for(k=0;k<Obj1.length;k++)
      {
       Obj1[k].style.fontWeight="normal";
      }
     if(Obj[num]!=null){Obj[num].style.display="";}
     Obj1[num].style.fontWeight="bold";
     SetCookie("tab",num);
 }


function delete_file(table,field,id)
 {
   if(!confirm("是否确定删除?"))
    {
      return;
    }
   var obj=document.getElementById(field);
   var del_obj=document.getElementById("delete_"+field);
   var upload_obj=document.getElementById("upload_"+field);
   var date=new Date(); 
   var R=Math.random();
   var x=new PAAjax();
   x.setarg("post",true);
   x.send("/e/aspx/delete_file.aspx","table="+table+"&field="+field+"&id="+id+"&path="+obj.value+"&r="+R,function(v){});
   obj.value="";
   del_obj.style.display="none";
   upload_obj.style.display="";
 }

//分类ajax
function Write_Select(sid,table)
 {
  var s="";
  for(i=2;i<10;i++)
   {
     s+="<select name=\"s_sort\" id=\"s_sort\" onchange=\"c_sort("+sid+","+i+",'"+table+"')\" style=\"display:none\"></select> ";
   }
  document.write(s);
 }

function c_siteofsort(The_Table)
 {
  var obj=document.getElementById("data_site");
  var siteid=obj.value;
  var s_objs=document.getElementsByName("s_sort");
  for(i=0;i<s_objs.length;i++)
     {
      s_objs[i].options.length=0;
      s_objs[i].style.display="none";
     }
  document.getElementById("sort").value="0";
  var R=Math.random();
  var x=new PAAjax();
  x.setarg("get",false);
  x.send("/e/aspx/get_sort.aspx","siteid="+siteid+"&table="+The_Table+"&thetype=changesite&r="+R,function(v){insert_sort(v,0)});
 }


function c_sort(SiteId,level,The_Table) //ajax获取分类
 {
   var s_objs=document.getElementsByName("s_sort");
   for(i=0;i<s_objs.length;i++)
     {
      if(i<=(level-1)){continue;}
      s_objs[i].options.length=0;
      s_objs[i].style.display="none";
     }
   var obj=s_objs[level-1];
   var IsDataSet=0;
   if(Sort_Type=="all")
     {
      if(obj.value=="")
       {
       document.getElementById("sort").value=s_objs[level-2].value;
       }
      else
       {
       document.getElementById("sort").value=obj.value;
       }
      IsDataSet=1
     }
   else
     {
      document.getElementById("sort").value="0";
     }
   if(obj.value!="0" && obj.value!="")
    {
      if(document.forms[The_Table]!=null)
       {
        var posttype=document.forms[The_Table].post;
        if(posttype!=null && typeof(load_form_structure)=="function")
         {
          load_form_structure(obj.value,posttype.value,The_Table);
         }
       }
      var R=Math.random();
      var x=new PAAjax();
      x.setarg("get",false);
      x.send("/e/aspx/get_sort.aspx","siteid="+SiteId+"&table="+The_Table+"&sortid="+obj.value+"&from=master&isset="+IsDataSet+"&r="+R,function(v){insert_sort(v,level)});
    }
  if(location.href.indexOf("data_add.aspx")>0)
   {
     c_sort_callback(The_Table);//改变触发
   }
 }

function c_sort_callback(The_Table)
 {

 }

function insert_sort(v,level) //ajax获取分类回调
 {
   var s_objs=document.getElementsByName("s_sort");
   if(IsNum(v))
    {
      document.getElementById("sort").value=v;
    }
   else
    {
      var obj=s_objs[level];
      obj.style.display="";
      var A_v=v.split(',,');
      var item;
      if(Sort_Type=="all")
       {
         if(level==0)
          {
           obj.options.length=0;
           item=new Option("---所有分类---","0");
          }
         else
          {
           item=new Option("---所有子分类---","");
          }
       }
      else
       {
         item=new Option("---请选择---","0");
       }
      obj.options.add(item);
      for(i=0;i<A_v.length;i++)
       {
        if(A_v[i]==""){continue;}
        item=new Option((A_v[i].split(','))[1],(A_v[i].split(','))[0]);
        obj.options.add(item);
       }
   }
 }

function Load_Sort(Siteid,Sorts,table) //初始分类，Sorts为parent_ids加current_sortid
   {
    var s_objs=document.getElementsByName("s_sort");
    if(s_objs.length==0){return;}
    var A_Sorts=Sorts.split(",");
    Sorts="";
   for(i=0;i<A_Sorts.length;i++)
    {
     if(A_Sorts[i]=="" || A_Sorts[i]=="0"){continue;}
     Sorts+=A_Sorts[i]+",";
    }
   A_Sorts=Sorts.split(",");
  for(k=0;k<A_Sorts.length;k++)
   {
     if(A_Sorts[k]!="")
      { 
        s_objs[k].value=A_Sorts[k];
        c_sort(Siteid,k+1,table);
      }
   }
 }

//分类ajax

function MouseoverColor(id)
{
 var trs=document.getElementById(id).getElementsByTagName("tr");
 for(var i=0 ;i<trs.length;i++)
  {
   if(trs[i].className.indexOf("listitem")>=0)
   {
   trs[i].onmouseover=function(){this.className+=" overcolor";}
   trs[i].onmouseout=function(){this.className=this.className.replace(" overcolor","")}
   }
  }
}

//自定义表单必填项验证
function Check_ZdyForm(formName)
  { 
   var Obj_Sort=document.forms[formName].sort;
   if(Obj_Sort!=null)
    {
       
      if(Obj_Sort.value=="0" || Obj_Sort.value=="")
       {
        if(Obj_Sort.value=="0")
         {
          alert("请选择分类!");
         }
        else
         {
          alert("分类必须选择最终类别!");
         }
        showtab(0);

        if(Obj_Sort.tagName.toLowerCase()=="select")
         {
          Obj_Sort.focus();
         }
        else
         { 
           var s_objs=document.getElementsByName("s_sort");
           for(i=0;i<s_objs.length;i++)
           {
            if(s_objs[s_objs.length-i-1].style.display=="")
             {
               s_objs[s_objs.length-i-1].focus();
               break;
             }
           }
         }
        return false;
       }
    }
   var J_start="";
   var Js_end="";
   var Names=document.forms[formName].mustname.value;
   var Fields=document.forms[formName].mustfield.value;
   var Fieldtype=document.forms[formName].musttype.value;
   var ANames,AFields,AFieldtype,Obj;
    if(Fields!="")
     {
       ANames=Names.split(',');
       AFields=Fields.split(',');
       AFieldtype=Fieldtype.split(',');
       for(i=0;i<AFields.length-1;i++)
        {
          Obj=document.forms[formName][AFields[i]];
          if(Obj==null){continue;}
          switch(AFieldtype[i])
           {
             case "select":
                J_start="请选择";
                Js_end="!";
             break;

             case "file":
                J_start="请上传";
                Js_end="!";
             break;

             case "image":
                J_start="请上传";
                Js_end="!";
             break;

             case "text":
                J_start="请填写";
                Js_end="!";
             break;

             case "textarea":
                J_start="请填写";
                Js_end="!";
             break;

             default:
                J_start="";
                Js_end="不能为空!";
             break;
           }
        
           if(AFieldtype[i]=="radio" || AFieldtype[i]=="checkbox")
             {
                J_start="请选择";
                Js_end="";
                if(!IsChecked(Obj))
                  {
                      alert(J_start+ANames[i]+Js_end);
                      showtab(0);
                      return false;
                  }
             }
           else if(AFieldtype[i]=="images" || AFieldtype[i]=="files")
            {
              if(Obj.value=="0")
               {
                 alert(J_start+ANames[i]+Js_end); 
                 showtab(0);
                 return false;
               }
            }
           else if(AFieldtype[i]=="editor") 
            {
             var editorobj=eval("KE_"+AFields[i]);
             if(editorobj!=null)
             {
              var ContentLength=editorobj.count("text");
              if(ContentLength==0)
               {
                 alert(J_start+ANames[i]+Js_end);
                 showtab(0);
                 editorobj.focus();
                 return false;
               }
             }
            }
           else
             {
                if(Trim(Obj.value)=="" && Obj.style.display!="none")
                {
                 alert(J_start+ANames[i]+Js_end); 
                 showtab(0);
                 Obj.focus();
                 return false;
                }
            }
        }
     }
   if(eval(formName+"_zdycheck()"))
    {
     startpost();
     document.forms[formName].submit();
     return true;
    }
   else
    {
     return false;
    }
  }

//基础函数

function TimeDiff(ST, ET){
        var rv;
	var ST = new Date(ST.replace(/-/g, '/'));			//开始时间转换为时间对象
	var ET = new Date(ET.replace(/-/g, '/'));			//结束时间转换为时间对象
	var DT = (ET - ST) / 1000;					//得到时间差，转换为秒
        
	var RD = Math.floor(DT / (60 * 60 * 24));			//得到天数
	var RH = Math.floor((DT % (60 * 60 * 24)) / (60 * 60));		//得到小时
	var RM = Math.floor(((DT % (60 * 60 * 24)) % (60 * 60)) / 60); 	//得到分钟
	var RS = (((DT % (60 * 60 * 24)) % (60 * 60)) % 60);		//得到秒
	RD = RD ? (RD + '天') : '';
	RH = RH ? (RH + '小时') : '';
	RM = RM ? (RM + '分钟') : '';
	RS = RS ? (RS + '秒') : '';
	rv=RD + RH + RM + RS;
        if(rv=="")
         {
          rv="0秒";
         }
       return rv;
}

function GetIPAdd(TheValue)
 { 
   if(TheValue!=""){window.open("http://www.ip138.com/ips138.asp?ip="+TheValue,"ip");}
 }

/*
//此方法已被注释，建议写到一个独立js文件中，可用来控制表单代码的显示和隐藏，请根据需要自行设计。
function load_form_structure(type_id,thetype,table) //type_id表示类别id，thetype可选择add,edit，table表示操作的表
 {
 }
*/
var PageJsDir="/e/js/";
document.write("<scr" + "ipt src=\"" +PageJsDir+ "function.js\" type=\"text/javascript\"></scr" + "ipt>");
document.write("<scr" + "ipt src=\"" +PageJsDir+ "general.js\" type=\"text/javascript\"></scr" + "ipt>");
document.write("<scr" + "ipt src=\"" +PageJsDir+ "calendar.js\" type=\"text/javascript\"></scr" + "ipt>");
document.write("<script src=\"/e/js/dialog.js\" type=\"text/javascript\"></script>");
//document.write("<script src=\"/e/js/diy.js\" type=\"text/javascript\"></script>");