<% @ Control  Language="C#" Inherits="PageAdmin.paform"%>
<%Start();%>
<tr><td align=right class='tdhead'>标题 <span style='color:#ff0000'>*</span></td><td><input type=text name='title' id='title' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("title"));}%>" style=''  maxlength='150'></td></tr>
<tr><td align=right class='tdhead'>邮箱 <span style='color:#ff0000'>*</span></td><td><input type=text name='fbk_email' id='fbk_email' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("fbk_email"));}%>" style=''  maxlength='150'></td></tr>
<tr><td align=right class='tdhead'>反馈内容 <span style='color:#ff0000'>*</span></td><td><textarea name='fbk_content' id='fbk_content' style=''  ><%if(post=="add"){Response.Write("");}else{Response.Write(r("fbk_content"));}%></textarea></td></tr>
<tr><td align=right class='tdhead'>发布日期 <span style='color:#ff0000'>*</span></td><td><input type=text name='thedate' id='thedate' value="<%if(post=="add"){Response.Write(""==""?DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"):"");}else{Response.Write(DateTime.Parse(r("thedate")).ToString("yyyy-MM-dd HH:mm:ss"));}%>" style=''  maxlength='150'><a href="javascript:open_calendar('thedate',1)"><img src=/e/images/icon/date.gif border=0 height=20 hspace=2 align=absbottom></a></td></tr>
<tr><td colspan=2 align=center><input type='hidden' name='mustname' value='标题,邮箱,反馈内容,发布日期,'><input type='hidden' name='mustfield' value='title,fbk_email,fbk_content,thedate,'><input type='hidden' name='musttype' value='text,text,textarea,text,'></td></tr>
<%End();%>






