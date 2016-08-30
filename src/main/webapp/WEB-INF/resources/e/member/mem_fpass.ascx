<% @  Control Language="c#" Inherits="PageAdmin.mem_fpass"%>
<div class="current_location">
<ul><li class="current_location_1">当前位置：会员中心 &gt; 找回密码</li>
<li class="current_location_2">会员登陆</li></ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<asp:PlaceHolder id="P1" runat="server" >
<div class="findpass_box">
<form method="post" name="pa_member">
<ul>
<li class="findpass_item_1">用户名： </li>
<li class="findpass_item_2">&nbsp;<input  type="text" size="20" maxlength="16" class="m_tb" name="username"   id="username"  />
</li>

<li class="findpass_item_jiange"></li>

<li class="findpass_item_1">注册邮箱： </li>
<li class="findpass_item_2">&nbsp;<input  type="text" size="20" maxlength="45" class="m_tb" name="email" id="email" /> 请填注册会员时所填的邮箱
</li>
<li class="login_item_jiange"></li>

<li class="login_item_1">验证码： </li>
<li class="login_item_2">&nbsp;<input type='textbox' name='vcode' class='m_tb' maxlength='4' style="width:50px">&nbsp;<img src='/e/aspx/yzm.aspx' onclick='Code_Change("logincode")' align=absmiddle border=0 id='logincode' style='cursor:pointer;height:20px'  alt='点击更换'>
</li>

<li class="findpass_item_jiange"></li>
<li class="findpass_item_jiange"></li>
<li class="findpass_submit_box"><input type="hidden" name="submit"  value="yes"><input type="submit"  value="找回密码"  onclick="return Find_Pass()" class="m_bt"></li>
<li class="findpass_tishi_box">忘记邮箱或用户名请联系客服人员</li>
 <li class="clear"></li>
</ul>
</form>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder id="P2" runat="server"  visible="false">
<div align=center>
<img src="/e/images/public/suc.gif" space="5"><br>
<asp:Label id="lb_nofind" runat="server" visible="false">对不起，用户名或邮箱填写错误（或填写的用户名和注册邮箱不匹配）。</asp:Label>
<asp:Label id="Lb_yzmerror" runat="server" visible="false">对不起，验证码填写错误，请返回重新输入。</asp:Label>
<asp:Label id="lb_admin" runat="server" visible="false">对不起，admin管理员请通过安装界面重设密码。</asp:Label>
<div style="padding-top:10px"><input type="button" class="m_bt" value="返 回"  onclick="location.href=location.href"></div>
<br><br>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder id="P3" runat="server"  visible="false">
<div align=center>
<img src=/e/images/public/suc.gif width="167px" vspace="5">
<br>您好，密码已经发送到您的注册邮箱(<%=SendResult=="1"?"邮件发送成功":"邮件发送失败"%>)，请查收!
<div style="padding-top:10px"><input type="button" class="m_bt" value="转到登录页面"  onclick="location.href='<%=GetUrl("login")%>'"></div>
<br><br>
</div>
</asp:PlaceHolder>
</div>
</div>