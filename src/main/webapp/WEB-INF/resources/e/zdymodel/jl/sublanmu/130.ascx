<% @ Control Language="C#" Inherits="PageAdmin.sublanmu_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%=Zdy_Location%>
<div class="sublanmu_box sublanmu_box_<%=Sublanmu_Id%>">
<div class="sublanmu_content sublanmu_content_<%=Query_Table%>"><%=TheContent%><asp:PlaceHolder id="P_Search" Runat="server"/>
<%if(IsSearch==0){conn.Open();%><script language="c#" Runat="server">
private bool IsNum(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="0123456789";
  for(int i=0;i<str.Length;i++)
   {
    if(str1.IndexOf(str[i])==-1)
     {
       return false;
     }
   }
  return true;
 }
</script>
<style type="text/css">
.yptable{border:1px solid #cccccc;border-collapse:collapse;}
.yptable td{border:1px solid #cccccc;padding:5px}
.yptable td input,.yptable td textarea{padding:2px 5px}
</style>
<script type='text/javascript' src='/e/js/calendar.js'></script><script type='text/javascript' src='/e/js/zdyform.js'></script>
<form action="/e/aspx/post.aspx" enctype="multipart/form-data" method="post" name="jl">
    <table width="100%" cellspacing="0"  align="center" class="yptable">
        <tbody>
            <tr>
                <td class="Name-title" align="right" width=100>应聘职位 <span style="color:#ff0000">*</span></td>
                <td>
<%if(IsNum(Request.QueryString["jobid"]))
{
 string jobname=Get_Data("title","select title from job where id="+Request.QueryString["jobid"]);
%>
<input type="text" maxlength="50" size="25" style="" value="<%=jobname%>" id="pa_position" name="pa_position" />
<%}else{
string JobList="";
DataTable dt=Get_Data("select title from job order by sort_id,thedate desc");
DataRow dr;
for(int i=0;i<dt.Rows.Count;i++)
 {
  dr=dt.Rows[i]; //说明：给dr赋值
  JobList+="<option value='"+dr["title"].ToString()+"'>"+dr["title"].ToString()+"</option>";
 }
%>
<select id="pa_position" name="pa_position">
<%=JobList%>
</select>
<%}%>
</td>
            </tr>
            <tr>
                <td class="Name-title" align="right">姓名 <span style="color:#ff0000">*</span></td>
                <td><input type="text" maxlength="50" size="25" style="" value="" id="title" name="title" /></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">性别 <span style="color:#ff0000">*</span></td>
                <td><input type="radio" name="pa_xb" checked="" value="男" />男 <input type="radio" name="pa_xb" value="女" />女</td>
            </tr>
            <tr>
                <td class="Name-title" align="right">出生年月 <span style="color:#ff0000">*</span></td>
                <td><input type="text" maxlength="50" style="" value="" id="pa_birthday" name="pa_birthday" /><a href="javascript:open_calendar('pa_birthday')"><img hspace="2" height="20" border="0" align="absbottom" src="/e/images/public/date.gif" alt="" /></a></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">身份证号 <span style="color:#ff0000">*</span></td>
                <td><input type="text" maxlength="50" size="25" style="" value="" id="pa_sfz" name="pa_sfz" /></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">民族 <span style="color:#ff0000">*</span></td>
                <td><input type="text" maxlength="50" size="25" style="" value="" id="pa_nation" name="pa_nation" /></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">政治面貌 <span style="color:#ff0000">*</span></td>
                <td><select name="pa_zzmm">
                <option value="普通公民">普通公民</option>
                <option value="共青团员 ">共青团员 </option>
                <option value="中共党员">中共党员</option>
                <option value="党外人士">党外人士</option>
                <option value="港澳同胞">港澳同胞</option>
                </select></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">婚姻状况 <span style="color:#ff0000">*</span></td>
                <td><select name="pa_marriage">
                <option value="未婚">未婚</option>
                <option value="已婚">已婚</option>
                </select></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">籍贯 <span style="color:#ff0000">*</span></td>
                <td><select name="pa_hometown">
                <option value="北京">北京</option>
                <option value="上海">上海</option>
                <option value="天津">天津</option>
                <option value="重庆">重庆</option>
                <option value="广东">广东</option>
                <option value="浙江">浙江</option>
                <option value="福建">福建</option>
                <option value="安徽">安徽</option>
                <option value="广西">广西</option>
                <option value="云南">云南</option>
                <option value="贵州">贵州</option>
                <option value="四川">四川</option>
                <option value="湖北">湖北</option>
                <option value="湖南">湖南</option>
                <option value="海南">海南</option>
                <option value="江苏">江苏</option>
                <option value="江西">江西</option>
                <option value="陕西">陕西</option>
                <option value="山东">山东</option>
                <option value="山西">山西</option>
                <option value="河北">河北</option>
                <option value="河南">河南</option>
                <option value="黑龙江">黑龙江</option>
                <option value="辽宁">辽宁</option>
                <option value="吉林">吉林</option>
                <option value="宁夏">宁夏</option>
                <option value="青海">青海</option>
                <option value="西藏">西藏</option>
                <option value="新疆">新疆</option>
                <option value="内蒙古">内蒙古</option>
                <option value="甘肃">甘肃</option>
                <option value="香港">香港</option>
                <option value="台湾">台湾</option>
                <option value="澳门">澳门</option>
                </select></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">家庭住址 <span style="color:#ff0000">*</span></td>
                <td><input type="text" maxlength="50" size="50" style="" value="" id="pa_homeaddress" name="pa_homeaddress" /></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">学历&nbsp;&nbsp;</td>
                <td><select name="pa_xl">
                <option value="博士后">博士后</option>
                <option value="博士">博士</option>
                <option value="硕士">硕士</option>
                <option value="本科">本科</option>
                <option value="专科">专科</option>
                <option value="中技">中技</option>
                <option value="职高">职高</option>
                <option value="高中">高中</option>
                <option value="初中级以下">初中级以下</option>
                </select></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">毕业学校 <span style="color:#ff0000">*</span></td>
                <td><input type="text" maxlength="50" size="25" style="" value="" id="pa_graduateschool" name="pa_graduateschool" /></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">专业名称 <span style="color:#ff0000">*</span></td>
                <td><input type="text" maxlength="50" size="25" style="" value="" id="pa_professionalname" name="pa_professionalname" /></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">毕业时间 <span style="color:#ff0000">*</span></td>
                <td><input type="text" maxlength="50" style="" value="" id="pa_graduationtime" name="pa_graduationtime" /><a href="javascript:open_calendar('pa_graduationtime')"><img hspace="2" height="20" border="0" align="absbottom" src="/e/images/public/date.gif" alt="" /></a></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">外语水平 <span style="color:#ff0000">*</span></td>
                <td><input type="text" maxlength="50" size="25" style="" value="" id="pa_wysp" name="pa_wysp" /></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">计算机水平 <span style="color:#ff0000">*</span></td>
                <td><input type="text" maxlength="50" size="25" style="" value="" id="pa_computer" name="pa_computer" /></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">期望月薪 <span style="color:#ff0000">*</span></td>
                <td><select name="pa_expectationssalary">
                <option value="1000-2000元">1000-2000元</option>
                <option value="2000-3000元">2000-3000元</option>
                <option value="3000-5000元">3000-5000元</option>
                <option value="5000-8000元">5000-8000元</option>
                <option value="8000-1万元">8000-1万元</option>
                <option value="面谈">面谈</option>
                </select></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">联系电话 <span style="color:#ff0000">*</span></td>
                <td><input type="text" maxlength="50" size="25" style="" value="" id="pa_tel" name="pa_tel" /></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">手机 <span style="color:#ff0000">*</span></td>
                <td><input type="text" maxlength="50" size="25" style="" value="" id="pa_phone" name="pa_phone" /></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">邮箱 <span style="color:#ff0000">*</span></td>
                <td><input type="text" maxlength="50" size="25" style="" value="" id="email" name="email" /></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">通讯地址 <span style="color:#ff0000">*</span></td>
                <td><input type="text" maxlength="50" size="50" style="" value="" id="pa_address" name="pa_address" /></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">自我评价 <span style="color:#ff0000">*</span></td>
                <td><textarea rows="10" cols="80" style="" id="pa_zwpj" name="pa_zwpj"></textarea></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">工作经历 <span style="color:#ff0000">*</span></td>
                <td><textarea rows="10" cols="80" style="" id="content" name="content"></textarea></td>
            </tr>
            <tr>
                <td class="Name-title" align="right">验证码<span style="color:#ff0000">*</span></td>
                <td><input type="text" size="4" maxlength="4" id="vcode" name="vcode" /> <img border="0" align="absmiddle" alt="点击更换" style="cursor:pointer" id="vcode_img" onclick="Code_Change('vcode_img')" src="/e/aspx/yzm.aspx" /></td>
            </tr>
            <tr>
                <td align="center" colspan="2"><input type="hidden" value="0" name="checked" /><input type="hidden" value="0" name="showcode" /><input type="hidden" value="" name="to" /><input type="hidden" value="" name="mailto" /><input type="hidden" value="" name="mailreply" /><input type="hidden" value="" name="mailsubject" /><input type="hidden" value="" name="mailbody" /><input type="hidden" value="0" name="sendmail" /><input type="hidden" value="1" name="insertdatabase" /><input type="hidden" value="1" name="siteid" /><input type="hidden" value="jl" name="formtable" /><input type="hidden" value="应聘职位,姓名,性别,出生年月,身份证号,民族,政治面貌,婚姻状况,籍贯,家庭住址,毕业学校,专业名称,毕业时间,外语水平,计算机水平,期望月薪,联系电话,手机,邮箱,通讯地址,自我评价,工作经历," name="mustname" /><input type="hidden" value="pa_position,title,pa_xb,pa_birthday,pa_sfz,pa_nation,pa_zzmm,pa_marriage,pa_hometown,pa_homeaddress,pa_graduateschool,pa_professionalname,pa_graduationtime,pa_wysp,pa_computer,pa_expectationssalary,pa_tel,pa_phone,email,pa_address,pa_zwpj,content," name="mustfield" /><input type="hidden" value="text,text,radio,text,text,text,select,select,select,text,text,text,text,text,text,select,text,text,text,text,textarea,textarea," name="musttype" /><input type="button" onclick="return set_jl()" value=" 提交 " class="bt" /> <input type="reset" class="bt" value=" 重设 " /></td>
            </tr>
        </tbody>
    </table>
</form>
<script type="text/javascript">
function set_jl()
{
document.forms["jl"].mailto.value="";
document.forms["jl"].mailreply.value="";
document.forms["jl"].mailsubject.value="";
document.forms["jl"].mailbody.value="";
return Check_ZdyForm("jl");
}

function jl_zdycheck(){
return true;
}
</script><%conn.Close();}
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