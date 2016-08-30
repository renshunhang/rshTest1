using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
using System.Collections.Generic;
using Com.Alipay;
using PageAdmin;

/// <summary>
/// 功能：服务器异步通知页面
/// 版本：3.2
/// 日期：2011-03-11
/// 说明：
/// 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
/// 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
/// 
/// ///////////////////页面功能说明///////////////////
/// 创建该页面文件时，请留心该页面文件中无任何HTML代码及空格。
/// 该页面不能在本机电脑测试，请到服务器上做测试。请确保外部可以访问该页面。
/// 该页面调试工具请使用写文本函数logResult。
/// 如果没有收到该页面返回的 success 信息，支付宝会在24小时内按一定的时间策略重发通知
/// WAIT_BUYER_PAY(表示买家已在支付宝交易管理中产生了交易记录，但没有付款);
/// WAIT_SELLER_SEND_GOODS(表示买家已在支付宝交易管理中产生了交易记录且付款成功，但卖家没有发货);
/// WAIT_BUYER_CONFIRM_GOODS(表示卖家已经发了货，但买家还没有做确认收货的操作);
/// TRADE_FINISHED(表示买家已经确认收货，这笔交易完成);
/// </summary>
public partial class notify_url : System.Web.UI.Page
{
    string UserName,SiteId;
    OleDbConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        SortedDictionary<string, string> sPara = GetRequestPost();

        if (sPara.Count > 0)//判断是否有带返回参数
        {
            Notify aliNotify = new Notify();
            bool verifyResult = aliNotify.Verify(sPara, Request.Form["notify_id"], Request.Form["sign"]);

            if (verifyResult)//验证成功
            {
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //请在这里加上商户的业务逻辑程序代码

                //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                //获取支付宝的通知返回参数，可参考技术文档中服务器异步通知参数列表
                string trade_no = Request.Form["trade_no"];         //支付宝交易号
                string order_no = Request.Form["out_trade_no"];     //获取订单号
                string total_fee = Request.Form["total_fee"];       //获取总金额
                string subject = Request.Form["subject"];           //商品名称、订单名称
                string body = Request.Form["body"];                 //商品描述、订单备注、描述
                string buyer_email = Request.Form["buyer_email"];   //买家支付宝账号
                string trade_status = Request.Form["trade_status"]; //交易状态
                string zdy_info=Request.Form["extra_common_param"]; //会员，site组合,返回地址组合
                UserName=zdy_info.Split(',')[0];
                SiteId=zdy_info.Split(',')[1];
                if (Request.Form["trade_status"] == "TRADE_FINISHED" || Request.Form["trade_status"] == "TRADE_SUCCESS")
                {
                    //判断该笔订单是否在商户网站中已经做过处理
                    //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                    //如果有做过处理，不执行商户的业务程序
                   //更新自己数据库的订单语句，请自己填写一下
                  double Fnc_Amount=double.Parse(total_fee);

                  Conn Myconn=new Conn();
                  conn=Myconn.OleDbConn();//获取OleDbConnection
                  conn.Open();
                  if(!Fnc_rk(trade_no))
                  {
                    Update_member_fnc(Fnc_Amount);
                    Update_fnc_list(Fnc_Amount,"支付宝即时充值",trade_no,"交易号:"+trade_no);
                    string M_body="支付方式：支付宝即时充值<br>支付宝交易号："+trade_no+"<br>支付金额："+Fnc_Amount;
                    SendMail(M_body);
                  }
                 else
                  {
                    //
                  }
                  conn.Close();

                   Response.Write("success");  //请不要修改或删除
                }
                else
                {
                    Response.Write("success");  //其他状态判断。普通即时到帐中，其他状态不用判断，直接打印success。
                }

                //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
            }
            else//验证失败
            {
                Response.Write("fail");
            }
        }
        else
        {
            Response.Write("无通知参数");
        }
    }

    /// <summary>
    /// 获取支付宝POST过来通知消息，并以“参数名=参数值”的形式组成数组
    /// </summary>
    /// <returns>request回来的信息组成的数组</returns>
    public SortedDictionary<string, string> GetRequestPost()
    {
        int i = 0;
        SortedDictionary<string, string> sArray = new SortedDictionary<string, string>();
        NameValueCollection coll;
        //Load Form variables into NameValueCollection variable.
        coll = Request.Form;

        // Get names of all forms into a string array.
        String[] requestItem = coll.AllKeys;

        for (i = 0; i < requestItem.Length; i++)
        {
            sArray.Add(requestItem[i], Request.Form[requestItem[i]]);
        }

        return sArray;
    }

 public bool Fnc_rk(string OrderId)  //判断是否入款。
  {
   OrderId="alipay_"+OrderId;
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
     OrderId="alipay_"+OrderId;
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

}
