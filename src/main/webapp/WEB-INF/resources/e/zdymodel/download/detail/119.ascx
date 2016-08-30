<% @ Control Language="C#" Inherits="PageAdmin.detail_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%=Zdy_Location%>
<div class="sublanmu_box sublanmu_box_<%=Sublanmu_Id%>" id="sublanmu_box">
<div class="sublanmu_content" id="sublanmu_content">
<%conn.Open();%><% 
string DownLoads="",FileId="",NeedPoint="",Permissions="",TPic="";
DataTable dt,dt1;
dt=Get_Data();
DataRow dr,dr1;
dr=dt.Rows[0]; //说明：给dr赋值
TPic=dr["titlepic"].ToString();
if(TPic==""){TPic="/e/images/noimage.gif";}
%>
<table  width="100%" align="center">
    <tbody>
        <tr>
            <td  style="height:5px"></td>
        </tr>
    </tbody>
</table>
<table  cellspacing="1" cellpadding="5" width="98%" align="center" border="0" style="word-break: break-all" bgcolor="#cccccc">
    <tbody>
        <tr  bgcolor="#fffffe">
            <td align="center"><strong><%=dr["title"]%></strong>
            </td>
        </tr>
    </tbody>
</table>
<table  width="100%" align="center">
    <tbody>
        <tr>
            <td  style="height:5px"></td>
        </tr>
    </tbody>
</table>
<table cellspacing="1" cellpadding="5" width="98%" align="center" bgcolor="#cccccc" border="0" style="word-break: break-all">
    <tbody>
        <tr bgcolor="#fffffe">
            <td width="50%">文件大小：<%=dr["pa_size"]%> MB</td>
            <td valign="middle" align="center" width="50%" rowspan="12"><img alt="" width="200" src="<%=TPic%>" ></td>
        </tr>
        <tr bgcolor="#fffffe">
            <td width="45%">授权方式：<%=dr["pa_sqfs"]%></td>
        </tr>
        <tr bgcolor="#fffffe">
            <td width="45%">软件类别：<%=Sort_Name(int.Parse(dr["sort_id"].ToString()))%></td>
        </tr>
        <tr bgcolor="#fffffe">
            <td width="45%">软件语言：<%=dr["pa_language"]%></td>
        </tr>
        <tr bgcolor="#fffffe">
            <td width="45%">运行环境：<%=dr["pa_yxhj"].ToString().Replace(",","/")%></td>
        </tr>
        <tr bgcolor="#fffffe">
            <td width="45%">发布人：<%=dr["pa_author"]%></td>
        </tr>
        <tr bgcolor="#fffffe">
            <td width="45%">发布时间：<%=((DateTime)dr["thedate"]).ToString("yyyy年M月d日")%></td>
        </tr>
        <tr bgcolor="#fffffe">
            <td width="45%">解压密码：<%=dr["pa_jspass"].ToString()==""?"无密码":dr["pa_jspass"].ToString()%></td>
        </tr>
        <tr bgcolor="#fffffe">
            <td width="45%">下载次数：<%=dr["downloads"]%></td>
        </tr>
        <tr bgcolor="#fffffe">
            <td width="45%">
<%
  dt1=Get_File("download","pa_fj",Detail_Id);
  for(int k=0;k<dt1.Rows.Count;k++)
   {
    dr1=dt1.Rows[k];
%>
<img height="16" alt="" width="21" src="/e/images/diy/down.gif" />&nbsp;<a href="/e/aspx/attachment.aspx?id=<%=dr1["id"]%>" target=_blank>下载地址<%=k+1%></a>
<%
}
%>
</td>
        </tr>
    </tbody>
</table>
<br />
<table cellspacing="0" cellpadding="2" width="98%" align="center" border="0">
    <tbody>
        <tr>
            <td>::软件简介::</td>
        </tr>
    </tbody>
</table>
<table cellspacing="1" cellpadding="5" width="98%" align="center" bgcolor="#cccccc" border="0" style="table-layout: fixed; word-break: break-all">
    <tbody>
        <tr>
            <td bgcolor="#fffffe"><div style="padding:2px 5px 5px 5px"><%=dr["content"]%></div></td>
        </tr>
    </tbody>
</table>
<br />
<table cellspacing="0" cellpadding="2" width="98%" align="center" border="0">
    <tbody>
        <tr>
            <td>::下载说明::</td>
        </tr>
    </tbody>
</table>
<table cellspacing="1" cellpadding="5" width="98%" align="center" bgcolor="#cccccc" border="0" style="word-break: break-all">
    <tbody>
        <tr>
            <td bgcolor="#fffffe" style="line-height: 16px"><b>*&nbsp;</b>如果您发现该文件不能下载，请通知<a href="mailto:pacme@pageadmin.net" style="color:#ff0000">管理员</a>，谢谢！ <br />
            <b>*&nbsp;</b>为了达到最快的下载速度，推荐使用网际快车、迅雷等下载本站软件。 <br />
            <b>*&nbsp;</b>未经本站明确许可，不得非法盗链及抄袭本站资源；如引用页面，请注明来自&ldquo;PageAdmin网站管理系统&rdquo;！</td>
        </tr>
    </tbody>
</table>
<br /><%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>