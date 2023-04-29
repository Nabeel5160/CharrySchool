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
    public partial class AdminSendSMSAll : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
         SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void chkok_CheckedChanged(object sender, EventArgs e)
        {try{
            CheckBox chkselectall = (CheckBox)gvsubst.HeaderRow.FindControl("chkok");
            foreach (GridViewRow row in gvsubst.Rows)
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
        finally
        {
           
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

        protected void btnsubmitattend_Click(object sender, EventArgs e)
        {
            string url = "";
            string number = "", message = "", username = "", password = "", to = "", from = "";
            try
            {
            CheckBox chkselectall = (CheckBox)gvsubst.HeaderRow.FindControl("chkok");

            con.Open();
            foreach (GridViewRow row in gvsubst.Rows)
            {
                CheckBox chkchecked = (CheckBox)row.FindControl("chkselect");
                if (row.RowType == DataControlRowType.DataRow)
                {
                    string num = row.Cells[5].Text;

                    if (chkselectall.Checked)
                    {
                        username = "rising.sagheer";
                        password = "56978";
                        from = "SMS Alert";
                        //to = "92" + num.Substring(1);
                        to = num;
                        message = txtmsg.Text;
                        System.Threading.Thread.Sleep(1000);
                        url = "http://Lifetimesms.com/api.php?username=" + username + "&password=" + password + "&to=" + to + "&from=" + from + "&message=" + message + "";

                        SendSMSToURL(url);
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_SendSMS(nsch_id,nUserId,strNumber,strMessage,dtAddDate,bisSent,dtSendDate) values('" + Session["nschoolid"] + "','" + Session["uid"] + "','" + num + "',@msg,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False',CONVERT(VARCHAR(10), GETDATE(), 105 ))";
                        cmd.Parameters.AddWithValue("@msg", txtmsg.Text);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                    }
                    else if (chkchecked.Checked)
                    {
                        username = "rising.sagheer";
                        password = "56978";
                        from = "SMS Alert";
                        //to = "92" + num.Substring(1);
                        to = num;
                        message = txtmsg.Text;
                        System.Threading.Thread.Sleep(1000);
                        url = "http://Lifetimesms.com/api.php?username=" + username + "&password=" + password + "&to=" + to + "&from=" + from + "&message=" + message + "";

                        SendSMSToURL(url);
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_SendSMS(nsch_id,nUserId,strNumber,strMessage,dtAddDate,bisSent,dtSendDate) values('" + Session["nschoolid"] + "','" + Session["uid"] + "','" + num + "',@msg,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False',CONVERT(VARCHAR(10), GETDATE(), 105 ))";
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
        protected void btndattnd_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["cid"] = gvr.Cells[0].Text;
                Session["cname"] = gvr.Cells[1].Text;
                Session["section"] = gvr.Cells[2].Text;
                Response.Redirect("AdminNotify.aspx");
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