<% @  Control Language="c#" Inherits="PageAdmin.mem_friends"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="/member/index.aspx?language=<%=Request.QueryString["language"]%>">会员中心</a> &gt; 好友管理</li>
<li class="current_location_2">好友管理</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
<li><a href='<%=Get_Url("mem_msg")%>'>收件箱</a></li><li><a href='<%=Get_Url("mem_msgout")%>'>发件箱</a></li>
<li><a href='<%=Get_Url("mem_msgsend")%>'>发信息</a></li>
<li class="c"><a href='<%=Get_Url("mem_friends")%>'>我的好友</a></li>
<li><a href='<%=Get_Url("mem_friendssort")%>'>好友分类</a></li>
<li><a href='<%=Get_Url("mem_blacklist")%>'>黑名单</a></li>
</ul></div>
<form runat="server" id="mem_friends">
<table border="0" cellspacing="0" cellpadding="5"  align="center" class="member_table_1"> 
    <tr>
      <td align=center  class="memlist_header_item" width="10%">选择</td>
      <td align=center  class="memlist_header_item" width="15%">用户名</td>
      <td align=center  class="memlist_header_item" width="30%">备注</td> 
      <td align=center  class="memlist_header_item" width="15%"><asp:DropDownList id="Dl_Sort" runat="server" DataTextField="sort_name" DataValueField="id" AutoPostBack="false"  OnChange="show_sort(this.options[this.options.selectedIndex].value)" /></td> 
      <td align=center  class="memlist_header_item_last" width="15%">添加时间</td> 
    </tr>
<asp:Repeater id="P1" runat="server" OnItemDataBound="P1_Bound">      
 <ItemTemplate>
      <tr>
       <td align=center class="memlist_item"><input type="checkbox" id="CK" Name="CK" value='<%#DataBinder.Eval(Container.DataItem,"id")%>'></td>
       <td align=center class="memlist_item"><a href='<%#Get_FriendUrl("mem_friendsdtl",DataBinder.Eval(Container.DataItem,"friend_username").ToString())%>'><%#DataBinder.Eval(Container.DataItem,"friend_username")%></a></td>
       <td align=center class="memlist_item"><asp:TextBox id="tb_beizhu" Text='<%#DataBinder.Eval(Container.DataItem,"friend_beizhu")%>' Runat="server" style="width:180px" maxlength="50"/></td> 
       <td align=center class="memlist_item"><asp:DropDownList id="Dpl_Sort" runat="server" DataTextField="sort_name" DataValueField="id"/></td>  
       <td align=center class="memlist_item_last"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td> 
       <asp:Label  id="lb_id" runat="server" Visible="false" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' />
       <asp:Label  id="lb_sortid" runat="server" Visible="false" Text='<%#DataBinder.Eval(Container.DataItem,"friend_sort")%>' />
    </tr>
 </ItemTemplate>
</asp:Repeater>
    <tr>
     <td colspan="6">
<input type="button" class="m_bt" value="反选" onclick="CheckBox_Inverse('CK')" >
<input type="hidden" value="" name="act" id="act"><input type="hidden" value="" name="ids" id="ids">
<asp:Button Text="更新" CssClass="m_bt" runat="server" onclick="Data_Update" onclientclick="return set('update')" />
<asp:Button Text="删除" CssClass="m_bt" runat="server" onclick="Data_Delete" onclientclick="return set('delete')" />
     </td>
     </tr>
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
<table border=0 cellpadding=0 cellspacing=2 width=98% align=center>
<tr>
<td  height=25>添加用户名：<asp:DropDownList id="Dl_AddType" runat="server" Visible="false">
<asp:ListItem Value="username">根据用户名</asp:ListItem>
<asp:ListItem Value="truename">根据联系人姓名</asp:ListItem>
</asp:DropDownList><asp:TextBox  Runat="server" Id="AddName" style="width:120px"/>&nbsp;
添加到：<asp:DropDownList id="Dl_AddSort" runat="server" DataTextField="sort_name" DataValueField="id">
<asp:ListItem Value="0">无分类</asp:ListItem>
</asp:DropDownList>
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
<script type="text/javascript">
function show_sort(id)
 {
   location.href="?s=<%=SiteId%>&type=mem_friends&sort="+id;
 }
function set(act)
 { 
  var IDS=Get_Checked("CK");
  if(IDS=="")
   {
     alert("请选择要操作的记录!");
     return false;
   }
  if(act=="delete")
   {
    if(!confirm("是否确定删除?"))
     {
      return false;
     }
   }
  document.getElementById("act").value=act;
  document.getElementById("ids").value=IDS;
  return true;
 }
</script>