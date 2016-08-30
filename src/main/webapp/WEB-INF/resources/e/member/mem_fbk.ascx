<% @  Control Language="c#" Inherits="PageAdmin.mem_fbk"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 有问必答</li>
<li class="current_location_2">有问必答</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li><a href='<%=Get_Url("mem_fbklst")%>'>我的留言</a></li>
 <li class="c"><a href='<%=Get_Url("mem_fbk")%>'>发布留言</a></li>
</ul></div>
<form method="post">
<table border=0 cellpadding="5px" cellspacing=0  align=center class="member_table">
 <tr>
      <td class="tdhead">类型<span style="color:#ff0000"> </span></td>
      <td><select name="fb_type" id="fb_type" >
	<option value="咨询">  咨询  </option>
	<option value="问题">  问题  </option>
	<option value="建议">  建议  </option>
	<option value="投诉">  投诉  </option>
	<option value="其他">  其他  </option></select>
     </td>
    </tr>

  <tr>
      <td class="tdhead">主题<span style="color:#ff0000">*</span></td>
      <td><input type="text" id="fb_title" name="fb_title" maxlength="50" size="40"  class="m_tb"></td>
    </tr>

  <tr>
      <td class="tdhead">联系人<span style="color:#ff0000">*</span></td>
      <td><input type="text" id="fb_truename" name="fb_truename" value="<%=Name%>" maxlength="30" size="20"  class="m_tb"></td>
    </tr>

   <tr>
      <td class="tdhead">电话<span style="color:#ff0000"> </span></td>
      <td><input type="text" id="fb_tel" name="fb_tel" maxlength="30" size="20"  class="m_tb"></td>
  </tr>

 <tr>
      <td class="tdhead">E-mail<span style="color:#ff0000">*</span></td>
      <td><input type="text" id="fb_email"  name="fb_email" value="<%=Email%>" maxlength="30" size="20" class="m_tb"></td>
    </tr>
   <tr>
      <td class="tdhead">反馈内容<span style="color:#ff0000">*</span></td>
      <td><textarea id="fb_content" name="fb_content" style="width:100%;height:250px"></textarea> 
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
allowFileManager :false,
items :kindeditor_SmallItems,
filterMode :true,
extraFileUploadParams:{siteid:'<%=Request.QueryString["s"]%>'}
});
});
</script>
    </td>
    </tr>
  </table>
<table border=0 cellpadding="5" cellspacing=0  align=center class="member_table_1">
   <tr>
       <td height=30px align=center>
      <input type="hidden" value="yes"  name="post">&nbsp;
      <input type="submit" value="提 交"  onclick="return Check_Feedback()" class="m_bt">&nbsp;
      <input type="button" value="返 回"   class="m_bt" onclick="location.href='<%=Get_Url("mem_fbklst")%>'">
     </td>
     </tr> 
 </table>
</form>
</div>
</div>
<script type="text/javascript">
function Check_Feedback() //用户反馈
  {  

   var fb_value=Trim(document.getElementById("fb_title").value);
   if(fb_value=="")
    {
      alert("请输入留言主题!");
      document.getElementById("fb_title").focus();
      return false;
    }

   fb_value=Trim(document.getElementById("fb_truename").value);
   if(fb_value.length<2)
    {
      alert("请输入联系人姓名!");
      document.getElementById("fb_truename").focus();
      return false;
    }

  fb_value=Trim(document.getElementById("fb_email").value);
   if(fb_value=="")
    {
     alert("请输入您的邮箱!");
     document.getElementById("fb_email").focus();
     return false;
    }
   else if (fb_value.charAt(0)=="." || fb_value.charAt(0)=="@" || fb_value.indexOf('@', 0) == -1 || fb_value.indexOf('.', 0) == -1 || fb_value.lastIndexOf("@")==fb_value.length-1 || fb_value.lastIndexOf(".")==fb_value.length-1)
     {
        alert("邮箱格式错误，请重新输入!");
        document.getElementById("fb_email").focus();
        return false;
     }

   if(editor.count("text")==0)
    {
      editor.focus();
      alert("请输入内容!");
      return false;
    }
   editor.sync();
   return true;
  }
</script>