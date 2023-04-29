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
    public partial class ParentStudentEnrollment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btnsreg_Click(object sender, EventArgs e)
        {
            try
            {
                string ssss = Session["nschoolid"].ToString();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from tbl_Enrollment where stremail='" + txtem.Text + "' and bisDeleted='False'";
                dr=cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Email already exist.');", true);
                }
                else
                {
                    con.Close();

                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select stremail from tbl_Enrollment where strNIC='" + txtstnic.Text + "' and bisDeleted='False'";
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('NIC already exist.');", true);
                    }
                    else
                    {
                        con.Close();
                        // if (chqacpt.Checked == true)[
                        // {
                        string s_img = "";
                        if (fstimg.HasFile)
                        {
                            s_img = @"~\Uploaded-Files\" + Path.GetFileName(fstimg.PostedFile.FileName);
                            fstimg.SaveAs(Server.MapPath(s_img));
                        }
                        else
                        {
                            if (ddsex.SelectedItem.ToString() == "Male")
                            {
                                s_img = @"~\Uploaded-Files\male.jpg";
                                //fustimg.SaveAs(Server.MapPath(s_img));
                            }
                            else if (ddsex.SelectedItem.ToString() == "Female")
                            {
                                s_img = @"~\Uploaded-Files\female.jpg";
                            }
                        }
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "select MAX(bRegisteredNum) as regnumber from tbl_Enrollment";
                        dr = cmd.ExecuteReader();
                        Int64 regnumber = 0;
                        string regnum = "1000";
                        if (dr.Read())
                        {
                            regnum = dr["regnumber"].ToString();
                            
                        }
                        if (regnum == "")
                        {
                            regnum = "0";
                            regnumber = Convert.ToInt64(regnum);
                            regnumber += 1;
                        }
                        else
                        {
                            regnumber = Convert.ToInt64(regnum);
                            regnumber += 1;
                        }
                        
                        con.Close();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_Enrollment(strStatus,bRegisteredNum,userid,strNIC,nu_id,nfee_id,dtEn_Date,strFname,strLname,nc_id,strShift,strDOB,strGender,strBirthPlace,strNationality,strMotherlang,strReligion,strPhAddress,strPrAddress,strCity,strState,strCountry,nPinCode,strPhone,strMobile,strEmail,strPassword,strImage,dtAddDate,bisDeleted,nsch_id) values ('Pending','" + regnumber + "','" + Session["uid"] + "',@stnic,(select nu_id from tbl_Users where strEmail='" + Session["userval"] + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'),(select nfee_id from tbl_Fee where nc_id='" + ddcl.SelectedValue + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'),CONVERT(VARCHAR(10), GETDATE(), 105 ),@fn,@ln,'" + ddcl.SelectedValue + "',@shft,@dob,@gen,@bplace,@nationality,@mlng,@relg,@phadrs,@pradrs,@city,@st,@cntry,@pin,@phn,@emphn,@em,@psd,@img,CONVERT(VARCHAR(10), GETDATE(), 105 ),'True',@sname)";
                        cmd.Parameters.AddWithValue("@fn", txtfn.Text);
                        cmd.Parameters.AddWithValue("@stnic", txtstnic.Text);
                        //cmd.Parameters.AddWithValue("@mn", txtml.Text);
                        cmd.Parameters.AddWithValue("@ln", txtln.Text);
                        cmd.Parameters.AddWithValue("@clnm", ddcl.Text);
                        cmd.Parameters.AddWithValue("@shft", ddshft.Text);
                        cmd.Parameters.AddWithValue("@dob", txtdob.Text);
                        cmd.Parameters.AddWithValue("@gen", ddsex.Text);
                        cmd.Parameters.AddWithValue("@bplace", txtbplace.Text);
                        cmd.Parameters.AddWithValue("@nationality", txtnt.Text);
                        cmd.Parameters.AddWithValue("@mlng", txtlng.Text);
                        cmd.Parameters.AddWithValue("@relg", txtrelg.Text);
                        cmd.Parameters.AddWithValue("@phadrs", txtphadrs.Text);
                        cmd.Parameters.AddWithValue("@pradrs", txtpradrs.Text);
                        cmd.Parameters.AddWithValue("@city", txtcity.Text);
                        cmd.Parameters.AddWithValue("@st", txtstate.Text);
                        cmd.Parameters.AddWithValue("@cntry", txtcntry.Text);
                        cmd.Parameters.AddWithValue("@pin", txtpcode.Text);
                        cmd.Parameters.AddWithValue("@phn", txtphn.Text);
                        cmd.Parameters.AddWithValue("@emphn", txtmobile.Text);
                        cmd.Parameters.AddWithValue("@em", txtem.Text);
                        cmd.Parameters.AddWithValue("@psd", txtpwd.Text);
                        cmd.Parameters.AddWithValue("@img", s_img);
                        cmd.Parameters.AddWithValue("@sname", Session["nschoolid"]);
                        cmd.ExecuteNonQuery();
                        con.Close();
                        Session["rgno"] = regnumber;
                        

                        /// send sms code.....
                        /// 
                        //string number = txtmobile.Text;
                        //string message = "Thank you for registration. This is your Registration Number:'"+regnumber+"' Your Child has been enrolled and will get verified soon by School. ";
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
                        txtfn.Text = "";
                        //txtml.Text = "";
                        txtln.Text = "";
                        txtdob.Text = "";
                        txtmobile.Text = "";
                        txtem.Text = "";
                        txtpwd.Text = "";
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Your Child has been enrolled.'); window.location='ParentStudentEnrollment.aspx';", true);
                        Response.Redirect("ParentsRegistrationNumber.aspx");
                    }
                }
                    //}
                    //else
                    //{
                    //    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('plz accept the user agreement.');", true);
                    //}
                
        
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
        }
    }
}