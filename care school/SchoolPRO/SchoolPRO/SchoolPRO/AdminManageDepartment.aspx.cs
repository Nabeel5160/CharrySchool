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
    public partial class AdminManageDepartment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
            if (!IsPostBack)
            {

                BindGrid();

            }
            }
            catch (Exception) { }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void gvsearchclass_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
            System.Threading.Thread.Sleep(2000);
            if (e.CommandName == "Search")
            {
                TextBox txtGrid = (TextBox)gvdep.HeaderRow.FindControl("txtcc");
                SearchText(txtGrid.Text);
            }
            }
            catch (Exception) { }
        }
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select ndep_id,strDepartment,nDepCode from tbl_Department where bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
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
                gvdep.DataSource = dt;
                gvdep.DataBind();
            }
        }
        catch (Exception) { }
        }

        private void SearchText(string strSearchText)
        {
            try
            {
                DataTable dt = GetRecords();
                DataView dv = new DataView(dt);
                string SearchExpression = null;
                if (!String.IsNullOrEmpty(strSearchText))
                {
                    SearchExpression =
                    string.Format("{0} '%{1}%'", gvdep.SortExpression, strSearchText);

                }
                else
                    Response.Redirect("AdminManageDepartment.aspx");
                dv.RowFilter = "strDepartment like" + SearchExpression;
                gvdep.DataSource = dv;
                gvdep.DataBind();
            }
            catch (Exception) { }
        }

        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvdep.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvdep.HeaderRow.FindControl("txtcc");

                if (txtExample.Text != null)
                {
                    string strSearch = txtExample.Text;
                    Regex RegExp = new Regex(strSearch.Replace(" ", "|").Trim(), RegexOptions.IgnoreCase);
                    return RegExp.Replace(InputTxt, new MatchEvaluator(ReplaceKeyWords));
                    RegExp = null;
                }
                else
                    return InputTxt;
            }
            else
            {
                return InputTxt;
            }
        }

        public string ReplaceKeyWords(Match m)
        {
            return "<span class='highlight'>" + m.Value + "</span>";
        }

        protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            gvdep.DataBind();
        }

        protected void gvsearchclass_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string s = "hello";
                Response.Write(s);

            }
            catch (Exception ex)
            {
                ex.ToString();
            }
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["cid"] = gvr.Cells[1].Text;
            txtedc.Text = gvr.Cells[4].Text;
            txtedc.Enabled = false;
            Label lb = (Label)gvr.FindControl("lblcname");
            txtedp.Text = lb.Text;
            txtedp.Focus();
            mvdep.ActiveViewIndex = 1;
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
            cmd.CommandText = "update tbl_Department set strDepartment=@edep,dtAddDate= CONVERT(VARCHAR(10), GETDATE(), 105 ) where ndep_id='" + Session["cid"] + "' and nsch_id='" + Session["nschoolid"] + "'";
            cmd.Parameters.AddWithValue("@edep",txtedp.Text);
            cmd.Parameters.AddWithValue("@edc", txtedc.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            //txtcupdate.Text = "";
            PopulateData();
            mvdep.ActiveViewIndex = 0;
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
            mvdep.ActiveViewIndex = 2;
            txtdp.Focus();
        }

        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try{
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select ndep_id from tbl_Department where nDepCode=@dcode1 and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
            cmd.Parameters.AddWithValue("@dcode1", txtdpc.Text);
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Department Code already exist.');", true);
            }
            else
            {
                con.Close();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into tbl_Department(strDepartment,nsch_id,nu_id,nDepCode,dtAddDate,bisDeleted) values(@dep,'" + Session["nschoolid"] + "','" + Session["uid"] + "',@dcode,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                cmd.Parameters.AddWithValue("@dep", txtdp.Text);
                cmd.Parameters.AddWithValue("@dcode", txtdpc.Text);
                cmd.ExecuteNonQuery();
                con.Close();
                txtdp.Text = "";
                txtdpc.Text = "";
                PopulateData();
                mvdep.ActiveViewIndex = 0;
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

        private void PopulateData()
        {
            try
            {
            DataTable table = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {

                string sql = "Select ndep_id,strDepartment,nDepCode from tbl_Department where bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvdep.DataSource = table;

            gvdep.DataBind();
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

        protected void btndel_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["cid"] = gvr.Cells[1].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Department set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where ndep_id='" + Session["cid"] + "' and nsch_id='" + Session["nschoolid"] + "'";
            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvdep.ActiveViewIndex = 0;
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

        protected void gvdep_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvdep.PageIndex = e.NewPageIndex;
                PopulateData();
            }
            catch (Exception) { }
        }
    }
}