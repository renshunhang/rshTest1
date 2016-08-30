using System;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.OleDb;
using PageAdmin;
public partial class Receive : System.Web.UI.Page
{
    protected string v_oid;		// 订单号
    protected string v_pstatus;	// 支付状态码
    //20（支付成功，对使用实时银行卡进行扣款的订单）；
    //30（支付失败，对使用实时银行卡进行扣款的订单）；

    protected string v_pstring;	//支付状态描述
    protected string v_pmode;	//支付银行
    protected string v_md5info;	//MD5校验码
    protected string v_amount;	//支付金额
    protected string v_moneytype;	//币种		
    protected string remark1;	// 备注1
    protected string remark2;	// 备注1

    protected string v_md5str;
    protected string UserName,status_msg,SiteId,R_Url;
    OleDbConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
       Conn Myconn=new Conn();
       conn=Myconn.OleDbConn();//获取OleDbConnection
       conn.Open();
        // MD5密钥要跟订单提交页相同，如Send.asp里的 key = "test" ,修改""号内 test 为您的密钥
        string key = Get_ChinaBank_Key();	// 如果您还没有设置MD5密钥请登陆我们为您提供商户后台，地址：https://merchant3.chinabank.com.cn/
        // 登陆后在上面的导航栏里可能找到“资料管理”，在资料管理的二级导航栏里有“MD5密钥设置”
        // 建议您设置一个16位以上的密钥或更高，密钥最多64位，但设置16位已经足够了

        v_oid = Request["v_oid"];
        v_pstatus = Request["v_pstatus"];
        v_pstring = Request["v_pstring"];
        v_pmode = Request["v_pmode"];
        v_md5str = Request["v_md5str"];
        v_amount = Request["v_amount"];
        v_moneytype = Request["v_moneytype"];
        remark1 = Request["remark1"];
        if(remark1==null){return;}
        remark2 = Request["remark2"];
        UserName=remark1.Split(',')[0];
        SiteId=remark1.Split(',')[1];
        R_Url=Server.UrlDecode(remark1.Split(',')[2]);
        string str = v_oid + v_pstatus + v_amount + v_moneytype + key;
        str = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(str, "md5").ToUpper();    
        if (str == v_md5str)
        {
            if (v_pstatus.Equals("20"))
            {
                //支付成功
                //在这里商户可以写上自己的业务逻辑
               status_msg="支付成功,金额已经转入您的会员名下";
               double Fnc_Amount=double.Parse(v_amount);
               if(!Fnc_rk(v_oid))
                {
                  Update_member_fnc(Fnc_Amount);
                  Update_fnc_list(Fnc_Amount,"网银在线",v_oid,"订单号:"+v_oid);
                  string M_body="支付方式：网银在线<br>订单号："+v_oid+"<br>支付金额："+v_amount;
                  SendMail(M_body);
                  Response.Redirect("/e/info/pay_result.aspx?s="+SiteId+"&pay_no="+v_oid+"&pay_amount="+v_amount+"&r_url="+Server.UrlEncode(R_Url)+"&pay_type="+Server.UrlEncode("网银在线"));
                }
               else
                {
                  Response.Redirect("/e/info/pay_result.aspx?s="+SiteId+"&pay_no="+v_oid+"&pay_amount="+v_amount+"&r_url="+Server.UrlEncode(R_Url)+"&pay_type="+Server.UrlEncode("网银在线"));
                }
            }
        }
        else
        {
           Response.Write("校验失败,数据可疑!");
           Response.End();
        }
      conn.Close();
    }


 private string  Get_ChinaBank_Key()
     {
       string sql="select onlinepay_key from pa_onlinepay where onlinepay_type='chinabank'";
       string Val;
       OleDbCommand comm=new OleDbCommand(sql,conn);
       OleDbDataReader dr=comm.ExecuteReader();
       if(dr.Read())  
        { 
           Val=dr["onlinepay_key"].ToString();;
        }
      else
        {
          Val="";
          Response.Write("error");
          Response.End();
        }
        dr.Close();
       return Val;
     }


private bool Fnc_rk(string OrderId)  //判断是否入款。
  {
   OrderId="chinabank_"+OrderId;
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

  }


private void Update_member_fnc(double Fnc_Amount)
 {
    string sql="update pa_member set fnc_rk=fnc_rk+"+Fnc_Amount+",fnc_ky=fnc_ky+"+Fnc_Amount+" where username='"+Sql_Format(UserName)+"'";
    OleDbCommand Comm=new OleDbCommand(sql,conn);
    Comm.ExecuteNonQuery();
 }

private void Update_fnc_list(double Fnc_Amount,string Rk_way,string OrderId,string Beizhu)
 {
    OrderId="chinabank_"+OrderId;
    string sql="insert into pa_fnc_list([site_id],[thetype],[username],[act],[amount],[detail],[identification],[beizhu],[thedate]) values("+SiteId+",1,'"+Sql_Format(UserName)+"','c',"+Fnc_Amount+",'"+Rk_way+"','"+Sql_Format(OrderId)+"','"+Sql_Format(Beizhu)+"','"+DateTime.Now+"')";
    OleDbCommand Comm=new OleDbCommand(sql,conn);
    Comm.ExecuteNonQuery();
 }

private void  SendMail(string Mail_Body) //发邮件部分
 {
  string FajianName,MailTo,Mail_subject;
  string sql="select fajianname,em_fnc from webset where site_id="+int.Parse(SiteId);
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
}

private string Sql_Format(string str)
 {
  if(string.IsNullOrEmpty(str)){return "";}
   str=str.Replace("'","''");
   str=str.Replace("\"","\""); 
   return str;
 }

private bool IsNum(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="1234567890";
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
