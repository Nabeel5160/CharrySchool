using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.IO;

namespace SchoolPRO
{
    public partial class AdminViewClassResultReport : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        string dtdate = DATE_FORMAT.format();
        SqlDataReader dr;
        DataTable dt1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                {
                    Bind_ddlClass();

                }
        }
        
        public void Bind_ddlSection()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT [strSection],[nsc_id] FROM [tbl_Section] WHERE (([nc_id] ='" + ddcl.SelectedValue + "') AND ([bisDeleted] = 0) and nsch_id= '" + Session["nschoolid"] + "')", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddsec.DataSource = dr;
                ddsec.Items.Clear();
                ddsec.Items.Add("--Please Select Section--");
                ddsec.DataTextField = "strSection";
                ddsec.DataValueField = "nsc_id";
                ddsec.DataBind();
                con.Close();
            }
            catch (Exception) { }
        }

        public void Bind_ddlClass()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT [strClass],[nc_id] FROM [tbl_Class] WHERE ([bisDeleted] = 0) and nsch_id= '" + Session["nschoolid"] + "'", con);
                SqlDataReader dr = cmd.ExecuteReader();

                ddcl.Items.Clear();
                ddcl.Items.Add("--Please Select Class--");
                ddcl.DataSource = dr;
                ddcl.DataTextField = "strClass";
                ddcl.DataValueField = "nc_id";
                ddcl.DataBind();
                con.Close();
            }
            catch (Exception) { }
        }
        protected void ddcl_SelectedIndexChanged(object sender, EventArgs e)
        {
            //gv_detail_list.DataSource = null;
            //gv_detail_list.DataBind();
            if (ddcl.SelectedIndex != 0)
                Bind_ddlSection();
        }
    }
}