<% @  Control Language="c#" Inherits="PageAdmin.mem_signlst"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 信息签收</li>
<li class="current_location_2">信息签收</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<form runat="server" name="datalist">

<table border=0 cellpadding=0 cellspacing=0 width=100% class="member_table">
         <tr>
           <td width=45% align=center class="memlist_header_item">标题</td>
           <td width=10% align=center class="memlist_header_item">所属表</td>
           <td width=15% align=center class="memlist_header_item">提交时间</td>
           <td width=10% align=center class="memlist_header_item">签收状态</td>
           <td width=10% align=center class="memlist_header_item">是否签收</td>
           <td width=10% align=center class="memlist_header_item_last">签收</td>
         </tr>
      <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr>
                  <td align=left class="memlist_item"><asp:Label id="Lb_Title" runat="server"/></td>
                  <td align=center  class="memlist_item"><asp:Label id="Lb_Table" runat="server" text='<%#DataBinder.Eval(Container.DataItem,"thetable")%>'/></td>
                  <td align=center class="memlist_item" title="<%#DataBinder.Eval(Container.DataItem,"thedate")%>"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
                  <td align=center  class="memlist_item_last"><%#GetState(DataBinder.Eval(Container.DataItem,"enddate").ToString())%></td>
                  <td align=center  class="memlist_item_last"><img src="/e/images/public/<%#GetSignState(DataBinder.Eval(Container.DataItem,"thetable").ToString(),DataBinder.Eval(Container.DataItem,"detail_id").ToString())%>.gif"></td>
                  <td align=center  class="memlist_item_last"><a href="javascript:void(0)" onclick="Sign('<%#DataBinder.Eval(Container.DataItem,"thetable")%>','<%#DataBinder.Eval(Container.DataItem,"detail_id")%>')">签收</a></td>
                </tr><asp:Label id="Lb_DetailId" runat="server" text='<%#DataBinder.Eval(Container.DataItem,"detail_id")%>' Visible="false"/>
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
<script type="text/javascript">
 function Sign(Table,DetialId)
  {
   IDialog("信息签收","/e/member/sign.aspx?table="+Table+"&detailid="+DetialId,800,"90%");
  } 

</script>
</div>
</div>
