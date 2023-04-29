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
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // lbltest.Text = DateTime.Now.DayOfWeek.ToString();
            Session.RemoveAll();
            txtem.Focus();
            
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btnlogin_Click(object sender, EventArgs e)
        {
            Boolean logflag = false;
            try
            {
               
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select ne_id,strfname,nsch_id from tbl_Enrollment where strEmail=@email and strPassword=@pswd and bisDeleted='False'";
                cmd.Parameters.AddWithValue("@email", txtem.Text);
                cmd.Parameters.AddWithValue("@pswd", txtpwd.Text);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    
                    Session["eid"] = dr["ne_id"].ToString();
                    string a = Session["eid"].ToString();
                    Session["stname"] = dr["strfname"].ToString();
                    Session["nschoolid"] = dr["nsch_id"].ToString();
                    logflag = true;
                    
                }
                else

                {
                   // con.Close();
                    //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalid User Name or Password.');", true);
                }
                con.Close();
                if (logflag == false)
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from tbl_Users where strEmail=@em and strPassword=@pwd and bisDeleted='False'";
                    cmd.Parameters.AddWithValue("@em", txtem.Text);
                    cmd.Parameters.AddWithValue("@pwd", txtpwd.Text);
                    dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        String role = dr["nLevel"].ToString();
                        Session["_level"] = role;
                        Session["name"] = dr["strfname"].ToString();
                        Session["userval"] = txtem.Text;
                        Session["uid"] = dr["nu_id"].ToString();
                        Session["nschoolid"] = dr["nsch_id"].ToString();
                        Session["userval"] = txtem.Text;
                        Session["_Groupid_"] = dr["nGid"].ToString();
                        string cell = dr["strCell"].ToString();
                        ///sms code ...
                        ///
                        //string number = cell;
                        //string message = "You are Logged in Successfully. If it is you then simply ignore this message otherwise review your account. Thank you";
                        //////////////////////////////////////////////////////////////////////////////////////////////

                        //string ozSURL = "http://127.0.0.1"; //where Ozeki NG SMS Gateway is running
                        //string ozSPort = "9501"; //port number where Ozeki NG SMS Gateway is listening
                        //string ozUser = HttpUtility.UrlEncode("admin"); //username for successful login
                        //string ozPassw = HttpUtility.UrlEncode("admin"); //user's password
                        //string ozMessageType = "SMS:TEXT"; //type of message
                        //string ozRecipients = HttpUtility.UrlEncode(number); //who will get the message
                        //string ozMessageData = HttpUtility.UrlEncode(message); //body of message

                        // string createdURL = ozSURL + ":" + ozSPort + "/httpapi" +
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



                        //1010010
                        if (role == "1010010")
                        {
                            //Server.Transfer("~/SuperAdmin/Farmecole.aspx");
                            Response.Redirect("~/SuperAdmin/Farmecole.aspx");
                        }
                        else if (role == "1")
                        {
                              Response.Redirect("AdminDashBoard.aspx");
                        }

                        else if (role == "2")
                        {
                            Response.Redirect("TeacherDashBoard.aspx");
                        }
                        else if (role == "3")
                        {
                            Response.Redirect("ParentDashBoard.aspx",false);
                            
                        }
                        else if (role == "10")
                        {
                            Response.Redirect("AdminLibraryDashboard.aspx");
                        }
                        else if (role == "11")
                        {
                            Response.Redirect("AdminHostelDashboard.aspx");
                        }

                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalid User Name or Password.');", true);
                    }

                }
            }
             catch(Exception ex)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('"+ex.Message+"');", true);
    }
            if(logflag)
            {
                Response.Redirect("StudentDashBoard.aspx");
               // ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "window.location = 'StudentDashBoard.aspx';", true);
            }
        }
       

    }
}