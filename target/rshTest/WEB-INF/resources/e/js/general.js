/*会员中心和后台公用的一些方法，上传界面，选择数据，ajax加载数据等*/
var currentfrom="";
if(location.href.indexOf("/e/member")>0)
 {
   currentfrom="member";
 }
else
 {
   currentfrom="master";
 }
function open_upload(sid,path,type,table,field,ObjId) //上传界面
 {
  var Width=560;
  var Height=185;
  if(type=="file"){Height=185;}
  IDialog("文件上传","/e/aspx/upload_panel.aspx?sid="+sid+"&filepath="+path+"&type="+type+"&table="+table+"&field="+field+"&objid="+ObjId+"&from="+currentfrom,Width,Height);
}

function open_files(sid,Id,table,field,FieldType,InforId) //附件组上传界面
 {
  var Width=600;
  var Height;
  var title;
  if(FieldType=="files")
   {
    Height=450;
    title="附件发布";
    if(Id!="0"){title="附件信息编辑";}
   }
  else
   {
    Height=300;
    title="图片发布";
    if(Id!="0"){title="图片信息编辑";}
   }
   IDialog(title,"/e/aspx/upload_files.aspx?sid="+sid+"&id="+Id+"&table="+table+"&field="+field+"&type="+FieldType+"&inforid="+InforId+"&from="+currentfrom,Width,Height);
}


function load_ajaxdata(Table,Ids,InsertObj,parameters) //通过ajax查找专题、相关信息、分类、用户、部门列表等,parameters为附加参数
 {
   if(typeof(Tg_Table)=="undefined"){Tg_Table="";}//信息表发界面的全局变量，主要用于前台检测投稿权限
   if(typeof(Current_SiteId)=="undefined"){Current_SiteId="";}//信息表发界面的全局变量
   var obj=document.getElementById(InsertObj);
   if(obj==null){alert(InsertObj+"对象不存在!");return;}
   if(typeof(parameters)=="undefined"){parameters="";}
   obj.className="loading";
   if(Ids==""){obj.className="";return;}
   var R=Math.random();
   var x=new PAAjax();
   x.setarg("get",true);
   //alert("/e/aspx/load_ajaxdata.aspx?siteid="+Current_SiteId+"&table="+Table+"&ids="+Ids+"&tgtable="+Tg_Table+"&parameters="+encodeURI(parameters)+"&from="+currentfrom+"&r="+R);
   x.send("/e/aspx/load_ajaxdata.aspx","siteid="+Current_SiteId+"&table="+Table+"&ids="+Ids+"&tgtable="+Tg_Table+"&parameters="+encodeURI(parameters)+"&from="+currentfrom+"&r="+R,function(v){write_ajaxdata(v,InsertObj)});
 }


function write_ajaxdata(v,Id) //load_ajaxdata回调
 {
  var obj=document.getElementById(Id);
  if(v==""){obj.className="";return;}
  var data=$.parseJSON(v);
  //obj.options.length=0;
  var item;
  var id,title;
  var nodetype=obj.nodeName.toLowerCase();
  if(nodetype=="select")
  {
   for(i=0;i<data.length;i++)
    {
      id=data[i].value;
      title=data[i].text;
      item=new Option(title,id);
      obj.options.add(item);
    }
   if(!obj.multiple)
    {
     obj.value=data[0].value;
    }
  }
 else
  {
   obj.value=data[0].text;
  } 
  obj.className="";
 }

function IsExists(Id,id)
 {
   var obj=document.getElementById(Id);
   if(obj.options.length==0){return false;}
   for(i=0;i<obj.options.length;i++)
   {
     if(obj.options[i].value==id)
      {
        return true;
      }
   }
  return false;
 }

function clear_select(Id)
 {
  var obj=document.getElementById(Id);
  if(obj.options.length==0){return;}
  for(i=0;i<obj.options.length;i++)
   {
    if(obj.options[i].selected)
     {
       obj.remove(i);
       clear_select(Id);
     }
   }
 }

function AddSelect(txt,value,id)
 {
   var obj=document.getElementById(id);
   obj.options.add(new Option(txt,value));
 }

//自定义选择部门
function Department_Select(Id,ismultiple,title,AutoClose,Width,Height)
 {
  if(typeof(ismultiple)=="undefined"){ismultiple="0";}
  if(typeof(title)=="undefined"){title="请选择部门";}
  if(typeof(Width)=="undefined"){Width="800";}
  if(typeof(Height)=="undefined"){Height=450;}
  if(typeof(AutoClose)=="undefined"){AutoClose=true;}
  IDialog(title,"/e/aspx/department_select.aspx?ismultiple="+ismultiple+"&sortchoicetype="+SortChoiceType+"&objid="+Id+"&autoclose="+AutoClose+"&from=master",Width,Height);
 }


//自定义选择会员组
function MemberType_Select(title,ismultiple,Current_SiteId,SourceTable,field,title,SortChoiceType,AutoClose,Width,Height)
 {
  if(SourceSites=="" || SourceSites=="0"){SourceSites=Current_SiteId;}
  if(typeof(ismultiple)=="undefined"){ismultiple="0";}
  if(typeof(title)=="undefined"){title="请选择数据";}
  if(typeof(Width)=="undefined"){Width="800";}
  if(typeof(Height)=="undefined"){Height=450;}
  if(typeof(SortChoiceType)=="undefined"){SortChoiceType=1;} //0代表可以选择非最终分类，1表示只能选择最终分类
  if(typeof(AutoClose)=="undefined"){AutoClose=true;}
  IDialog(title,"/e/aspx/membertype_select.aspx?siteid="+Current_SiteId+"&sourcesites="+SourceSites+"&table="+SourceTable+"&ismultiple="+ismultiple+"&sortchoicetype="+SortChoiceType+"&objid="+field+"&autoclose="+AutoClose+"&tgtable="+Current_Table+"&from=master",Width,Height);
 }


//自定义选择会员
function Member_Select(title,selecttype,valuetype,ismultiple,objId,AutoClose,Width,Height)
 {
  if(typeof(title)=="undefined"){title="请选择用户";}
  if(typeof(selecttype)=="undefined"){selecttype="0";}
  if(typeof(valuetype)=="undefined"){valuetype="0";}
  if(typeof(Width)=="undefined"){Width=400;}
  if(typeof(Height)=="undefined"){Height=500;}
  if(typeof(AutoClose)=="undefined"){AutoClose=true;}
  IDialog(title,"/e/aspx/member_select.aspx?ismultiple="+ismultiple+"&selecttype="+selecttype+"&valuetype="+valuetype+"&objid="+objId+"&autoclose="+AutoClose+"&from=master",Width,Height);
 }

//自定义选择数据分类
function Sort_Select(title,SourceSites,Current_SiteId,SourceTable,Tg_Table,field,ismultiple,SortChoiceType,AutoClose,Width,Height) //Tg_Table主要用于检测前台会员投稿权限
 {
  if(typeof(Current_SiteId)=="undefined"){Current_SiteId="0";}
  if(SourceSites=="" || SourceSites=="0"){SourceSites=Current_SiteId;}
  if(typeof(ismultiple)=="undefined"){ismultiple="0";}
  if(typeof(title)=="undefined"){title="请选择数据";}
  if(typeof(Width)=="undefined"){Width="800";}
  if(typeof(Height)=="undefined"){Height=450;}
  if(typeof(SortChoiceType)=="undefined"){SortChoiceType=1;} //2代表可以选择非最终分类，1表示只能选择最终分类
  if(typeof(AutoClose)=="undefined"){AutoClose=true;}
  IDialog(title,"/e/aspx/sort_select.aspx?siteid="+Current_SiteId+"&sourcesites="+SourceSites+"&table="+SourceTable+"&ismultiple="+ismultiple+"&sortchoicetype="+SortChoiceType+"&objid="+field+"&autoclose="+AutoClose+"&tgtable="+Tg_Table+"&from="+currentfrom,Width,Height);
 }

//自定义选择数据
function Data_Select(title,SourceSites,Current_SiteId,SourceTable,Tg_Table,field,ismultiple,AutoClose,Width,Height) //Tg_Table主要用于检测前台会员投稿权限
 {
  if(typeof(Current_SiteId)=="undefined"){Current_SiteId="0";}
  if(SourceSites=="" || SourceSites=="0"){SourceSites=Current_SiteId;}
  if(typeof(ismultiple)=="undefined"){ismultiple="0";}
  if(typeof(title)=="undefined"){title="请选择数据";}
  if(typeof(Width)=="undefined"){Width="800";}
  if(typeof(Height)=="undefined"){Height=450;}
  if(typeof(AutoClose)=="undefined"){AutoClose=true;}
  IDialog(title,"/e/aspx/data_select.aspx?siteid="+Current_SiteId+"&sourcesites="+SourceSites+"&table="+SourceTable+"&field="+field+"&multiple="+ismultiple+"&autoclose="+AutoClose+"&tgtable="+Tg_Table+"&from="+currentfrom,Width,Height);
 }