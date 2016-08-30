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
  public class spc_newlist:UserControl
  {
   protected Repeater Pnew;
   protected Label lb_info;
   OleDbConnection conn;
   protected string UID,UserName;
   int Is_Static,MType_Id,Department_Id;
   string Url_Prefix,TheTable,sql;
   protected void Page_Load(Object sender,EventArgs e)
    {
         Conn Myconn=new Conn();
         conn=Myconn.OleDbConn();
         conn.Open();
          List_Bind();
         conn.Close();
    }

private void List_Bind()
 { 
   string tables="";
   UID=Request.QueryString["uid"];
   UserName="";
   sql="select username,mtype_id,department_id from pa_member where id="+UID;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     UserName=dr["username"].ToString();
     MType_Id=int.Parse(dr["mtype_id"].ToString());
     Department_Id=int.Parse(dr["department_id"].ToString());
    }
   dr.Close();
   if(Department_Id>0)
   {
    sql="select thetable from pa_table where thetable in(select thetable from pa_member_tgset where department_id="+Department_Id+") order by xuhao";
   }
  else
   {
    sql="select thetable from pa_table where thetable in(select thetable from pa_member_tgset where mtype_id="+MType_Id+") order by xuhao";
   }
   comm=new OleDbCommand(sql,conn);
   dr=comm.ExecuteReader();
   while(dr.Read())
    {
     tables=tables+","+dr["thetable"].ToString();
    }
   dr.Close();
   DataSet ds=new DataSet();
   OleDbDataAdapter myadapter;
   if(UserName!="" && tables!="")
    {
     string[] Atables=tables.Split(',');
     for(int i=0;i<Atables.Length;i++)
     {
      if(Atables[i]==""){continue;}
      sql="select top 15 id,site_id,sort_id,id,title,lanmu_id,sublanmu_id,static_dir,Static_file,zdy_url,permissions,clicks,[html],thedate,'"+Atables[i]+"' as thetable from "+Atables[i]+" where sublanmu_id>0 and checked=1 and username='"+UserName+"' order by thedate desc";
      myadapter=new OleDbDataAdapter(sql,conn);
      myadapter.Fill(ds,"default");
     }
     if(ds.Tables["default"].Rows.Count>0)
     {
       DataView dv=new DataView();
       dv.Table=GetTable(ds.Tables["default"],"thedate desc");
       Pnew.DataSource=dv;
       Pnew.DataBind();
      lb_info.Visible=false;
     }

    }
 }


private DataTable GetTable(DataTable sorucedt,string orderby)
  {
   sorucedt.DefaultView.Sort=orderby;
   DataTable newdt = sorucedt.DefaultView.ToTable();
   for (int i=newdt.Rows.Count-1;i>19;i--)
        {
         newdt.Rows[i].Delete();
        }
   return newdt;
  }

protected void Data_Bound(Object sender,RepeaterItemEventArgs e)
 { 
 if (e.Item.ItemType   ==   ListItemType.Item   ||   e.Item.ItemType   ==   ListItemType.AlternatingItem) 
    { 

    }
 }

protected string DetailUrl(string Table,string SiteId,string Static_dir,string Static_file,string Lanmu_Id,string SubLanmu_Id,string Id,string ZdyUrl,string Permissions,string Html)
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
            Rv=Url_Prefix+Table+"/detail_"+Id+".html";
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

private bool Has_Data(string thetable)
 {
   bool Rv=false;
   sql="select id from "+thetable+" where checked=1 and username='"+UserName+"'";
   OleDbCommand  myComm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=myComm.ExecuteReader();
   if(dr.Read())
    {
      Rv=true;
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
