using System;
using System.Collections;
using System.Web;
using System.Data;
using System.Data.OleDb;
using PageAdmin;
namespace tenpay
{
	/// <summary>
	/// return_url 的摘要说明。
	/// </summary>
	public partial class return_url : System.Web.UI.Page
	{
                string UserName,SiteId,R_Url,url;
                OleDbConnection conn;
		protected void Page_Load(object sender, System.EventArgs e)
		{
                    Conn Myconn=new Conn();
                    conn=Myconn.OleDbConn();//获取OleDbConnection
                    conn.Open();

		    string key =Get_Key();//密钥

			//创建PayResponseHandler实例
			PayResponseHandler resHandler = new PayResponseHandler(Context);

			resHandler.setKey(key);

			//判断签名
			if(resHandler.isTenpaySign()) 
			{
				//交易单号
				string transaction_id = resHandler.getParameter("transaction_id");
	
				//金额金额,以分为单位
				string total_fee = resHandler.getParameter("total_fee");
	
				//支付结果
				string pay_result = resHandler.getParameter("pay_result");

	                       string zdy_info=resHandler.getParameter("attach"); //会员和site组合，r-url组合
                               UserName=zdy_info.Split(',')[0];
                               SiteId=zdy_info.Split(',')[1];
                               R_Url=Server.UrlDecode(zdy_info.Split(',')[2]);
				if( "0".Equals(pay_result) ) 
				{
					//------------------------------
					//处理业务开始
					//------------------------------ 
					//注意交易单不要重复处理
					//注意判断返回金额
		                   string sp_billno=resHandler.getParameter("sp_billno"); //订单号
                                   double Fnc_Amount=(double.Parse(total_fee)/100);
                                   if(!Fnc_rk(sp_billno))
                                     {
                                       Update_member_fnc(Fnc_Amount);
                                       Update_fnc_list(Fnc_Amount,"财付通即时充值",sp_billno,"订单号:"+sp_billno);
                                       string M_body="支付方式：财付通即时充值<br>财付通订单号："+sp_billno+"<br>支付金额："+Fnc_Amount;
                                       SendMail(M_body);
                                     }
                                  else
                                    {
                                      //
                                    }
			           conn.Close();
					//------------------------------
					//处理业务完毕
					//------------------------------
					//调用doShow, 打印meta值跟js代码,告诉财付通处理成功,并在用户浏览器显示$show页面.
					resHandler.doShow("http://"+url+"/e/member/onlinepay/tenpay/show.aspx?s="+SiteId+"&total_fee="+Fnc_Amount+"&sp_billno="+sp_billno+"&r_url="+Server.UrlEncode(R_Url));
				} 
				else 
				{
					//当做不成功处理
	                                 conn.Close();
					Response.Write("支付失败");
				}
	
			} 
			else 
			{
                                conn.Close();
				Response.Write("认证签名失败");
				//string debugInfo = resHandler.getDebugInfo();
				//Response.Write("<br/>debugInfo:" + debugInfo);
			}


		}


   private string Get_Key()
     {
       string rv;
       string sql="select * from pa_onlinepay where onlinepay_type='tenpay'";

       OleDbCommand comm=new OleDbCommand(sql,conn);
       OleDbDataReader dr=comm.ExecuteReader();
       if(dr.Read())  
        { 
          url=dr["url"].ToString();  
          rv=dr["onlinepay_key"].ToString();                  //密钥
        }
       else
        {
          url="";
          rv="";
        }
       dr.Close();
       return rv;
     }

 public bool Fnc_rk(string OrderId)  //判断是否入款。
  {
   OrderId="tenpay_"+OrderId;
   string sql="select id from pa_fnc_list where identification='"+Sql_Format(OrderId)+"' and thetype=1 and username='"+Sql_Format(UserName)+"'";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())  
     { 
       return true;
     }
   else
     {
       return false;
     }
   dr.Close();
  }


public void Update_member_fnc(double Fnc_Amount)
 {
     string sql="update pa_member set fnc_rk=fnc_rk+"+Fnc_Amount+",fnc_ky=fnc_ky+"+Fnc_Amount+" where username='"+Sql_Format(UserName)+"'";
     OleDbCommand Comm=new OleDbCommand(sql,conn);
     Comm.ExecuteNonQuery();
 }

public void Update_fnc_list(double Fnc_Amount,string Rk_way,string OrderId,string Beizhu)
 {
     OrderId="tenpay_"+OrderId;
     string sql="insert into pa_fnc_list([site_id],[thetype],[username],[act],[amount],[detail],[identification],[beizhu],[thedate]) values("+SiteId+",1,'"+Sql_Format(UserName)+"','c',"+Fnc_Amount+",'"+Rk_way+"','"+Sql_Format(OrderId)+"','"+Sql_Format(Beizhu)+"','"+DateTime.Now+"')";
     OleDbCommand Comm=new OleDbCommand(sql,conn);
     Comm.ExecuteNonQuery();

 }

private void  SendMail(string Mail_Body) //发邮件部分
 {
  string FajianName,MailTo,Mail_subject;
  string sql="select fajianname,em_fnc from pa_webset where site_id="+int.Parse(SiteId);
  OleDbCommand comm=new OleDbCommand(sql,conn);
  OleDbDataReader dr=comm.ExecuteReader();
  if(dr.Read())
   {
    FajianName=dr["fajianname"].ToString();
    MailTo=dr["em_fnc"].ToString();
    Mail_subject="来自"+FajianName+"的在线支付通知";
    if(MailTo!="")
     {
      PageAdmin.SendMessage Mail=new PageAdmin.SendMessage(int.Parse(SiteId));   
      Mail.SendEmail(MailTo,"","",Mail_subject,Mail_Body);//发邮件
     }
   } 
 dr.Close();
}

private string Sql_Format(string str)
 {
  if(string.IsNullOrEmpty(str)){return "";}
   str=str.Replace("'","''");
   str=str.Replace("\"","\""); 
   return str;
 }


		#region Web 窗体设计器生成的代码
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: 该调用是 ASP.NET Web 窗体设计器所必需的。
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// 设计器支持所需的方法 - 不要使用代码编辑器修改
		/// 此方法的内容。
		/// </summary>
		private void InitializeComponent()
		{    

		}
		#endregion
	}

}
