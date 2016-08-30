<% @  Control Language="c#" Inherits="PageAdmin.mem_favolst"%>
<div class="current_location">
<ul><li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 我的收藏</li>
<li class="current_location_2">我的收藏</li></ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<form runat="server"> 
 <table border="0" cellspacing="0" cellpadding="0" align="center" class="member_table">
    <tbody>
    <tr>
      <td align=center  class="memlist_header_item" width="65%">收藏主题</td> 
      <td align=center  class="memlist_header_item" width="20%">收藏日期</td> 
      <td align=center  class="memlist_header_item_last" width="15%">操作</td>
    </tr>
<asp:Repeater id="P1" runat="server" OnItemDataBound="P1_Bound">      
 <ItemTemplate>
       <tr>
      <td   class="memlist_item"><a href="<%#DataBinder.Eval(Container.DataItem,"url")%>" target="_blank"><%#DataBinder.Eval(Container.DataItem,"title")%></a></td> 
      <td align=center  class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd HH:mm:ss}")%></td> 
      <td align=center  class="memlist_item_last">
       <a href="<%#DataBinder.Eval(Container.DataItem,"url")%>" target="_blank">查看</a>
       <asp:LinkButton Text="删除" id="Delete" runat="server" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="Data_Delete" />
      </td>
    </tr>
 </ItemTemplate>
</asp:Repeater>
   </tbody>
   </table> 
<br>
<div class="sublanmu_page">
<span>共<asp:Literal id="Lblrecordcount"  Text=0 runat="server" />条记录</span>
<span>页次: <asp:Literal id="Lblcurrentpage"  runat="server" />/<asp:Literal id="LblpageCount"  runat="server" /></span>
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
