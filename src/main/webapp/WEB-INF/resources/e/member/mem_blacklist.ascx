<% @  Control Language="c#" Inherits="PageAdmin.mem_blacklist"%>
<div class="current_location">
<ul><li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 黑名单</li>
<li class="current_location_2">黑名单</li></ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li><a href='<%=Get_Url("mem_msg")%>'>收件箱</a></li>
 <li><a href='<%=Get_Url("mem_msgout")%>'>发件箱</a></li>
 <li><a href='<%=Get_Url("mem_msgsend")%>'>发信息</a></li>
 <li><a href='<%=Get_Url("mem_friends")%>'>我的好友</a></li>
 <li><a href='<%=Get_Url("mem_friendssort")%>'>好友分类</a></li>
 <li class="c"><a href='<%=Get_Url("mem_blacklist")%>'>黑名单</a></li>
</ul></div>
<form method="post">
<table border=0 cellpadding="5px" cellspacing=0  align=center class="member_table_1">
   <tr>
       <td>
       如果某用户被加入到黑名单中，那么该用户给您发送的消息将不会被接收。<br>
       多个用户添加到黑名单时需要用逗号(英文半角)分开，如“zhansan,lisi,wanger”。<br>
      <textarea name="Content" id="Content" cols="70" rows="5"><%=The_Content%></textarea>
      </td>
      </tr> 

     <tr>
      <td height=30px>
      <input type="hidden" value="save"  name="Submit" id="Submit">&nbsp;
      <input type="submit" value="保 存"  class="m_bt">&nbsp;
     </td>
    </tr>
   </table>
</form>

</div>
</div>
