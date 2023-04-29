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
    public partial class AdminStudentListReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                school_name();
            }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;

        public void school_name()
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * from tbl_School where nsch_id='" + Session["nschoolid"] + "'";
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                lblschname.Text = dr["strSchName"].ToString();
                lblschadrs.Text = dr["strAddress"].ToString();
                //imgschlogo.ImageUrl=dr["
            }
            con.Close();
        }

        protected void btnview_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["val"] = gvr.Cells[1].Text;
            Session["secs"] = gvr.Cells[3].Text;
            
            mvstlist.ActiveViewIndex = 1;
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
        double m_count, f_count;
        protected void gvmalelist_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                m_count += 1;
                lblmalecount.Text = m_count.ToString();
            }
        }

        protected void gvfemalelist_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                f_count += 1;
                lblfemcount.Text = f_count.ToString();
            }
        }

        
    }
}