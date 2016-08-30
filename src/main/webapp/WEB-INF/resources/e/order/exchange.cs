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
 public class exchange:Page
 {
  protected PlaceHolder p1,p2;
  protected Label Lb_Point,Lb_MyPoint,Lb_Reserves,Lb_UserName,Lb_Title;
  OleDbConnection conn;
  protected string TheTitle,Point,MyPoint,Reserves,ServerInfo;
  string SiteId,Table,DetailId,sql,UserName,Enum;
  
  protected void Page_Load(Object sender,EventArgs e)
   {
     SiteId=Request.QueryString["s"];
     Table=Request.QueryString["table"];
     DetailId=Request.QueryString["id"];
     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
     if(!IsNum(DetailId))
      {
       DetailId="0";
      }
     if(!IsNum(SiteId))
      {
       SiteId="0";
      }
     if(!IsStr(Table))
      {
       Response.Write("<script type='text/javascript'>alert('Table参数错误');</script>");
       Response.End();
      }
     if(!Page.IsPostBack)
      {
        if(IsNum(SiteId) && IsNum(DetailId) && IsStr(Table))
         {
           conn.Open();
           Member_Check();
           Get_Prod();
           conn.Close();
         }
        else
         {
          Response.Write("<script type='text/javascript'>alert('参数错误');</script>");
          Response.End();
         }
      }
    else
      {
        conn.Open();
         Member_Check();
         if(IsUserName(UserName))
          {
           ExChange();
          }
        conn.Close();
      }
    
   }



private void Member_Check()
  {
     if(Request.Cookies["Member"]==null)
        {
          UserName="";
          string fun="quick_login(\""+SiteId+"\",\"exchange('"+SiteId+"','"+Table+"',"+DetailId+")\")";
          fun=fun.Replace("\"","\\\"");
          Response.Write("<script type='text/javascript'>parent.CloseDialog(\""+fun+"\")</"+"script>");
          Response.End();
        }
      else
        {
          Member_Valicate YZ=new Member_Valicate();
          YZ.Member_Check();
          UserName=YZ._UserName;
        }
     if(UserName=="")
      {
        Response.Write("<script type='text/javascript'>window.close();</script>");
        Response.End();
      }
     else
      {
        Lb_UserName.Text=UserName;
        sql="select point_ky from pa_member where username='"+UserName+"'";
        OleDbCommand comm=new OleDbCommand (sql,conn);
        OleDbDataReader dr=comm.ExecuteReader();
        if(dr.Read())
        {
          MyPoint=dr["point_ky"].ToString();
        }
       else
        {
         MyPoint="0";
        }
       Lb_MyPoint.Text=MyPoint;
       dr.Close();
     }

  }

private void Get_Prod()
  {
    int Id=int.Parse(DetailId);
    sql="select title,reserves,point from "+Table+" where id="+Id;
    OleDbCommand comm=new OleDbCommand (sql,conn);
    OleDbDataReader dr=comm.ExecuteReader();
    if(dr.Read())
     {
      Point=dr["point"].ToString();
      TheTitle=dr["title"].ToString();
      Reserves=dr["reserves"].ToString();
      Lb_Title.Text=TheTitle;
      Lb_Point.Text=Point;
      Lb_Reserves.Text=Reserves;
      if(Reserves=="0")
       {
         ServerInfo="NoReserves()";
         return;
       }
     }
    dr.Close();
  }


protected void ExChange()
 {
   Reserves=Lb_Reserves.Text;
   MyPoint=Lb_MyPoint.Text;
   Point=Lb_Point.Text;
   Enum=Request.Form["num"];
   if(IsNum(Enum) && Enum!="0" && Point!="0")
    {
       if(int.Parse(Enum)>int.Parse(Reserves)) //大于库存
        {
          ServerInfo="Exchange('num>reserves')";
          return;
        }
       if(int.Parse(Enum)*int.Parse(Point)>int.Parse(MyPoint)) //积分不足
        {
          ServerInfo="Exchange('mypoint<points')";
          return;
        }
       Update_member_and_Reserves(int.Parse(Enum)*int.Parse(Point),Lb_UserName.Text);
       p1.Visible=false;
       p2.Visible=true;
    }
   else
    {
      ServerInfo="Exchange('invalid')";
      return;
    }
 }

private void Update_member_and_Reserves(int Points,string User_Name)
 {
     sql="update pa_member set point_ky=point_ky-"+Points+",point_xf=point_xf+"+Points+" where username='"+Sql_Format(User_Name)+"'";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     comm.ExecuteNonQuery();

     sql="insert into pa_fnc_list(site_id,thetype,username,act,amount,detail,beizhu,thedate) values("+int.Parse(SiteId)+",2,'"+Sql_Format(User_Name)+"','k',"+Points+",'兑换商品','"+Sql_Format(Lb_Title.Text)+"("+Enum+")','"+DateTime.Now+"')";
     comm=new OleDbCommand(sql,conn);
     comm.ExecuteNonQuery();

     sql="update "+Table+" set reserves=Reserves-"+int.Parse(Enum)+" where id="+int.Parse(DetailId);
     comm=new OleDbCommand(sql,conn);
     comm.ExecuteNonQuery();
   
     sql="insert into pa_exchange(site_id,thetable,detail_id,username,title,num,paypoint,name,tel,email,address,postcode,operator,thedate) values("+int.Parse(SiteId)+",'"+Sql_Format(Table)+"',"+int.Parse(DetailId)+",'"+Sql_Format(User_Name)+"','"+Sql_Format(Lb_Title.Text)+"',"+int.Parse(Enum)+","+Points+",'"+Sql_Format(Request.Form["truename"])+"','"+Sql_Format(Request.Form["tel"])+"','"+Sql_Format(Request.Form["email"])+"','"+Sql_Format(Request.Form["address"])+"','"+Sql_Format(Request.Form["postcode"])+"','','"+DateTime.Now+"')";
     comm=new OleDbCommand(sql,conn);
     comm.ExecuteNonQuery();
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
  if(str=="" || str==null)
   {
    return false;
   }
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

private string Sql_Format(string str)
 {
  if(str=="" || str==null)
   {
    return "";
   }
   string Res=str.Replace("'","''");
   Res=Res.Replace("\"","\""); 
   return Res;
 }

private bool IsNum(string str)
 {
  string str1="0123456789";
  if(str=="" ||   str==null)
   {
    return false;
   }

  for(int i=0;i<str.Length;i++)
   {
    if(str1.IndexOf(str[i])==-1)
     {
       return false;
     }
   }
  return true;
 }

 }

 }