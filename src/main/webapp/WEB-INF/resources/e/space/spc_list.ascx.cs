using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Text;
using System.Text.RegularExpressions;

namespace PageAdmin
 {
  public class spc_list:UserControl
  {
   protected Panel P_Page;
   protected Repeater Plist;
   protected string TableName,UserName,UID;
   protected int PageSize,RecordCount,PageCount,CurrentPage;
   OleDbConnection conn;
   int Is_Static,Tid;
   string Url_Prefix,TheTable,sql;

   protected void Page_Load(Object sender,EventArgs e)
    {
         Conn Myconn=new Conn();
         conn=Myconn.OleDbConn();
         PageSize=20;
         if(IsNum(Request.QueryString["page"]))
         {
          CurrentPage=int.Parse(Request.QueryString["page"]);
         }
        else
         {
          CurrentPage=1;
         }
         if(IsNum(Request.QueryString["tid"]))
         {
          Tid=int.Parse(Request.QueryString["tid"]);
          UID=Request.QueryString["uid"];
          conn.Open();
           Get_Table();
           Get_UserName();
           Tongji();
           List_Bind();
         conn.Close();
        }
    }


private void Get_UserName()
 {
  UserName="";
  sql="select username from pa_member where id="+UID;
  OleDbCommand comm=new OleDbCommand(sql,conn);
  OleDbDataReader dr=comm.ExecuteReader();
  if(dr.Read())
   {
     UserName=dr["username"].ToString();
   }
   dr.Close();
 }

private void Get_Table()
  {
   sql="select [thetable],[table_name] from pa_table where id="+Tid;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
      TheTable=dr["thetable"].ToString();
      TableName=dr["table_name"].ToString();
    }
  else
    {
       TheTable="";
       TableName="";
       dr.Close();
       Response.Write("<script type='text/javascript'>alert('无效的tid!');location.href='/e/space/?uid="+UID+"'</script>");
       Response.End();
    }
    dr.Close();
  }

private void Tongji()
  { 
    if(UserName!="")
     {
     sql="select count(id) as co from "+TheTable+" where checked=1 and username='"+UserName+"'";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr= comm.ExecuteReader();
     if(dr.Read())
      {
      RecordCount=int.Parse(dr["co"].ToString());
      }
     else
      {
      RecordCount=0;
      }
     dr.Close();
     if(RecordCount%PageSize==0)
       {
        PageCount=RecordCount/PageSize;
       }
       else
       {
       PageCount=RecordCount/PageSize+1;
       }
    }
  }

private void List_Bind()
   {
     if(UserName!="")
      {
     sql="select site_id,sort_id,id,title,lanmu_id,sublanmu_id,thedate,static_dir,static_file,zdy_url, permissions,clicks,html from "+TheTable+" where sublanmu_id>0 and checked=1 and username='"+UserName+"' order by thedate desc";
     if(CurrentPage>PageCount)
      {
        CurrentPage=PageCount;
      }
     if(CurrentPage<1)
      {
        CurrentPage=1;
      }
     if(PageCount<2)
      {
        P_Page.Visible=false;
      }
     DataSet ds=new  DataSet(); 
     OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
     myAdapter.Fill(ds,(CurrentPage-1)*PageSize,PageSize,"default");
     Plist.DataSource =ds.Tables["default"].DefaultView;
     Plist.DataBind();
     }
   }



protected string GoPage(int Page)
 {
  string Rv;
   Rv="/e/space/?uid="+UID+"&tid="+Tid.ToString()+"&page="+Page.ToString();
  return Rv;
 }

protected void Data_Bound(Object sender,RepeaterItemEventArgs e)
 { 
 if (e.Item.ItemType   ==   ListItemType.Item   ||   e.Item.ItemType   ==   ListItemType.AlternatingItem) 
    { 

    }
 }

protected string DetailUrl(string SiteId,string Static_dir,string Static_file,string Lanmu_Id,string SubLanmu_Id,string Id,string ZdyUrl,string Permissions,string Html)
 {
  string Rv;
  if(ZdyUrl!="")
   {
     Rv=ZdyUrl;
   }
  else
   {
    Get_Site(int.Parse(SiteId));
    if(Is_Static==1)
     {
       switch(Html)
        {
          case "2":
           if(Permissions=="")
            {Rv=Url_Prefix+Static_dir+"/"+(Static_file==""?Id+".html":Static_file);}
           else
            {Rv=Url_Prefix+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;}
          break;

          case "1":
            Rv=Url_Prefix+TheTable+"/detail_"+Id+".html";
          break;

          default:
            Rv=Url_Prefix+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;
          break;
        }
     }
    else
     {
       Rv=Url_Prefix+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;
     }
   }
  return Rv;
 }

private void Get_Site(int sid)
 {
   Url_Prefix="/";
   sql="select [directory],[domain],[html] from pa_site where id="+sid;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     string SiteDir=dr["directory"].ToString();
     string TheDomain=dr["domain"].ToString();
     Is_Static=int.Parse(dr["html"].ToString());
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
   dr.Close();
 }

protected string GetSortName(string sortid)
 {
   string Rv="";
   sql="select sort_name from pa_sort where id="+int.Parse(sortid);
   OleDbCommand  myComm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=myComm.ExecuteReader();
   if(dr.Read())
    {
      Rv="["+dr["sort_name"].ToString()+"]";
    }
   dr.Close();
   return Rv;
 }

protected string SubStr(string Title,int Title_Num,bool HtmlEncode) 
{ 
   if(Title_Num==0)
    {
      return "";
    }
   else
    {
       Regex regex = new Regex("[\u4e00-\u9fa5]+", RegexOptions.Compiled); 
       char[] stringChar = Title.ToCharArray(); 
       StringBuilder sb = new StringBuilder(); 
       int nLength = 0; 
      for(int i = 0; i < stringChar.Length; i++) 
       { 
          if (regex.IsMatch((stringChar[i]).ToString())) 
           { 
            nLength += 2; 
           } 
         else 
           { 
             nLength = nLength + 1; 
           } 
         if(nLength <= Title_Num) 
          { 
           sb.Append(stringChar[i]); 
          } 
        else 
         { 
          break; 
         } 
      } 
     if(sb.ToString() != Title) 
      { 
         sb.Append("..."); 
      } 
    if(HtmlEncode)
      {
        return Server.HtmlEncode(sb.ToString());
      }
    else
      {
        return sb.ToString(); 
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

 }
 }
