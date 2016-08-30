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
string Price;
DataTable dt,dt1;
dt=Get_Data(); 
DataRow dr,dr1; 
if(dt.Rows.Count>0)
 {
  dr=dt.Rows[0]; 
  Id=int.Parse(dr["id"].ToString());
  P_SortId=int.Parse(dr["sort_id"].ToString());
  Price=dr["price"].ToString();
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
<div class="thumbnails" id="thumbnails"><ul>
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
Model：<%=dr["pa_xinghao"]%><br>
<%if(Price!="" && Price!="0"){%>Price：<%=dr["price"]%> &nbsp;<br><%}%>
<%=Ubb(dr["pa_introduction"].ToString())%>
<div><input type="hidden" id="currentimage"><a href=javascript:ShowImage()><img align=absmiddle hspace=2 src=/e/images/public/zoom.gif border=0 width=24px height=24px>View Big Image</a></div>
</li>
<li class="clear"></li>
</ul>
</div>

<br>

<div class="prodinfotab">
<div class="tabheader"><dl class="tab_t" id="tab_t">
<dd class="current">Introduction</dd><dd>Relevant</dd>
</dl></div>
<div class="tabcontent"><dl class="tab_c" id="tab_c">
<dd style="display:block"><%=dr["content"]%></dd>
<dd>
<script src="/e/aspx/ajax_list.aspx?modelid=93" type="text/javascript"></script>
<script type="text/javascript">
var ajaxparameter_93="siteid=<%=Site_Id%>&sortid=<%=P_SortId%>&id=<%=Id%>"
rajax_93(1);
</script>
</dd>
</dl></div>
</div>
<script type="text/javascript">
tabs("tab_t","tab_c","dd","dd","current","onclick")
window.onload=function(){zoom({width:300,height:200});}
</script>
<%
}
%><%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>