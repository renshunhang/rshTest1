<% @ Control Language="C#" Inherits="PageAdmin.detail_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%=Zdy_Location%>
<div class="sublanmu_box sublanmu_box_<%=Sublanmu_Id%>" id="sublanmu_box">
<div class="sublanmu_content" id="sublanmu_content">
<%conn.Open();%><% 
DataTable dt=Get_Data();
DataRow dr;
for(int i=0;i<dt.Rows.Count;i++)
 {
  dr=dt.Rows[i]; //说明：给dr赋值
%>
<div class="jobinfo">
<div class="item">
<b>职位名称：</b><%=dr["title"]%><br>
<b>薪资待遇：</b><%=dr["pa_xz"]%><br>
<b>工作经验：</b><%=dr["pa_nianxian"]%><br>
<b>学历要求：</b><%=dr["pa_xueli"]%><br>
<b>招聘人数：</b><%=dr["pa_num"]%>名<br>
<b>发布时间：</b><%=((DateTime)dr["thedate"]).ToString("yyyy-MM-dd")%>
</div>
  
<div class="description">
<span class="title"> 职位描述<img src="/e/css/images/job_icon.gif" border="0" hspace="5"></span>
<%=Ubb(dr["content"].ToString())%> 
</div>
<div class="zxyp"><a href="/index.aspx?lanmuid=68&sublanmuid=634&jobid=<%=dr["id"]%>"><img src="/e/images/diy/hr_yingping.gif" width=90 height=25 border=0></a></div>
</div>

<%
 }
%><%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>