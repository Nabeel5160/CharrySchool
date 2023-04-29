using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace SchoolPRO
{
    public partial class AdminManageTeacherDepartment : System.Web.UI.Page
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


        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select nDpt_id,strDptName,strDptCode from tbl_TeacherDepartment where bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
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
                    gvDesig.DataSource = dt;
                    gvDesig.DataBind();
                }
            }
            catch (Exception) { }
        }
        private void PopulateData()
        {
            try
            {

                DataTable table = new DataTable();

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
                {

                    string sql = "Select nDpt_id,strDptName,strDptCode from tbl_TeacherDepartment where bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {

                        using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                        {

                            ad.Fill(table);

                        }

                    }

                }

                gvDesig.DataSource = table;

                gvDesig.DataBind();
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
                    string.Format("{0} '%{1}%'", gvDesig.SortExpression, strSearchText);

                }
                else
                    Response.Redirect("AdminManageDesignation.aspx");
                dv.RowFilter = "strDptName like" + SearchExpression;
                gvDesig.DataSource = dv;
                gvDesig.DataBind();
            }
            catch (Exception) { }
        }
        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvDesig.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvDesig.HeaderRow.FindControl("txtcc");

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
        protected void gvsearchclass_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }
        protected void gvsearchclass_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            //try
            //{
            //    GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            //    string s = "hello";
            //    Response.Write(s);

            //}
            //catch (Exception ex)
            //{
            //    ex.ToString();
            //}
        }
        protected void gvDesig_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvDesig.PageIndex = e.NewPageIndex;
                PopulateData();
            }
            catch (Exception) { }
        }

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 2;
            txtaddDesig.Focus();
        }

        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select nDpt_id from tbl_TeacherDepartment where strDptCode='" + txtDesigCode.Text + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Designation already exist.');", true);
                }
                else
                {
                    con.Close();
                    dr.Dispose();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_TeacherDepartment(strDptName,nsch_id,nu_id,strDptCode,dtAddDate,bisDeleted) values(@cname,'" + Session["nschoolid"] + "','" + Session["uid"] + "',@nos,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                    cmd.Parameters.AddWithValue("@cname", txtaddDesig.Text);
                    cmd.Parameters.AddWithValue("@nos", txtDesigCode.Text);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    txtaddDesig.Text = "";
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Department has been registered successfully.'); ", true);
                    PopulateData();
                    MultiView1.ActiveViewIndex = 0;
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

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_TeacherDepartment set strDptName=@cname,dtAddDate= CONVERT(VARCHAR(10), GETDATE(), 105 ) where nDpt_id='" + Session["cid"] + "'";
                cmd.Parameters.AddWithValue("@cname", txtupDesig.Text);

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

        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["cid"] = gvr.Cells[1].Text;
                //Session["cnm"] = gvr.Cells[3].Text;
                //txtcupdate.Text = gvr.Cells[2].Text;
                txtupDesigCode.Enabled = false;
                Label lbl = (Label)gvr.FindControl("lblcname");
                txtupDesig.Text = lbl.Text;
                txtupDesigCode.Text = gvr.Cells[4].Text;
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

        protected void btndel_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string id = gvr.Cells[1].Text;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_TeacherDepartment set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nDpt_id='" + id + "'";
                cmd.ExecuteNonQuery();
                con.Close();
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

        protected void gvDesig_PageIndexChanging1(object sender, GridViewPageEventArgs e)
        {

        }

        protected void gvDesig_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                System.Threading.Thread.Sleep(2000);
                if (e.CommandName == "Search")
                {
                    TextBox txtGrid = (TextBox)gvDesig.HeaderRow.FindControl("txtcc");
                    SearchText(txtGrid.Text);
                }
            }
            catch (Exception) { }
        }

        protected void gvDesig_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }
    
    }
}