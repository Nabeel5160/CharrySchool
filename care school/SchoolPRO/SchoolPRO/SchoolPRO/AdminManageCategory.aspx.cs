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
    public partial class AdminManageCategory : System.Web.UI.Page
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
            try{
            System.Threading.Thread.Sleep(2000);
            if (e.CommandName == "Search")
            {
                TextBox txtGrid = (TextBox)gvcat.HeaderRow.FindControl("txtcc");
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
            cmd.CommandText = "Select c.ndep_id,c.ncat_id,d.strDepartment,c.strCategory,c.nCatCode from tbl_Category c inner join tbl_Department d on c.ndep_id=d.ndep_id where c.bisDeleted='False' and c.nsch_id='" + Session["nschoolid"] + "'";
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
                gvcat.DataSource = dt;
                gvcat.DataBind();
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
                string.Format("{0} '%{1}%'", gvcat.SortExpression, strSearchText);

            }
            else
                Response.Redirect("AdminManageCategory.aspx");
            dv.RowFilter = "strCategroy like" + SearchExpression;
            gvcat.DataSource = dv;
            gvcat.DataBind();
            }
            catch (Exception) { }
        }

        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvcat.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvcat.HeaderRow.FindControl("txtcc");

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
            gvcat.DataBind();
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
            Label catname = (Label)gvr.FindControl("lblcname");
            txtecat.Text = catname.Text;
            txtedc.Text = gvr.Cells[5].Text;
            txtedc.Enabled = false;
            //dddep.SelectedValue = gvr.Cells[8].Text;
                ddedep.DataBind();
            
            ddedep.SelectedValue = ddedep.Items.FindByText(gvr.Cells[3].Text).Value;
           
            mvdep.ActiveViewIndex = 1;
            ddedep.Focus();
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
            cmd.CommandText = "update tbl_Category set strCategory=@edep,ndep_id='" + ddedep.SelectedValue + "',dtAddDate= CONVERT(VARCHAR(10), GETDATE(), 105 )  where ncat_id='" + Session["cid"] + "'";
            cmd.Parameters.AddWithValue("@edep", txtecat.Text);
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
            dddep.Focus();
        }

        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try
            {
                 con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select ncat_id from tbl_Category where nCatCode=@dcode1 and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                cmd.Parameters.AddWithValue("@dcode1", txtccode.Text);
                dr=cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Category Code already exist.');", true);
                }
                else
                {
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_Category(strCategory,ndep_id,nsch_id,nu_id,nCatCode,dtAddDate,bisDeleted) values(@cat,'" + dddep.SelectedValue + "','" + Session["nschoolid"] + "','" + Session["uid"] + "',@dcode,CONVERT(VARCHAR(10), GETDATE(), 105 ) ,'False')";
                    cmd.Parameters.AddWithValue("@cat", txtcat.Text);
                    cmd.Parameters.AddWithValue("@dcode", txtccode.Text);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    txtcat.Text = "";
                    txtccode.Text = "";
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

                string sql = "Select c.ndep_id,c.ncat_id,d.strDepartment,c.strCategory,c.nCatCode from tbl_Category c inner join tbl_Department d on c.ndep_id=d.ndep_id where c.bisDeleted='False' and c.nsch_id='" + Session["nschoolid"] + "'";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvcat.DataSource = table;

            gvcat.DataBind();
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
            cmd.CommandText = "update tbl_Category set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 )  where ncat_id='" + Session["cid"] + "' and bisDeleted='False'";
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
    }
}