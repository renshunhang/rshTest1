<% @ Control  Language="C#" Inherits="PageAdmin.paform"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<tr id='tr_member_email'><td class='tdhead'>邮箱<span style='color:#ff0000'>*</span></td><td><input type=text name='email' id='email' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("email"));}%>" style='height:18px;border:1px solid #cccccc;text-align:left;width:180px'  onblur='if(!IsEmail(Id("email").value)){Id("email_tip").innerHTML=" <span style=color:#ff0000>邮箱格式错误!</span>";Id("bt_post").disabled=true;}else{Id("email_tip").innerHTML="";Id("bt_post").disabled=false;}' maxlength='100' ><span id="email_tip"></span></td></tr>
<tr id='tr_member_mobile'><td class='tdhead'>手机号码<span style='color:#ff0000'>*</span></td><td><input type=text name='mobile' id='mobile' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("mobile"));}%>" style='height:18px;border:1px solid #cccccc;text-align:left;width:180px'  onblur='if(!IsMobile(Id("mobile").value)){Id("mobile_tip").innerHTML=" <span style=color:#ff0000>手机号码格式错误!</span>";Id("bt_post").disabled=true;}else{Id("mobile_tip").innerHTML="";Id("bt_post").disabled=false;}' maxlength='100' ><span id="mobile_tip"></span></td></tr>
<tr id='tr_member_truename'><td class='tdhead'>联系人<span style='color:#ff0000'>*</span></td><td><input type=text name='truename' id='truename' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("truename"));}%>" style='height:18px;border:1px solid #cccccc;text-align:left;width:180px'   maxlength='100' ><span id="truename_tip"></span></td></tr>
<tr id='tr_member_pa_tel'><td class='tdhead'>联系电话</td><td><input type=text name='pa_tel' id='pa_tel' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_tel"));}%>" style='height:18px;border:1px solid #cccccc;text-align:left;width:180px'   maxlength='100' ><span id="pa_tel_tip"></span></td></tr>
<tr id='tr_member_pa_fax'><td class='tdhead'>传真</td><td><input type=text name='pa_fax' id='pa_fax' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_fax"));}%>" style='height:18px;border:1px solid #cccccc;text-align:left;width:180px'   maxlength='100' ><span id="pa_fax_tip"></span></td></tr>
<tr id='tr_member_pa_qq'><td class='tdhead'>QQ号码</td><td><input type=text name='pa_qq' id='pa_qq' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_qq"));}%>" style='height:18px;border:1px solid #cccccc;text-align:left;width:180px'   maxlength='100' ><span id="pa_qq_tip"></span></td></tr>
<tr id='tr_member_pa_msn'><td class='tdhead'>MSN</td><td><input type=text name='pa_msn' id='pa_msn' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_msn"));}%>" style='height:18px;border:1px solid #cccccc;text-align:left;width:180px'   maxlength='100' ><span id="pa_msn_tip"></span></td></tr>
<tr id='tr_member_pa_address'><td class='tdhead'>联系地址</td><td><input type=text name='pa_address' id='pa_address' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_address"));}%>" style='height:18px;border:1px solid #cccccc;text-align:left;width:290px'   maxlength='100' ><span id="pa_address_tip"></span></td></tr>
<tr id='tr_member_pa_from'><td class='tdhead'>如何知道本站</td><td> <input type=radio value="百度"  name='pa_from' id='pa_from' <%if(post=="add"){Response.Write("百度"=="百度"?"checked":"");}else{Response.Write(r("pa_from")=="百度"?"checked":"");}%>>百度 <input type=radio value="google "  name='pa_from' id='pa_from' <%if(post=="add"){Response.Write("百度"=="google "?"checked":"");}else{Response.Write(r("pa_from")=="google "?"checked":"");}%>>google  <input type=radio value="朋友介绍  "  name='pa_from' id='pa_from' <%if(post=="add"){Response.Write("百度"=="朋友介绍  "?"checked":"");}else{Response.Write(r("pa_from")=="朋友介绍  "?"checked":"");}%>>朋友介绍   <input type=radio value="其他网站"  name='pa_from' id='pa_from' <%if(post=="add"){Response.Write("百度"=="其他网站"?"checked":"");}else{Response.Write(r("pa_from")=="其他网站"?"checked":"");}%>>其他网站<span id="pa_from_tip"></span></td></tr>
<input type='hidden' name='mustname' value='邮箱,手机号码,联系人,'><input type='hidden' name='mustfield' value='email,mobile,truename,'><input type='hidden' name='musttype' value='text,text,text,'>
<script  type='text/javascript'>
function pa_member_zdycheck(){
return true;
}
</script>
<%End();%>






