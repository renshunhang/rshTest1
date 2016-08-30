<% @  Control Language="c#" Inherits="PageAdmin.mem_spcset"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 空间设置</li>
<li class="current_location_2">空间设置</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li><a href='<%=Get_Url("mem_mdy")%>'>个人资料</a></li>
 <li class="c"><a href='<%=Get_Url("mem_spcset")%>'>空间设置</a></li>
</ul></div>
<asp:PlaceHolder id="P1" runat="server">
<form method="post" name="pa_member" Enctype="multipart/form-data">
<table border="0" cellpadding=5 cellspacing=0  align=center class="member_table">
  <tr>
      <td class="tdhead">空间地址</td>
      <td><a href="/e/space/?s=<%=Request.QueryString["s"]%>&username=<%=UserName%>" target="myspace">/e/space/?uid=<%=UID%></a></a></td>
  </tr>

  <tr>
      <td class="tdhead">空间名称</td>
      <td><input type="text" id="space_title" name="space_title"  size="40" class="m_tb" value="<%=SpaceTitle%>"></td>
  </tr>

  <tr>
      <td class="tdhead">个人头像</td>
      <td>
   <input type="file" id="headimage" name="headimage" maxlength="50" size="30">图片建议尺寸:150px*150px
   <br><a href="<%=HeadImage%>" target="spc"><img src="<%=HeadImage%>" border="0" height="50px" vspace="5"></a>
   </td>
  </tr>

  <tr>
      <td class="tdhead">空间banner背景</td>
      <td>
       <input type="file" id="space_banner" name="space_banner" size="30" > 图片控制在500kb以内
      <br><a href="<%=SpaceBanner%>" target="spc"><img src="<%=SpaceBanner%>" border="0" height="50px" vspace="5"></a>
    </td>
  </tr>

  <tr>
      <td class="tdhead">空间简介</td>
      <td><textarea id="space_introduction" name="space_introduction" style="width:450px" rows="5"><%=SpaceIntroduction%></textarea></td>
  </tr>

  <tr>
      <td class="tdhead">个人简介</td>
      <td>
<textarea id="introduction" name="introduction" style="width:450px" rows="5"><%=Introduction%></textarea>
  </td>
  </tr>
</table>
<div align="center" style="padding:10px"><input name="post" type="hidden" value="edit"><input id="sub" type="submit" value="提 交" class="m_bt"></div>
</form>
</asp:PlaceHolder>
<asp:PlaceHolder id="P2" runat="server" visible="false">
<div align=center>
<img src=/e/images/public/suc.gif width="167px" vspace="5px">
<br>空间设置成功!  
<br><br><input type="button" class="m_bt" value="返 回"  onclick="location.href='<%=Get_Url("mem_spcset")%>'">
</div>
</asp:PlaceHolder>

</div>
</div>