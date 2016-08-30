<% @ Control Language="C#" Inherits="PageAdmin.detail_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%=Zdy_Location%>
<div class="sublanmu_box sublanmu_box_<%=Sublanmu_Id%>" id="sublanmu_box">
<div class="sublanmu_content" id="sublanmu_content">
<%conn.Open();%><%
string SortId="",video="";
DataTable dt=Get_Data(); 
DataRow dr; 
if(dt.Rows.Count>0)
 {
  dr=dt.Rows[0];
  video=dr["pa_video"].ToString();
  SortId=dr["sort_id"].ToString();
%>
<div class="articleinfor">
<ul>
<li class="title"><h1><%=Server.HtmlEncode(dr["title"].ToString())%>
</h1></li>
<li class="info">
发布日期：<%=((DateTime)dr["thedate"]).ToString("yyyy-MM-dd")%>&nbsp;
<%=dr["pa_autor"].ToString()==""?"":"&nbsp;作者："+dr["pa_autor"].ToString()%>
<%=dr["pa_source"].ToString()==""?"":"&nbsp;来源："+dr["pa_source"].ToString()%>
阅读数：<span id="clicks"></span>
</li>
</ul>
<div class="content" id="Content"><%if(video!=""){%>
<script src="/e/js/video.js" type="text/javascript"></script>
<div align=center><script type="text/javascript">
player("<%=video%>",800,600);
</script></div>
<%}%><%=Add_KeyLink(dr["content"].ToString(),1,false)%>
</div>
</div>
<script src="/e/js/internal_page.js" type="text/javascript"></script>
<%}
%><%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>