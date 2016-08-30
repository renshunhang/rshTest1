<% @  Control Language="c#"  Inherits="PageAdmin.mem_pay"%>
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
<div style="margin:30px 0px 10px 130px;text-align:left;">
<table border=0 cellpadding=5 cellspacing=0  style="width:500px;table-layout:fixed;align:left;">
    <tr>
      <td align="right" width="80px" style="height:35px">账户余额：</td>
     <td align="left" width="420px"><span style="color:#ff0000;Font-Size:13px;font-weight:bold">￥<%=Fnc_Ky%></span></td>
    </tr>
    <tr>
      <td align="right" style="height:35px">充值金额：</td>
     <td align="left"><input id="amount" type=text maxlength="8" value="<%=Request.QueryString["amount"]%>" size="10" onkeyup="if(isNaN(value))execCommand('undo')" class="m_tb">&nbsp;元
     </td>
    </tr>
    <tr>
      <td align="right" style="height:40px">支付平台：</td>
      <td align="left">
        <%
          if(P_Type=="")
          {
             Response.Write("暂无可用的支付平台!");
          }
         else
          {
          string[] A_Type=P_Type.Split(',');
          string[] A_Name=P_Name.Split(',');
          for(int i=0;i<A_Type.Length-1;i++)
           {
            Response.Write("<input type='radio' value='"+A_Type[i]+"' name='paytype' id='paytype' "+(i==0?"checked":"")+"><img height=30px src='images/"+A_Type[i]+".gif' title='"+A_Name[i]+"' align=absmiddle>&nbsp;&nbsp;");
           }
          }
        %>
     </td>
    </tr>
    <tr>
      <td align="left" colspan="2" style="padding-left:70px;height:35px"><input type="button" class="m_bt" value="充 值" onclick="GoToPay()"></td>
    </tr>
    <tr>
     <td colspan="2" align=left style="padding-left:20px;height:30px""><span style="color:#ff0000">提示：</span>支付未结束前请不要关闭浏览器，支付成功后该充值款项将划入您的会员帐户上。</td>
    </tr>
</TABLE>
</div>
</div>
</div>
<script type="text/javascript">
 var amount=document.getElementById("amount");
 var pamount="<%=Request.QueryString["amount"]%>";
 var r_url="<%=Request.QueryString["r_url"]%>";
 if(pamount!="" && !isNaN(pamount))
  {
   amount.value=pamount;
  }
 else
  {
   amount.value="0";
  }
 function GoToPay()
 { 
   var M=amount.value;
   if(M=='')
    {
     alert('请输入充值金额!');
     amount.focus();
     return;
    }
   else if(isNaN(M))
    {
     alert('请输入有效的数字!');
     amount.focus();
     return;
    }
   else if(M<0.01)
    {
     alert('充值金额不能小于0.01!');
     amount.focus();
     return;
    }
  var P_type="";
  var pay_type=document.getElementsByName("paytype");
  for(var i=0;i<pay_type.length;i++)
   {
    if(pay_type[i].checked){P_type=pay_type[i].value;break;};
   } 
   if(P_type=="")
    {
     alert("请选择支付平台!")
     return;
    }
   switch(P_type)
    {
      case "alipay":
       window.open("/e/member/onlinepay/alipay/Default.aspx?s=<%=SiteId%>&amount="+M+"&r_url="+UrlEncode(r_url),"onlinepay")
      break;

      case "chinabank":
       window.open("/e/member/onlinepay/chinabank/Default.aspx?s=<%=SiteId%>&amount="+M+"&r_url="+UrlEncode(r_url),"onlinepay")
      break;

      case "tenpay":
       window.open("/e/member/onlinepay/tenpay/index.aspx?s=<%=SiteId%>&amount="+M+"&r_url="+UrlEncode(r_url),"onlinepay")
      break;
    }
 }
 </script>