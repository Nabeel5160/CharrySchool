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
    public partial class AdminManageLoans : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
            salary();
            txtlamnt.Visible = false;
            txtsamnt.Visible = false;
            txtltime.Visible = false;
            txtstime.Visible = false;
            txtintrst.Visible = false;
            txtsal.Visible = false;
            if (ddloan.Text == "LTA")
            {
                txtlamnt.Visible = true;
                txtintrst.Visible = true;
                txtltime.Visible = true;
                txtsal.Visible = true;
            }
            else
            {
                txtsal.Visible = true;
                txtsamnt.Visible = true;
                txtstime.Visible = true;
            }
            if (!IsPostBack)
            {

                BindGrid();

            }
            }
            catch (Exception ex)
            {
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
        SqlDataReader dr;
        public void salary()
        {
            try
            {
            //int sal = 0;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select strSalary from tbl_Users where nu_id='" + ddenm.SelectedValue + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "' ";
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                txtsal.Text  = dr["strSalary"].ToString();
            }
            
            con.Close();
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
        //protected void ddenm_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    int sal = 0;
        //    con.Open();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "select strSalary from tbl_Users where strlname='" + ddenm.Text + "'";
        //    dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //    {
        //        sal = Convert.ToInt32(dr["strSalary"].ToString());
        //    }
        //    txtsal.Text = sal.ToString();
        //    con.Close();
        //}

        protected void btnAddexp_Click(object sender, EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tbl_Loan (nsch_id,nu_id,strLoanType,strLoanAmount,strDuration,strRetAmount,dtAddDate,bisDeleted) values ('"+Session["nschoolid"]+"','" + ddenm.SelectedValue + "',@lt,@la,@dur,@ret,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
            cmd.Parameters.AddWithValue("@lt", ddloan.Text);
            if (ddloan.Text == "LTA")
            {
                cmd.Parameters.AddWithValue("@la", txtlamnt.Text);
                cmd.Parameters.AddWithValue("@dur", txtltime.Text);
                cmd.Parameters.AddWithValue("@ret", txtlamnt.Text);
            }
            else
            {
                cmd.Parameters.AddWithValue("@ret", txtintrst.Text);
                cmd.Parameters.AddWithValue("@la", txtsamnt.Text);
                cmd.Parameters.AddWithValue("@dur", txtstime.Text);
            }
            cmd.ExecuteNonQuery();
            con.Close();
            txtstime.Text = "";
            txtltime.Text = "";
            txtsamnt.Text = "";
            txtlamnt.Text = "";
            PopulateData();
            mvloan.ActiveViewIndex = 0;
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
            mvloan.ActiveViewIndex = 1;
        }
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select l.nln_id,u.strfname+' '+u.strlname as name,l.strLoanType,l.strLoanAmount,l.strDuration,l.strRetAmount,l.dtAddDate from tbl_Loan l inner join tbl_Users u on l.nu_id=u.nu_id where  l.bisDeleted='False'  and l.nsch_id='" + Session["nschoolid"] + "' and u.bisDeleted='False'  and u.nsch_id='" + Session["nschoolid"] + "'";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            return objDs.Tables[0];

        }
        private void BindGrid()
        {
            try
            {
            DataTable dt = GetRecords();
            if (dt.Rows.Count > 0)
            {
                gvloan.DataSource = dt;
                gvloan.DataBind();
            }
            }
            catch (Exception ex)
            {
                
            }
            finally
            {
                
            }
        }

        private void PopulateData()
        {

            try
            {
            DataTable table = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {

                string sql = "Select l.nln_id,u.strfname+' '+u.strlname as name,l.strLoanType,l.strLoanAmount,l.strDuration,l.strRetAmount,l.dtAddDate from tbl_Loan l inner join tbl_Users u on l.nu_id=u.nu_id where l.bisDeleted='False' and l.nsch_id='" + Session["nschoolid"] + "'  and u.bisDeleted='False'  and u.nsch_id='" + Session["nschoolid"] + "'";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvloan.DataSource = table;

            gvloan.DataBind();
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

        protected void lblgoback_Click(object sender, EventArgs e)
        {
            mvloan.ActiveViewIndex = 0;
        }

        protected void btnsal_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminManageSalary.aspx");
        }
    }
}