<% @  Control Language="c#" Inherits="PageAdmin.mem_fbkdtl"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; <a href="<%=Get_Url("mem_fbklst")%>">留言查看</a></li>
<li class="current_location_2"><a href="<%=Get_Url("mem_fbklst")%>">留言查看</a></li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li class="c"><a href='<%=Get_Url("mem_fbklst")%>'>我的留言</a></li>
 <li><a href='<%=Get_Url("mem_fbk")%>'>发布留言</a></li>
</ul></div>
 <table border="0" cellpadding="0" cellspacing="0" align="center" class="member_table" style="border-bottom-width:0px">
 <tr>
  <td class="feedback_head" style="border-bottom-width:0px">[<%=Fb_Type%>]<%=Fb_Title%></p></td>
 </tr>
 </table>
<table border="0" cellpadding="0" cellspacing="0" align="center" class="member_table">
  <tr>
   <td class="feedback_reply_item" width="100px"><%=Fb_Username%></td>
   <td class="feedback_reply_item_last">
    <div style="overflow-x:auto;padding:5px 5px 5px 5px"><%=Fb_Content%></div>
   <div align="right">发布时间: <%=Fb_Date%></div>
  </td>
 </tr>
<asp:Repeater id="P1" runat="server">
 <ItemTemplate>
  <tr>
   <td class="feedback_reply_item"><%#Get_ReplyUser(DataBinder.Eval(Container.DataItem,"username").ToString(),DataBinder.Eval(Container.DataItem,"department").ToString())%></td>
   <td class="feedback_reply_item_last">
<div style="overflow-x:auto;padding:5px 5px 5px 5px"><%#DataBinder.Eval(Container.DataItem,"reply")%></div>
<div align="right">回复时间: <%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd HH:mm:ss}")%></div>
</td>
 </tr>
 </ItemTemplate>
</asp:Repeater>
 </table>
<asp:PlaceHolder id="P_1" Runat="server">
<br>
<table border=0 cellpadding=0 cellspacing=0 align=center class="member_table">
 <form method="post">
  <tr>
   <td width="100px" class="feedback_reply_style" align="center">回复内容</td>
   <td  class="feedback_reply_style_last">
<textarea id="fb_content" name="fb_content" style="width:100%;height:200px"></textarea>
<script charset="utf-8" src="/e/incs/kindeditor/kindeditor.js" type="text/javascript"></script>
<script type="text/javascript">
var editor;
KindEditor.ready(function(K) 
{editor= K.create("#fb_content",
{
uploadJson :kindeditor_uploadJson,
fileManagerJson :kindeditor_fileManagerJson,
allowImageUpload:<%=Editor_ImageUpload%>,
allowFlashUpload:false,
allowMediaUpload:false,
allowFileUpload:<%=Editor_AttachmentUpload%>,
allowFileManager:false,
items :kindeditor_SmallItems,
extraFileUploadParams:{siteid:'<%=Request.QueryString["s"]%>'},
filterMode :false});
});
</script>
 </tr>
  <tr>
    <td colspan="2" class="feedback_reply_style_1"  align="center">
     <input type="hidden" value="yes"  name="post">
    <input type="submit" value="提 交"  onclick="return Check_Reply()" class="m_bt">&nbsp;
    <input type="button"  class="m_bt" value="返 回" onclick="location.href='<%=Get_Url("mem_fbklst")%>'">
   </td>
   </tr>
    </form>
 </table>
<br>
</asp:PlaceHolder>
</div>
</div>
<script type="text/javascript">
function Check_Reply() //用户反馈回复
  { 
   if(editor.count("text")==0)
    {
      alert("请输入内容!");
      editor.focus();
      return false;
    }
  editor.sync();
  return true;
  }
</script>