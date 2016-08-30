<% @  Control Language="c#" Inherits="PageAdmin.mem_idx"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 会员首页</li>
<li class="current_location_2">会员首页</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div style="padding:10px 0 10px 0">您好：<span style="color:#ff0000;Font-Size:13px;font-weight:bold"><%=UserName%></span><%if(Space_Open=="1"){%>（<a href="/e/space/?uid=<%=UID%>" target="myspace">我的空间</a>）<%}%>，欢迎您登陆会员中心!</div>
<table border=0 cellpadding="0px"  align="center" class="mem_idx_table">
  <%if(ShowFnc=="1"){%>
  <tr>
    <td align="right" width=100>可用金额：</td><td><%if(Fnc_Ky=="0"){%>0<%}else{%><span style="color:#ff0000;Font-Size:13px;font-weight:bold">￥<%=Fnc_Ky%></span><%}%> <a href="<%=Get_Url("mem_pay")%>">(在线支付)</a></td>
  </tr>
  <%}%>

  <%if(ShowPoint=="1"){%>
  <tr>
    <td align="right" width=100>可用积分：</td><td><%if(Point_Ky=="0"){%>0<%}else{%><span style="color:#ff0000;Font-Size:13px;font-weight:bold"><%=Point_Ky%></span><%}%> <a href="<%=Get_Url("mem_point")%>">(在线充值)</a></td>
  </tr>
  <%}%>

  <%if(ShowMsg=="1"){%>
  <tr>
    <td align="right" width=100>未读短信：</td>
   <td>
    <%if(Msg_New=="0"){%>0
    <%}else{%><span style="color:#ff0000;Font-Size:13px;font-weight:bold"><%=Msg_New%></span> (<a href="/e/member/index.aspx?s=<%=SiteId%>&type=mem_msg">查看</a>)<%}%>
   </td>
  </tr>
  <%}%>

  <%if(ShowIssue=="1"){%>
  <tr>
    <td align="right" width=100>待签发信息：</td>
    <td>
    <%if(Issues==0){%>0
    <%}else{%><span style="color:#ff0000;Font-Size:13px;font-weight:bold"><%=Issues%></span> (<a href="/e/member/index.aspx?s=<%=SiteId%>&type=mem_issuelst">查看</a>)<%}%>
    </td>
  </tr>
  <%}%>

  <%if(ShowSign=="1"){%>
  <tr>
    <td align="right" width=100>待签收信息：</td>
    <td>
     <%if(Signs==0){%>0
    <%}else{%><span style="color:#ff0000;Font-Size:13px;font-weight:bold"><%=Signs%></span> (<a href="/e/member/index.aspx?s=<%=SiteId%>&type=mem_signlst">查看</a>)<%}%>
    </td>
  </tr>
  <%}%>

  <%if(ShowLetter=="1"){%>
  <tr>
    <td align="right" width=100>待回复信息：</td>
   <td>
    <%if(Letters==0){%>0
    <%}else{%><span style="color:#ff0000;Font-Size:13px;font-weight:bold"><%=Letters%></span> (<a href="/e/member/index.aspx?s=<%=SiteId%>&type=mem_letlst">查看</a>)<%}%>
   </td>
  </tr>
  <%}%>

  <%if(ShowOrder=="1"){%>
  <tr>
    <td align="right" width=100>未付订单：</td>
    <td>
     <%if(Order_NoPay=="0"){%>0
    <%}else{%><span style="color:#ff0000;Font-Size:13px;font-weight:bold"><%=Order_NoPay%></span> (<a href="/e/member/index.aspx?s=<%=SiteId%>&type=mem_odidx">查看</a>)<%}%>
    </td>
  </tr>
  <%}%>

  <%if(ShowFbk=="1"){%>
  <tr>
    <td align="right" width=100>待复留言：</td>
   <td>
   <%if(Feedback_NoReply=="0"){%>0
    <%}else{%><span style="color:#ff0000;Font-Size:13px;font-weight:bold"><%=Feedback_NoReply%></span> (<a href="/e/member/index.aspx?s=<%=SiteId%>&type=mem_fbklst">查看</a>)<%}%>
   </td>
  </tr>
  <%}%>
  <%if(ShowFavorites=="1"){%>
  <tr>
    <td align="right" width=100>我的收藏：</td>
   <td>
    <%if(Favolst_Num=="0"){%>0
    <%}else{%><span style="color:#ff0000;Font-Size:13px;font-weight:bold"><%=Favolst_Num%></span> (<a href="/e/member/index.aspx?s=<%=SiteId%>&type=mem_favolst">查看</a>)<%}%>
   </td>
  </tr>
  <%}%>
  <tr>
    <td align="right" width=100>登陆次数：</td><td><%=Logins%></td>
  </tr>
  <tr>
    <td align="right">注册时间：</td><td><%=Reg_Date%></td>
  </tr>
  <tr>
    <td align="right">最后登陆：</td><td><%=Last_Date%></td>
  </tr>
</table> 

</div>
</div>