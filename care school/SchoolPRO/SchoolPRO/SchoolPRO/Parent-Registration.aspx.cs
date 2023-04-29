using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class Parent_Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;

        protected void btnreg_Click(object sender, EventArgs e)
        {
            string img = "";
            if (ddbrnch.SelectedItem.ToString() != "--Select School--")
            {
                try
                {
                    //and strNIC='" + txtnic.Text+ "'
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from tbl_Users where stremail='" + txtem.Text + "' and bisDeleted='False' ";
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Email  already exist.');", true);
                    }
                    else
                    {
                        con.Close();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "select * from tbl_Users where strNIC='" + txtnic.Text + "'   and bisDeleted='False' ";
                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('NIC  already exist.');", true);
                        }
                        else
                        {
                            con.Close();

                            //if (chqacpt.Checked == true)
                            //{

                            img = @"~\Uploaded-Files\TransParentDayLogo.jpg";


                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "insert into tbl_Users(nsch_id,strImage,strfname,strlname,strRelation,strEducation,strOccupation,strIncome,strAddress,strCity,strState,strPincode,strCountry,strPhone,strCell,strEmail,strPassword,nlevel,strNIC,dtAddDate,bisDeleted) values (@schid,@img,@fn,@ln,@rel,@edu,@occ,@inc,@adrs,@city,@st,@pin,@cntry,@phn,@cell,@em,@psd,'3','" + txtnic.Text + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                            cmd.Parameters.AddWithValue("@schid", ddbrnch.SelectedValue);
                            cmd.Parameters.AddWithValue("@fn", txtfn.Text);
                            cmd.Parameters.AddWithValue("@img", img);
                            cmd.Parameters.AddWithValue("@ln", txtln.Text);
                            cmd.Parameters.AddWithValue("@rel", ddgaurd.Text);
                            cmd.Parameters.AddWithValue("@edu", txtedu.Text);
                            cmd.Parameters.AddWithValue("@occ", txtocc.Text);
                            cmd.Parameters.AddWithValue("@inc", txtinc.Text);
                            cmd.Parameters.AddWithValue("@adrs", txtadrs.Text);
                            cmd.Parameters.AddWithValue("@city", txtcity.Text);
                            cmd.Parameters.AddWithValue("@st", txtstate.Text);
                            cmd.Parameters.AddWithValue("@pin", txtpcode.Text);
                            cmd.Parameters.AddWithValue("@cntry", txtcntry.Text);
                            cmd.Parameters.AddWithValue("@phn", txtphn.Text);
                            cmd.Parameters.AddWithValue("@cell", txtmobile.Text);
                            cmd.Parameters.AddWithValue("@em", txtem.Text);
                            cmd.Parameters.AddWithValue("@psd", txtpwd.Text);
                            cmd.ExecuteNonQuery();
                            con.Close();
                            ///// send sms code....

                            string number = txtmobile.Text;
                            string message = "Thank you for registration. These are your credentials. Email:'"+txtem.Text+"' Password:'"+txtpwd.Text+"'";
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
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnreset_Click(object sender, EventArgs e)
        {
            txtfn.Text = "";
            //txtml.Text = "";
            txtln.Text = "";
            ddgaurd.Text = "";
            txtcity.Text = "";
            txtcntry.Text = "";
            txtedu.Text = "";
            txtem.Text = "";
            txtadrs.Text = "";
            txtinc.Text = "";
            txtocc.Text = "";
            txtpcode.Text = "";
            txtstate.Text = "";
            txtphn.Text = "";
        }
    }
}