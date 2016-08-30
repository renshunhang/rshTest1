<% @  Control Language="c#" Inherits="PageAdmin.mem_odidx"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 我的订单</li>
<li class="current_location_2">我的订单</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<form runat="server">
 <table border="0" cellspacing="0" cellpadding="0" align="center" class="member_table">
    <tr>
      <td align=center  class="memlist_header_item" width="5%">序号</td> 
      <td align=center  class="memlist_header_item" width="30%">订单号</td> 
      <td align=center  class="memlist_header_item" width="15%">订单总额</td>
      <!--<td align=center  class="memlist_header_item" width="10%">配送费用</td>-->
      <td align=center  class="memlist_header_item" width="15%">订购日期</td>
      <td align=center  class="memlist_header_item" width="10%">付款状态</td> 
      <td align=center  class="memlist_header_item" width="10%">发货状态</td> 
      <td align=center  class="memlist_header_item_last" width="15%">操作</td>
    </tr>
<asp:Repeater id="P1" runat="server" OnItemDataBound="P1_Bound">
 <ItemTemplate>
   <tr>
      <td align=center height="25px" class="memlist_item"><%=i++%></td> 
      <td align=center class="memlist_item"><a href='/e/order/orderview.aspx?orderid=<%#DataBinder.Eval(Container.DataItem,"order_id")%>' target='orderview'><%#DataBinder.Eval(Container.DataItem,"order_id")%></a></td>
      <td align=center class="memlist_item">￥<asp:Label Id="Lb_TotalAmount" runat="server"/><asp:Label Id="Lb_Amount" runat="server" Visible="false"/></td>
      <!--<td align=center class="memlist_item">￥<asp:Label Id="Lb_SendEx" runat="server"/></td>-->
      <td align=center class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
      <td align=center class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"paystate").ToString()=="1"?"<span class='pay_success'>已付款</span>":"未付款"%></td> 
      <td align=center class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"sendstate").ToString()=="2"?"<span class='send_success'>已发货</span>":DataBinder.Eval(Container.DataItem,"sendstate").ToString()=="1"?"<span class='send_success'>已确认</span>":"未确认"%></td> 
      <td align=center class="memlist_item_last">
     <asp:HyperLink Text="详情" id="Hy_List" runat="server" NavigateUrl='<%#Get_Url("mem_odlst",DataBinder.Eval(Container.DataItem,"order_id").ToString())%>' />&nbsp;
     <asp:LinkButton Text="删除" id="Delete" runat="server" CommandName='<%#DataBinder.Eval(Container.DataItem,"order_id")%>' OnCommand="Data_Delete" />
     <asp:Label Id="Lb_orderid" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"order_id")%>' Visible="false" />
     <asp:Label Id="Lb_Paystate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"paystate")%>' Visible="false" />
    </td>
    </tr>
 </ItemTemplate>
</asp:Repeater>
 </table>

<div class="sublanmu_page">
<span>共<asp:Literal id="Lblrecordcount"  Text=0 runat="server" />条记录</span>
<span>页次：<asp:Literal id="Lblcurrentpage"  runat="server" />/<asp:Literal id="LblpageCount"  runat="server" /></span>
         <asp:LinkButton id="First" CssClass="link" CommandName="First"  OnCommand="Page_change"  runat="server" Text="首页"/>
         <asp:LinkButton id="Prev"  CssClass="link"  CommandName="Prev"  OnCommand="Page_change"  runat="server" Text="上一页"/>
         <asp:LinkButton id="Next"  CssClass="link"  CommandName="Next"  OnCommand="Page_change"  runat="server" Text="下一页"/>
         <asp:LinkButton id="Last"  CssClass="link"  CommandName="Last"  OnCommand="Page_change"  runat="server" Text="尾页"/>
转到：<asp:DropDownList id="Dp_page" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_select">
          </asp:DropDownList>页
</div>

</form>
</div>
</div>
