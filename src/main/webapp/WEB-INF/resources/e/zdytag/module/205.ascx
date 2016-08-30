<% @ Control  Language="C#" Inherits="PageAdmin.patag"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<div class="sy_anli">
<div class="sy_al_com">
<div class="sy_ac_tit">
<span class="title1">成功案例</span><div class="title2"><span class="ywwz">SUCCESSFUL CESES</span></div>
</div>
<div class="sy_ac_com">
<% @ Register TagPrefix="ascx" TagName="M_0" src="/e/zdymodel/article/module/153.ascx"%><ascx:M_0 runat="server" TagSiteId=1 SiteId=1 ZdyTag=1 ModuleId="205_0" TagTable="article" TagSortId=632 SqlOrder="order by " SqlCondition="" ShowNum=8 TagZtId=0 TitleNum=50 TitlePicWidth=150 TitlePicHeight=150 TheTarget="_self"/>
</div>
<div class="mk_more"><a href="/index.aspx?lanmuid=84&sublanmuid=708">更多案例</a></div>
</div>
</div>
<%End();%>