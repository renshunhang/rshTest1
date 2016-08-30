<% @ Control  language="c#"  Inherits="PageAdmin.mem_menu"%>
<asp:PlaceHolder id="P_meminfo" runat="server" Visible="false">
<div class="nav_box nav_box_introduct nav_box_loginstate">
<div class="nav_title"><span class="nav_sign">用户资料</span></div>
<div class="nav_content">
会员名：<%=UserName%><% if(msg_icon_show=="1"){%><a href="<%=Get_Url("mem_msg")%>"><img src=/e/images/public/message.gif border=0 width=20px height=17px></a><%}%><br>
类&nbsp;&nbsp;别：<%=Member_Type_Name%><br><%if(!string.IsNullOrEmpty(Department)){%>部&nbsp;&nbsp;门：<%=Department%><br><%}%>
<a href="<%=Get_Url("index")%>" class="logined_href">会员中心</a>&nbsp;&nbsp; <%if(order_cart_show=="1"){%><a class='logined_href' href="javascript:ordercart('<%=SiteId%>','')">购物车</a>&nbsp;&nbsp; <%}%><a href="<%=SignOut("")%>" class="logined_href">注销退出</a>
</div>
</div>
</asp:PlaceHolder>
<div class="nav_box nav_box_sublanmu nav_box_membermenu">
<div class="nav_title"><span class="nav_sign">会员中心</span></div>
<div class="nav_menu">
 <ul id="root_nav_menu"><asp:PlaceHolder id="P_message" runat="server" Visible="false" >
  <li><a href="<%=Get_Url("mem_msg")%>" id="nav_msg">站内信息</a></li></asp:PlaceHolder>
<asp:PlaceHolder id="P_issue" runat="server" Visible="false">
  <li><a href="<%=Get_Url("mem_issuelst")%>" id="nav_issue">签发信息</a></li></asp:PlaceHolder>
<asp:PlaceHolder id="P_sign" runat="server" Visible="false">
  <li><a href="<%=Get_Url("mem_signlst")%>" id="nav_sign">信息签收</a></li></asp:PlaceHolder>
<asp:PlaceHolder id="P_letter" runat="server" Visible="false">
  <li><a href="<%=Get_Url("mem_letlst")%>" id="nav_let">信息回复</a></li>
</asp:PlaceHolder>
<asp:Repeater id="P_zdyform" runat="server" Visible="false">
  <HeaderTemplate><li id="AddData"><a href="javascript:void(0)">信息发布</a><ul style="display:none"></HeaderTemplate>
   <ItemTemplate>
   <li><span class="childnode"></span><a href="<%#Get_ListUrl(DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"thetable").ToString())%>" id="nav_<%#DataBinder.Eval(Container.DataItem,"id")%>"><%#DataBinder.Eval(Container.DataItem,"table_name")%></a></li>
  </ItemTemplate>
  <FooterTemplate></ul></li></FooterTemplate>
</asp:Repeater>
<asp:Repeater id="Pmenu" runat="server">      
 <ItemTemplate>
  <li><a href="<%#DiyMenu_Url(DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"thetype").ToString(),DataBinder.Eval(Container.DataItem,"url").ToString())%>" id="nav_m<%#DataBinder.Eval(Container.DataItem,"id")%>" target="<%#DataBinder.Eval(Container.DataItem,"target")%>"><%#DataBinder.Eval(Container.DataItem,"name")%></a></li>
 </ItemTemplate>
</asp:Repeater>
<asp:PlaceHolder id="P_order" runat="server" Visible="false" >
  <li><a href="<%=Get_Url("mem_odidx")%>" id="nav_od">我的订单</a></li>
</asp:PlaceHolder>
<asp:PlaceHolder id="P_exchange" runat="server" Visible="false" >
  <li><a href="<%=Get_Url("mem_exlst")%>" id="nav_ex">我的兑换</a></li>
</asp:PlaceHolder>
<asp:PlaceHolder id="P_fnc" runat="server" Visible="false" >
  <li><a href="<%=Get_Url("mem_fnclst")%>" id="nav_fnc">我的财务</a></li>
</asp:PlaceHolder>
<asp:PlaceHolder id="P_point" runat="server" Visible="false" >
  <li><a href="<%=Get_Url("mem_ptlst")%>" id="nav_pt">我的积分</a></li>
</asp:PlaceHolder>
<asp:PlaceHolder id="P_fbk" runat="server" Visible="false" >
  <li><a href="<%=Get_Url("mem_fbklst")%>" id="nav_fbk">我的留言</a></li>
</asp:PlaceHolder>
<asp:PlaceHolder id="P_favorites" runat="server" Visible="false" >
  <li><a href="<%=Get_Url("mem_favolst")%>" id="nav_favolst">我的收藏</a></li>
</asp:PlaceHolder>
<asp:PlaceHolder id="P_info" runat="server" Visible="false" >
  <li><a href="<%=Get_Url("mem_mdy")%>" id="nav_mdy">资料修改</a></li>
</asp:PlaceHolder>  
<asp:PlaceHolder  id="P_reg" runat="server">
  <li><a href="<%=Get_Url("reg")%>" id="nav_reg">会员注册</a></li>
  <li><a href="<%=Get_Url("login")%>" id="nav_login">会员登陆</a></li>
  <li><a href="<%=Get_Url("findpass")%>" id="nav_fps">找回密码</a></li>
</asp:PlaceHolder>
 </ul>
</div>
</div>
<script type="Text/javascript">
$(document).ready(function(){
 $("#AddData").children("a").click(function(){
  $("#AddData").children("ul").toggle();
 });
});
memnav_current();
var thetype="<%=Request.QueryString["type"]%>";
var worknode="<%=Request.QueryString["worknode"]%>";
if(thetype=="mem_datalst" || thetype=="mem_datadtl" || thetype=="mem_sitelst")
 {  
   if(worknode=="")
   {
    $("#AddData").children("ul").show();
   }
 }
</script>