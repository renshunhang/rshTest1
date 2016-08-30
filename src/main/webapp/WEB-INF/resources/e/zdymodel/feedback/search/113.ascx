<% @ Control Language="C#" Inherits="PageAdmin.search_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<asp:PlaceHolder id="P_Head" runat="server"><div class="main_box main_box_style"><div class="main_box_inner">
<%=Zdy_Location%>
<div class="sublanmu_box">
<div class="sublanmu_content"></asp:PlaceHolder>
<%conn.Open();%><% 
DataTable dt=Get_Data(); 
DataRow dr; 
if(dt.Rows.Count>0)
{
dr=dt.Rows[0]; //说明：给dr赋值
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="letterinfo">
    <tr class="head">
      <td colspan="2" align="center"><b>信件处理结果</b></td>
    </tr>
    <tr>
      <td align="right" width="100px">信件编号：</td>
      <td><%=dr["code"]%></td>
    </tr>
    <tr>
      <td align="right">信件类型：</td>
      <td><%=dr["pa_type"]%></td>
    </tr>
    <tr>
      <td align="right">来信时间：</td>
      <td><%=((DateTime)dr["thedate"]).ToString("yyyy-MM-dd")%></td>
    </tr>
    <tr>
      <td align="right">信件主题：</td>
      <td><%=Server.HtmlEncode(dr["title"].ToString())%></td>
    </tr>

    <tr>
      <td align="right">信件内容：</td>
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
dt=Get_Data("select * from pa_reply where thetable='letter' and detail_id="+dr["id"].ToString()+" order by thedate desc");  
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
%><%conn.Close();
if(PageCount>1)
{
 string PageHtml="<div class=\"sublanmu_page search_zdymodel_page\">";
 if(CurrentPage==1)
 {
 if(APage_LinkText[0]!=""){PageHtml+="<span class=\"firstpage\">"+APage_LinkText[0]+"</span>";} //首页
 }
 else if(CurrentPage>1)
 {
  if(APage_LinkText[0]!=""){PageHtml+="<a href=\""+GoPage(1)+"\" class=\"firstpage\">"+APage_LinkText[0]+"</a>";} //首页
  if(APage_LinkText[1]!=""){PageHtml+=" <a href=\""+GoPage(CurrentPage-1)+"\" class=\"prevpage\">"+APage_LinkText[1]+"</a>";} //上一页
 }
 int p=8; //表示开始时显示的页码总数
 int M=4; //超过p页后左右两边显示页码数
 int LastPage=1;
 if(CurrentPage<p)
  {
    LastPage=p;
    if(LastPage>PageCount)
     {
       LastPage=PageCount;
     }
    for(int i=1;i<=LastPage;i++)
    {
     if(CurrentPage==i)
      {
        PageHtml+=" <span class=\"c\">"+i.ToString()+"</span>";
      }
    else
      {
       PageHtml+=" <a href=\""+GoPage(i)+"\">"+i.ToString()+"</a>";
      }
    }
  }
 else
  {
    //PageHtml+=" <a href=\""+GoPage(CurrentPage-1)+"\">1...</a>";
    LastPage=CurrentPage+M;
    if(LastPage>PageCount)
     {
       LastPage=PageCount;
     }
    for(int i=(CurrentPage-M);i<=LastPage;i++)
    {
     if(CurrentPage==i)
      {
        PageHtml+=" <span class=\"c\">"+i.ToString()+"</span>";
      }
    else
      {
       PageHtml+=" <a href=\""+GoPage(i)+"\">"+i.ToString()+"</a>";
      }
    }

  }

if(CurrentPage<PageCount)
 {
  if(LastPage<PageCount)
   {
     PageHtml+=" <a href=\""+GoPage(LastPage+1)+"\">...</a>";
   }
  if(APage_LinkText[2]!=""){PageHtml+=" <a href=\""+GoPage(CurrentPage+1)+"\" class=\"nextpage\">"+APage_LinkText[2]+"</a>";}  //下一页
  if(APage_LinkText[3]!=""){PageHtml+=" <a href=\""+GoPage(PageCount)+"\" class=\"lastpage\">"+APage_LinkText[3]+"</a>";}     //尾页
 }
else if(CurrentPage==PageCount)
 {
 if(APage_LinkText[3]!=""){PageHtml+=" <span class=\"lastpage\">"+APage_LinkText[3]+"</span>";}     //尾页
 }
 if(Page_LinkInfo!=""){PageHtml+=" <span class=\"pageinfo\">"+String.Format(Page_LinkInfo,CurrentPage,PageCount,RecordCount)+"</span>";} //记录页次
 PageHtml+="</div>";
 Response.Write(PageHtml);
}%>
<asp:PlaceHolder id="P_Footer" runat="server"></div></div></div></div></asp:PlaceHolder>