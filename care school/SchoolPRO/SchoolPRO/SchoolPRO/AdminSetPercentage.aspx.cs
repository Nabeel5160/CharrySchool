using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminSetPercentage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try{

            if (!IsPostBack)
            {

                BindGrid();

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
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select nper_id, strPercentage from tbl_Percentage where nsch_id='" + Session["nschoolid"] + "' ";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            return objDs.Tables[0];

        }
        private void BindGrid()
        {try
        {
            DataTable dt = GetRecords();
            if (dt.Rows.Count > 0)
            {
                gvsearchclass.DataSource = dt;
                gvsearchclass.DataBind();
                //btngotoAdd.Enabled = false;
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
        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["perid"] = gvr.Cells[0].Text;
            txteptg.Text = gvr.Cells[1].Text;
            MultiView1.ActiveViewIndex = 1;
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

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Percentage set strPercentage=@cname,dtAddDate= CONVERT(VARCHAR(10), GETDATE(), 105 ) where nper_id='" + Session["perid"] + "'";
            cmd.Parameters.AddWithValue("@cname", txteptg.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            //txtcupdate.Text = "";
            PopulateData();
            MultiView1.ActiveViewIndex = 0;
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

        //protected void btngotoAdd_Click(object sender, EventArgs e)
        //{
        //    MultiView1.ActiveViewIndex = 2;
        //}

        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tbl_Percentage(strPercentage,dtAddDate,nsch_id) values(@cname,CONVERT(VARCHAR(10), GETDATE(), 105 ),'" + Session["nschoolid"] + "')";
            cmd.Parameters.AddWithValue("@cname", txtptg.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            txtptg.Text = "";
            PopulateData();
            MultiView1.ActiveViewIndex = 0;
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

        private void PopulateData()
        {
            try
            {
            DataTable table = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {

                string sql = "Select nper_id, strPercentage from tbl_Percentage where nsch_id='" + Session["nschoolid"] + "'";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvsearchclass.DataSource = table;

            gvsearchclass.DataBind();
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

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 2;
        }
    }
}