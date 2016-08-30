<% @ Control  Language="C#" Inherits="PageAdmin.paform"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<tr id='tr_ljyd_title'><td class='tdhead'>姓名<span style='color:#ff0000'>*</span></td><td><input type=text name='title' id='title' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("title"));}%>"  maxlength="200"><span id="title_tip"></span></td></tr>
<tr id='tr_ljyd_pa_xingbie'><td class='tdhead'>性别<span style='color:#ff0000'>*</span></td><td><select name='pa_xingbie' id='pa_xingbie'   ><option value="男">男</option><option value="女">女</option></select><span id="pa_xingbie_tip"></span><%if(post=="add"){%><script type="text/javascript">Set_Selected("","pa_xingbie")</script><%}else{%><script type="text/javascript">Set_Selected("<%=r("pa_xingbie")%>","pa_xingbie")</script><%}%></td></tr><tr id='tr_ljyd_pa_youxiang'><td class='tdhead'>邮箱</td><td><input type=text name='pa_youxiang' id='pa_youxiang' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_youxiang"));}%>"  maxlength="200"><span id="pa_youxiang_tip"></span></td></tr>
<tr id='tr_ljyd_pa_shouji'><td class='tdhead'>手机<span style='color:#ff0000'>*</span></td><td><input type=text name='pa_shouji' id='pa_shouji' value="<%if(post=="add"){Response.Write("0");}else{Response.Write(r("pa_shouji"));}%>"  maxlength="200"><span id="pa_shouji_tip"></span></td></tr>
<tr id='tr_ljyd_content'><td class='tdhead' id='tr_ljyd_content'>备注<span style='color:#ff0000'>*</span></td><td><textarea name='content' id='content'  ><%if(post=="add"){Response.Write("");}else{Response.Write(r("content"));}%></textarea><span id="content_tip"></span></td></tr>

<input type='hidden' name='mustname' value='姓名,性别,手机,备注,'><input type='hidden' name='mustfield' value='title,pa_xingbie,pa_shouji,content,'><input type='hidden' name='musttype' value='text,select,text,textarea,'>
<script  type='text/javascript'>
function ljyd_zdycheck(){
return true;
}
</script>
<%End();%>






