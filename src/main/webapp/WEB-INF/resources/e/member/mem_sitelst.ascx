<% @ Control Language="c#" Inherits="PageAdmin.mem_sitelst"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; <%=TableName%>(选择站点)</li>
<li class="current_location_2"><%=TableName%></li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
 <table border="0" cellspacing="0" cellpadding="0" align="center" class="member_table">
    <tr>
      <td align=center  class="memlist_header_item" width="50%">站点名称</td> 
      <td align=center  class="memlist_header_item" width="20%">已发布数</td>
      <td align=center  class="memlist_header_item_last" width="30%">操作</td>
    </tr>
 <asp:Repeater id="P1" runat="server">      
 <ItemTemplate>
    <tr id="<%=TheTable%>_<%#DataBinder.Eval(Container.DataItem,"id")%>" title="<%#DataBinder.Eval(Container.DataItem,"sitename")%>">
      <td class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"sitename")%></td> 
      <td align=center  class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"tongji")%></td> 
      <td align=center  class="memlist_item_last">
      <a href="javascript:url('<%#DataBinder.Eval(Container.DataItem,"domain")%>','<%#DataBinder.Eval(Container.DataItem,"directory")%>')">浏览站点</a> &nbsp;
      <a href="<%#Get_Url("mem_datalst",DataBinder.Eval(Container.DataItem,"id").ToString())%>">管理信息</a> &nbsp;
      <a href="<%#Get_Url("mem_datadtl",DataBinder.Eval(Container.DataItem,"id").ToString())%>">发布信息</a>
    </td>
    </tr>
 </ItemTemplate>
</asp:Repeater>
 </table>
</div>
</div>
<script>
function url(domain,dir)
 {
   if(domain=="")
    {
      window.open((dir==""?"":"/"+dir)+"/","vsite");
    }
  else
   {
     window.open("http://"+domain+(dir==""?"":"/"+dir)+"/","vsite");
   }
 }
</script>