<% @ Control language="c#" Inherits="PageAdmin.spc_fbk" src="spc_fbk.ascx.cs"%>
<div class="spc_location">当前位置：<a href="/e/space/?uid=<%=UID%>"><%=UserName%>的空间</a> &gt; 我的留言</div>
<asp:Panel id="P1" runat="server" cssclass="module_box" visible="false"> 
<div class="module_title"><span class="module_sign">发布留言</span></div>
<div class="module_content">
<table border=0 cellpadding="4px" cellspacing=0  align=center width="98%">
  <form name="f" method="post" action="index.aspx?uid=<%=UID%>&type=fbk">
   <tr>
      <td height=20 align=right width="50px">留言<span style="color:#ff0000"> *</span></td>
      <td height=20>
<textarea id="fb_content" name="fb_content" style="width:100%;height:150px"></textarea>
    </td>
    </tr>
     <tr>
      <td height=20 align="center" colspan=2>
      <input type="hidden" value="<%=Current_LoginName%>" name="Current_LoginName">
      <input type="hidden" value="0" name="did" id="did">&nbsp;
      <input type="hidden" value="feedback"  name="post" id="post">&nbsp;
      <input type="submit" value="提交"  onclick="return SpcFeedback()" class="bt">&nbsp;
     </td>
    </tr>
   </form>
 </table>
</div>
</asp:Panel>

<asp:Panel id="P2" runat="server" cssclass="module_box" visible="false">
<div class="module_title"><span class="module_sign">留言请先登录</span></div>
<div class="module_content">
  <table border=0 cellpadding="5px" cellspacing=0  align=center width="98%">
    <form name="l" method="post" action="/e/space/index.aspx?uid=<%=UID%>&type=fbk">
     <tr>
      <td height=30 align="left" align="left">
      <input type="hidden" value="login"  name="post">&nbsp;
      用户名：<input type='textbox' name='fb_username' id="fb_username" size="12" maxlength='50' class="tb"> 密码：<input type='textbox' name='fb_pass' id="fb_pass" size="12" maxlength='50' class="tb">
      <input type="submit" value="登录"  onclick="return SpcLogin()" class="bt">&nbsp;&nbsp;[<a href="/e/member/index.aspx?type=reg">没有账号点此注册</a>]
     </td>
    </tr>
   </form>
 </table>
</div>
</asp:Panel>
<div class="module_box">
<div class="module_title"><span class="module_sign">我的留言</span></div>
<div class="module_content">
 <ul class="fbklist">
  <asp:Repeater Id="Plist" Runat="server" OnItemDataBound="Data_Bound">
    <ItemTemplate>
    <li class="left finfo"><a href="/e/space/?username=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"fbk_username").ToString())%>" target="space"><%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"fbk_username").ToString())%></a> <span class="finfo">发布于：<%#DataBinder.Eval(Container.DataItem,"fbk_date","{0:yyyy-MM-dd HH:mm:ss}")%></span></li>
    <asp:PlaceHolder id="p_control" Runat="server" Visible="false"><li class="right">[<a href="javascript:d_spcfbk('<%#DataBinder.Eval(Container.DataItem,"id")%>')">删除</a>]&nbsp;&nbsp;[<a href="javascript:r_spcfbk('<%#DataBinder.Eval(Container.DataItem,"id")%>')">回复</a>]</li></asp:PlaceHolder>
    <li class="clear"></li>
    <li class="fbk"><%#DataBinder.Eval(Container.DataItem,"feedback")%></li>
    <asp:PlaceHolder id="p_reply" Runat="server" Visible="false"><li class="reply"><asp:Label id="lb_reply" Text='
<%#ubb(DataBinder.Eval(Container.DataItem,"reply").ToString())%>' Runat="server"/><div class="rinfo"> 回复时间：<%#DataBinder.Eval(Container.DataItem,"reply_date","{0:yyyy-MM-dd HH:mm:ss}")%></div>
</li></asp:PlaceHolder><li class="sp"></li>
  </ItemTemplate>
  </asp:Repeater>
</ul>
<asp:Label id="Lb_PageSize" Text="10" runat="server" Visible="false"/>
<asp:Label id="Lb_CurrentLoginName" runat="server" Visible="false"/>
<asp:Panel id="P_Page" runat="server" cssclass="page">
<% 
if (CurrentPage>1)
{
%>
<a href="<%=GoPage(1)%>">首页</a> <a href="<%=GoPage(CurrentPage-1)%>">上一页</a><%
}

 int p=7; //表示开始时显示的页码总数
 int M=3; //超过p页后左右两边显示页码数
 if(CurrentPage<p)
  {
    for(int i=1;i<=(PageCount>p?p:PageCount);i++)
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
    int LastPage=CurrentPage+M;
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
%> <a href="<%=GoPage(CurrentPage+1)%>">下一页</a> <a href="<%=GoPage(PageCount)%>">尾页</a>
<%}%> <span><%=String.Format("页次：{0}/{1} 共{2}条记录",CurrentPage,PageCount,RecordCount)%></span>
</asp:Panel>
</div>
</div>