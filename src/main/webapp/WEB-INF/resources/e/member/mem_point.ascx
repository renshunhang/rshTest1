<% @  Control Language="c#"  Inherits="PageAdmin.mem_point"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 积分充值</li>
<li class="current_location_2">积分充值</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li><a href='<%=Get_Url("mem_ptlst")%>'>积分记录</a></li>
 <li class="c"><a href='<%=Get_Url("mem_point")%>'>积分充值</a></li>
</ul></div>
<form runat="server">
<asp:PlaceHolder id="P1" runat="server">
 <table border=0 cellpadding=1 cellspacing=0  align=center class="member_table">
   <tr>
       <td width=30% align=center class="memlist_header_item">充值类型</td>
       <td width=20% align=center class="memlist_header_item">购买费用</td>
       <td width=20% align=center class="memlist_header_item">充值点数</td>
       <td width=30% align=center class="memlist_header_item_last">简介</td>
     </tr>
  <asp:Repeater id="List" Runat="server">
    <ItemTemplate>
     <tr>
      <td class="memlist_item">
<input type="radio" name="pid" id="pid" value="<%#DataBinder.Eval(Container.DataItem,"id")%>">
<input type="hidden" id="sp_<%#DataBinder.Eval(Container.DataItem,"id")%>" value="<%#DataBinder.Eval(Container.DataItem,"spending")%>">
<%#DataBinder.Eval(Container.DataItem,"name")%></td>
      <td class="memlist_item" align=center> ￥<%#DataBinder.Eval(Container.DataItem,"spending")%></td>
      <td class="memlist_item" align=center><%#DataBinder.Eval(Container.DataItem,"point")%></td>
      <td class="memlist_item_last"><%#DataBinder.Eval(Container.DataItem,"introduct")%> </td>
     </tr>
   </ItemTemplate>
  </asp:Repeater>
 </table>
 <table border=0 cellpadding=5 cellspacing=0  align=center width="98%">
  <tr>
    <td>账户余额：￥<span style="color:#ff0000;"><%=Fnc_Ky%></span> &nbsp;&nbsp;积分余额：<span style="color:#ff0000;"><%=Point_Ky%></span>点</td>
  </tr>
  <tr>
    <td><input type="submit" value="购 买" onclick="return payck()"  class="m_bt" /> &nbsp; <input type="button" value="返 回"   class="m_bt" onclick="location.href='<%=Get_Url("mem_ptlst")%>'"></td>
  </tr>
 </table>
</asp:PlaceHolder>

<asp:PlaceHolder id="P2" runat="server" visible="false">
<div align=center>
<img src=/e/images/public/suc.gif width="167px" vspace="10px">
<br>充值成功！您的可用积分为：<span style="color:#ff0000;"><%=Point_Ky%></span>点。
<br><br><input type="button" value=" 返 回 "  class="m_bt" onclick="location.href='<%=Get_Url("mem_ptlst")%>'">
</div>
</asp:PlaceHolder>

</form> 
</div>
</div>
<script type="text/javascript">
 function payck()
  {
   var Id=Get_Checked("pid");
   var fnc_ky=<%=Fnc_Ky%>;
   if(Id=="")
    {
      alert("请选择要充值的类型!");
      return false;
    }
   var Amount=document.getElementById("sp_"+Id).value;
   if(fnc_ky<Amount)
    {
      if(confirm("对不起，您的账户可用金额不足!\n\n是否进行充值?"))
       {
         location.href="<%=Get_Url("mem_pay")%>&amount="+Amount+"&r_url="+UrlEncode("/e/member/index.aspx?s=<%=Request.QueryString["s"]%>&type=mem_point");
       }
      return false;
    }
   if(confirm("此操作将从您的账户余额中扣除"+Amount+"元，是否确定?"))
    {
      return true;
    }
   else
    {
      return false;
    }
  }
</script>
