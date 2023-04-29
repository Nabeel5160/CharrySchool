using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminDailyDiary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind_ddClass();
            }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 1;
        }

        public void Bind_ddClass()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT [strClass] as name,nc_id FROM [tbl_Class] WHERE ([bisDeleted] = 0) and nsch_id='" + Session["nschoolid"] + "' ", con);
                SqlDataReader dr = cmd.ExecuteReader();

                ddcl.Items.Clear();
                ddcl.Items.Add("--Please Select Class--");
                ddcl.DataSource = dr;
                ddcl.DataTextField = "name";
                ddcl.DataValueField = "nc_id";
                ddcl.DataBind();
                con.Close();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        public void Bind_ddSection()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT [strSection] as name,nsc_id FROM [tbl_Section] WHERE ([bisDeleted] = 0) and nu_id='"+Session["uid"]+"' and  nc_id='" + ddcl.SelectedItem.Value + "' and nsch_id='" + Session["nschoolid"] + "' ", con);
                SqlDataReader dr = cmd.ExecuteReader();

                ddst.Items.Clear();
                //ddst.Items.Add("--Please Select Class--");
                ddst.DataSource = dr;
                ddst.DataTextField = "name";
                ddst.DataValueField = "nsc_id";
                ddst.DataBind();
                con.Close();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        private string SendSMSToURL(string getUri)
        {

            string SentResult = String.Empty;
            string StatusCode = String.Empty;

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(getUri);

            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            StreamReader responseReader = new StreamReader(response.GetResponseStream());

            String resultmsg = responseReader.ReadToEnd();
            responseReader.Close();

            int StartIndex = 0;
            int LastIndex = resultmsg.Length;

            if (LastIndex > 0)
                SentResult = resultmsg.Substring(StartIndex, LastIndex);

            HttpStatusCode objHSC = response.StatusCode;

            StatusCode = objHSC.GetHashCode().ToString();

            responseReader.Dispose();

            return SentResult;

        }
        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            string cid = ddcl.SelectedItem.Value;
            string number = "";
            string message = txtdiary.Text;
            foreach (ListItem items in ddst.Items)
            {
                if (items.Selected)
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    
                    cmd.CommandText = "select e.* from tbl_Enrollment e inner join tbl_Class c on e.nc_id=c.nc_id where e.nc_id='" + cid + "' and nsc_id='"+ddst.SelectedItem.Value+"'";
                    dr = cmd.ExecuteReader();
                    List<AdminFunctions> tempList = null;
                    tempList = new List<AdminFunctions>();
                    while (dr.Read())
                    {
                        AdminFunctions af = new AdminFunctions();
                        af.sch_parentnum = "92" + dr["strPhone"].ToString().Substring(1);
                        af.sch_class = dr["nc_id"].ToString();
                        af.sch_school = dr["nsc_id"].ToString();
                        af.eid = dr["ne_id"].ToString();
                        af.pid = dr["nu_id"].ToString();
                        tempList.Add(af);
                    }
                    tempList.TrimExcess();
                    con.Close();
                    foreach (var c in tempList)
                    {
                        System.Threading.Thread.Sleep(1000);
                        string url = "http://websms.fc.net.pk/sendsms.php?username=fr_mschool&password=mschool123&sender=MUSLIM intl&phone=" + c.sch_parentnum + "&message=" + message + "";

                        SendSMSToURL(url);

                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_Notification(ne_id,nc_id,nsc_id,nu_id,strDesc,strSMS,bisStatus,dtAddDate,nsch_id)values(@eid,@cid,@scid,@uid,@desc,'SMS','1',CONVERT(DATE,SYSDATETIME()),@schid)";
                        cmd.Parameters.AddWithValue("@eid", c.eid);
                        cmd.Parameters.AddWithValue("@cid", c.sch_class);
                        cmd.Parameters.AddWithValue("@scid", c.sch_school);
                        cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                        cmd.Parameters.AddWithValue("@desc", message);
                        cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                        con.Close();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_SendSMS(nUserId,nParentId,strNumber,strMessage,bisSent,dtSendDate,nsch_id)values(@uid,@pid,@numb,@msg,'1',CONVERT(DATE,SYSDATETIME()),@schid)";
                        cmd.Parameters.AddWithValue("@uid", Session["uid"]);
                        cmd.Parameters.AddWithValue("@pid", c.pid);
                        cmd.Parameters.AddWithValue("@numb", c.sch_parentnum);
                        cmd.Parameters.AddWithValue("@msg", message);
                        cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                        con.Close();
                    }
                    tempList.Clear();
                }
            }
            txtdiary.Text = "";
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Diary Successfully Sent.');", true);

        }

        protected void ddcl_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bind_ddSection();
        }
    }
}