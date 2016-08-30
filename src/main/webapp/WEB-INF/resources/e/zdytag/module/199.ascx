<% @ Control  Language="C#" Inherits="PageAdmin.patag"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<div class="sy_xwdt_box">
  <div class="xwdt_left"><% @ Register TagPrefix="ascx" TagName="M_0" src="/e/zdymodel/article/module/148.ascx"%><ascx:M_0 runat="server" TagSiteId=1 SiteId=1 ZdyTag=1 ModuleId="199_0" TagTable="article" TagSortId=623 SqlOrder="order by " SqlCondition="and has_titlepic=1" ShowNum=1 TagZtId=0 TitleNum=50 TitlePicWidth=150 TitlePicHeight=150 TheTarget="_self"/></div>
  <div class="xwdt_right"><% @ Register TagPrefix="ascx" TagName="M_1" src="/e/zdymodel/article/module/149.ascx"%><ascx:M_1 runat="server" TagSiteId=1 SiteId=1 ZdyTag=1 ModuleId="199_1" TagTable="article" TagSortId=623 SqlOrder="order by " SqlCondition="" ShowNum=4 TagZtId=0 TitleNum=50 TitlePicWidth=150 TitlePicHeight=150 TheTarget="_self"/></div>
</div>
<div class="mk_more"><a href="/index.aspx?lanmuid=63&sublanmuid=547">更多新闻</a></div>
<%End();%>