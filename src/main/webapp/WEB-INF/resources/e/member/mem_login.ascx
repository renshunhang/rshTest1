<% @  Control Language="c#" Inherits="PageAdmin.mem_login"%>
<div class="current_location">
<ul><li class="current_location_1">当前位置：会员中心 &gt; 会员登陆</li>
<li class="current_location_2">会员登陆</li></ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<asp:PlaceHolder id="P1" runat="server" >

<div class="login_box">
<form method="post" name="pa_member">
<ul>
<li class="login_item_1">用户名： </li>
<li class="login_item_2">&nbsp;<input type="text" maxlength="16" class="m_tb m_tb_width" name="username" id="username"/>
</li>

<li class="login_item_jiange"></li>

<li class="login_item_1">密 码： </li>
<li class="login_item_2">&nbsp;<input type="password" maxlength="16" class="m_tb m_tb_width" name="password" id="password" /> <a href="<%=Get_Url("findpass")%>">忘记密码?</a>
</li>

<li class="login_item_jiange"></li>

<li class="login_item_1">验证码： </li>
<li class="login_item_2">&nbsp;<input type='textbox' name='vcode' class='m_tb' maxlength='4' style="width:50px">&nbsp;<img src='/e/aspx/yzm.aspx' onclick='Code_Change("logincode")' align=absmiddle border=0 id='logincode' style='cursor:pointer;height:20px'  alt='点击更换'>
</li>
<li class="login_item_jiange"></li>
<li class="login_item_jiange"><input type="hidden" name="login"  value="yes"><input type="hidden" name="To_Url" value="<%=Server.HtmlEncode(To_Url)%>"></li>
<li class="login_submit_box">&nbsp;<input type="submit"  value="登 录"  onclick="return login_check()" class="m_bt"></li>
<li class="login_reg_box"><input type="button" onclick="location.href='<%=Get_Url("reg")%>'" align="absmiddle" class="m_bt" value="注 册"></li>
<li class="clear"></li>
</ul>
</form>
</div>
</asp:PlaceHolder>

<asp:PlaceHolder id="P2" runat="server"  visible="false">
<div align=center style="line-height:25px;padding:10px 0px;">
<img src="/e/images/public/suc.gif" width="167" vspace="5"><br>
<asp:Label id="Lb_yzmerror" Visible="false" runat="server" Text="对不起，验证码输入错误，请返回重新输入。"/>
<asp:Label id="Lb_iuser" Visible="false" runat="server" Text="无效的用户名。"/>
<asp:Label id="Lb_nochecked" Visible="false" runat="server" Text="对不起，此用户还未通过审核。"/>
<asp:Label id="Lb_error" Visible="false" runat="server" Text="对不起，用户名或密码错误，请返回重新登陆。"/>
<div style="padding-top:10px"><input type="button" class="m_bt" value="返 回"  onclick="location.href='<%=Get_Url("login")%>'"></div>
<br><br>
</div>
</asp:PlaceHolder>

<asp:PlaceHolder id="P_Noact" runat="server"  visible="false"><form runat="server">
<div align=center style="line-height:25px;padding:10px 0px;">
<img src="/e/images/public/suc.gif" width="167" vspace="5"><br>
<asp:label id="lb_emailtishi" runat="server" text="对不起，此用户还未通过邮件验证，请到注册邮箱中查收邮件并按提示操作。"  /> 
<asp:label id="lb_emailerror"  runat="server" text="发送失败，邮箱格式错误。" visible="false" /> 
<asp:label id="lb_emailhasreged"  runat="server" visible="false">对不起，邮箱<font color=#ff0000><%=Email%></font>已经被注册，请更换一个邮箱重新发送。</asp:Label>
<asp:label id="lb_sendsuccess" runat="server" text="发送成功，请尽快查收验证邮件并按提示操作。" visible="false" /> 
<asp:label id="lb_sendfalse"  runat="server" text="发送失败，请更换一个邮箱重新发送、或联系客服人员。" visible="false" /> 
<asp:label id="lb_sendrepeat"  runat="server" text="请不要重复操作╰_╯，如有还未收到邮件请联系客服人员处理。" visible="false" /> 
<div style="display:<%=ShowChangeMail=="0"?"none":""%>">如未收到验证邮件，<a href='javascript:ShowChangeMail()' style='color:#ff0000;'>请点击这里重新发送</a>。</div>
<div id="ChangeMail" style="display:none">
<asp:TextBox Id="Bt_Email" runat="server" cssclass="m_tb"/> <asp:Button OnClick="ChangeActMail" Text="发 送" class="m_bt" runat="server"/>
</div>
<div style="padding-top:10px"><input type="button" class="m_bt" value="返 回"  onclick="location.href='<%=Get_Url("login")%>'"></div>
</div>
<asp:Label id="Lb_truename" Visible="false" runat="server" />
<asp:Label id="Lb_username" Visible="false" runat="server" />
<asp:Label id="Lb_password" Visible="false" runat="server" />
<asp:Label id="Lb_mailto" Visible="false" runat="server" />
<asp:Label id="Lb_vode" Visible="false" runat="server" />
</form>
<script type="text/javascript">
function ShowChangeMail()
 {
  document.getElementById("ChangeMail").style.display="";
 }
</script>
</asp:PlaceHolder>
</div>
</div>