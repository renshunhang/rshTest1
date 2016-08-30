using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.OleDb;
using System.Configuration;

namespace PageAdmin
 {
 public class order1:Page
 {

  protected Repeater List,S_List;
  OleDbConnection conn;
  string UserName,Anonymous,Str_orderid,SendWay,sql;
  protected string SiteId,Tongji,Table,Tongji_Point;
  protected int RecordCounts;
  int SendSpending;

  protected void Page_Load(Object sender,EventArgs e)
   {
     SiteId=Request.QueryString["s"];
     Table=Request.QueryString["table"];
     if(!IsNum(SiteId))
      {
       SiteId="0";
      }
     if(!IsNum(Table))
      {
       Table="product";
      }
     if(!Page.IsPostBack)
      {
        Conn Myconn=new Conn();
        conn=Myconn.OleDbConn();//获取OleDbConnection
        Member_Check();
        if(Request.Form["post"]=="add")
         {
           conn.Open();
           if(IsNum(SiteId))
           {
             Order_Add();
           }
           conn.Close();
         }
        else
         {
           if(IsNum(SiteId))
           {
             conn.Open();
              Get_Total();
              Data_Bind();
             conn.Close();
           }
        }
      }
    
   }


private void Member_Check()
  {
     if(Request.Cookies["Member"]==null)
        {

         //注释掉下面这段则可进行匿名订购
           string fun="quick_login(\""+SiteId+"\",\"ordercart('"+SiteId+"')\")";
           fun=fun.Replace("\"","\\\"");
           Response.Write("<script type='text/javascript'>parent.CloseDialog(\""+fun+"\")</"+"script>");
           Response.End();
         //注释掉上面这段则可进行匿名订购

          if(Request.Cookies["anonymous"]==null)
           {
            Response.Write("anonymous cookie is invalid");
            Response.End();
           }
          else
           {
            if(IsStr(Request.Cookies["anonymous"].Value))
             {
              Anonymous=Request.Cookies["anonymous"].Value;
             }
            else
             {
              Response.Write("anonymous cookie is invalid");
              Response.End();
             }
           }
        }
      else
        {
          Member_Valicate YZ=new Member_Valicate();
          YZ.Member_Check();
          UserName=YZ._UserName;
          Anonymous="";
        }
  }

private void Data_Bind()
 { 
   sql="select id,title,thetable,detail_id,member_price,num,[color],[size],[type],(sendpoint*num) as count_sendpoint,(member_price*num) as tj from pa_orderlist where username='"+UserName+"' and anonymous='"+Anonymous+"' and state=0";
   DataSet ds=new DataSet();
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   myAdapter.Fill(ds,"tb");
   RecordCounts=ds.Tables["tb"].Rows.Count;
   if(RecordCounts>0)
    {
       List.DataSource=ds.Tables["tb"].DefaultView;
       List.DataBind();
    }

   sql="select * from pa_sendway where site_id="+int.Parse(SiteId)+" order by xuhao";
   ds=new DataSet();
   myAdapter=new OleDbDataAdapter(sql,conn);
   myAdapter.Fill(ds,"tb");
   S_List.DataSource=ds.Tables["tb"].DefaultView;
   S_List.DataBind();

 }

protected string Get_Field(string Table,string Field,string DetailId)
 {
   string rv="";
   int HasTable=1;
   if(IsStr(Table) && IsStr(Field) && IsNum(DetailId))
    {
     OleDbCommand comm;
     OleDbDataReader dr;
     sql="select id from pa_table where thetable='"+Table+"'";
     comm=new OleDbCommand (sql,conn);
     dr=comm.ExecuteReader();
     if(!dr.Read())
     {
       HasTable=0;
     }
    dr.Close();
    if(HasTable==1)
     {
       sql="select "+Field+" from "+Table+" where id="+DetailId;
       comm=new OleDbCommand (sql,conn);
       dr=comm.ExecuteReader();
       if(dr.Read())
       {
        return dr[Field].ToString();
       }
       dr.Close();
     }
    }
   if(Field=="title_pic" && rv=="")
    {
     rv="/e/images/noimage.gif";
    }
   return rv;
 }

private void Get_Total()
 {  
   sql="select sum(member_price*num) as Tj,sum(sendpoint*num) as Tj_Point from pa_orderlist where username='"+UserName+"' and anonymous='"+Anonymous+"' and state=0";
   OleDbCommand comm=new OleDbCommand (sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
      Tongji_Point=dr["Tj_Point"].ToString();
      Tongji=dr["Tj"].ToString();
    }
   else
    {
      Tongji_Point="0";
      Tongji="0";
    }
   dr.Close();
 }

private void Order_Add()
 {   
   string Name=Request.Form["name"];
   string Tel=Request.Form["tel"];
   string Province=Request.Form["Province"];
   string City=Request.Form["city"];
   string Email=Request.Form["email"];
   string PostCode=Request.Form["postcode"];
   string Address=Request.Form["address"];
   string Fax=Request.Form["fax"];
   string QQ=Request.Form["qq"];
   string Beizhu=ubb(Request.Form["beizhu"]);
   SendWay="待确定";
   SendSpending=0;
   if(IsNum(Request.Form["sendway"]))
    {
      int SendWayId=int.Parse(Request.Form["sendway"]);
      Get_SendWay(SendWayId);
    }
   //生成订单号
   Random r=new Random();
   Str_orderid=System.DateTime.Now.ToString("yyMMddHHmmss")+r.Next(0,100);
   sql="insert into pa_orders(site_id,username,anonymous,order_id,name,tel,province,city,email,postcode,address,fax,qq,beizhu,sendway,send_spending,operator) values("+SiteId+",'"+UserName+"','"+Anonymous+"','"+Str_orderid+"','"+Sql_Format(Name)+"','"+Sql_Format(Tel)+"','"+Sql_Format(Province)+"','"+Sql_Format(City)+"','"+Sql_Format(Email)+"','"+Sql_Format(PostCode)+"','"+Sql_Format(Address)+"','"+Sql_Format(Fax)+"','"+Sql_Format(QQ)+"','"+Sql_Format(Beizhu)+"','"+Sql_Format(SendWay)+"',"+SendSpending+",'')";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   comm.ExecuteNonQuery();

   sql="update pa_orderlist set state=1,order_id='"+Str_orderid+"' where state=0 and username='"+UserName+"' and anonymous='"+Anonymous+"'";
   comm=new OleDbCommand(sql,conn);
   comm.ExecuteNonQuery();
   SendMail(Email);

   string Mem_Order_Ulr="/e/member/index.aspx?s="+SiteId+"&type=mem_odlst&&detailid="+Str_orderid;
   conn.Close();
   Response.Write("<script type='text/javascript' src='/e/js/order.js'></script><script type='text/javascript'>order_submit('"+Mem_Order_Ulr+"','"+UserName+"');</script>");
   Response.End();
 }

private void  SendMail(string Email) //发邮件部分
 {
  string FajianName,MailTo,Mail_subject,HttpUrl,Mail_Body;
  sql="select top 1 fajianname,em_order from pa_webset where site_id="+SiteId;
  OleDbCommand comm=new OleDbCommand(sql,conn);
  OleDbDataReader dr=comm.ExecuteReader();
  if(dr.Read())
   {
    FajianName=dr["fajianname"].ToString();
    MailTo=dr["em_order"].ToString();
    HttpUrl=Request.ServerVariables["SERVER_NAME"];
    Mail_subject="来自于"+FajianName+"的在线订单";
    Mail_Body="尊敬的朋友：您好!<br><br>以下是您在"+FajianName+"的订单明细链接:<br><a href='http://"+HttpUrl+"/e/order/orderview.aspx?orderid="+Str_orderid+"' target=blank>http://"+HttpUrl+"/e/order/orderview.aspx?orderid="+Str_orderid+"</a>";
    if(MailTo!="")
     {
      SendMessage Mail=new SendMessage(int.Parse(SiteId));   
      Mail.SendEmail(MailTo,"",Email,Mail_subject,Mail_Body);//发邮件
     }
   } 
  dr.Close();
}

private void Get_SendWay(int Id)
 {
  sql="select sendway,spending from pa_sendway where id="+Id;
  OleDbCommand comm=new OleDbCommand(sql,conn);
  OleDbDataReader dr=comm.ExecuteReader();
  if(dr.Read())
   {
    SendWay=Sql_Format(dr["sendway"].ToString());
    SendSpending=int.Parse(dr["spending"].ToString());
   }
 }

protected string GetUrl(string Type)
  {
    return "/e/member/index.aspx?type="+Type+"&s="+SiteId;
  }

private string Sql_Format(string str)
 {
   if(string.IsNullOrEmpty(str)){return "";}
   string Res=str.Replace("'","''");
   Res=Res.Replace("\"","\""); 
   return Res;
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
  string str1="0123456789";
  for(int i=0;i<str.Length;i++)
   {
    if(str1.IndexOf(str[i])==-1)
     {
       return false;
     }
   }
  return true;
 }

protected string ubb(string str)
   {
    if(string.IsNullOrEmpty(str)){return "";}
    str=str.Replace("\r\n","<br>");
    str=str.Replace(" ","&nbsp;");
    return str;
   }

 }

 }