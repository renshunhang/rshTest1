<% @ Control Language="C#" Inherits="PageAdmin.detail_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%=Zdy_Location%>
<div class="sublanmu_box sublanmu_box_<%=Sublanmu_Id%>" id="sublanmu_box">
<div class="sublanmu_content" id="sublanmu_content">
<%conn.Open();%><% 
DataTable dt=Get_Data(); 
DataRow dr; 
if(dt.Rows.Count>0)
{
dr=dt.Rows[0]; //说明：给dr赋值
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="letterinfo">
    <tr class="head">
      <td colspan="2" align="center"><b>留言回复结果</b></td>
    </tr>
    <tr>
      <td align="right" width="100px">信件类型：</td>
      <td><%=Sort_Name(int.Parse(dr["sort_id"].ToString()))%></td>
    </tr>

    <tr>
      <td align="right">留言时间：</td>
      <td><%=((DateTime)dr["thedate"]).ToString("yyyy-MM-dd")%></td>
    </tr>
    <tr>
      <td align="right">留言主题：</td>
      <td><%=Server.HtmlEncode(dr["title"].ToString())%></td>
    </tr>

    <tr>
      <td align="right">留言内容：</td>
      <td><%=dr["content"]%></td>
    </tr>

<%if(dr["reply_state"].ToString()=="0"){%>
    <tr>
      <td align="right">处理进度：</td>
      <td>待处理</td>
    </tr>
<%
}
else
{
dt=Get_Reply("letter",int.Parse(dr["id"].ToString()));
for(int i=0;i<dt.Rows.Count;i++)
 {
   dr=dt.Rows[i]; //说明：给dr赋值
 
%>
    <tr>
      <td align="right">回复：</td>
      <td ><div style="font-size:16px;font-family:楷体_gb2312;line-height:180%"><%=dr["reply"]%></div><div align="right">回复时间：<%=dr["thedate"]%> </div></td>
    </tr>

<%
}
}
%>
<tr>
<td colspan="2" align="center"><a href="javascript:history.back()">返回上一页</a></td>
</tr>

</table>
<%
 }
%><%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>