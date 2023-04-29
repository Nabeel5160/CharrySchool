using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminEditStudentPic : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnEditImg_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
            SqlCommand cmd = new SqlCommand();
            SqlDataReader dr;
        
            try
            {
                string img = "";
                if (editImagefile.HasFile)
                {

                    string asd = editImagefile.HasFile.ToString();


                    img = @"~\Uploaded-Files\" + Path.GetFileName(editImagefile.PostedFile.FileName);
                    editImagefile.SaveAs(Server.MapPath(img));

                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "Update tbl_Enrollment Set strImage='" + img + "'  where  ne_id='" + Session["id"] + "' and bisDeleted=0";



                    cmd.ExecuteNonQuery();
                    con.Close();

                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Image Updated SuccessFully.');", true);

                }

                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Select the image file to update');", true);


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
        }

        protected void BackBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminViewStudentDetail.aspx");
        }
    }

}