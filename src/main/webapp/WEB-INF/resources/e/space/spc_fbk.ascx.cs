using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Text;
using System.Text.RegularExpressions;
namespace PageAdmin
 {
  public class spc_fbk:UserControl
  {
   protected Label Lb_CurrentLoginName,Lb_PageSize;
   protected Panel P1,P2,P_Page;
   protected Repeater Plist;
   protected string UserName,UID,Current_LoginName;
   protected int PageSize,RecordCount,PageCount,CurrentPage;
   OleDbConnection conn;
   int SiteId;
   string sql;
   protected void Page_Load(Object sender,EventArgs e)
    {
       Conn Myconn=new Conn();
       conn=Myconn.OleDbConn();
       UID=Request.QueryString["uid"];
       PageSize=int.Parse(Lb_PageSize.Text);
       if(IsNum(Request.QueryString["page"]))
         {
           CurrentPage=int.Parse(Request.QueryString["page"]);
         }
       else
         {
          CurrentPage=1;
         }
       if(!Page.IsPostBack)
        {
         conn.Open();
         if(IsNum(Request.QueryString["uid"]))
          {
            UID=Request.QueryString["uid"];
            Get_UserName();
           switch(Request.Form["post"])
           {
             case null:
               Check_IsMember();
               Tongji();
               List_Bind();
             break;

             case "feedback":
               Check_Post();
               Post_Fbk();
             break;  
 
             case "login":
              Check_Post();
              MLogin();
             break; 

            case "delete":
              Check_Post();
              Del_Fbk();
            break; 
           }
         conn.Close();
        }
      }
    }


private void Check_IsMember()
 {
     if(Request.Cookies["Member"]==null)
      {
        P2.Visible=true;
      }
     else
      {
        Member_Valicate Member=new Member_Valicate();
        Member.Member_Check();
        Current_LoginName=Member._UserName;
        Lb_CurrentLoginName.Text=Current_LoginName;
        P1.Visible=true;
      }
 }

private void Get_UserName()
 {
  UserName="";
  sql="select username from pa_member where id="+UID;
  OleDbCommand comm=new OleDbCommand(sql,conn);
  OleDbDataReader dr=comm.ExecuteReader();
  if(dr.Read())
   {
     UserName=dr["username"].ToString();
   }
   dr.Close();
 }

private void Tongji()
  { 
    if(UserName!="")
     {
     sql="select count(id) as co from pa_spcfbk where space_owner ='"+UserName+"'";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr= comm.ExecuteReader();
     if(dr.Read())
      {
      RecordCount=int.Parse(dr["co"].ToString());
      }
     else
      {
      RecordCount=0;
      }
     dr.Close();
     if(RecordCount%PageSize==0)
       {
        PageCount=RecordCount/PageSize;
       }
       else
       {
       PageCount=RecordCount/PageSize+1;
       }
    }
  }


protected void List_Bind()
   {
     if(UserName!="")
     {
     sql="select * from pa_spcfbk where space_owner ='"+UserName+"' order by id desc";
     if(CurrentPage>PageCount)
      {
        CurrentPage=PageCount;
      }
     if(CurrentPage<1)
      {
        CurrentPage=1;
      }
     if(PageCount<2)
      {
        P_Page.Visible=false;
      }
     DataSet ds=new  DataSet(); 
     OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
     myAdapter.Fill(ds,(CurrentPage-1)*PageSize,PageSize,"default");
     Plist.DataSource =ds.Tables["default"].DefaultView;
     Plist.DataBind();
    }
   }

private void Post_Fbk()
 {
   string Fbk_Content=Request.Form["fb_content"];
   if(Fbk_Content.Trim()=="")
    {
      conn.Close();
      Response.Write("<script type='text/javascript'>alert('留言内容不能为空!');location.href=location.href</script>");
      Response.End();
    }
   else
    {
      Member_Valicate Member=new Member_Valicate();
      Member.Member_Check();
      Fbk_Content=ResplayJs(Fbk_Content);
      Current_LoginName=Request.Form["Current_LoginName"];
      if(IsUserName(Current_LoginName))
       {
         sql="insert into pa_spcfbk(space_owner,fbk_username,feedback,reply) values('"+UserName+"','"+Sql_Format(Current_LoginName)+"','"+Sql_Format(Fbk_Content)+"','')";
         OleDbCommand Comm=new  OleDbCommand(sql,conn);
         Comm.ExecuteNonQuery();
        }
      conn.Close();
      Response.Write("<script type='text/javascript'>alert('提交成功!');location.href=location.href</script>");
      Response.End();
    }
 }

private void  Del_Fbk()
 {
   string Did=Request.Form["did"];
   if(IsNum(Did))
    {
     Member_Valicate Member=new Member_Valicate();
     Member.Member_Check();
     sql="delete from pa_spcfbk where space_owner='"+UserName+"' and id="+int.Parse(Did);
     OleDbCommand Comm=new  OleDbCommand(sql,conn);
     Comm.ExecuteNonQuery();
     conn.Close();
    }
   conn.Close();
   Response.Write("<script type='text/javascript'>location.href=location.href</script>");
   Response.End();
 }

private void  MLogin()
 {
   string LoginName=Request.Form["fb_username"];
   string LoginPass=Request.Form["fb_pass"];
   if(!IsUserName(LoginName) || LoginPass=="")
    {
      conn.Close();
      Response.Write("<script type='text/javascript'>alert('用户名或密码输入错误!');location.href=location.href</script>");
      Response.End();
      return;
    }
   else
    {
     Md5 Jm=new Md5();
     LoginPass=Jm.Get_Md5(LoginPass);
     sql="select id from pa_member where username='"+LoginName+"' and userpassword='"+LoginPass+"' and checked=1";
     OleDbCommand Comm=new  OleDbCommand(sql,conn);
     OleDbDataReader dr=Comm.ExecuteReader();
     if(dr.Read())
     {
       Build_Cookie(dr["id"].ToString());
       dr.Close();
       conn.Close();
       Response.Write("<script type='text/javascript'>location.href=location.href</script>");
       Response.End();
     }
    else
     {
      dr.Close();
      conn.Close();
      Response.Write("<script type='text/javascript'>alert('用户名或密码输入错误!');location.href=location.href</script>");
      Response.End();
     }
     dr.Close();
    }
 }

protected string Get_TrueName(string UserName)
 {
     string TrueName="";
     sql="select truename from pa_member where username='"+UserName+"'";
     OleDbCommand Comm=new  OleDbCommand(sql,conn);
     OleDbDataReader dr=Comm.ExecuteReader();
     if(dr.Read())
     {
      TrueName=dr["truename"].ToString();
     }
    dr.Close();
    if(TrueName=="")
     {
      TrueName=UserName;
     }
   return TrueName;
 }

private void  Build_Cookie(string Uid)
 {
     DateTime LoginDate=DateTime.Now;
     Random r=new Random();
     string LoginKey=LoginDate.AddSeconds(r.Next(1,2592000)).ToString("yyMMddHHmmss")+Guid.NewGuid().ToString("N");
     Md5 Jm=new Md5();
     HttpCookie MCookie=new HttpCookie("Member");
     MCookie.Values.Add("UID",Uid);
     MCookie.Values.Add("Valicate",Jm.Get_Md5(LoginKey));
     Response.AppendCookie(MCookie); 
     Update_Member(UserName,LoginDate,LoginKey); 
 }

private void Update_Member(string UserName,DateTime LoginDate,string LoginKey)
 {
   string Lst_Ip=GetClientIP();
   sql="update pa_member set login_key='"+LoginKey+"',lastdate='"+LoginDate+"',lst_ip='"+Lst_Ip+"',logins=logins+1 where username='"+UserName+"'";
   OleDbCommand Comm=new  OleDbCommand(sql,conn);
   Comm.ExecuteNonQuery();
 }

protected string GoPage(int Page)
 {
  string Rv;
   Rv="/e/space/?s="+SiteId+"&username="+UserName+"&type=fbk&page="+Page.ToString();
  return Rv;
 }

protected void Data_Bound(Object sender,RepeaterItemEventArgs e)
 { 
 if (e.Item.ItemType   ==   ListItemType.Item   ||   e.Item.ItemType   ==   ListItemType.AlternatingItem) 
    { 
      PlaceHolder P1=(PlaceHolder)e.Item.FindControl("p_control");
      PlaceHolder P2=(PlaceHolder)e.Item.FindControl("p_reply");
      Label lb_1=(Label)e.Item.FindControl("lb_reply");
      if(Lb_CurrentLoginName.Text==UserName)
       {
         P1.Visible=true;
       }
      if(lb_1.Text!="")
       {
         P2.Visible=true;
       }
    }
 }

private string GetClientIP()
  {
   if (HttpContext.Current==null) return "127.0.0.1";
   string clientIp=Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
   if (string.IsNullOrEmpty(clientIp))
   {
     clientIp=Request.ServerVariables["REMOTE_ADDR"];
   }
   if(string.IsNullOrEmpty(clientIp))
   {
     clientIp=Request.UserHostAddress;
   }
   if(clientIp.IndexOf(",")>0)
    {
      clientIp=clientIp.Split(',')[0];
    }
   if(!IsNum(clientIp.Replace(".","")))
    {
      clientIp="unknown";
    }
   return clientIp;
  }

private void Check_Post()
 {
    string PostUrl=Request.ServerVariables["HTTP_REFERER"];
    string LocalUrl=Request.ServerVariables["SERVER_NAME"];
    if(PostUrl!=null)
      {
         if(PostUrl.Replace("http://","").Split('/')[0].Split(':')[0]!=LocalUrl)
          {
             Response.Write("<script type='text/javascript'>alert('Invalid Submit');</script>");
             Response.End();
          }
      }
 }


private string ResplayJs(string html)
{
  System.Text.RegularExpressions.Regex regex1 = new System.Text.RegularExpressions.Regex(@"<script[\s\S] </script *>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
  System.Text.RegularExpressions.Regex regex2 = new System.Text.RegularExpressions.Regex(@" href *= *[\s\S]*script *:", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
  System.Text.RegularExpressions.Regex regex3 = new System.Text.RegularExpressions.Regex(@" no[\s\S]*=", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
  System.Text.RegularExpressions.Regex regex4 = new System.Text.RegularExpressions.Regex(@"<iframe[\s\S] </iframe *>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
  System.Text.RegularExpressions.Regex regex5 = new System.Text.RegularExpressions.Regex(@"<frameset[\s\S] </frameset *>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
  html = regex1.Replace(html, ""); //过滤<script></script>标记
  html = regex2.Replace(html, ""); //过滤href=javascript: (<A>) 属性
  html = regex3.Replace(html, " _disibledevent="); //过滤其它控件的on...事件
  html = regex4.Replace(html, ""); //过滤iframe
  html = regex5.Replace(html, ""); //过滤frameset
  return html;
}

protected string ubb(string str)
   {
   if(string.IsNullOrEmpty(str)){return "";}
    str=str.Replace("\r\n","<br>");
    str=str.Replace(" ","&nbsp;");
    return str;
   }

private string Sql_Format(string str)
 {
   if(string.IsNullOrEmpty(str)){return "";}
   string Res=str.Replace("'","''");
   Res=Res.Replace("\"","\""); 
   return Res;
 }

private bool IsUserName(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  Regex re = new Regex(@"[\u4e00-\u9fa5]+");
  str=re.Replace(str,"");
  if(str.Length==0){return true;}
  else{return IsStr(str);}
 }

private bool IsStr(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="abcdefghijklmnopqrstuvwxyz0123456789_";
  string str2=str.ToLower();;
  for(int i=0;i<str2.Length;i++)
   {
    if(str1.IndexOf(str2[i])==-1)
     {
       return false;
     }
   }
  return true;
 }

private bool IsNum(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  int rv=0;
  if(Int32.TryParse(str,out rv))
   {
    return true;  
   }
  else
   {
    return false;
   }
 }

 }
 }