<% @ Control language="c#" Inherits="PageAdmin.spc_list" src="spc_list.ascx.cs"%>
<div class="spc_location">当前位置：<a href="/e/space/?uid=<%=UID%>"><%=UserName%>的空间</a> &gt; <%=TableName%></div>
<div class="module_box">
<div class="module_title"><span class="module_sign"><%=TableName%></span></div>
<div class="module_content"><ul class="list">
  <asp:Repeater Id="Plist" Runat="server">
    <ItemTemplate>
    <li><span class="title"><%#GetSortName(DataBinder.Eval(Container.DataItem,"sort_id").ToString())%><a href="<%#DetailUrl(DataBinder.Eval(Container.DataItem,"site_id").ToString(),DataBinder.Eval(Container.DataItem,"Static_dir").ToString(),DataBinder.Eval(Container.DataItem,"Static_file").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"sublanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString(),DataBinder.Eval(Container.DataItem,"permissions").ToString(),DataBinder.Eval(Container.DataItem,"html").ToString())%>" target="myinfo"><%#SubStr(DataBinder.Eval(Container.DataItem,"title").ToString(),60,true)%></a><span class="clicks">(点击:<%#DataBinder.Eval(Container.DataItem,"clicks")%>)</span></span><span class="date"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></span></li>
  </ItemTemplate>
  </asp:Repeater></ul>
<asp:Panel id="P_Page" runat="server" cssclass="page">
<% 
if (CurrentPage>1)
{
%>
<a href="<%=GoPage(1)%>">首页</a><%
}

 int p=7; //表示开始时显示的页码总数
 int M=3; //超过p页后左右两边显示页码数
 int LastPage=1;
 if(CurrentPage<p)
  {
    LastPage=p;
    if(LastPage>PageCount)
     {
       LastPage=PageCount;
     }
    for(int i=1;i<=LastPage;i++)
    {
     if(CurrentPage==i)
      {
        Response.Write(" <span class=\"c\">"+i.ToString()+"</span>");
      }
    else
      {
       Response.Write(" <a href=\""+GoPage(i)+"\">"+i.ToString()+"</a>");
      }
    }
  }
 else
  {
    LastPage=CurrentPage+M;
    if(LastPage>PageCount)
     {
       LastPage=PageCount;
     }
    for(int i=(CurrentPage-M);i<=LastPage;i++)
    {
     if(CurrentPage==i)
      {
        Response.Write(" <span class=\"c\">"+i.ToString()+"</span>");
      }
    else
      {
       Response.Write(" <a href=\""+GoPage(i)+"\">"+i.ToString()+"</a>");
      }
    }

  }

if (CurrentPage<PageCount)
{
 if(LastPage<PageCount){Response.Write(" <a href=\""+GoPage(LastPage+1)+"\">...</a>");}
%> <a href="<%=GoPage(PageCount)%>">尾页</a>
<%}%> <span><%=String.Format("页次：{0}/{1} 共{2}条记录",CurrentPage,PageCount,RecordCount)%></span>
</asp:Panel>
</div>
</div>