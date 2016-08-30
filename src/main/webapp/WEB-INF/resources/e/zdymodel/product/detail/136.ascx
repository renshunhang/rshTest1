<% @ Control Language="C#" Inherits="PageAdmin.detail_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%=Zdy_Location%>
<div class="sublanmu_box sublanmu_box_<%=Sublanmu_Id%>" id="sublanmu_box">
<div class="sublanmu_content" id="sublanmu_content">
<%conn.Open();%><%
string SortId="",video="";
Site_Id=1;
DataTable dt=Get_Data(); 
DataRow dr; 
if(dt.Rows.Count>0)
 {
  dr=dt.Rows[0];
  SortId=dr["sort_id"].ToString();
%>
<div class="articleinfor">
<ul>
<li class="title"><h1><%=Server.HtmlEncode(dr["title"].ToString())%>
</h1></li>
</ul>
<div class="content" id="Content"><%=Add_KeyLink(dr["content"].ToString(),1,false)%>
<div class="pics">
<ul>
<%
dt=Get_File("product","pa_images",Detail_Id);
for(int i=0;i<dt.Rows.Count;i++)
 {
   dr=dt.Rows[i];
%>
 <li><%=dr["title"]%><img src="<%=dr["url"]%>"></li>
<%}%>
<ul>
</div>
</div>
</div>
<%}
%><%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>