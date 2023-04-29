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
//using System.IO.StreamReader;

namespace SchoolPRO
{
    public partial class AdminNotify : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        //SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        //SqlDataReader dr1;
        //SqlConnection con2 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        //SqlDataReader dr2;
        private string SendSMSToURL(string getUri)
        {
            try
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
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }

        
        protected void btnsubmitattend_Click(object sender, EventArgs e)
        {
            string url = "";
            string number = "", message = "", username = "", password = "", to = "", from = "";
            try{
            CheckBox chkselectall = (CheckBox)gvattnd.HeaderRow.FindControl("chkok");
            
            con.Open();
            foreach (GridViewRow row in gvattnd.Rows)
            {
                CheckBox chkchecked = (CheckBox)row.FindControl("chkselect");
                if (row.RowType == DataControlRowType.DataRow)
                {
                    if (chkselectall.Checked)
                    {
                        Session["eid"] = row.Cells[1].Text;
                        string phone = row.Cells[7].Text;

                        username = "rising.sagheer";
                        password = "56978";
                        from = "SMS Alert";
                        //to = "92" + phone.Substring(1);
                        to = phone;
                        message = txtmsg.Text;
                        System.Threading.Thread.Sleep(1000);
                        url = "http://Lifetimesms.com/api.php?username=" + username + "&password=" + password + "&to=" + to + "&from=" + from + "&message=" + message + "";

                        SendSMSToURL(url);
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_SendSMS(nsch_id,nUserId,strNumber,strMessage,dtAddDate,bisSent,dtSendDate) values('" + Session["nschoolid"] + "','" + Session["uid"] + "','" + phone + "',@msg,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False',CONVERT(VARCHAR(10), GETDATE(), 105 ))";
                        cmd.Parameters.AddWithValue("@msg", txtmsg.Text);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                    }
                    else if (chkchecked.Checked)
                    {
                        Session["eid"] = row.Cells[1].Text;
                        string phone = row.Cells[7].Text;

                        username = "rising.sagheer";
                        password = "56978";
                        from = "SMS Alert";
                        //to = "92" + phone.Substring(1);
                        to = phone;
                        message = txtmsg.Text;
                        System.Threading.Thread.Sleep(1000);
                        url = "http://Lifetimesms.com/api.php?username=" + username + "&password=" + password + "&to=" + to + "&from=" + from + "&message=" + message + "";

                        SendSMSToURL(url);
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_SendSMS(nsch_id,nUserId,strNumber,strMessage,dtAddDate,bisSent,dtSendDate) values('" + Session["nschoolid"] + "','" + Session["uid"] + "','" + phone + "',@msg,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False',CONVERT(VARCHAR(10), GETDATE(), 105 ))";
                        cmd.Parameters.AddWithValue("@msg", txtmsg.Text);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                    }
                }
            }
            con.Close();
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Processing.....');", true);
            chkselectall.Checked = false;
            txtmsg.Text = "";
            // data retrieveing against sms not delivered yet
            //con.Open();
            //cmd.Connection = con;
            //cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "select * from tbl_Notification where bisStatus='False' and strSMS='SMS' and dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 )";
            //dr = cmd.ExecuteReader();
            //string id = "";
            //string data;

            //while (dr.Read())
            //{
            //    id = dr["nntf_id"].ToString();
            //    data = dr["strDesc"].ToString();
            //    //send sms code..
            //    cmd.Connection = con;
            //    cmd.CommandType = CommandType.Text;
            //    cmd.CommandText = "update tbl_Notification set bisStatus='True' where nntf_id='" + id + "'";
            //    cmd.ExecuteNonQuery();
            //}
            //con.Close();
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
        //protected void tRefresh_Tick(object sender, EventArgs e)
        //{
        //    string time="0";
        //    string val="15:00:00";
        //    con.Open();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "select max(strTime) from tbl_Notification where bisStatus='True' and strSMS='SMS'";
        //    dr = cmd.ExecuteReader();
        //    if (dr.Read())
        //    {
        //        while (dr.Read())
        //        {
        //            time = dr["strTime"].ToString();
        //        }
        //    }
        //    con.Close();

        //    string hms = DateTime.Now.TimeOfDay.ToString();
        //    int diff = Convert.ToInt32(hms) - Convert.ToInt32(time);
        //    if (diff <=Convert.ToInt32(val) )
        //    {
        //    }
        //    else 
        //    {
        //        // data retrieving against not delivered sms
        //    con.Open();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "select * from tbl_Notification where bisStatus='False' and strSMS='SMS' and dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 )";
        //    dr = cmd.ExecuteReader();
        //    string id = "";
        //    string data;

        //    while (dr.Read())
        //    {
        //        id = dr["nntf_id"].ToString();
        //        data = dr["strDesc"].ToString();
        //        //send sms code....
        //        con.Open();
        //        cmd.Connection = con;
        //        cmd.CommandType = CommandType.Text;
        //        cmd.CommandText = "update tbl_Notification set bisStatus='True' where nntf_id='" + id + "'";
        //        cmd.ExecuteNonQuery();
        //        con.Close();
        //    }
        //    }


        //}
        protected void chkok_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                CheckBox chkselectall = (CheckBox)gvattnd.HeaderRow.FindControl("chkok");
                foreach (GridViewRow row in gvattnd.Rows)
                {
                    CheckBox chkchecked = (CheckBox)row.FindControl("chkselect");
                    if (chkselectall.Checked)
                    {
                        chkchecked.Checked = true;
                    }
                    else
                    {
                        chkchecked.Checked = false;
                    }
                }
            }
            catch (Exception ex)
            {
             
            }
            finally {
               
            }
        }

        
    }
}