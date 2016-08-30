using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.IO;
using System.Net;
namespace PageAdmin
 {
 public class orderview:Page
 {
  protected Label LblPdtongji,LblSendExpense,LblSendWay,LblTongji,Lblorderid,LbName,LbTel,LbProvince,LbCity,LbEmail,LbPostcode,LbAddress,Lbbeizhu,Lbbeizhu1,PayState,SendState,ChargeName,Thedate,TheMember,Lbl_info;
  protected Repeater DL_1;
  protected PlaceHolder P1;
  OleDbConnection conn;
  int Xuhao=0;
  string Url_Prefix,Is_Static;

protected void Page_Load(Object sender,EventArgs e)
   {
     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
     if(!Page.IsPostBack)
      {
        if(IsNum(Request.QueryString["orderid"]))
         {
          conn.Open();
           Get_Total();
           Data_Bind();
           Info_Bind();
          conn.Close();
          Lblorderid.Text=Request.QueryString["orderid"];
         }
       else
         {
           P1.Visible=false;
           Lbl_info.Visible=true;
         }
      }
   
   }

private void Data_Bind()
 {

   string Str_orderid=Request.QueryString["orderid"];
   string sql="select id,title,thetable,detail_id,num,state,member_price,[color],[size],[type],(num*member_price) as tongji from pa_orderlist where order_id='"+Str_orderid+"'";
   OleDbCommand comm=new OleDbCommand (sql,conn);
   DataSet ds=new DataSet();
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   myAdapter.Fill(ds,"orderlist");
   if(ds.Tables["orderlist"].Rows.Count<=0)
    {
      P1.Visible=false;
      Lbl_info.Visible=true;
    }
  else
   {
     DL_1.DataSource=ds.Tables["orderlist"].DefaultView;
     DL_1.DataBind();
   }
 }


private void Get_Total()
 {  
   string Str_orderid=Request.QueryString["orderid"];
   string sql="select sum(num*member_price) as Tj from pa_orderlist where order_id='"+Str_orderid+"' and state<>-1";
   OleDbCommand comm=new OleDbCommand (sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     LblPdtongji.Text=dr["Tj"].ToString();
     if(dr["Tj"].ToString()=="")
      {
        LblPdtongji.Text="0";
      }
    }
   dr.Close();
 }


private void Info_Bind()
 {
   string Str_orderid=Request.QueryString["orderid"];
   string sql="select * from pa_orders where order_id='"+Str_orderid+"'";
   OleDbCommand comm=new OleDbCommand (sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     if(dr["paystate"].ToString()=="0")
      {
        PayState.Text="未付款";
      }
     else
      {
       PayState.Text=Get_PayState(dr["paystate"].ToString());
      }

     if(dr["sendstate"].ToString()=="0")
      {
        SendState.Text="未发货";
      }
     else
      {
       SendState.Text=Get_SendState(dr["sendstate"].ToString());
      }

     if(dr["operator"].ToString()=="")
      {
        ChargeName.Text="待确定";
      }
     else
      {
       ChargeName.Text=dr["operator"].ToString();
      }
     Thedate.Text=(Convert.ToDateTime(dr["thedate"])).ToString("yyyy年MM月dd日");
     TheMember.Text=dr["username"].ToString();
     LbName.Text=dr["name"].ToString();
     LbTel.Text=dr["tel"].ToString();
     LbProvince.Text=dr["province"].ToString();
     LbCity.Text=dr["city"].ToString();
     LbEmail.Text=dr["email"].ToString();
     LbPostcode.Text=dr["postcode"].ToString();
     LbAddress.Text=dr["address"].ToString();
     Lbbeizhu.Text=dr["beizhu"].ToString();
     Lbbeizhu1.Text=dr["replay"].ToString();
     LblSendWay.Text=dr["sendway"].ToString();
     LblSendExpense.Text=dr["send_spending"].ToString();
     double Tongji=double.Parse(dr["send_spending"].ToString())+double.Parse(LblPdtongji.Text);
     LblTongji.Text=Tongji.ToString();
    }
   dr.Close();
 }

protected  string Get_State(string Str)
 {
  switch(Str)
   {

    case "1":
     return "正常销售";
    break;

    case "-1":
     return "<font color=#ff0000>已缺货</font>";
    break;

    default:
     return "未确定";
    break;


   }
 }

private string Get_PayState(string Str)
 {
  switch(Str)
   {
    case "1":
     return "<font color=#ff0000>已付款</font>";
    break;

    case "-1":
     return "<font color=#0066FF>未付款</font>";
    break;

    default:
     return "未确定";
    break;


   }
 }

private string Get_SendState(string Str)
 {
  switch(Str)
   {
    case "2":
     return "<font color=#0066FF>已发货</font>";
    break;

    case "1":
     return "<font color=#0066FF>已确认</font>";
    break;

    default:
     return "未确定";
    break;

   }
 }

protected string Get_DetailUrl(string thetable,string Id)
  {
   string Rv="";
   int HasTable=0;
   string sql="select id from pa_table where thetable='"+thetable+"'";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    { 
      HasTable=1;
    }
   dr.Close();
   if(HasTable==1)
    {
     sql="select top 1 id,site_id,lanmu_id,sublanmu_id from "+thetable+" where id="+Id;
     comm=new OleDbCommand(sql,conn);
     dr=comm.ExecuteReader();
     if(dr.Read())
      {
       Get_Site(int.Parse(dr["site_id"].ToString()));
       Rv=DetailUrl(Url_Prefix,dr["lanmu_id"].ToString(),dr["sublanmu_id"].ToString(),dr["id"].ToString());
      }
      dr.Close();
    }
   return Rv;
  }

private string DetailUrl(string Url_Prefix,string Lanmu_Id,string SubLanmu_Id,string Id)
 {
   string Rv=Url_Prefix+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;
   return Rv;
 }

private void Get_Site(int SiteId)
 {
   Url_Prefix="/";
   string sql="select [directory],[domain],[html] from pa_site where id="+SiteId;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     string SiteDir=dr["directory"].ToString();
     string TheDomain=dr["domain"].ToString();
     Is_Static=dr["html"].ToString();
     if(TheDomain!="")
      {
        Url_Prefix="http://"+TheDomain.Replace("http://","")+"/";
      }
     if(SiteDir!="")
        {
          if(TheDomain=="")
           {
             Url_Prefix="/"+SiteDir+"/";
           }
          else
           {
             Url_Prefix+=SiteDir+"/";
           }
        }
    }
   else
    {
      Is_Static="0";
    }
  dr.Close();
 }


protected string Get_Field(string Table,string Field,string DetailId)
 {
   string rv="";
   int HasTable=1;
   if(IsStr(Table) && IsStr(Field) && IsNum(DetailId))
    {
     OleDbCommand comm;
     OleDbDataReader dr;
     string sql="select id from pa_table where thetable='"+Table+"'";
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

protected  int GetXuhao()
 {
   Xuhao++;
   return Xuhao;
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


 }

 }