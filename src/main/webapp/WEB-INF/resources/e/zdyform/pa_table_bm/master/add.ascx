<% @ Control  Language="C#" Inherits="PageAdmin.paform"%>
<%Start();%>
<tr><td align=right class='tdhead'>标题 <span style='color:#ff0000'>*</span></td><td><input type=text name='title' id='title' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("title"));}%>" style=''  maxlength='150'></td></tr>
<tr><td align=right class='tdhead'>姓名&nbsp;&nbsp;&nbsp;</td><td><input type=text name='pa_name' id='pa_name' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_name"));}%>" style=''  maxlength='150'></td></tr>
<tr><td align=right class='tdhead'>标题图片&nbsp;&nbsp;&nbsp;</td><td><input ondblclick="if(this.value!='')window.open(this.value)" type=text name='titlepic' id='titlepic'  value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("titlepic"));}%>"  style=''  ><a id='upload_titlepic' href="javascript:open_upload('<%=SiteId%>','','image','pa_table_bm','titlepic','titlepic')"><img src='/e/images/icon/image.gif' border=0 height=16px hspace=2 alt='上传图片' align='absmiddle'></a></td></tr><tr><td align=right class='tdhead'>发布日期 <span style='color:#ff0000'>*</span></td><td><input type=text name='thedate' id='thedate' value="<%if(post=="add"){Response.Write(""==""?DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"):"");}else{Response.Write(DateTime.Parse(r("thedate")).ToString("yyyy-MM-dd HH:mm:ss"));}%>" style=''  maxlength='150'><a href="javascript:open_calendar('thedate',1)"><img src=/e/images/icon/date.gif border=0 height=20 hspace=2 align=absbottom></a></td></tr>
<tr><td colspan=2 align=center><input type='hidden' name='mustname' value='标题,发布日期,'><input type='hidden' name='mustfield' value='title,thedate,'><input type='hidden' name='musttype' value='text,text,'></td></tr>
<%End();%>






