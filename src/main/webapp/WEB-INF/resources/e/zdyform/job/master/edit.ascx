<% @ Control  Language="C#" Inherits="PageAdmin.paform"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<tr id='tr_job_title'><td class='tdhead'>职位名称<span style='color:#ff0000'>*</span></td><td><input type=text name='title' id='title' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("title"));}%>"  maxlength="200"><span id="title_tip"></span></td></tr>
<tr id='tr_job_pa_xz'><td class='tdhead'>薪资待遇</td><td><select name='pa_xz' id='pa_xz'   ><option value="面议">面议</option><option value="1000元以下">1000元以下</option><option value="1000-2000元">1000-2000元</option><option value="2000-3000元">2000-3000元</option><option value="3000-5000元">3000-5000元</option><option value="5000-8000元">5000-8000元</option><option value="8000-12000元">8000-12000元</option><option value="12000-20000元">12000-20000元</option><option value="20000-25000元">20000-25000元</option><option value="25000元以上">25000元以上</option></select><span id="pa_xz_tip"></span><%if(post=="add"){%><script type="text/javascript">Set_Selected("","pa_xz")</script><%}else{%><script type="text/javascript">Set_Selected("<%=r("pa_xz")%>","pa_xz")</script><%}%></td></tr><tr id='tr_job_pa_xueli'><td class='tdhead'>学历要求</td><td><select name='pa_xueli' id='pa_xueli'   ><option value="不限">不限</option><option value="高中">高中</option><option value="技校">技校</option><option value="中专">中专</option><option value="大专">大专</option><option value="本科">本科</option><option value="硕士">硕士</option><option value="博士">博士</option></select><span id="pa_xueli_tip"></span><%if(post=="add"){%><script type="text/javascript">Set_Selected("","pa_xueli")</script><%}else{%><script type="text/javascript">Set_Selected("<%=r("pa_xueli")%>","pa_xueli")</script><%}%></td></tr><tr id='tr_job_pa_nianxian'><td class='tdhead'>工作年限</td><td><select name='pa_nianxian' id='pa_nianxian'   ><option value="不限">不限</option><option value="1年以下">1年以下</option><option value="1-2年">1-2年</option><option value="3-5年">3-5年</option><option value="6-7年">6-7年</option><option value="8-10年">8-10年</option><option value="10年以上">10年以上</option></select><span id="pa_nianxian_tip"></span><%if(post=="add"){%><script type="text/javascript">Set_Selected("","pa_nianxian")</script><%}else{%><script type="text/javascript">Set_Selected("<%=r("pa_nianxian")%>","pa_nianxian")</script><%}%></td></tr><tr id='tr_job_pa_num'><td class='tdhead'>招聘人数<span style='color:#ff0000'>*</span></td><td><input type=text name='pa_num' id='pa_num' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_num"));}%>" onkeyup="if(isNaN(value))execCommand('undo')"  onblur="$('pa_num').value=Trim($('pa_num').value)" maxlength="200"><span id="pa_num_tip"></span></td></tr>
<tr id='tr_job_pa_place'><td class='tdhead'>工作地点<span style='color:#ff0000'>*</span></td><td><input type=text name='pa_place' id='pa_place' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_place"));}%>"  maxlength="200"><span id="pa_place_tip"></span></td></tr>
<tr id='tr_job_pa_gwyq'><td class='tdhead' id='tr_job_pa_gwyq'>岗位要求<span style='color:#ff0000'>*</span></td><td><textarea name='pa_gwyq' id='pa_gwyq' cols="80"  rows="15" ><%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_gwyq"));}%></textarea><span id="pa_gwyq_tip"></span></td></tr>
<tr id='tr_job_content'><td class='tdhead' id='tr_job_content'>工作内容<span style='color:#ff0000'>*</span></td><td><textarea name='content' id='content' cols="80"  rows="15" ><%if(post=="add"){Response.Write("");}else{Response.Write(r("content"));}%></textarea><span id="content_tip"></span></td></tr>
<tr id='tr_job_thedate'><td class='tdhead'>发布日期<span style='color:#ff0000'>*</span></td><td><input type=text name='thedate' id='thedate' value="<%if(post=="add"){Response.Write(""==""?DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"):"");}else{Response.Write(DateTime.Parse(r("thedate")).ToString("yyyy-MM-dd HH:mm:ss"));}%>"  maxlength="200"><a href="javascript:open_calendar('thedate',1)"><img src=/e/images/icon/date.gif border=0 height=20 hspace=2 align=absbottom></a><span id="thedate_tip"></span></td></tr>

<input type='hidden' name='mustname' value='职位名称,招聘人数,工作地点,岗位要求,工作内容,发布日期,'><input type='hidden' name='mustfield' value='title,pa_num,pa_place,pa_gwyq,content,thedate,'><input type='hidden' name='musttype' value='text,text,text,textarea,textarea,text,'>
<script  type='text/javascript'>
function job_zdycheck(){
return true;
}
</script>
<%End();%>






