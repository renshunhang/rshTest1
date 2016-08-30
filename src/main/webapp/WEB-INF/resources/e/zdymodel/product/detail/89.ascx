<% @ Control Language="C#" Inherits="PageAdmin.detail_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%=Zdy_Location%>
<div class="sublanmu_box sublanmu_box_<%=Sublanmu_Id%>" id="sublanmu_box">
<div class="sublanmu_content" id="sublanmu_content">
<%conn.Open();%><script type="text/javascript" src="/e/js/zoom.js"></script>
<link href="/e/css/zoom.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="/e/js/product.js"></script>
<% 
int i,Id,P_SortId;
string Price,Point;
DataTable dt,dt1;
dt=Get_Data(); 
DataRow dr,dr1; 
if(dt.Rows.Count>0)
 {
  dr=dt.Rows[0]; 
  Id=int.Parse(dr["id"].ToString());
  P_SortId=int.Parse(dr["sort_id"].ToString());
  Price=dr["price"].ToString();
  Point=dr["point"].ToString();
%>
<div class="product_pic_infor">
<ul>
<li class="left">
<div class="view" id="view" style="position:relative">
<%
dt1=Get_File("product","pa_images",Id);
for(i=0;i<dt1.Rows.Count;i++)
 {
  dr1=dt1.Rows[i];
%><img class="zoom" src="<%=dr1["thumbnail"]%>" big="<%=dr1["url"]%>" border="0" id="picture" name="picture" style="display:<%=i==0?"":"none"%>">
<%}%></div>
<div class="clear"></div>
<!--缩略图区域--->
<%if(int.Parse(dr["pa_images"].ToString())>1){%>
<div class="leftbar" onmouseover="roll('left')" onmouseout="stoproll()"></div>
<div class="thumbnails" id="thumbnails">
<ul>
<%
dt1=Get_File("product","pa_images",Id);
for(i=0;i<dt1.Rows.Count;i++)
 {
  dr1=dt1.Rows[i];
%>
<li><img <%=i==0?"class='current'":""%> src="<%=dr1["thumbnail"]%>" onclick="LoadImg(<%=i%>)" id="thumbnail" name="thumbnail"></li>
<%}%></ul></div>
<div class="rightbar" onmouseover="roll('right')" onmouseout="stoproll()"></div>
<%}%>
<!--缩略图区域--->
</li>
<li class="right">
<span class="title"><%=dr["title"]%></span>
<span class="cpnr">产品型号：<%=dr["pa_xinghao"]%></span>
<%if(Price!="" && Price!="0"){%><span class="cpnr">产品价格：<%=Price%>元<!-- &nbsp;<a href="javascript:ordercart('<%=Site_Id%>','product',<%=Id%>)" style="color:#ff0000">[在线订购]</a>--></span><%}%>
<%if(Point!="" && Point!="0"){%><span class="cpnr">所需积分：<%=Point%>点 &nbsp;<a href="javascript:exchange('<%=Site_Id%>','product',<%=Id%>)" style="color:#ff0000">[积分兑换]</a></span><%}%>
<div class="cpjj-box"><%=Ubb(dr["pa_introduction"].ToString())%></div>
</li>
<li class="clear"></li>
</ul>
</div>
<div class="prodinfotab">
<div class="tabheader"><dl class="tab_t" id="tab_t">
<dd>详细内容</dd>
</dl></div>
<div class="tabcontent"><dl class="tab_c" id="tab_c">
<dd>
<%=dr["content"].ToString()%>
</script>
</dd>
</dl></div>
</div>
<script type="text/javascript">
tabs("tab_t","tab_c","onclick")
window.onload=function(){zoom({width:350,height:350});}
</script>
<%
}
Prev_and_Next();
%>
<ul class="sublanmu_pn">
<li class="syb"><%=_Previous==""?"":"上一篇："+_Previous%></li>
<li class="xyb"><%=_Next==""?"":"下一篇："+_Next%></li>
</ul><%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>