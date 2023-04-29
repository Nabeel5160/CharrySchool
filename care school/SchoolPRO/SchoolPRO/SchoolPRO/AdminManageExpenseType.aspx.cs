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
    public partial class AdminManageExpenseType : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }
        protected void btnadetyp_Click(object sender, EventArgs e)
        {
            mvetyp.ActiveViewIndex = 1;
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["bnkid"] = gvr.Cells[0].Text;
            txtbn.Text = gvr.Cells[1].Text;
            mvetyp.ActiveViewIndex = 2;
        }

        protected void lblgoback_Click(object sender, EventArgs e)
        {
            mvetyp.ActiveViewIndex = 0;
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            mvetyp.ActiveViewIndex = 0;
        }

        protected void gvetyp_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvetyp.PageIndex = e.NewPageIndex;
            //PopulateData();
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(1000);
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tbl_ExpenseType(strExpenseType,dtAddDate,bisDeleted) values(@bn,convert(date,SYSDATETIME()),'False')";
            cmd.Parameters.AddWithValue("@bn", txtetp.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            txtetp.Text = "";
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert(' Expense Type Added Successfully.');", true);
        }
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select next_id, strExpenseType from tbl_ExpenseType where bisDeleted='False'";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            return objDs.Tables[0];

        }
        private void BindGrid()
        {
            DataTable dt = GetRecords();
            if (dt.Rows.Count > 0)
            {
                gvetyp.DataSource = dt;
                gvetyp.DataBind();
            }
        }
        private void PopulateData()
        {

            DataTable table = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {

                string sql = "Select * from tbl_ExpenseType where bisDeleted='False' ";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvetyp.DataSource = table;

            gvetyp.DataBind();

        }

        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_ExpenseType set strExpenseType=@ebn,dtAddDate= convert(date,SYSDATETIME()) where next_id='" + Session["bnkid"] + "'";
            cmd.Parameters.AddWithValue("@ebn", txtbn.Text);

            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvetyp.ActiveViewIndex = 0;
        }

        protected void btndel_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            string del = gvr.Cells[0].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_ExpenseType set bisDeleted='True',dtDeleteDate=convert(date,SYSDATETIME()) where next_id='" + del + "'";
            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvetyp.ActiveViewIndex = 0;
        }
    }
}