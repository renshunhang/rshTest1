<% @ Control  Language="C#" Inherits="PageAdmin.patag"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<style>
.f_tb{border:0px solid #cccccc}
.f_tb td{border:0px solid #cccccc;padding:5px}
</style>
<script type="text/javascript" src="/e/js/zdyform.js"></script>
<form name="feedback" method="post" Enctype="multipart/form-data" action="/e/aspx/post.aspx">
<table border=0 cellpadding=5 cellspacing=0  align=center width=98% class="f_tb">
<tr><td align=right width=60px>主题 <span style="color:#ff0000">*</span></td><td><input type=text name="title" id="title"  style="width:95%" maxlength="50" ></td></tr>
<tr><td align=right>联系人&nbsp;&nbsp;</td><td><input type=text name="pa_truename" id="pa_truename" style="width:95%" maxlength="50" ></td></tr>
<tr><td align=right>电话&nbsp;&nbsp;</td><td><input type=text name="pa_tel" id="pa_tel"  style="width:95%"  maxlength="50" ></td></tr>
<tr><td align=right>邮箱 <span style="color:#ff0000">*</span></td><td><input type=text name="email" id="email" maxlength="50"  style="width:95%" ></td></tr>
<tr><td align=right>内容 <span style="color:#ff0000">*</span></td><td><textarea name="content" id="content" style="width:95%;height:200px" ></textarea></td></tr>
<tr><td align=right>验证码<span style="color:#ff0000">*</span></td><td><input type=text name="vcode" id="vcode" maxlength=4 size=4 style="width:50%"> <img src="/e/aspx/yzm.aspx" onclick=Code_Change("vcode_img") align=absmiddle border=0 id="vcode_img" style="cursor:pointer" alt="点击更换"></td></tr>
<tr><td colspan=2 align=center><input type="hidden" name="checked" value="0"><input type="hidden" name="showcode" value="0"><input type="hidden" name="to" ><input type="hidden" name="mailto" ><input type="hidden" name="mailreply" ><input type="hidden" name="mailsubject" ><input type="hidden" name="mailbody" ><input type="hidden" name="insertdatabase" value="1"><input type="hidden" name="siteid" value="7"><input type="hidden" name="formtable" value="feedback"><input type="hidden" name="mustname" value="主题,邮箱,内容,"><input type="hidden" name="mustfield" value="title,email,content,"><input type="hidden" name="musttype" value="text,text,editor,"><input type="button"  value=" 提交 " onclick="return set_feedback()"> <input type="reset" value=" 重设 "></td></tr></table>
</form>
<script type="text/javascript">
function set_feedback()
{
document.forms["feedback"].mailto.value="";
document.forms["feedback"].mailreply.value="";
document.forms["feedback"].mailsubject.value="";
document.forms["feedback"].mailbody.value="";
return Check_ZdyForm("feedback");
}

function feedback_zdycheck(){
KE_content.sync();
return true;
}
</script>
<%End();%>