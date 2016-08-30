<% @  Control Language="c#"%>
<script language="c#" runat="server">
 string Get_Url(string Type)
  {
    return "index.aspx?s="+Request.QueryString["s"]+"&type="+Type;
  }
</script>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 在线支付</li>
<li class="current_location_2">在线支付</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li><a href='<%=Get_Url("mem_fnclst")%>'>财务记录</a></li>
 <li class="c"><a href='<%=Get_Url("mem_pay")%>'>在线支付</a></li>
</ul></div>
<div style="margin:30px 0px 10px 150px;text-align:left;">
<%if(Request.QueryString["s"]!=null && Request.QueryString["pay_no"]!=null){
string R_Url=Request.QueryString["r_url"];
if(string.IsNullOrEmpty())
 {
  R_Url=Get_Url("mem_pay");
 }

%>
<TABLE width=500 border=0 align="center" cellPadding=5 cellSpacing=0>
   <tr>
       <td align="left"><img src="images/paysuc.png" border=0"></td>
   </tr>

   <TR>   
       <TD vAlign=top align="left">支付订单号：<%=Server.HtmlEncode(Request.QueryString["pay_no"])%></TD>
   </TR>

   <TR> 
      <TD vAlign=top align="left">支付平台：<%=Server.HtmlEncode(Request.QueryString["pay_type"])%></TD>
   </TR>

   <TR> 
       <TD vAlign=top align="left">充值金额：<span style="color:#ff0000;Font-Size:13px;font-weight:bold">￥<%=Server.HtmlEncode(Request.QueryString["pay_amount"])%></span></TD>
   </TR>

   <TR> 
      <TD vAlign=top align="left">支付时间：<%=DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")%></TD>
   </TR>				
</TABLE>
<%
}
else
{
 //Response.Redirect(Get_Url("mem_pay"));
}
%>
</div>
</div>
</div>