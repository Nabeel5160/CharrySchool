using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace SchoolPRO.SuperAdmin
{
    public partial class home : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            string pagename = Path.GetFileNameWithoutExtension(Request.Path);
            try
            {
                con.Open();

                con.Close();
                    


            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

        }
        void HtmlAnchor_Click(Object sender, EventArgs e)
        {

            

        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {

        }
    }
}