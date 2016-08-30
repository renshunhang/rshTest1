<% @ Control  Language="C#" Inherits="PageAdmin.patag"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
非常感谢您的留言，我们会对您所留言的意见或需求做出及时的处理，如果您需要回复或解决问题，请留下您
的详细联系方式，我们好安排专人为您服务；谢谢！<br />
<script type="text/javascript" src="/e/js/zdyform.js"></script>
<style type='text/css'>
.feedback_table{border:1px solid #eeeeee;width:99%;}
.feedback_table td{border:1px solid #eeeeee;padding:7px;}
.feedback_table td input{width:300px;height:28px;line-height:28px;border:#CCC 1px solid;}
.feedback_table td textarea{width:450px;height:100px;border:#CCC 1px solid;}
.feedback_table td #vcode{width:80px;}
.feedback_table td .bt{background:#DE0012;width:130px;height:36px;line-height:32px;border-radius:6px;font-size:16px;color:white;margin:0px 20px;}
.feedback_tablesj{display:none;}

</style>
<form name="feedback" method="post" Enctype="multipart/form-data" action="/e/aspx/post.aspx">
<table border=0 cellpadding=0 cellspacing=0  align=center class="feedback_table">
<tr><td align=right>分类&nbsp;&nbsp;</td><td><select name="sort" id="sort"><option value="0">选择分类</option><option value="555">咨询</option>
<option value="556">建议</option>
<option value="557">投诉</option>
<option value="558">其他</option>
</select></td></tr>
<tr><td align=right>留言标题 <span style="color:#ff0000">*</span></td><td><input type=text name="title" id="title" value=""  maxlength="50" ></td></tr>
<tr><td align=right>姓名 <span style="color:#ff0000">*</span></td><td><input type=text name="pa_truename" id="pa_truename" value="" maxlength="50" ></td></tr>
<tr><td align=right>电话 <span style="color:#ff0000">*</span></td><td><input type=text name="pa_tel" id="pa_tel" value="" maxlength="50" ></td></tr>
<tr><td align=right>邮箱&nbsp;&nbsp;</td><td><input type=text name="email" id="email" value=""onblur="if(!IsEmail(this.value)){alert('无效的邮件格式');document.letter.fbk_email.value=''}" maxlength="50" ></td></tr>
<tr><td align=right>留言内容 <span style="color:#ff0000">*</span></td><td><textarea name="content" id="content" ></textarea></td></tr>
<tr><td align=right>验证码<span style="color:#ff0000">*</span></td><td><input type=text name="vcode" id="vcode" maxlength=4 size=4> <img src="/e/aspx/yzm.aspx" onclick=Code_Change("vcode_img") align=absmiddle border=0 id="vcode_img" style="cursor:pointer" alt="点击更换"></td></tr>
<tr><td colspan=2 align=center><input type="hidden" name="checked" value="0"><input type="hidden" name="showcode" value="0"><input type="hidden" name="to" value=""><input type="hidden" name="mailto" value=""><input type="hidden" name="mailreply" value=""><input type="hidden" name="mailsubject" value=""><input type="hidden" name="mailbody" value=""><input type="hidden" name="insertdatabase" value="1"><input type="hidden" name="siteid" value="1"><input type="hidden" name="formtable" value="feedback"><input type="hidden" name="mustname" value="留言标题,姓名,电话,留言内容,"><input type="hidden" name="mustfield" value="title,pa_truename,pa_tel,content,"><input type="hidden" name="musttype" value="text,text,text,textarea,"><input type="button" class="bt" value=" 提交 " onclick="return set_feedback()"> <input type="reset" value=" 重设 " class="bt"></td></tr></table>
</form>
<script type="text/javascript">
function set_feedback()
{
document.forms["feedback"].mailto.value="";
document.forms["feedback"].mailreply.value="";
document.forms["feedback"].mailsubject.value="";
document.forms["feedback"].mailbody.value="";
return Check_ZdyForm("feedback");
}

function feedback_zdycheck(){
return true;
}
</script>
<%End();
if(PageCount>1)
{
string PageHtml="<div id=\"sublanmu_page\" class=\"sublanmu_page\">";
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