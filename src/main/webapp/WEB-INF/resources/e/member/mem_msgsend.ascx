<% @  Control Language="c#" Inherits="PageAdmin.mem_msgsend"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="/e/member/index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 发送信息</li>
<li class="current_location_2">发送信息</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li><a href='<%=Get_Url("mem_msg")%>'>收件箱</a></li>
 <li><a href='<%=Get_Url("mem_msgout")%>'>发件箱</a></li>
 <li class="c"><a href='<%=Get_Url("mem_msgsend")%>'>发信息</a></li>
 <li><a href='<%=Get_Url("mem_friends")%>'>我的好友</a></li>
 <li><a href='<%=Get_Url("mem_friendssort")%>'>好友分类</a></li>
 <li><a href='<%=Get_Url("mem_blacklist")%>'>黑名单</a></li>
</ul></div>
<form method="post" name="f_msg">
<table border=0 cellpadding="5px" cellspacing=0  align=center class="member_table">
     <tr>
      <td align=left width=200px valign=top>
      选择收件组：<br>
      <select id="receiver_sort"  name="receiver_sort" multiple style='width:200px;height:100px' title="按住Ctrl键可以实现多选或取消选中状态"><%=Friend_Sort%></select>
      <br>或指定收件人[<a href="javascript:Friends_window()">选择好友</a>]
      <select id="receiver_users"  name="receiver_users" multiple style='width:200px;height:150px' ondblclick="clear_select('fb_receiver')"><%=Receiver_Users%></select>
    </td>
    <td valign=top>
     <table cellpadding="5px" cellspacing=0 border=0 align=left width=100% style="table-layout:fixed">
       <tr>
        <td style="width:60px"  align=right>发送方式：</td>
        <td align=left><input type="radio" name="sendtype" value="0" checked onclick="change_type('0')">站内信息<%if(SendEmail=="1"){%> <input type="radio" name="sendtype" value="1" onclick="change_type('1')">邮件<%}%><%if(SendEmail=="1"){%> <input type="radio" name="sendtype" value="2" onclick="change_type('2')">手机短信<%}%></td>
       </tr>
       <tr id="tr_title">
        <td align=right>标题：</td>
        <td align=left><input type="text"  id="fb_title"  name="fb_title"  maxlength="100" style="width:300px"  value="<%=The_Title%>" class="m_tb"></td>
       </tr>
       <tr id="tr_content">
        <td align=right>内容：</td>
        <td align=left><textarea name="Content" id="Content" style="width:100%;height:200px"><%=The_Content%></textarea>
<script charset="utf-8" src="/e/incs/kindeditor/kindeditor.js" type="text/javascript"></script>
<script type="text/javascript">
var editor;
KindEditor.ready(function(K) 
{editor= K.create("#Content",
{
uploadJson :kindeditor_uploadJson,
fileManagerJson :kindeditor_fileManagerJson,
allowImageUpload:<%=Editor_ImageUpload%>,
allowFlashUpload:false,
allowMediaUpload:false,
allowFileUpload:<%=Editor_AttachmentUpload%>,
allowFileManager :false,
items :kindeditor_SmallItems,
extraFileUploadParams:{siteid:'<%=Request.QueryString["s"]%>'},
filterMode :true});
});
</script>

</td>
       </tr>

       <tr id="tr_smscontent" style="display:none">
        <td width=100px>短信内容：</td>
        <td align=left> <textarea name="SmsContent" id="SmsContent" style="width:95%;height:130px" onkeyup="fontnums()" onmousemove="fontnums()"></textarea>
            <br>一条短信最多70个字，超过按2条短信收费，您现在已经输入了<span id="fontnums" style="color:#ff0000">0</span>个字。</td>
       </tr>

     </table>
   </td>
   </tr> 
   </table>

<table border=0 cellpadding="5" cellspacing=0  align=center class="member_table_1">
   <tr>
       <td height=30px align=center>
      <input type="hidden" value="1"  name="sendmail">&nbsp;
      <input type="hidden" value="send"  name="post" id="post">&nbsp;
      <input type="button" value="发 送"  onclick="return Check_Message('send')" class="m_bt">&nbsp;
      <input type="button" value="保 存"  onclick="return Check_Message('save')" class="m_bt">&nbsp;
      <input type="button" value="返 回"  class="m_bt"  onclick="location.href='<%=Get_BackUrl()%>'">
     </td>
     </tr> 
 </table>
</form>
</div>
</div>
<script type='text/javascript'>
 var receiver_users=document.getElementById("receiver_users");
 var receiver_sort=document.getElementById("receiver_sort");

 var Str_Receiver_Users="<%=Receiver_Users%>";
 var Str_Receiver_Sort="<%=Receiver_Sort%>";
 Str_Receiver_Users=Str_Receiver_Users.split(",");
 Str_Receiver_Sort=Str_Receiver_Sort.split(",");
 for(var i=0;i<Str_Receiver_Users.length;i++)
  {
     if(IsUserName(Str_Receiver_Users[i]))
     {
       receiver_users.options.add(new Option(Str_Receiver_Users[i],Str_Receiver_Users[i]));
     }
  }
 for(var i=0;i<receiver_sort.length;i++)
  {
     for(var k=0;k<Str_Receiver_Sort.length;k++)
     {
       if(receiver_sort[i].value==Str_Receiver_Sort[k])
        {
          receiver_sort[i].selected=true;
        }
     }
  }

 function Check_Message(thetype)
  {  
   var isSms=0;
   var fb_value;
   var ReceiverLength=0;
   document.getElementById('post').value=thetype;
   var sendtype=document.forms["f_msg"].sendtype;
   if(sendtype.length==3)
    {
      if(sendtype[2].checked)
       {
        isSms=1;
       }
    }
   for(var i=0;i<receiver_sort.length;i++)
    {
      if(receiver_sort[i].selected)
       {
          ReceiverLength++;
       }
    }
   ReceiverLength+=receiver_users.length;
   if(ReceiverLength==0)
    {
      alert("请选择一个收件组或者至少指定一个收件人!");
      return false;
    }
  if(isSms==0)
  {
   fb_value=Trim(document.getElementById("fb_title").value);
   if(fb_value=="")
    {
      alert("请输入标题!");
      document.getElementById("fb_title").focus();
      return false;
    }
   if(editor.count("text")==0)
    {
      alert("请输入内容!");
      editor.focus();
      return false;
    }
   }
  else
   {
   fb_value=Trim(document.getElementById("SmsContent").value);
   if(fb_value=="")
    {
      alert("请输入短信内容!");
      document.getElementById("SmsContent").focus();
      return false;
    }
    var kw="";
    var x=new PAAjax();
    x.setarg("post",false);
    x.send("/e/aspx/smskey.aspx","content="+encodeURI(fb_value),function(v){kw=v;});
    if(kw.length>0)
     {
      alert("对不起，短信内容中包含了非法关键词："+kw);
      document.getElementById("SmsContent").focus();
      return false;
     }
   }
   for(var i=0;i<receiver_users.length;i++)
    {
      receiver_users[i].selected=true;
    }

   if(thetype=="send")
    {
     if(!confirm("是否确定发送?"))
      {
       return false;
      }
    }
    editor.sync();
    document.forms["f_msg"].submit();
  }



function change_type(type)
 {
   switch(type)
    {
      case "2":
        document.getElementById("tr_smscontent").style.display="";
        document.getElementById("tr_content").style.display="none";
        document.getElementById("tr_title").style.display="none";
      break;

      default:
        document.getElementById("tr_smscontent").style.display="none";
        document.getElementById("tr_content").style.display="";
        document.getElementById("tr_title").style.display="";
      break;

    }

 }

function Friends_window()
 {
   IDialog("好友列表","friendslist.aspx",240,340);
 }

function AddUsers(txt,value)
 {
   var obj=document.getElementById("receiver_users");
   obj.options.add(new Option(txt,value));
 }

function clear_select()
 {
  var obj=document.getElementById("receiver_users");
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


function fontnums()
  {
    var SmsContent=document.getElementById("SmsContent");
    var FontNums=document.getElementById("fontnums");
    FontNums.innerHTML=SmsContent.value.length;
  }
</script>
