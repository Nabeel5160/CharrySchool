using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Net;

namespace SchoolPRO
{
    public partial class AdminVerifyStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //txtsrchstd.Focus();
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void asignrol_Click(object sender, EventArgs e)
        {
            try
            {
                Label1.Visible = true;
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string id = gvr.Cells[1].Text;
                string clas = gvr.Cells[6].Text;
                string section = gvr.Cells[7].Text;
                TextBox tb = (TextBox)gvr.FindControl("txtroll");

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select nsc_id from tbl_Enrollment where strStudentNum=@reg1 and nsc_id=(select nsc_id from tbl_Section where strSection='" + section + "' and nc_id=(select nc_id from tbl_Class where strClass='" + clas + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "')and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                cmd.Parameters.AddWithValue("@reg1", tb.Text);
                dr=cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('The Student Verification Number already exist.');", true);
                }
                else
                {
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "update tbl_Enrollment set strStatus='Confirm', dtVerifyDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) ,  strStudentNum=@reg,nsc_id=(select nsc_id from tbl_Section where strSection='" + section + "' and nc_id=(select nc_id from tbl_Class where strClass='" + clas + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') where ne_id='" + id + "'";
                    cmd.Parameters.AddWithValue("@reg", tb.Text);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    string cell = "";
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select strCell from tbl_Users where nu_id=(select nu_id from tbl_Enrollment where ne_id='"+id+"')";
                    dr = cmd.ExecuteReader();
                    if(dr.Read())
                    {
                        cell = dr["strCell"].ToString();

                    }
                    con.Close();
                    ///send sms code...
                    ///
                    //string number = cell;
                    //string message = "Congratulations..!! Your Child has been enrolled in Class:'"+clas+"' Section:'"+section+"' Roll #:'"+tb.Text+"'";
                    //////////////////////////////////////////////////////////////////////////////////////////////

                    //string ozSURL = "http://127.0.0.1"; //where Ozeki NG SMS Gateway is running
                    //string ozSPort = "9501"; //port number where Ozeki NG SMS Gateway is listening
                    //string ozUser = HttpUtility.UrlEncode("admin"); //username for successful login
                    //string ozPassw = HttpUtility.UrlEncode("admin"); //user's password
                    //string ozMessageType = "SMS:TEXT"; //type of message
                    //string ozRecipients = HttpUtility.UrlEncode(number); //who will get the message
                    //string ozMessageData = HttpUtility.UrlEncode(message); //body of message

                    //string createdURL = ozSURL + ":" + ozSPort + "/httpapi" +
                    //    "?action=sendMessage" +
                    //    "&username=" + ozUser +
                    //    "&password=" + ozPassw +
                    //    "&messageType=" + ozMessageType +
                    //    "&recipient=" + ozRecipients +
                    //    "&messageData=" + ozMessageData;


                    ////Create the request and send data to Ozeki NG SMS Gateway Server by HTTP connection
                    //HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(createdURL);

                    ////Get response from Ozeki NG SMS Gateway Server and read the answer
                    //HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();
                    //System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
                    //string responseString = respStreamReader.ReadToEnd();
                    //respStreamReader.Close();
                    //myResp.Close();

                    tb.Text = "";
                    //txtsrchstd.Text = "";
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Verified Successfully.');", true);
                    //Response.Redirect("AdminVerifyStudent.aspx");
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
                    gdshow.DataBind();
                    con.Close();
                }
            }
        }

        protected void btnnewenrl_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminEnrollStudents.aspx");
        }
        string GenrerateStudentNumber(string id,string sec,string cls)
        {
          
            string stroll = "";
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select strStudentNum from  tbl_Enrollment where ne_id=(select Max(ne_id) as Id from tbl_Enrollment where  nsc_id=(select nsc_id from tbl_Section where strSection='" + sec + "' and nc_id=(select nc_id from tbl_Class where strClass='" + cls + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "')and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') and nc_id=(select nc_id from tbl_Class where strClass='" + cls + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') and bisDeleted='False')";
            //  cmd.CommandText = "select strStudentNum from  tbl_StudentNumber where ne_id=(select Max(ne_id) as Id from tbl_StudentNumber where  nsc_id=(select nsc_id from tbl_Section where strSection='" + ddsec.Text + "' and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted='False')and bisDeleted='False') and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted='False') and bisDeleted='False')";
            //cmd.Parameters.AddWithValue("@reg1", tb.Text);
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                string stnum = dr["strStudentNum"].ToString();
                //stnum = "10B-100";
                int dashe = stnum.IndexOf('-');
                string rollnumber = stnum.Substring(dashe + 1, stnum.Length - (dashe + 1));
                string classSection = stnum.Substring(0, dashe);
                int rollnumber2 = Convert.ToInt32(rollnumber);
                rollnumber2++;

                string NewSTNUM = classSection + "-" + rollnumber2.ToString();
                stroll = NewSTNUM;
                //txtstnum.Text = NewSTNUM;
                //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('The Student Verification Number already exist.');", true);
            }
            else
            {
                string stnum = cls + sec + "-" + "1";
                stroll = stnum;
                //txtstnum.Text = stnum;
            }

            return stroll;

        }
        protected void genraterol_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            string id = gvr.Cells[1].Text;
            string clas = gvr.Cells[6].Text;
            string section = gvr.Cells[7].Text;
            string stroll=GenrerateStudentNumber(id,section, clas);

            TextBox tb = (TextBox)gvr.FindControl("txtroll");

            tb.Text = stroll;
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
    }
}