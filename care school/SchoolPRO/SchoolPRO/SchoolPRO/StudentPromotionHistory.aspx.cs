using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class StudendPromotionHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        void bindPromotionData()
        {
            if (txtsearch.Text != "")
            {
                int ne_id = Convert.ToInt32(txtsearch.Text);

                DataSet ds = new DataSet();
                string CS = WebConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString;
                using (SqlConnection con = new SqlConnection(CS))
                {
                    SqlDataAdapter da = new SqlDataAdapter("select * from tbl_PromoteHistory where ne_id=" + ne_id, con);
                    con.Open();
                    da.Fill(ds, "students");
                    gv_students.DataSource = ds;
                    gv_students.DataBind();

                }
            }
        }
        protected void btnPromote_Click(object sender, EventArgs e)
        {
            bindPromotionData();
        }

    }
}