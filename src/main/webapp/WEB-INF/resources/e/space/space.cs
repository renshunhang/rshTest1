using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Text.RegularExpressions;
namespace PageAdmin
 {
  public class space:Page
  {
   protected Repeater P_Menu;
   protected PlaceHolder P1,P2,P_UC;
   protected string Wz_Name,Wz_Bottom,LoginName,Login_Member_Type,msg_icon_show,UID,UserName,Member_Type,TrueName,Space_Clicks,Head_Image,Space_Banner,Space_Title,Space_Introduction,Introduction;
   OleDbConnection conn;
   int MType_Id,Department_Id;
   string sql;
   protected void Page_Load(Object sender,EventArgs e)
    {
      Conn Myconn=new Conn();
      conn=Myconn.OleDbConn();
      if(IsNum(Request.QueryString["uid"]))
       {
         conn.Open();
           Get_Member();
           Get_Permissions();
           Table_Bind();
           Get_Login();
         conn.Close();
         Load_Control();
       }
     else if(IsUserName(Request.QueryString["username"]))
       {
         Go_Uid();
       }
     else
       {
         Response.Write("<script type='text/javascript'>alert('Invalid username!');</script>");
         Response.End();
       }
    }

private void Get_Member()
 {
   UserName="";
   MType_Id=0;
   UID=Request.QueryString["uid"];
   sql="select id,username,mtype_id,department_id,space_title,space_introduction,introduction,truename,space_clicks,head_image,space_banner from pa_member where checked=1 and id="+UID;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
      UID=dr["id"].ToString();
      UserName=dr["username"].ToString();
      MType_Id=int.Parse(dr["mtype_id"].ToString());
      Department_Id=int.Parse(dr["department_id"].ToString());
      Space_Title=dr["space_title"].ToString();
      if(Space_Title=="")
       {
         Space_Title=UserName+"的空间";
       }
      Space_Introduction=ubb(dr["space_introduction"].ToString());
      Introduction=ubb(dr["introduction"].ToString());
      TrueName=dr["truename"].ToString();
      Space_Clicks=dr["space_clicks"].ToString();
      Head_Image=dr["head_image"].ToString();
      if(Head_Image=="")
        {
          Head_Image="/e/member/images/defaultface.gif";
        }
     Space_Banner=dr["space_banner"].ToString();
     if(Space_Banner=="")
       {
        Space_Banner="/e/member/images/spacebanner.gif";
       }
    }
   dr.Close();
   if(MType_Id==0)
    {
      dr.Close();
      conn.Close();
      Response.Write("<script type='text/javascript'>alert('Invalid uid!');</script>");
      Response.End();
    }
   else
    {
     sql="select name from pa_member_type where id="+MType_Id;
     comm=new OleDbCommand(sql,conn);
     dr= comm.ExecuteReader();
     if(dr.Read())
      {
       Member_Type=dr["name"].ToString();
      }  
     dr.Close();
    }
 }


private void Go_Uid()
 {
   UID="";
   conn.Open();
   sql="select id from pa_member where checked=1 and username='"+Sql_Format(Request.QueryString["username"])+"'";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
      UID=dr["id"].ToString();
    }
   dr.Close();
   conn.Close();
   if(UID=="")
    {
      Response.Write("<script type='text/javascript'>alert('Invalid username!');</script>");
      Response.End();
    }
   else
    {
     Response.Status="301 Moved Permanently";
     Response.AddHeader("Location","/e/space/?uid="+UID);
     Response.End();
    }
 }

private void Table_Bind()
  {
   if(Department_Id>0)
   {
    sql="select id,thetable,table_name from pa_table where thetable in(select thetable from pa_member_tgset where department_id="+Department_Id+") order by xuhao";
   }
  else
   {
    sql="select id,thetable,table_name from pa_table where thetable in(select thetable from pa_member_tgset where mtype_id="+MType_Id+") order by xuhao";
   }
   DataSet ds=new DataSet();
   OleDbDataAdapter myadapter=new OleDbDataAdapter(sql,conn);
   myadapter.Fill(ds,"tb");
   if(ds.Tables["tb"].Rows.Count>0)
   {
     P_Menu.DataSource =ds.Tables["tb"].DefaultView;
     P_Menu.DataBind();
   }
  }

private void Load_Control()
 {
    Control UC;
   if(Request.QueryString["type"]=="exit")
     {
       Clear_Cookie();
     }
   else
     {
       if(Request.QueryString["type"]=="fbk")
       {
        UC=Page.LoadControl("~/e/space/spc_fbk.ascx");
       }
      else if(IsNum(Request.QueryString["tid"]))
      {
       UC=Page.LoadControl("~/e/space/spc_list.ascx");
      }
      else
      {
      UC=Page.LoadControl("~/e/space/spc_newlist.ascx");
      }
      P_UC.Controls.Add(UC);
    }
 }

private void Get_Permissions()
 {
     string Mcenter_Permissions="";
     string Space_Open="0";
     if(Department_Id>0)
      {
       sql="select m_set from pa_department where id="+Department_Id;
      }
     else
      {
        sql="select m_set from pa_member_type where id="+MType_Id;
      }
      OleDbCommand comm=new OleDbCommand(sql,conn);
      OleDbDataReader dr=comm.ExecuteReader();
      if(dr.Read())
      {
        Mcenter_Permissions=dr["m_set"].ToString();
      }
     dr.Close();
    if(Mcenter_Permissions.IndexOf(",m_space,")<0)
     {
      conn.Close();
      Response.Write("<script src='/e/js/space.js' type='text/javascript'></script><script type='text/javascript'>Space_Close();</script>");
      Response.End();
     }
 }


private void Get_Login()
 {
  if(Request.Cookies["Member"]!=null)
    {
      Member_Valicate MCheck=new Member_Valicate();
      MCheck.Member_Check();
      P2.Visible=true;
      LoginName=MCheck._UserName;
      Get_LoginMember(LoginName,MCheck._MemberTypeId);
    }
  else
    {
      P1.Visible=true;
    }
 }

private void Get_LoginMember(string User,int MType_Id)
 {
   sql="select name from pa_member_type where id="+MType_Id;
   OleDbCommand  comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
       Login_Member_Type=dr["name"].ToString();
    }  
   dr.Close();
   sql="select id from pa_msg_inbox where receiver='"+User+"' and readed=0";
   comm=new OleDbCommand(sql,conn);
   dr= comm.ExecuteReader();
     if(dr.Read())
      {
        msg_icon_show="";
      }  
     else
      {
        msg_icon_show="none";
      }
  dr.Close();
 }


private void Clear_Cookie()
 {
   HttpCookie MCookie=new HttpCookie("Member");
   MCookie.Expires=DateTime.Now.AddDays(-1);
   Response.AppendCookie(MCookie);
   Response.Write("<script type='text/javascript'>location.href='/e/space/?uid="+UID+"'</script>");
   Response.End();
 }

protected string Get_Url(string Type)
  {
    return "/e/member/index.aspx?type="+Type;
  }

private string Sql_Format(string str)
 {
   if(string.IsNullOrEmpty(str)){return "";}
   string Res=str.Replace("'","''");
   Res=Res.Replace("\"","\""); 
   return Res;
 }

private string ubb(string str)
   {
    if(string.IsNullOrEmpty(str)){return "";}
    str=str.Replace("\r\n","<br>");
    str=str.Replace(" ","&nbsp;");
    return str;
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
