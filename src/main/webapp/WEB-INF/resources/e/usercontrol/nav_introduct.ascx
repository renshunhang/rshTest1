<% @ Control Language="C#" Inherits="PageAdmin.nav_introduct" %>
<%if(CleanContainer<2){%><div id="nav_<%=Nav_Id%>" <%=Nav_box_style%>class="nav_box<%=Nav_ClassName%>"><%}%><%if(CleanContainer==0){%>
<div <%=Nav_titlebox_style%>class="nav_title"><span <%=Nav_title_style%>class="nav_sign"><%=Nav_title%></span><span <%=Nav_more_style%>class="nav_more"><%=More_Url%></span></div>
<%}if(Nav_Header!=""){Response.Write(Nav_Header);}%><%if(CleanContainer<2){%><div id="nav_conent_<%=Nav_Id%>" <%=Nav_content_style%>class="nav_content nav_content_introduct"><%}%>
<%=Nav_Content%><asp:PlaceHolder id="P_Zdy" runat="server"/>
<%if(CleanContainer<2){%></div></div><%}%>