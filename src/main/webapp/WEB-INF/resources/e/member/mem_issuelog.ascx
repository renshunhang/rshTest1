<% @  Control Language="c#" Inherits="PageAdmin.mem_issuelog"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 签发记录</li>
<li class="current_location_2">签发记录</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li class="c"><a href="<%=Get_Url("mem_issuelst")%>">签发信息</a></li>
 <li><a href='<%=Get_Url("mem_issuelog")%>'>签发记录</a></li>
</ul></div>
<form runat="server" name="datalist">
  <table border=0 cellpadding=0 cellspacing=0 width=100% class="member_table">
         <tr>
           <td width=45% align=center class="memlist_header_item">标题</td>
           <td width=10% align=center class="memlist_header_item">所属表</td>
           <td width=10% align=center class="memlist_header_item">发布人</td>
           <td width=15% align=center class="memlist_header_item">提交时间</td>
           <td width=10% align=center class="memlist_header_item">状态</td>
           <td width=10% align=center class="memlist_header_item_last">操作</td>
         </tr>
      <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr>
                  <td align=left class="memlist_item"><asp:Label id="Lb_Title" runat="server" /></td>
                  <td align=center  class="memlist_item"><asp:Label id="Lb_Table" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"thetable")%>'/></td>
                  <td align=center  class="memlist_item"><asp:Label id="Lb_UserName" runat="server" /></td>
                  <td align=center  class="memlist_item" title="<%#DataBinder.Eval(Container.DataItem,"thedate")%>"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
                  <td align=center  class="memlist_item_last" style="color:#ff0000"><%#DataBinder.Eval(Container.DataItem,"work_state")%></td>
                  <td align=center  class="memlist_item_last">
<asp:Label id="Lb_DetailId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"detail_id")%>' visible="false"/>
<asp:Label id="Lb_WorkNode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"work_node")%>' visible="false"/>
<a href="javascript:Issue('<%#DataBinder.Eval(Container.DataItem,"thetable")%>','<%#DataBinder.Eval(Container.DataItem,"detail_id")%>','<%#DataBinder.Eval(Container.DataItem,"work_id")%>')">签发</a>
<asp:Label id="Lb_Edit" runat="server"><a href="javascript:Edit('<%#DataBinder.Eval(Container.DataItem,"thetable")%>','<%#DataBinder.Eval(Container.DataItem,"detail_id")%>','<%#DataBinder.Eval(Container.DataItem,"work_id")%>')">编辑</a></asp:Label>
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
<script type="text/javascript">

 var obj_sort=document.getElementById("sortid");
 var obj_order=document.getElementById("s_order");
 var obj_keyword=document.getElementById("s_keyword");

 var Sid="<%=Request.QueryString["s"]%>";

 var Sortid="<%=Request.QueryString["sortid"]%>";

 var Order="<%=Request.QueryString["order"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 if(obj_sort!=null && Sortid!="0"){obj_sort.value=Sortid;}

 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}

function state(Id,Table,DetailId,Wid)
  {
   if(Wid=="0"){return false;}
   IDialog("操作记录","/e/member/state.aspx?s="+Sid+"&id="+Id+"&table="+Table+"&detailid="+DetailId+"&workid="+Wid+"&viewstate=1",800,300);
  } 

</script>
</div>
</div>
