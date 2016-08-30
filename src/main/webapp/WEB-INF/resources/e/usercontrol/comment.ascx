<% @ Control Language="C#" Inherits="PageAdmin.comment"%>
<script type="text/javascript" src="/e/js/<%=Language%>/comments.js"></script>
<div class="comments_box"><a name="comments" style="display:none"></a>
<ul><form method="post">
<li class="title"><span id="c_title_sign">发布评论</span></li>
<li><div id="c_quote_tips" style="display:none"></div><textarea id="c_content" class="textarea"></textarea></li>
<li>
<%if(Comment_Anonymous=="1"){%><span id="c_anonymous_box" style="display:none">
<span id="c_user_sign">用户：</span><input type="textbox" id="c_user"  maxlength="10" size="12" class="tb">
<span id="c_yzm_sign">验证码：</span><input type='textbox' id="c_yzm" size="5" maxlength='4' class="tb">&nbsp;<img src='/e/aspx/yzm.aspx' onclick="Code_Change('c_yzmcode')" align=absmiddle border=0 id="c_yzmcode" style='cursor:pointer;height:20px'>
</span><%}%>
<span id="c_member_box" style="display:none">
<span id="c_username_sign">用户名：</span><input type="textbox" id="c_username" maxlength="16" size="12" class="tb">&nbsp;<span id="c_pass_sign">密码：</span><input type="password" id="c_password" maxlength="20" size="12" class="tb">
</span>
<%if(Comment_Anonymous=="1"){%>
<input type="checkbox" id="c_anonymous" value="1" checked onclick="c_type(this.checked)"><span id="c_anonymous_sign">匿名</span>&nbsp;<%}%>
&nbsp;<input type="button" id="c_submit" class="button" onclick="return check_comments()" value="提交"/>
</li>
<input type="hidden" id="c_quote" value="">
<input type="hidden" id="c_siteid" value="<%=Site_Id%>">
<input type="hidden" id="c_detailid" value="<%=Detail_Id%>">
<input type="hidden" id="c_table" value="<%=Thetable%>">
<input type="hidden" id="c_checked" value="<%=Comment_Checked%>">
</form>
</ul>
</div>
<div><ul>
<li class="comments_list" id="comments_list">loading...</li>
<li class="comments_page" id="comments_page"></li>
</ul></div>
<script type="text/javascript">
var c_anonymous_box=document.getElementById("c_anonymous_box");
var c_member_box=document.getElementById("c_member_box");
var Comment_MaxLength=<%=Comment_MaxLength%>;
var Comment_TimeLimit=<%=Comment_TimeLimit%>;<%if(Comment_Anonymous=="1"){%>
document.getElementById("c_anonymous").checked=true;
c_anonymous_box.style.display="";
<%}else{%>
c_member_box.style.display="";
<%}%>
function c_type(checked)
 {
  if(checked)
   {
    c_anonymous_box.style.display="";
    c_member_box.style.display="none";
   }
  else
   {
    c_anonymous_box.style.display="none";
    c_member_box.style.display="";
   }
 }
Load_Comments("<%=Thetable%>","<%=Detail_Id%>",1,false);
</script>