<% @  Control Language="c#" Inherits="PageAdmin.mem_msg"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 收件箱</li>
<li class="current_location_2">收件箱</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li class="c"><a href='<%=Get_Url("mem_msg")%>'>收件箱</a></li>
 <li><a href='<%=Get_Url("mem_msgout")%>'>发件箱</a></li>
 <li><a href='<%=Get_Url("mem_msgsend")%>'>发信息</a></li>
 <li><a href='<%=Get_Url("mem_friends")%>'>我的好友</a></li>
 <li><a href='<%=Get_Url("mem_friendssort")%>'>好友分类</a></li>
 <li><a href='<%=Get_Url("mem_blacklist")%>'>黑名单</a></li>
</ul></div>
<form runat="server">
 <table border="0" cellspacing="0" cellpadding="0"  align="center" class="member_table_1"> 
    <tr>
      <td align=center  class="memlist_header_item" width="70%">标题</td> 
      <td align=center  class="memlist_header_item" width="15%">发件人</td> 
      <td align=center  class="memlist_header_item_last" width="15%">发送时间</td> 
    </tr>
<asp:Repeater id="P1" runat="server" OnItemDataBound="P1_Bound">      
 <ItemTemplate>
      <tr>
       <td align=left class="memlist_item_1"><input type="checkbox" id="CK" Name="CK" value='<%#DataBinder.Eval(Container.DataItem,"id")%>'>&nbsp;<img src='/e/images/public/<%#Get_Read(DataBinder.Eval(Container.DataItem,"readed").ToString())%>' border=0>&nbsp;<a href='<%#Get_Url("mem_msgdtl",DataBinder.Eval(Container.DataItem,"id").ToString())%>' ><%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"title").ToString())%></a></td> 
       <td align=center class="memlist_item_1" ><a href='<%#Get_FriendUrl("mem_friendsdtl",DataBinder.Eval(Container.DataItem,"sender").ToString())%>'><%#DataBinder.Eval(Container.DataItem,"sender")%></a></td> 
       <td align=center class="memlist_item_1"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td> 
      </tr>
 </ItemTemplate>
</asp:Repeater>
 </table> 
<div align=left style="display:<%=Show_DeletControl%>;padding:5px">
<input type="button" class="m_bt" value="反选" onclick="CheckBox_Inverse('CK')" >
<input type="button" class="m_bt" value="删除" onclick="Delete_Msg()" >
</div>
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
</form>
</div>
</div>
<script type="text/javascript">

function Delete_Msg()
 { 
  var IDS=Get_Checked("CK");
  if(IDS=="")
   {
     alert("请选择要删除的信息!");
     return;
   }
  else
   {
    if(confirm("确定删除吗?"))
     {
      location.href="?act=delete&ids="+IDS+"&type=mem_msg&s=<%=Request.QueryString["s"]%>";
     }
   }
 }
</script>
