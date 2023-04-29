using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SchoolPRO
{
    public partial class ParentsReplyToTeacherMessage : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnaddMessage_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into tbl_Message (nU_sndr_id,nsch_id,strMsgTitle,strMsgDesc,nU_rcv_id,bisRead,bisDeleted,dtAddDate) Values ('" + Session["uid"] + "','" + Session["nschoolid"] + "','" + txtaddMessagetitle.Text + "','" + txtaddMessagedesc.Text + "','" + Session["senderid1"] + "','False','False',CONVERT(VARCHAR(10), GETDATE(), 105 ))";
                cmd.Parameters.AddWithValue("@mgstitle", txtaddMessagetitle.Text);
                cmd.Parameters.AddWithValue("@mgsdes", txtaddMessagedesc.Text);
                cmd.Parameters.AddWithValue("@mgssend", Session["senderid1"].ToString());
                cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                cmd.Parameters.AddWithValue("@mgsch", Session["nschoolid"].ToString());
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@date", DATE_FORMAT.format()); 
                cmd.ExecuteNonQuery();

                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Message Send successfully.');", true);
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
                    txtaddMessagedesc.Text = "";
                    txtaddMessagetitle.Text = "";
                }
            }
        }
    }
}