<% @  Control Language="c#" Inherits="PageAdmin.mem_exlst"%>
<div class="current_location">
<ul><li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 我的兑换</li>
<li class="current_location_2">我的兑换</li></ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<form runat="server">
 <table border="0" cellspacing="0" cellpadding="0" align="center" class="member_table">
    <tr>
      <td align=center  class="memlist_header_item" width="5%">序号</td> 
      <td align=center  class="memlist_header_item" width="35%">商品名称</td> 
      <td align=center  class="memlist_header_item" width="10%">兑换数</td> 
      <td align=center  class="memlist_header_item" width="15%">兑换积分</td> 
      <td align=center  class="memlist_header_item" width="15%">兑换日期</td>
      <td align=center  class="memlist_header_item" width="10%">发货状态</td>
      <td align=center  class="memlist_header_item_last" width="10%">操作</td>
    </tr>
<asp:Repeater id="P1" runat="server" OnItemDataBound="P1_Bound">
 <ItemTemplate>
   <tr>
      <td align=center class="memlist_item"><%=i++%></td> 
      <td align=center class="memlist_item"><a href="<%#Get_DetailUrl(DataBinder.Eval(Container.DataItem,"thetable").ToString(),DataBinder.Eval(Container.DataItem,"detail_id").ToString())%>" target='view'><%#DataBinder.Eval(Container.DataItem,"title")%></a></td> 
      <td align=center class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"num")%></td> 
      <td align=center class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"paypoint")%></td> 
      <td align=center class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
      <td align=center class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"sendstate").ToString()=="1"?"<span class='send_success'>已发货</span>":"未发货"%></td>
      <td align=center class="memlist_item_last"><a href="<%#Get_Url("mem_exdtl",DataBinder.Eval(Container.DataItem,"id").ToString())%>">详细</a></td>
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
