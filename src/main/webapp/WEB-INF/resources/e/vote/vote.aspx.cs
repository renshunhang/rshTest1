using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.OleDb;
namespace PageAdmin
 {
 public class vote:Page
 {
  protected Repeater P;
  OleDbConnection conn;
  protected string VoteTitle,StartDate,EndDate,Thetype,QuesionId,QuesionIds;
  protected int Id,I;
  string SiteId,PLanguage,VoteSet,LangJs;

protected void Page_Load(Object sender,EventArgs e)
   {
     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
     conn.Open();
      if(Request.Form["vote"]=="1")
        {
         Check_Post();
         Get_Vote();
         Get_Site(int.Parse(SiteId));
         Get_QIds(int.Parse(Request.QueryString["id"]));
         Get_Post();
        }
      else
        {
         I=1;
         Get_Vote();
         Get_QIds(int.Parse(Request.QueryString["id"]));
         Data_Bind();
        }
     conn.Close();
   }


private void Get_Vote()
 {
  if(IsNum(Request.QueryString["id"]))
   {
     Id=int.Parse(Request.QueryString["id"]);
     string sql="select [site_id],[title],[enddate],[startdate],[voteset] from pa_vote where id="+Id;
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     if(dr.Read())
      {
        SiteId=dr["site_id"].ToString();
        VoteTitle=dr["title"].ToString();
        StartDate=dr["startdate"].ToString().Split(' ')[0];
        EndDate=dr["enddate"].ToString().Split(' ')[0];
        VoteSet=dr["voteset"].ToString();
      }
     else
      {
        SiteId="0";
        Response.End();
      }
    dr.Close();
   }
  else
   {
     SiteId="0";
     Response.Write("<script type='text/javascript'>alert('您好，请先设置好问卷问题!');window.close()</script>");
     Response.End();
   }

 }

private void Get_QIds(int Vid)
 {
     QuesionIds="";
     string sql="select [id] from pa_vote_quesions where vote_id="+Vid;
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     while(dr.Read())
      {
        QuesionIds+=dr["id"].ToString()+",";
      }
    dr.Close();
    if(QuesionIds=="")
     {
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


private void Get_Post()
 {
   if(IsDate(EndDate)) //检查时间
    {
      if(DateTime.Compare(DateTime.Now,DateTime.Parse(EndDate))>0)
       {
          Response.Write(LangJs+"<script type='text/javascript'>VoteBack('vote has ended','/e/vote/voteview.aspx?id="+Id+"');</script>");
          Response.End();
       }
    }

   if(VoteSet=="1")
    {
      if(Request.Cookies["vote"]!=null)
       {
        Response.Write(LangJs+"<script type='text/javascript'>VoteBack('repeat vote','/e/vote/voteview.aspx?id="+Id+"');</script>");
        Response.End();
       }
    }

   string[] AQuesionIds=QuesionIds.Split(',');
   string QValue;
   for(int i=0;i<AQuesionIds.Length;i++)
    {
      if(AQuesionIds[i]=="")
        {
          break;
        }
      else
        {
          QValue=Request.Form["q"+AQuesionIds[i]];  
          if(QValue==null || QValue=="")
           {
             Response.Write(LangJs+"<script type='text/javascript'>VoteBack('not completed','/e/vote/voteview.aspx?id="+Id+"');</script>");
             Response.End();
           }
          else
           {
             Add_Choice(QValue);
           }
        }
    }


//定义cookie==========================================
       HttpCookie vc=new HttpCookie("vote");
        vc.Expires=DateTime.Now.AddDays(1);
       Response.AppendCookie(vc);
//定义cookie=========================================

  Response.Write(LangJs+"<script type='text/javascript'>VoteBack('success','/e/vote/voteview.aspx?id="+Id+"');</script>");
  Response.End();
 }

private void Add_Choice(string ChoiceIds)
 {
  string sql;
  OleDbCommand comm;
  string[] AIds=ChoiceIds.Split(',');
  for(int i=0;i<AIds.Length;i++)
    {
      if(IsNum(AIds[i]))
       {
         sql="update pa_vote_choices set [num]=[num]+1 where id="+int.Parse(AIds[i]);
         comm=new OleDbCommand(sql,conn);
         comm.ExecuteNonQuery();
       }
    }

 }

private void Check_Post()
 {
    string PostUrl=Request.ServerVariables["HTTP_REFERER"];
    string LocalUrl=Request.ServerVariables["SERVER_NAME"];
    if(PostUrl!=null)
      {
         if(PostUrl.Replace("http://","").Split('/')[0].Split(':')[0]!=LocalUrl)
          {
             Response.Write("<script type='text/javascript'>alert('Invalid Submit');window.close()</script>");
             Response.End();
          }
      }
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

private void Get_Site(int sid)
 {
   string sql="select [language] from pa_site where id="+sid;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     PLanguage=dr["language"].ToString();
     LangJs="<script src=\"/e/js/"+PLanguage+"/vote.js\" type=\"text/javascript\"></script>";
    }
   else
    {
     PLanguage="";
     LangJs="";
     Response.Write("<script type='text/javascript'>alert('invalid siteid!');window.close()</script>");
     Response.End();
    }
   dr.Close();
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

private bool IsDate(string str)
 {
  //日期
  if(System.Text.RegularExpressions.Regex.IsMatch((str==null?"":str), @"^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-9]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$"))
   {
     return true;
   }
  else
   {
    //日期+时间
    return System.Text.RegularExpressions.Regex.IsMatch((str==null?"":str), @"^(((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-)) (20|21|22|23|[0-1]?\d):[0-5]?\d:[0-5]?\d)$");
   }
 }


 }

 }