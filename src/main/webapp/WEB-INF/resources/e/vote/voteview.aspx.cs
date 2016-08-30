using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.OleDb;
namespace PageAdmin
 {
 public class voteview:Page
 {
  protected Repeater P;
  protected string VoteTitle,StartDate,EndDate,Thetype,QuesionId,Per;
  protected int Id,I,BarWidth;
  OleDbConnection conn;

protected void Page_Load(Object sender,EventArgs e)
   {
     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
     conn.Open();
      I=1;
      Get_Vote();
     conn.Close();
   }


private void Get_Vote()
 {
  if(IsNum(Request.QueryString["id"]))
   {
     Id=int.Parse(Request.QueryString["id"]);
     string sql="select [title],[enddate],[startdate] from pa_vote where id="+Id;
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     if(dr.Read())
      {
        VoteTitle=dr["title"].ToString();
        StartDate=dr["startdate"].ToString().Split(' ')[0];
        EndDate=dr["enddate"].ToString().Split(' ')[0];
        Data_Bind();
      }
     else
      {
        Response.Write("<script type='text/javascript'>alert('参数错误!');window.close()</script>");
        Response.End();
      }
    dr.Close();
   }
  else
   {
        Response.Write("<script type='text/javascript'>alert('参数错误!');window.close()</script>");
        Response.End();
   }

 }

private void Data_Bind()
 {
  if(IsNum(Request.QueryString["id"]))
   {
     Id=int.Parse(Request.QueryString["id"]);
     string sql="select quesion,id,thetype from pa_vote_quesions where vote_id="+Id+" order by xuhao";
     DataSet ds=new DataSet();
     OleDbDataAdapter AD=new OleDbDataAdapter(sql,conn);
     AD.Fill(ds,"tb");
     P.DataSource=ds.Tables["tb"].DefaultView;
     P.DataBind();
   }
 }

private DataView Choice_Bind(int QuesionId)
 {
     string sql="select [id],[choice],[num] from pa_vote_choices where quesion_id="+QuesionId+" order by xuhao";
     DataSet ds=new DataSet();
     OleDbDataAdapter AD=new OleDbDataAdapter(sql,conn);
     AD.Fill(ds,"tb");
     return ds.Tables["tb"].DefaultView;
 }

protected string GetPercent(string Num,string Quesion_Id)
 {
   int tj=0;
   Per="0%";
   BarWidth=1;
   string sql="select sum([num]) as tj from pa_vote_choices where quesion_id="+int.Parse(QuesionId);
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
      tj=int.Parse(dr["tj"].ToString());
    }
   if(tj>0)
    {
      BarWidth=(int)((float.Parse(Num)/(float)tj)*(float)100);
      if(BarWidth<1)
       {
         BarWidth=1;
       }
      Per=((float.Parse(Num)/(float)tj)*(float)100).ToString("f2")+"%";
      if(Per=="100.00%")
       {
         Per="100%";
       }
    }
   return "";
 }

protected void Data_Bound(Object sender,RepeaterItemEventArgs e)
 { 
  if (e.Item.ItemType   ==   ListItemType.Item   ||   e.Item.ItemType   ==   ListItemType.AlternatingItem) 
    { 
       Label Lb_type=(Label)e.Item.FindControl("Lb_thetype");
       Label Lb_id=(Label)e.Item.FindControl("Lb_id");
       Repeater P_1=(Repeater)e.Item.FindControl("P1");
       if(Lb_type.Text=="multiple")
        {
          Thetype="checkbox";
        }
       else
        {
          Thetype="radio";
        }
        QuesionId=Lb_id.Text;
        P_1.DataSource=Choice_Bind(int.Parse(QuesionId));
        P_1.DataBind();
    }
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