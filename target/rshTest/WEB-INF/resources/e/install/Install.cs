using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.IO;

namespace PageAdmin
 {
   public class PaInstall:Page
    {
      protected TextBox Tb_sql,TbMasterDir,Login_Pass,Login_Pass1;
      protected PlaceHolder Panel1,Panel2,Panel3,Panel4,Panel5;
      protected RadioButton Radio_1,Radio_2;
      protected Label Lbl_error;
      protected Button Setup_1;
      protected string Net_Version,ManageDirectory,masterurl,SERVER_PORT;
      protected string[] r_p,w_p,d_p;
      int Mtype_Id;

     protected void Page_Load(Object src,EventArgs e)
        {
          if(check_Installlock())
           {
            if(!Page.IsPostBack)
            {
            Net_Version=Environment.Version.ToString(); 
            SERVER_PORT=Request.ServerVariables["SERVER_PORT"]=="80"?"":":"+Request.ServerVariables["SERVER_PORT"];
            switch(Request.QueryString["Setup"])
            {

              case "2":
                 Panel1.Visible=false;
                 Panel2.Visible=true;
                 Panel3.Visible=false;
                 Panel4.Visible=false;
                 Panel5.Visible=false;
                 check_permission();
             break;

              case "3":
                 Panel1.Visible=false;
                 Panel2.Visible=false;
                 Panel3.Visible=true;
                 Panel4.Visible=false;
                 Panel5.Visible=false;
                 string Str_DbType=ConfigurationManager.AppSettings["DbType"].ToString();
                if(Str_DbType=="1")
                 {
                  Radio_1.Checked=false;
                  Radio_2.Checked=true;
                 }
                else
                 {
                  Radio_1.Checked=true;
                  Radio_2.Checked=false;
                 }
                 TbMasterDir.Text=ConfigurationManager.AppSettings["ManageDirectory"].ToString().Replace("/e/","").Replace("/","");
             break;

            case "4":
                 Panel1.Visible=false;
                 Panel2.Visible=false;
                 Panel3.Visible=false;
                 Panel4.Visible=true;
                 Panel5.Visible=false;
             break;

            default:
                 Panel1.Visible=true;
                 Panel2.Visible=false;
                 Panel3.Visible=false;
                 Panel4.Visible=false;
                 Panel5.Visible=false;
             break;

          }
        }

       }

    }

     protected void Next_1(Object src,EventArgs e)
      {
        if(check_Installlock())
        {
         string ThePath=Server.MapPath("/web.config");
         if(!File.Exists(ThePath))
            {
              Lbl_error.Visible=true;
              Lbl_error.Text="错误：请将网站放在根目录下再运行。"; 
              Setup_1.Enabled=false;
              return;       
             }
           Response.Write("<script>location.href='?setup=2'</script>");
           Response.End();
        }
      }



     protected void Next_2(Object src,EventArgs e)
      {
        if(!check_Installlock()){return;}
        Response.Write("<script>location.href='?setup=3'</script>");
        Response.End();
      }

     protected void Next_3(Object src,EventArgs e)
      {
        if(!check_Installlock()){return;}
        Update_Config();
      }

     protected void Next_4(Object src,EventArgs e)
      {
        if(!check_Installlock()){return;}
       if(Update_DataBase())
        {
         Lbl_error.Text="";
         ManageDirectory=ConfigurationManager.AppSettings["ManageDirectory"].ToString();
         Panel1.Visible=false;
         Panel2.Visible=false;
         Panel3.Visible=false;
         Panel4.Visible=false;
         Panel5.Visible=true;
         Build_Installlock();
         masterurl=ManageDirectory+"login.aspx";
        }
      }

private void Update_Config()
 {  
   string MDir,the_DbType,Url;
    if(Radio_1.Checked)
     {
       the_DbType="0";
     }
    else
     {
       the_DbType="1";
     }
    MDir=TbMasterDir.Text.Trim();
    if(!IsStr(MDir))
     {
       Lbl_error.Text="错误：请正确设置后台目录，目录只能由字母和下划线组成!"; 
       return;
     }
     MDir="/e/"+MDir+"/";
     Url=GetUrl(Request.ServerVariables["SERVER_NAME"]);
     System.Xml.XmlDocument   x   =   new   System.Xml.XmlDocument();   
     x.Load(Server.MapPath("/web.Config"));  
     System.Xml.XmlNodeList   xnlist   =   x.SelectSingleNode("configuration/appSettings").ChildNodes;
     foreach (System.Xml.XmlNode xn   in   xnlist) 
          { 
            System.Xml.XmlElement xe  = (System.Xml.XmlElement)(xn); 
             switch(xe.Attributes["key"].Value)
             {
              case "DbType":
                 if(Request.QueryString["Setup"]=="3")
                  {
                   xe.Attributes["value"].Value=the_DbType;
                  }
              break;

              case "Url":
                  if(Url!="localhost")
                   {
                     string current_url=Request.ServerVariables["SERVER_NAME"].ToLower();
                     string config_url=ConfigurationManager.AppSettings["ManageDirectory"].ToString().ToLower();
                     if(config_url.IndexOf(current_url)<0)
                      {
                        xe.Attributes["value"].Value=Request.ServerVariables["SERVER_NAME"];
                      }
                   }
              break;

              case "ManageDirectory":
                  if(MDir!=ConfigurationManager.AppSettings["ManageDirectory"].ToString())
                   {
                    if(Directory.Exists(Server.MapPath(ConfigurationManager.AppSettings["ManageDirectory"].ToString())))
                     {
                       Directory.Move(Server.MapPath(ConfigurationManager.AppSettings["ManageDirectory"].ToString()),Server.MapPath(MDir));
                       xe.Attributes["value"].Value=MDir;
                     }
                   }
              break;
            }
         }
     x.Save(Server.MapPath("/web.Config")); 
     Response.Write("<script>location.href='?setup=4'</script>");
     Response.End();
  }


private void Check_DefaultType(OleDbConnection Myconn)
 {
   string sql="select *  from pa_member_type where m_group='admin'";
   OleDbCommand Comm=new OleDbCommand(sql,Myconn);
   OleDbDataReader dr=Comm.ExecuteReader();
   if(!dr.Read())
    {
      sql="insert into pa_member_type(name,m_reg,m_check,m_group,beizhu) values('管理员组',0,1,'admin','内置组')";
      Comm=new OleDbCommand(sql,Myconn);
      Comm.ExecuteNonQuery();
    }

   sql="select *  from pa_member_type where m_group='admin'";
   Comm=new OleDbCommand(sql,Myconn);
   dr=Comm.ExecuteReader();
   if(dr.Read())
    {
      Mtype_Id=int.Parse(dr["id"].ToString());
    }

   sql="select *  from pa_member_type where m_group='defaultusers'";
   Comm=new OleDbCommand(sql,Myconn);
   dr=Comm.ExecuteReader();
   if(!dr.Read())
    {
      sql="insert into pa_member_type(name,m_reg,m_check,m_group,beizhu) values('普通会员',1,0,'defaultusers','内置组')";
      Comm=new OleDbCommand(sql,Myconn);
      Comm.ExecuteNonQuery();
    }

 }

private bool Update_DataBase()
 {  
   if(Login_Pass.Text!=Login_Pass1.Text)
    {
      Lbl_error.Text="两次输入的密码不一致，请重新输入!";
      return false;
    }
   Conn theconn=new Conn();
   OleDbConnection Myconn= theconn.OleDbConn();//获取
   Md5 jm1=new Md5();
   string Pass=jm1.Get_Md5(Login_Pass.Text.Trim());
   Myconn.Open();
   Check_DefaultType(Myconn);
   string sql="select top 1 * from pa_member where username='admin'";
   OleDbCommand Comm=new OleDbCommand(sql,Myconn);
   OleDbDataReader dr=Comm.ExecuteReader();
   if(dr.Read())
     {
      sql="update pa_member set userpassword='"+Pass+"',m_group='admin',checked=1,mtype_id="+Mtype_Id+" where username='admin'";
      Comm=new OleDbCommand(sql,Myconn);
      Comm.ExecuteNonQuery();
     }
    else
     {
      sql="insert into pa_member(username,userpassword,m_group,checked,mtype_id,space_clicks,department_id) values('admin','"+Pass+"','admin',1,"+Mtype_Id+",0,0)";
      Comm=new OleDbCommand(sql,Myconn);
      Comm.ExecuteNonQuery();
     }

   dr.Close();
   Myconn.Close();
   return true;

 }

private bool check_Installlock()
 {
   string ThePath=Server.MapPath("install.lock");
   if(File.Exists(ThePath))
     {
       Panel1.Visible=false;
       Panel2.Visible=false;
       Panel3.Visible=false;
       Panel4.Visible=false;
       Panel5.Visible=false;
       Lbl_error.Text="提示：请先删除/e/install/目录下的install.lock文件后再运行。";
       return false;
     }
   else
     {
      return true;
     }
 }

private void Build_Installlock()
 {
   FileStream Fs=new FileStream(Server.MapPath("install.lock"),FileMode.Create,FileAccess.Write);
   System.Text.Encoding encoding=System.Text.Encoding.GetEncoding("GB2312"); 
   StreamWriter rw=new StreamWriter(Fs,encoding);
   rw.Write("1");
   rw.Flush();
   rw.Close();
   Fs.Close();
 }

private string GetUrl(string Url)
     {
      if(IsLocal(Url) || Url.IndexOf(".")<0)
       {
         return "localhost";
       }
      else
       {   
         return Url.Replace("www.","");
       }
     }

private bool IsLocal(string str)
 {
   string[] LocalIp=new string[]{@"^127[.]0[.]0[.]1$",@"^localhost$",@"^10[.]\d{1,3}[.]\d{1,3}[.]\d{1,3}$",@"^172[.]((1[6-9])|(2\d)|(3[01]))[.]\d{1,3}[.]\d{1,3}$",@"^192[.]168[.]\d{1,3}[.]\d{1,3}$"};
   for(int i=0;i<LocalIp.Length;i++)
    {
      if(System.Text.RegularExpressions.Regex.IsMatch((str==null?"":str),LocalIp[i]))
       {
         return true;
       }
    }
   return false;
 }

private void check_permission()
 {
   r_p=new string[]{"√","√","√","√","√","√","√","√"};
   w_p=new string[]{"<font color=red>X</font>","<font color=red>X</font>","<font color=red>X</font>","<font color=red>X</font>","<font color=red>X</font>","<font color=red>X</font>","<font color=red>X</font>","<font color=red>X</font>"};
   d_p=new string[]{"<font color=red>X</font>","-","<font color=red>X</font>","<font color=red>X</font>","<font color=red>X</font>","<font color=red>X</font>","<font color=red>X</font>","-"};
   string[] paths=new string[]{"/","web.config","/e/d/","/e/zdyform/","/e/zdymodel/","/e/zdytag/","/e/upload/","/e/database/"};
   System.Text.Encoding encoding=System.Text.Encoding.GetEncoding("GB2312");
   FileStream Fs;
   StreamWriter rw;
   string cfiles="";
   for(int i=0;i<paths.Length;i++)
    {
     if(paths[i]=="web.config")
      {
       cfiles=Server.MapPath("/web.config");
      }
     else
      {
       cfiles=Server.MapPath(paths[i]+"c.txt");
      }
     try
      {
       if(paths[i]=="web.config")
        {
         Fs=new FileStream(cfiles,FileMode.Append,FileAccess.Write);
         rw=new StreamWriter(Fs,encoding);
         rw.Write("");
        }
       else
        {
         Fs=new FileStream(cfiles,FileMode.Create,FileAccess.Write);
         rw=new StreamWriter(Fs,encoding);
         rw.Write(paths[i]);
        }
       rw.Flush();
       rw.Close();
       Fs.Close();
       w_p[i]="√";
     } 
    catch{}

    if(File.Exists(cfiles) && paths[i]!="web.config" && paths[i]!="/e/database/")
      {
         try
         {
           File.Delete(cfiles);
           d_p[i]="√";
         }
        catch{} 
       }
  }
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


  }

 }

