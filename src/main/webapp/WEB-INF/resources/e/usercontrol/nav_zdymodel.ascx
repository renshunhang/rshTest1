<% @ Control Language="C#" Inherits="PageAdmin.nav_zdymodel" %>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%><%if(Zdy_Tag==0 && CleanContainer<2){%>
<div id="nav_<%=Nav_Id%>" <%=Nav_box_style%>class="nav_box<%=Nav_ClassName%>">
<%if(CleanContainer==0){%><div <%=Nav_titlebox_style%>class="nav_title"><span <%=Nav_title_style%>class="nav_sign"><%=Nav_title%></span><span <%=Nav_more_style%>class="nav_more"><%=More_Url%></span></div>
<%}if(Nav_Header!=""){Response.Write(Nav_Header);}%><div id="nav_content_<%=Nav_Id%>" <%=Nav_content_style%>class="nav_content">
<%}%><%conn.Open();%>{pa:Model_Content}<%conn.Close();%>
<%if(Zdy_Tag==0 && CleanContainer<2){%></div>
</div><%}%>