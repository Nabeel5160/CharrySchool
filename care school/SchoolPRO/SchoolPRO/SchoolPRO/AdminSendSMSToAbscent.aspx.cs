using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminSendSMSToAbscent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btnsubmitattend_Click(object sender, EventArgs e)
        {try
        {
            con.Open();
            foreach (GridViewRow row in gvattnd.Rows)
            {
               
                if (row.RowType == DataControlRowType.DataRow)
                {
                    
                        //Session["eid"] = row.Cells[1].Text;
                        string phone = row.Cells[5].Text;
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_SendSMS(nsch_id,nUserId,strNumber,strMessage,dtAddDate,bisSent,dtSendDate) values('" + Session["nschoolid"] + "','" + Session["uid"] + "','" + phone + "',@msg,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False',CONVERT(VARCHAR(10), GETDATE(), 105 ))";
                        cmd.Parameters.AddWithValue("@msg", txtmsg.Text);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                    
                }
            }
            con.Close();
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Processing.....');", true);
            
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
    }
}