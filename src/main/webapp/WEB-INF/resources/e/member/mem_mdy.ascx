<% @  Control Language="c#" Inherits="PageAdmin.mem_mdy"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 资料修改</li>
<li class="current_location_2">我的资料</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<%if(Space_Open=="1"){%><div class="tabdiv"><ul>
 <li class="c"><a href='<%=Get_Url("mem_mdy")%>'>个人资料</a></li>
 <li><a href='<%=Get_Url("mem_spcset")%>'>空间设置</a></li>
</ul></div><%}%>
<asp:PlaceHolder id="P1" runat="server">
<form  method="post" name="pa_member">
<script src="/e/js/zdyform.js" type="text/javascript"></script>
<table border="0" cellpadding=5 cellspacing=0  align=center class="member_table">
<tr>
 <td class="tdhead">新密码<span style="color:#ff0000">*</span></td>
 <td><input type="password" size="25" maxlength="16" name="password" id="password" class="m_tb"/> 不修改密码请留空 </td>
</tr>

<tr>
 <td class="tdhead">密码确认<span style="color:#ff0000">*</span></td>
 <td><input type="password" size="25" maxlength="16" name="password1" id="password1" class="m_tb"/> 密码再次确认 </td>
</tr>
<asp:PlaceHolder id="P_Form" Runat="server"/>
</table>
<div align="center" style="padding:10px">
<input name="post" type="hidden" value="edit">
<input id="bt_post" type="submit"  value="修改资料" onclick="return Check_Mdy()" class="m_bt">
</div>
</form>
<script type="text/javascript">
if(typeof(load_form_structure)=="function")
{
load_form_structure("<%=MType_Id%>","edit","pa_member");
}
function Check_Mdy()
 {
  var obj=document.pa_member.password;
  if(obj.value=="")
   {
     //修改密码
   }
  else if(!IsStr(obj.value))
   {
     alert("密码只能由字母、数字、下划线组成!");
     obj.focus();
     return false;
   }
  else if(obj.value.length<4 || obj.value.length>16)
   {
     alert("密码必须在4—16个字符之间!");
     obj.focus();
     return false;
   }
 if(obj.value!=document.pa_member.password1.value)
   {
     alert("两次输入的密码不一致!");
     document.pa_member.password1.value="";
     return false;
   }
  var zdyform=Check_ZdyForm('pa_member');
  if(!zdyform)
   {
     return false;
   }
 }
</script>
</asp:PlaceHolder>
<asp:PlaceHolder id="P2" runat="server" visible="false">
<div align=center>
<img src=/e/images/public/suc.gif width="167px" vspace="5px">
<br>资料修改成功!
<br>如果修改了密码，新的密码将发往您的注册信箱<%=SendMailResult==null?"":"("+SendMailResult+")"%>。  
<br><br><input type="button"  class="m_bt"  value="返 回"  onclick="location.href='<%=Get_Url("mem_mdy")%>'">
</div>
</asp:PlaceHolder>

<asp:PlaceHolder id="P3" runat="server"  visible="false">
<div align=center>
<img src=/e/images/public/suc.gif width="167px" vspace="5px">
<br>
<asp:Label id="Lb_iemail" Visible="false" runat="server" Text="对不起，E-Mail格式错误。"/>
<asp:Label id="Lb_forbidkeyword" Visible="false" runat="server">对不起，提交的内容包含被禁止的关键词：<font color=#ff0000><%=Forbid_Keyword%></font>。</asp:Label>
<asp:label id="lb_fieldrepeat"  runat="server" visible="false">对不起，您填写的<%=RepeatField%>已经存在，请重新输入。</asp:Label>
<br><br><input type="button" class="m_bt" value="返 回"  onclick="history.back()">
<br><br>
</div>
</asp:PlaceHolder>
</div>
</div>