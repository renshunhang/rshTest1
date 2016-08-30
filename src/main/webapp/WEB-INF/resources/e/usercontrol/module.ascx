<% @ Control Language="C#" Inherits="PageAdmin.module" %>
<%=Zdy_Location%>
<asp:Repeater id="List"  runat="server"  OnItemDataBound="Data_Bound">
<ItemTemplate><asp:PlaceHolder id="Holder" runat="server"/><asp:Label id="Lb_type" Text='<%#DataBinder.Eval(Container.DataItem,"thetable")%>' runat="server" Visible="false"/><asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" Visible="false"/><asp:Label id="Lb_ModelId" Text='<%#DataBinder.Eval(Container.DataItem,"model_id")%>' runat="server" Visible="false"/>
</ItemTemplate>
</asp:Repeater>