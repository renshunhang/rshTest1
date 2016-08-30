<% @  Control Language="c#" Inherits="PageAdmin.mem_odlst"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; <a href="index.aspx?type=mem_odidx&s=<%=Request.QueryString["s"]%>">我的订单</a> &gt; 订单明细</li>
<li class="current_location_2">订单明细</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<form runat="server">
 <table border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
    <tr>
      <td height=25px style="font-weight:bold" >订单号：<%=Request.QueryString["detailid"]%>[<a href='/e/order/orderview.aspx?orderid=<%=Request.QueryString["detailid"]%>' target='orderview'>查看</a>]</td> 
      <td height=25px align="right">我的账户余额：<span style="color:#ff0000;font-weight:bold"><%=Fnc_Ky%></span>元</td>
   </tr>
 </table>

 <table border="0" cellspacing="0"  align="center" class="member_table">
    <tr>
      <td align=center  class="memlist_header_item" width="5%">序号</td> 
      <td align=center  class="memlist_header_item" width="30%">名称</td> 
      <td align=center  class="memlist_header_item" width="10%">订购数量</td> 
      <td align=center  class="memlist_header_item" width="10%">赠送积分</td>
      <td align=center  class="memlist_header_item" width="10%">您的价格</td>
      <td align=center  class="memlist_header_item" width="10%">总计</td>
      <td align=center  class="memlist_header_item" width="10%">状态</td>
      <td align=center  class="memlist_header_item_last" width="15%">操作</td>
    </tr>
<asp:Repeater id="P1" runat="server" OnItemDataBound="P1_Bound">
 <ItemTemplate>
   <tr>
      <td align=center  class="memlist_item"><%#ItemIndex+1%></td> 
      <td align=center  class="memlist_item"><a href="<%#Get_DetailUrl(DataBinder.Eval(Container.DataItem,"thetable").ToString(),DataBinder.Eval(Container.DataItem,"detail_id").ToString())%>" target="_blank"><img src="<%#Get_Field(DataBinder.Eval(Container.DataItem,"thetable").ToString(),"titlepic",DataBinder.Eval(Container.DataItem,"detail_id").ToString())%>" border=0 class="order_pdimage"><%#DataBinder.Eval(Container.DataItem,"title")%></a>
       <%#DataBinder.Eval(Container.DataItem,"color").ToString()==""?"":"<br>颜色："+DataBinder.Eval(Container.DataItem,"color").ToString()%>
       <%#DataBinder.Eval(Container.DataItem,"size").ToString()==""?"":"<br>尺寸："+DataBinder.Eval(Container.DataItem,"size").ToString()%>
       <%#DataBinder.Eval(Container.DataItem,"type").ToString()==""?"":"<br>类型："+DataBinder.Eval(Container.DataItem,"type").ToString()%>
      </td>
      <td align=center  class="memlist_item"><asp:TextBox id="Tb_Num" Text='<%#DataBinder.Eval(Container.DataItem,"num")%>' runat="server" size="3" maxlength="10" reserves='<%#Get_Field(DataBinder.Eval(Container.DataItem,"thetable").ToString(),"reserves",DataBinder.Eval(Container.DataItem,"detail_id").ToString())%>' onkeyup='check_kc(this,this.value,this.attributes["reserves"].value)'/></td> 
      <td align=center  class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"count_sendpoint")%></td>
      <td align=center  class="memlist_item">￥<asp:Label id="Lb_MPrice" Text='<%#DataBinder.Eval(Container.DataItem,"member_price")%>' runat="server" /></td>
      <td align=center  class="memlist_item">￥<%#DataBinder.Eval(Container.DataItem,"tj")%></td>
      <td align=center  class="memlist_item"><%#Get_PdState(DataBinder.Eval(Container.DataItem,"state").ToString())%></td>
      <td align=center class="memlist_item_last">
     <asp:LinkButton Text="修改" id="Edit" runat="server" CommandName='<%#ItemIndex%>'  OnCommand="Data_Update"/>
     <asp:LinkButton Text="删除" id="Delete" runat="server" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="Data_Delete" />
     <asp:Label Id="Lb_Paystate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"paystate")%>' Visible="false" />
     <asp:Label Id="Lb_Id" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' Visible="false" />
    </td>
    </tr>
 </ItemTemplate>
</asp:Repeater>
 </table>

<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center">
   <tr>
      <td  align="left" style="padding:10px 0 10px 0;line-height:25px">
订单总额：<asp:Label id="Lb_Tj"  runat="server" style="color:#ff0000;font-weight:bold"/>元(赠送积分：<asp:Label id="Lb_Point"  runat="server"/>)
<br>配送费用：<asp:Label id="Lb_send" runat="server" style="color:#ff0000;font-weight:bold"/>元(<asp:Label id="Lb_sendway" runat="server"/>)
<br>费用总计：<asp:Label id="Lb_All"  runat="server"  style="color:#ff0000;font-weight:bold"/>元
<br>付款状态：<%=PayState=="1"?"<span class='pay_success'>已付款</span>":"未付款"%>
<br>发货状态：<%=SendState=="2"?"<span class='send_success'>已发货</span>":SendState=="1"?"已确认":"未发货"%>
<br><%if(PayState!="1"){%><asp:Button Text="付 款"  onclick="Pay_Order" onclientclick="return payck()"  runat="server" cssclass="m_bt"/> &nbsp; <%}%><input type="button" value="返 回"   class="m_bt" onclick="location.href='<%=Get_Url("mem_odidx")%>'">
  </td> 
   </tr>
   <tr>
      <td align="center"><asp:label id="Lb_Empty" Text="此订单为空！" runat="server" visible="false" /></td> 
   </tr>
 </table>
</form>
</div>
</div>
<script type="text/javascript">
 function payck()
  {
   var fnc_ky=<%=Fnc_Ky%>;
   var Amount=<%=Total_Amount%>;
   if(fnc_ky<Amount)
    {
      if(confirm("对不起，您的账户可用金额不足!\n\n是否进行充值?"))
       {
         location.href="<%=Get_Url("mem_pay")%>&amount="+Amount+"&r_url="+UrlEncode("/e/member/index.aspx?s=<%=Request.QueryString["s"]%>&type=mem_odlst&detailid=<%=Request.QueryString["detailid"]%>");
       }
      return false;
    }
   if(confirm("此操作将从您的账户余额中扣除"+Amount+"元，是否确定?"))
    {
      return true;
    }
   else
    {
      return false;
    }
  }

function check_kc(obj,num,reserves)
 {
   if(!IsNum(num)){num=0;}
    if(!IsNum(reserves)){reserves=0;}
    if(parseInt(num)<=0)
     {
       alert("对不起，订购数必须大于0!");
       obj.value="";
       obj.style.color="#ff0000";
     }
    if(parseInt(num)>parseInt(reserves))
     {
       alert("对不起，订购数不能超过库存数(现有库存数："+reserves+")!");
       obj.value=reserves;
       obj.style.color="#ff0000";
     }
   else
     {
       obj.style.color="#333333";
     }
 }
</script>