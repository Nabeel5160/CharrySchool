using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.Sql;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Collections;

namespace SchoolPRO
{
    public partial class TeacherViewDiary : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {

                    BindGrid();

                }
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
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select n.nntf_id,c.strClass,sc.strSection,s.strSubject,n.strDesc,n.strTitle,n.dtDate,n.dtAddDate as dt,n.strTime from tbl_Notification n inner join tbl_Section sc on n.nsc_id=sc.nsc_id inner join tbl_Subject s on n.nsbj_id=s.nsbj_id inner join tbl_Class c on n.nc_id=c.nc_id inner join tbl_ClassIncharge ci on n.nc_id=ci.nc_id and n.nsc_id=ci.nsc_id inner join tbl_Users u on n.nu_id=u.nu_id  where u.nlevel='2' and u.nu_id='" + Session["uid"] + "' And n.bisDeleted='False' And n.nsch_id='" + Session["nschoolid"] + "'";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            con.Close();
            return objDs.Tables[0];

        }
        private void BindGrid()
        {
            try
            {
                DataTable dt = GetRecords();
                if (dt.Rows.Count > 0)
                {
                    gvsearchsub.DataSource = dt;
                    gvsearchsub.DataBind();
                }
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

        protected void btncompose_Click(object sender, EventArgs e)
        {
           
            foreach(GridViewRow gvr in gvsearchsub.Rows)
            {
                if(gvr.RowType==DataControlRowType.DataRow)
                {
                    lblcl.Text = gvr.Cells[2].Text;
                    lblsc.Text = gvr.Cells[3].Text;
                    txtdiary.Text = txtdiary.Text + " " + gvr.Cells[4].Text + "  " + gvr.Cells[5].Text + " " + gvr.Cells[6].Text + Environment.NewLine;
                }
            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {

        }

        protected void btnsend_Click(object sender, EventArgs e)
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select strMobile FROM tbl_Enrollment WHERE nc_id =(select nc_id from tbl_Class where strClass=@nc_id) and nsc_id=(select nsc_id from tbl_Section where nc_id=(select nc_id from tbl_Class where strClass=@nc_id) and strSection=@nsc_id) and bisDeleted='False'";
            cmd.Parameters.AddWithValue("@nc_id", lblcl.Text);
            cmd.Parameters.AddWithValue("@nsc_id", lblsc.Text);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ///sms code ...
                ///
                string number = dr["strMobile"].ToString();
                string message = txtdiary.Text;
                ////////////////////////////////////////////////////////////////////////////////////////////

                string ozSURL = "http://127.0.0.1"; //where Ozeki NG SMS Gateway is running
                string ozSPort = "9501"; //port number where Ozeki NG SMS Gateway is listening
                string ozUser = HttpUtility.UrlEncode("admin"); //username for successful login
                string ozPassw = HttpUtility.UrlEncode("admin"); //user's password
                string ozMessageType = "SMS:TEXT"; //type of message
                string ozRecipients = HttpUtility.UrlEncode(number); //who will get the message
                string ozMessageData = HttpUtility.UrlEncode(message); //body of message

                string createdURL = ozSURL + ":" + ozSPort + "/httpapi" +
                    "?action=sendMessage" +
                    "&username=" + ozUser +
                    "&password=" + ozPassw +
                    "&messageType=" + ozMessageType +
                    "&recipient=" + ozRecipients +
                    "&messageData=" + ozMessageData;


                //Create the request and send data to Ozeki NG SMS Gateway Server by HTTP connection
                HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(createdURL);

                //Get response from Ozeki NG SMS Gateway Server and read the answer
                HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();
                System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
                string responseString = respStreamReader.ReadToEnd();
                respStreamReader.Close();
                myResp.Close();
            }
            con.Close();

            
        }
    }
}