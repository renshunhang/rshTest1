<% @  Control Language="c#" Inherits="PageAdmin.mem_friendssort"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 好友分类</li>
<li class="current_location_2">好友分类</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li><a href='<%=Get_Url("mem_msg")%>'>收件箱</a></li>
 <li><a href='<%=Get_Url("mem_msgout")%>'>发件箱</a></li>
 <li><a href='<%=Get_Url("mem_msgsend")%>'>发信息</a></li>
 <li><a href='<%=Get_Url("mem_friends")%>'>我的好友</a></li>
 <li class="c"><a href='<%=Get_Url("mem_friendssort")%>'>好友分类</a></li>
 <li><a href='<%=Get_Url("mem_blacklist")%>'>黑名单</a></li>
</ul></div>
<form runat="server">
 <table border="0" cellspacing="0" cellpadding="0"  align="center" class="member_table_1"> 
    <tr>
      <td align=center  class="memlist_header_item" width="50%">分类名称</td> 
      <td align=center  class="memlist_header_item" width="25%">序号</td> 
      <td align=center  class="memlist_header_item_last" width="25%">操作</td> 
    </tr>
<asp:Repeater id="P1" runat="server" OnItemDataBound="P1_Bound">      
 <ItemTemplate>
      <tr>
       <td align=center  class="memlist_item"><asp:TextBox id="tb_sort"  Text='<%#DataBinder.Eval(Container.DataItem,"sort_name")%>' Runat="server" CssClass="tb " size="30" maxlength="50" /></a></td> 
       <td align=center  class="memlist_item"><asp:TextBox id="tb_xuhao" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>' Runat="server" CssClass="tb " size="5" maxlength="2"/></td> 
       <td align=center  class="memlist_item_last">
       <asp:Label  id="lb_id" runat="server" Visible="false" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' />
       <asp:LinkButton Text="更新"   runat="server"   CommandName='<%#Items%>' OnCommand="Data_Update"/>
       <asp:LinkButton Text="删除" id="Delete" runat="server" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="Data_Delete" />
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

<br>
<table border=0 cellpadding=0 cellspacing=2 width=98% align=center>
<tr>
<td  height=25>
添加分类：<asp:TextBox  Runat="server" Id="AddSort"  size="20"  />
<asp:Button  Text="确定" CssClass="m_bt" runat="server" onclick="Data_Add"/>
<br><asp:Label id="Lberror" Runat="server"  ForeColor="#ff0000"/>
</td>
</tr>
 </td>
 <tr>
</table>
</form>
</div>
</div>