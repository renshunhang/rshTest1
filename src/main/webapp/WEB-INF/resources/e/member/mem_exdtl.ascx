<% @  Control Language="c#" Inherits="PageAdmin.mem_exdtl"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 兑换信息</li>
<li class="current_location_2">兑换信息</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<form runat="server">

<table border=0 cellpadding=5 cellspacing=0 align=center style="width:100%;border-width:0px;margin:2px 0 2px 0">
      <tr>
<td height=25px align="left">
发货状态：<input type="textbox" size="10" value="<%=SendState%>" style="border:1px solid #cccccc;border-width:0 0 1px 0">&nbsp;负责人：<input type="textbox" size="15" value="<%=ChargeName%>" style="border:1px solid #cccccc;border-width:0 0 1px 0">
</td>
<td height=25px align="right">我的积分余额：<span style="color:#ff0000;"><%=Point_Ky%></span></td>
    </tr>
  </table>
<table border=0 cellpadding=5 cellspacing=0  align=center class="member_table">
      <tr>
         <td height=20  width=100px class=memlist_header_item>兑换商品：</td><td><a target=view href="<%=Url%>"><%=Title%></a></td>
       </tr>
      <tr>
         <td height=20 class=memlist_header_item>兑换数量：</td><td><%=Num%></td>
       </tr>

      <tr>
         <td height=20 class=memlist_header_item>花费积分：</td><td><span style="color:#ff0000;font-weight:bold"><%=PayPoint%></span>积分</td>
       </tr>

      <tr>
         <td height=20 class=memlist_header_item>兑换时间：</td><td><%=TheDate%></td>
       </tr>

      <tr>
         <td height=20 class=memlist_header_item>收货人：</td><td><input type="text" name="name" value="<%=Name%>" size="20" maxlength="50" class="m_tb"></td>
       </tr>

      <tr>
         <td height=20 class=memlist_header_item>联系电话：</td><td><input type="text" name="tel" value="<%=Tel%>" size="20" maxlength="50" class="m_tb"></td>
       </tr>

       <tr>
         <td height=20 class=memlist_header_item>Email：</td><td><input type="text" name="email"  value="<%=Email%>" size="20" maxlength="50" class="m_tb"></td>
       </tr>

       <tr>
         <td height=20 class=memlist_header_item>收货地址：</td><td><input type="text" name="address" value="<%=Address%>" size="50" maxlength="150" class="m_tb"></td>
       </tr>

      <tr>
         <td height=20 class=memlist_header_item>邮编：</td><td><input type="text" name="postcode" value="<%=PostCode%>" size="20" maxlength="50" class="m_tb"></td>
       </tr>
      <%if(!string.IsNullOrEmpty(Replay)){%>
      <tr>
         <td height=20 class=memlist_header_item>后台回复：</td><td><%=Replay%></td>
       </tr>
      <%}%>
</table>
<br>
<div align=center>
<asp:Button Text="提 交" id="bt" runat="server" CssClass="m_bt" Onclick="Update_Data" />&nbsp;
<input type="button" class="m_bt" value="返 回"  onclick="location.href='<%=Get_Url("mem_exlst")%>'">

</div>
</form>
</div>
</div>