<% @ Control  Language="C#" Inherits="PageAdmin.patag"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 考试报名1</li>
<li class="current_location_2">考试报名1</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<%Start();%>
<%=Site_Id%><br>
<%=UserName%><br>
<%=UID%><br>
<%=MemberTypeId%><br>
<%=DepartmentId%><br>

<%End();%>
</div>
</div>






