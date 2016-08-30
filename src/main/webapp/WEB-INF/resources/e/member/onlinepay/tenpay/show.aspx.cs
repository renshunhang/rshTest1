using System;

namespace tenpayApp
{
	/// <summary>
	/// show 的摘要说明。
	/// </summary>
	public partial class show : System.Web.UI.Page
	{
		protected void Page_Load(object sender, System.EventArgs e)
		{
		  //Response.Write("支付成功！");
                  string R_Url=Server.UrlDecode(Request.QueryString["r_url"]);
                  Response.Redirect("/e/info/pay_result.aspx?s="+Request.QueryString["s"]+"&pay_no="+Request.QueryString["sp_billno"]+"&pay_amount="+Request.QueryString["total_fee"]+"&r_url="+Server.UrlEncode(R_Url)+"&pay_type="+Server.UrlEncode("财付通"));
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
