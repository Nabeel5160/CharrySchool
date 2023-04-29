using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class StudentViewTeacherRating : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btndel_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string delid = gvr.Cells[1].Text;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.CommandText = "update tbl_StudentRateTeacher set bisDeleted=@tbit,dtDeleteDate=@date where nSRateT_id=@did";
                cmd.Parameters.AddWithValue("@tbit", BIT_T_F.TrueBit());
                cmd.Parameters.AddWithValue("@date", DATE_FORMAT.format());
                cmd.Parameters.AddWithValue("@did", delid);
                cmd.ExecuteNonQuery();
                con.Close();
                mvquiz.ActiveViewIndex = 0;
                gvrteachrate.DataBind();
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