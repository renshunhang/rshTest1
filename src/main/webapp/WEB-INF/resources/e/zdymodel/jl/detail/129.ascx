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
<style type="text/css">
.tablestyle{border:1px solid #cccccc;border-collapse:collapse;}
.tablestyle td{border:1px solid #cccccc}
</style>
<div align=center><b><%=dr["title"].ToString()%>的简历</b></div>
<table width="100%" cellspacing="1" cellpadding="5" border="0" align="center" class="tablestyle">
    <tbody>
        <tr bgcolor="#ffffff">
            <td width="80" height="25" align="center" style="color:#111111;font-weight:bold">应聘职位</td>
            <td  colspan="2"><%=Server.HtmlEncode(dr["pa_position"].ToString())%></td>
            <td width="80" height="25" align="center" style="color:#111111;font-weight:bold">期望月薪</td>
            <td  colspan="2"><%=dr["pa_expectationssalary"].ToString()%></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td height="25" colspan="6"></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td width="80" height="25" align="center" style="color:#111111;font-weight:bold">姓名</td>
            <td width="100"><%=Server.HtmlEncode(dr["title"].ToString())%></td>
            <td width="80" align="center" style="color:#111111;font-weight:bold">性别</td>
            <td width="100"><%=dr["pa_xb"].ToString()%></td>
            <td width="80" align="center" style="color:#111111;font-weight:bold">出生年月</td>
            <td width="100"><%=((DateTime)dr["pa_birthday"]).ToString("yyyy-MM-dd")%></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td width="80" align="center" style="color:#111111;font-weight:bold">身份证号</td>
            <td width="100"><%=Server.HtmlEncode(dr["pa_sfz"].ToString())%></td>
            <td width="80" height="25" align="center" style="color:#111111;font-weight:bold">婚姻状况</td>
            <td width="100"><%=dr["pa_marriage"].ToString()%></td>
            <td width="80" align="center" style="color:#111111;font-weight:bold">政治面貌</td>
            <td width="100"><%=dr["pa_zzmm"].ToString()%></td>
        </tr>
 <tr bgcolor="#ffffff">
            <td width="80" height="25" align="center" style="color:#111111;font-weight:bold">名族</td>
            <td width="100"><%=Server.HtmlEncode(dr["pa_nation"].ToString())%></td>
            <td width="80" align="center" style="color:#111111;font-weight:bold">籍贯/住址</td>
            <td colspan="3"><%=Server.HtmlEncode(dr["pa_hometown"].ToString())%> <%=Server.HtmlEncode(dr["pa_homeaddress"].ToString())%></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td width="80" height="25" align="center" style="color:#111111;font-weight:bold">联系电话</td>
            <td width="100"><%=Server.HtmlEncode(dr["pa_tel"].ToString())%></td>
            <td width="80" align="center" style="color:#111111;font-weight:bold">手机</td>
            <td width="100"><%=Server.HtmlEncode(dr["pa_phone"].ToString())%></td>
            <td width="80" align="center" style="color:#111111;font-weight:bold">Email</td>
            <td width="100"><%=Server.HtmlEncode(dr["email"].ToString())%></td>

        </tr>
        <tr bgcolor="#ffffff">
            <td width="80" height="25" align="center" style="color:#111111;font-weight:bold">联系地址</td>
            <td align="left" colspan="5"><%=Server.HtmlEncode(dr["pa_address"].ToString())%></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td height="25" colspan="6"></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td width="80" height="25" align="center" style="color:#111111;font-weight:bold">学历</td>
            <td width="100"><%=dr["pa_xl"].ToString()%></td>
            <td width="80" height="25" align="center" style="color:#111111;font-weight:bold">毕业学校</td>
            <td width="100"><%=Server.HtmlEncode(dr["pa_graduateschool"].ToString())%></td>
            <td width="80" align="center" style="color:#111111;font-weight:bold">毕业时间</td>
            <td width="100"><%=((DateTime)dr["pa_graduationtime"]).ToString("yyyy-MM-dd")%></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td width="80" height="25" align="center" style="color:#111111;font-weight:bold">所学专业</td>
            <td width="100"><%=Server.HtmlEncode(dr["pa_professionalname"].ToString())%></td>
            <td width="80" align="center" style="color:#111111;font-weight:bold">外语水平</td>
            <td width="100"><%=Server.HtmlEncode(dr["pa_wysp"].ToString())%></td>
            <td width="80" align="center" style="color:#111111;font-weight:bold">计算机水平</td>
            <td width="100"><%=Server.HtmlEncode(dr["pa_computer"].ToString())%></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td height="25" colspan="6"></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td width="100" height="25" align="center" style="color:#111111;font-weight:bold;">自我评价</td>
            <td align="left" style="line-height:22px;" colspan="5"><%=Ubb(Server.HtmlEncode(dr["pa_zwpj"].ToString()))%></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td width="100" height="25" align="center" style="color:#111111;font-weight:bold;">工作经历</td>
            <td align="left" style="line-height:22px;" colspan="5"><%=Ubb(Server.HtmlEncode(dr["content"].ToString()))%></td>
        </tr>
    </tbody>
</table>
<%}%><%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>