<% @ Control Language="C#" Inherits="PageAdmin.sublanmu_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%=Zdy_Location%>
<div class="sublanmu_box sublanmu_box_<%=Sublanmu_Id%>">
<div class="sublanmu_content sublanmu_content_<%=Query_Table%>"><%=TheContent%><asp:PlaceHolder id="P_Search" Runat="server"/>
<%if(IsSearch==0){conn.Open();%><script src="/e/js/feedback.js" type="text/javascript"></script>
<form action="/e/aspx/post.aspx" method="post" enctype="multipart/form-data" name="feedback">
    <div class="feedback_box">
    <ul>
        <li style="float: left; width: 100px; height: 25px; text-align: right"><span style="color: #ff0000">*</span>留言主题：</li>
        <li style="float: left"><input class="f_tb" id="title" maxlength="50" size="55" name="title" type="text" /></li>
        <li style="clear: both; font-size: 1px; line-height: 0px; height: 2px">&nbsp;</li>

        <li style="float:left; width:100px;height:20px;text-align:right"><span style="color: #ff0000">*</span>Email：</li>
        <li style="float: left"><input class="f_tb" id="email" maxlength="30" name="email" type="text" size="15"/></li>

        <li style="float: left">&nbsp;联系人：<input class="f_tb" id="pa_truename" maxlength="30" size="10" name="pa_truename" type="text" /></li>
        <li style="float: left">&nbsp;电话：<input class="f_tb" id="pa_tel" maxlength="30" size="12" name="pa_tel" type="text" /></li>


        <li style="clear: both; font-size:1px; line-height:0px;height: 2px">&nbsp;</li>
        <li style="float: left; margin: 30px 0px 0px; width: 100px; text-align: right"><span style="color: #ff0000">*</span>留言：</li>
        <li style="float: left; padding-bottom: 5px; padding-top: 5px"><textarea id="content"  name="content" rows="5" cols="70" onblur="if(this.value.length&gt;250)this.value=this.value.substr(0,250)" class="f_tb" ></textarea> <span style="color: #ff0000">*</span></li>
        <li style="clear: both; font-size: 1px; line-height: 0px; height: 2px">&nbsp;</li>
        <li style="float: left; width: 100px; height: 20px; text-align: right"><span style="color: #ff0000">*</span>验证码：</li>
        <li style="float: left"><input class="f_tb" id="vcode" maxlength="4" size="4" name="vcode" type="text" /><img id="vcode_img" alt="点击更换" hspace="2" align="absMiddle" border="0" onclick="Code_Change('vcode_img')" style="cursor: pointer" src="/e/aspx/yzm.aspx" /></li>
        <li style="clear: both;font-size: 1px; line-height:0px; height:2px">&nbsp;</li>
        <li style="clear: both;padding:5px 0 5px 95px"><input type="radio" checked="checked" name="sort" value="555" />咨询 &nbsp; <input type="radio" name="sort" value="556" />建议 &nbsp;<input type="radio" name="sort" value="557" />投诉 &nbsp; <input type="radio" name="sort" value="558" />其他&nbsp; <input class="button" type="submit" onclick="return set_feedback()" value=" 提交 " /> <input class="button" type="reset" value=" 重设 " /></li>
    </ul>
    </div>
    <input type="hidden" name="checkyzm" value="1" /> <input type="hidden" name="checked" value="0" /> <input type="hidden" name="to" /> <input type="hidden" name="mailto" /> <input type="hidden" name="mailreply" /> <input type="hidden" name="mailsubject" /> <input type="hidden" name="mailbody" /> <input type="hidden" name="sendmail" value="0" /> <input type="hidden" name="insertdatabase" value="1" /> <input type="hidden" name="siteid" value="1" /> <input type="hidden" name="formtable" value="feedback" />
</form>
<script type="text/javascript">
function set_feedback()
{
document.forms["feedback"].mailto.value="";
document.forms["feedback"].mailreply.value="";
document.forms["feedback"].mailsubject.value="";
document.forms["feedback"].mailbody.value="";
return Check_Feedback();
}
</script>

<!---留言列表区--->
<div class="feedbacklist_box">
<% 
int i,k;
DataTable dt,dt1;
DataRow dr,dr1;
dt=Get_Data();
for(i=0;i<dt.Rows.Count;i++)
 {
  dr=dt.Rows[i]; //说明：给dr赋值
%>
<ul class="feedbacklist_item_box">

    <li style="float:left;height:20px;background:url(/e/images/public/face1.gif) no-repeat 0 0;padding:0 0 0 25px;">
<%=Sort_Name(int.Parse(dr["sort_id"].ToString()))%>：<%=Server.HtmlEncode(dr["title"].ToString())%></li>
        <li style="float:right;height:20px;"><%=dr["thedate"]%></li>
    <li class="feedbacklist_item_jiange"></li>

    <li style="padding:5px 10px 5px 10px"><%=Ubb(dr["content"].ToString())%></li>


<%
if(dr["reply_state"].ToString()=="1")
{
dt1=Get_Reply("feedback",int.Parse(dr["id"].ToString()));  
for(k=0;k<dt1.Rows.Count;k++)
 {
   dr1=dt1.Rows[k]; //说明：给dr赋值
%>
    <li class="feedbacklist_item_jiange"></li>
    <li style="float:left;height:20px;background:url(/e/images/public/face2.gif) no-repeat 0 0;padding:0 0 0 25px;color:#ff0000">回复</li>
    <li style="float:right;height:20px;"><%=dr1["thedate"].ToString()%></li>
    <li class="feedbacklist_item_jiange"></li>
    <li style="padding:5px 10px 5px 10px"><%=dr1["reply"].ToString()%></li>
<%
}
}

%>
</ul>
<%
}
%>
</div><%conn.Close();}
if(PageCount>1)
{
string PageHtml="<div class=\"sublanmu_page\">";
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
</div>
</div>