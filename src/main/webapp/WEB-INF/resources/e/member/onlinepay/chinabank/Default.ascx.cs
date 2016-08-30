using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.OleDb;
using System.Collections;
using PageAdmin;
public class chinabank_pay:Page
 {
   public string SiteId,UserName,R_Url,TrueName,Company,Sex,Email,Province,City,Address,Postcode,Tel,Fax,QQ,Msn;
   OleDbConnection conn;
   string Constr;
   void Page_Load(Object sender,EventArgs e)
    {
      if(IsNum(Request.QueryString["s"]))
       {
         SiteId=Request.QueryString["s"];
         Member_Valicate MCheck=new Member_Valicate();
         MCheck.Member_Check(true,int.Parse(SiteId));
         UserName=MCheck._UserName;
         R_Url=Request.QueryString["r_url"];
         if(string.IsNullOrEmpty(R_Url)){R_Url="";}
         OleDbConnection conn;
         Conn Myconn=new Conn();
         conn=Myconn.OleDbConn();//获取OleDbConnection
         conn.Open();
           Check_SiteId();
           Data_Bind();
        conn.Close();
      }
     else
      {
      }
    }

 void Data_Bind()
 {
   string sql="select * from pa_member where username='"+UserName+"'";
   OleDbCommand Comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=Comm.ExecuteReader();
   if(dr.Read())
    {
      TrueName=dr["truename"].ToString();
      Email=dr["email"].ToString();
    }   
   dr.Close();
   
 }

private void Check_SiteId()
 {
     string sql="select id from pa_site where id="+int.Parse(SiteId);
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr= comm.ExecuteReader();
     if(!dr.Read())
     {
       Response.Write("<script type='text/javascript'>alert('invalid siteid!');</script>");
       Response.End();
     }  
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
