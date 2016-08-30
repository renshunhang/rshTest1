<% @  Control Language="c#" Inherits="PageAdmin.mem_ptlst"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 积分记录</li>
<li class="current_location_2">积分记录</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li class="c"><a href='<%=Get_Url("mem_ptlst")%>'>积分记录</a></li>
 <li><a href='<%=Get_Url("mem_point")%>'>积分充值</a></li>
</ul></div>
<form runat="server">
<table border=0 cellpadding=2 cellspacing=0 align=center class="member_table">
                <tr>
                  <td align=left width=25% class=memlist_item height=25>可用积分：<span style="color:#ff0000;Font-Size:13px;"><%=Point_Ky%>点</span></td>
                  <td align=left width=25% class=memlist_item>已消费积分：<span style="Font-Size:13px;"><%=Point_Xf%>点</span></td>
                  <td align=left width=25% class=memlist_item>充值总额：<span style="Font-Size:13px;"><%=Point_Rk%>点</span></td>
                  <td align=left width=25% class=memlist_item_last>返点总额：<span style="Font-Size:13px;"><%=Point_Fk%>点</span></td>
                </tr>
 </table>
<br>

<table border=0 cellpadding=0 cellspacing=0  align="center" class="member_table">
        <tr>
                  <td align=center width=10% class=memlist_header_item height=20>事项</td>
                  <td align=center width=15% class=memlist_header_item>点数</td>
                  <td align=center width=25% class=memlist_header_item><select id="point_type" OnChange="t_change(this.options[this.options.selectedIndex].value)"><option value=""> -- </option><option value="c"> 充值 </option><option value="k"> 扣点 </option><option value="f"> 返点 </option></select></td>
                  <td align=center width=25% class=memlist_header_item>备注</td>
                  <td align=center width=25% class=memlist_header_item_last>时间</td>
        </tr>

          <asp:Repeater id="P1" runat="server">         
             <ItemTemplate>
                 <tr>
                  <td align=center class=memlist_item ><%#Get_Type(DataBinder.Eval(Container.DataItem,"act").ToString())%>&nbsp;</td>
                  <td align=center class=memlist_item ><b><%#Get_Symbol(DataBinder.Eval(Container.DataItem,"act").ToString())%><%#DataBinder.Eval(Container.DataItem,"amount")%></b>&nbsp;</td>
                  <td align=center  class=memlist_item ><%#DataBinder.Eval(Container.DataItem,"detail")%>&nbsp;</td>
                  <td align=center class=memlist_item ><%#DataBinder.Eval(Container.DataItem,"beizhu")%>&nbsp;</td>
                  <td align=center  class=memlist_item_last><%#DataBinder.Eval(Container.DataItem,"thedate")%>
                    <asp:Label Id="Lb_type" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"act")%>' visible="false" />
                    <asp:Label Id="Lb_amount" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"amount")%>' visible="false" />
                 </td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>
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
<script type="text/javascript">
function t_change(sort)
 {
   location.href="?s=<%=SiteId%>&type=mem_ptlst&sort="+sort;
 }
document.getElementById("point_type").value="<%=Point_Sort%>";
</script>