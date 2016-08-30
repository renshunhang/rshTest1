using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Data.OleDb;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using PageAdmin;
//---------------------------------------------------------
//财付通即时到帐支付请求示例，商户按照此文档进行开发即可
//---------------------------------------------------------

namespace tenpay
{
	/// <summary>
	/// index 的摘要说明。
	/// </summary>
        
	public partial class index : System.Web.UI.Page
	{
                string UserName,SiteId,R_Url,bargainor_id,key,url;
		protected void Page_Load(object sender, System.EventArgs e)
		{

                     if(IsNum(Request.QueryString["s"]))
                      {
                        SiteId=Request.QueryString["s"];
                        Member_Valicate MCheck=new Member_Valicate();
                        MCheck.Member_Check(true,int.Parse(SiteId));
                        UserName=MCheck._UserName;
                        R_Url=Request.QueryString["r_url"];
                        if(string.IsNullOrEmpty(R_Url)){R_Url="";}
                      }
                   else
                      {
                        UserName="";
                        SiteId="";
                        Response.Write("<script type='text/javascript'>alert('invalid siteid!');</script>");
                        Response.End();
                      }

                   if(IsFloat(Request.Form["pay_fee"]))
                    {
	
                        Get_TenPay();
                        float Total_Fee=float.Parse(Request.Form["pay_fee"])*100;
	
			//当前时间 yyyyMMdd
			string date = DateTime.Now.ToString("yyyyMMdd");

			//生成订单10位序列号，此处用时间和随机数生成，商户根据自己调整，保证唯一
			string strReq = "" + DateTime.Now.ToString("HHmmss") + TenpayUtil.BuildRandomStr(4);

			//商户订单号，不超过32位，财付通只做记录，不保证唯一性
			string sp_billno = DateTime.Now.ToString("yyyyMMddHHmmss") + TenpayUtil.BuildRandomStr(4);

			//财付通订单号，10位商户号+8位日期+10位序列号，需保证全局唯一
			string transaction_id = bargainor_id + date + strReq;
			string return_url = "http://"+url+"/e/member/onlinepay/tenpay/return_url.aspx";

			//创建PayRequestHandler实例
			PayRequestHandler reqHandler = new PayRequestHandler(Context);

			//设置密钥
			reqHandler.setKey(key);

			//初始化
			reqHandler.init();

			//-----------------------------
			//设置支付参数
			//-----------------------------
			reqHandler.setParameter("bargainor_id", bargainor_id);			//商户号
			reqHandler.setParameter("sp_billno", sp_billno);				//商家订单号
			reqHandler.setParameter("transaction_id", transaction_id);		//财付通交易单号
			reqHandler.setParameter("return_url", return_url);				//支付通知url
			reqHandler.setParameter("desc", "订单号：" + transaction_id);	//商品名称
			reqHandler.setParameter("total_fee",Total_Fee.ToString("f0"));						//商品金额,以分为单位
			reqHandler.setParameter("cs","utf-8");	
                        reqHandler.setParameter("attach",UserName+","+SiteId+","+Server.UrlEncode(R_Url));
			reqHandler.setParameter("spbill_create_ip",Page.Request.UserHostAddress);//用户ip,测试环境时不要加这个ip参数，正式环境再加此参数
			string requestUrl = reqHandler.getRequestURL();
                        Response.Redirect(requestUrl);
                         
			//获取请求带参数的url
			/*
			string a_link = "<a target=\"_blank\" href=\"" + requestUrl + "\">" + "财付通支付" + "</a>";

			Response.Write(a_link);
			*/

			//post实现方式
			/*
			reqHandler.getRequestURL();
			Response.Write("<form method=\"post\" action=\""+ reqHandler.getGateUrl() + "\" >\n");
			Hashtable ht = reqHandler.getAllParameters();
			foreach(DictionaryEntry de in ht) 
			{
				Response.Write("<input type=\"hidden\" name=\"" + de.Key + "\" value=\"" + de.Value + "\" >\n");
			}
			Response.Write("<input type=\"submit\" value=\"财付通支付\" >\n</form>\n");
			*/
			
			//获取debug信息
			//string debuginfo = reqHandler.getDebugInfo();
			//Response.Write("<br/>" + debuginfo + "<br/>");
			
			//重定向到财付通支付
			//reqHandler.doSend();
                   }
		}

   private void Get_TenPay()
     {

       OleDbConnection conn;
       Conn Myconn=new Conn();
       conn=Myconn.OleDbConn();//获取OleDbConnection
       string sql="select * from pa_onlinepay where onlinepay_type='tenpay'";
       conn.Open();
       OleDbCommand comm=new OleDbCommand(sql,conn);
       OleDbDataReader dr=comm.ExecuteReader();
       if(dr.Read())  
        { 
	   bargainor_id=dr["onlinepay_mid"].ToString();		//商户号
           key=dr["onlinepay_key"].ToString();                  //密钥
           url=dr["url"].ToString();  
        }
       else
        {
          bargainor_id="";
          key="";
          url="";
        }
       dr.Close();
       conn.Close();
     }

private bool IsFloat(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="0123456789.";
  if((str.Length-str.Replace(".",String.Empty).Length)>1)
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
