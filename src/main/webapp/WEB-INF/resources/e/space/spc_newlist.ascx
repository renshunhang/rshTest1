<% @ Control language="c#" Inherits="PageAdmin.spc_newlist" src="spc_newlist.ascx.cs"%>
<div class="spc_location">当前位置：<a href="/e/space/?uid=<%=UID%>"><%=UserName%>的空间</a> &gt; 首页</div>
<div class="module_box">
<div class="module_title"><span class="module_sign">最新发布</span></div>
<div class="module_content"><ul class="list">
  <asp:Repeater Id="Pnew" Runat="server">
    <ItemTemplate>
    <li><span class="title"><a href="<%#DetailUrl(DataBinder.Eval(Container.DataItem,"thetable").ToString(),DataBinder.Eval(Container.DataItem,"site_id").ToString(),DataBinder.Eval(Container.DataItem,"Static_dir").ToString(),DataBinder.Eval(Container.DataItem,"Static_file").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"sublanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString(),DataBinder.Eval(Container.DataItem,"permissions").ToString(),DataBinder.Eval(Container.DataItem,"html").ToString())%>" target="myinfo"><%#SubStr(DataBinder.Eval(Container.DataItem,"title").ToString(),60,true)%></a><span class="clicks">(点击:<%#DataBinder.Eval(Container.DataItem,"clicks")%>)</span></span><span class="date"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></span></li>
  </ItemTemplate>
  </asp:Repeater></ul><asp:Label id="lb_info" runat="server">对不起，没有可显示的信息记录。</asp:Label>
</div>
</div>