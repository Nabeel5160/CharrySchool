using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
//using System.Web.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class forgotpassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        string password = "";
        protected void btnforgot_Click(object sender, EventArgs e)
        {
            
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select strPassword from tbl_Users where strEmail='"+txtem.Text+"'";
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                password = dr["strPassword"].ToString();
            }
            con.Close();
            string toemail="", contact = "";
             toemail = txtem.Text;
        contact = " " + Environment.NewLine + " Best Regards," + Environment.NewLine + " " + Environment.NewLine + "FARMecole" + Environment.NewLine + " Thank you";
        sendmail(toemail,contact);
        con.Close();
        }
        public void sendmail(string toemail, string contact)
        {
            try
            {


                MailMessage newmail = new MailMessage();
                MailAddress fromaddress = new MailAddress("testingemailaspdotnet@gmail.com");
                MailAddress toaddress = new MailAddress(toemail);
                newmail.Subject = "Your account has been created in Online Admissions System";
                newmail.From = fromaddress;

                newmail.To.Add(new MailAddress(toemail));

                newmail.Body = "Dear Candidate" + Environment.NewLine + " Assalam o Allikum! " + Environment.NewLine + " Please find below your login credentials. " + Environment.NewLine + " " + Environment.NewLine + " Email='" + txtem.Text + "' " + Environment.NewLine + " Password='" + password + "' " + Environment.NewLine + " " + Environment.NewLine + " " + Environment.NewLine + " " + contact;
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                smtpClient.EnableSsl = true;
                smtpClient.Credentials = new System.Net.NetworkCredential()
                {
                    UserName = "testingemailaspdotnet@gmail.com",
                    Password = "test1234test"
                };

                smtpClient.Send(newmail);
            }
            catch (Exception ee)
            {
                Response.Write("ee");
            }

        }
    }
}