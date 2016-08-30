<% @  Control Language="c#" Inherits="PageAdmin.mem_friendsdtl"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 我的好友</li>
<li class="current_location_2">我的好友</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li><a href='<%=Get_Url("mem_msg")%>'>收件箱</a></li>
 <li><a href='<%=Get_Url("mem_msgout")%>'>发件箱</a></li>
 <li><a href='<%=Get_Url("mem_msgsend")%>'>发信息</a></li>
 <li class="c"><a href='<%=Get_Url("mem_friends")%>'>我的好友</a></li>
 <li><a href='<%=Get_Url("mem_friendssort")%>'>好友分类</a></li>
 <li><a href='<%=Get_Url("mem_blacklist")%>'>黑名单</a></li>
</ul></div>
<form runat="server"><asp:Label id="Lb_TrueName" runat="server" Visible="false"/>
<table border=0 cellpadding="5" cellspacing=0  align=center class="member_table">
  <tr>
     <td class="tdhead">用户名</td>
     <td><%=F_UserName%></td>
  </tr>
  <tr>
     <td class="tdhead">会员组</td>
     <td><%=F_UserName_Type%></td>
  </tr>

  <tr>
     <td class="tdhead">好友类别</td>
     <td>
<asp:DropDownList id="Dl_Sort" runat="server" DataTextField="sort_name" DataValueField="id">
<asp:ListItem Value="0">未分类</asp:ListItem>
</asp:DropDownList>&nbsp;<asp:Button runat="server" id="Tb_Update" Text="更改" OnClick="Update_Friend" cssclass="m_bt"/>
   </td>
  </tr>

<%if(IsFrend=="0"){%>
  <tr>
     <td colspan="2"><span style="color:#999999">&nbsp;注：只有对方添加您为好友后才能看到详细资料。</span></td>
  </tr>
<%}%>
<asp:PlaceHolder id="Friends_Detail" Runat="server"></asp:PlaceHolder>
 </table>
<table border=0 cellpadding="5" cellspacing=0  align=center>
   <tr>
       <td height=30px>
      <input type="button" value="发信"  onclick="location.href='<%=Get_SendUrl("mem_msgsend")%>'" class="m_bt">&nbsp;
      <asp:Button runat="server" id="Tb_Add" Text="加为好友"  OnClick="Add_Friend" cssclass="m_bt" />
      <asp:Button runat="server"  Text="删除"  id="Delete" OnClick="Date_Delete" cssclass="m_bt" />
     </td>
     </tr> 
 </table>
</form>
</div>
</div>