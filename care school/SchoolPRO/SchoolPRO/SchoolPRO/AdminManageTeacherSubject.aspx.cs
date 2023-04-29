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
    public partial class AdminManageTeacherSubject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {try
        {
            if (!IsPostBack)
            {

                BindGrid();

            }
            txtcc.Focus();
        }
        catch (Exception ex)
        {
             Response.Redirect("Error.aspx");
        }
        finally
        {
        }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select i.ntsbj_id,c.nc_id,c.strClass,s.strSubject,t.strfname from tbl_TeacherSubject i inner join tbl_Class c on i.nc_id=c.nc_id inner join tbl_Subject s on i.nsbj_id=s.nsbj_id inner join tbl_Users t on i.nu_id=t.nu_id where i.bisDeleted='False' and i.nsch_id='" + Session["nschoolid"] + "'";
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
                gvsearchclass.DataSource = dt;
                gvsearchclass.DataBind();
            }
            }
            catch (Exception ex)
            {
                // Response.Redirect("Error.aspx");
            }
            finally
            {
            }
        }

        protected void txtcc_TextChanged(object sender, EventArgs e)
        {
            SearchText();
        }
        private void SearchText()
        {
            try
            {

            DataTable dt = GetRecords();
            DataView dv = new DataView(dt);
            string SearchExpression = null;
            if (!String.IsNullOrEmpty(txtcc.Text))
            {
                SearchExpression = string.Format("{0} '%{1}%'",
                gvsearchclass.SortExpression, txtcc.Text);

            }
            else
            {
                Response.Redirect("AdminManageTeacherSubject.aspx");
            }
            dv.RowFilter = "strfname like" + SearchExpression;
            gvsearchclass.DataSource = dv;
            gvsearchclass.DataBind();
            }
            catch (Exception ex)
            {
               // Response.Redirect("Error.aspx");
            }
            finally
            {
            }
        }
        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvsearchclass.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvsearchclass.HeaderRow.FindControl("txtcc");

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

        private void PopulateData()
        {
            try
            {

            DataTable table = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {

                string sql = "Select i.ntsbj_id,c.nc_id,c.strClass,s.strSubject,t.strfname from tbl_TeacherSubject i inner join tbl_Class c on i.nc_id=c.nc_id inner join tbl_Subject s on i.nsbj_id=s.nsbj_id inner join tbl_Users t on i.nu_id=t.nu_id where i.bisDeleted='False' and i.nsch_id='" + Session["nschoolid"] + "'";

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

        /// <summary>
        /// /////////////////////DELETING Teacher Subject/////////////////
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnshow_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            string del = gvr.Cells[1].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_TeacherSubject set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where ntsbj_id='" + del+ "'";
            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvt.ActiveViewIndex = 0;
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
            mvt.ActiveViewIndex = 1;
        }

        

        protected void btngoback_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 0;
        }

        protected void btnadd_Click(object sender, EventArgs e)
        {
            try
            {

                if (ddcl.Text == "" && ddtchr.Text == "")
                {
                    Response.Write("fill the fields");
                }
                else
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from tbl_TeacherSubject where nu_id=@umn1  and nc_id=@cnm1  and nsbj_id=@snm1  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    cmd.Parameters.AddWithValue("@umn1", ddtchr.SelectedValue);
                    cmd.Parameters.AddWithValue("@cnm1", ddcl.SelectedValue);
                    cmd.Parameters.AddWithValue("@snm1", ddsbj.SelectedValue);
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This Teacher  already exist In the Class For this SubJect.');", true);
                    }
                    else
                    {
                        con.Close();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "select * from tbl_TeacherSubject where nc_id=@cnm1  and nsbj_id=@snm1  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                        
                        cmd.Parameters.AddWithValue("@cnm1", ddcl.SelectedValue);
                        cmd.Parameters.AddWithValue("@snm1", ddsbj.SelectedValue);
                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This Subject  already exist In the Class.');", true);
                        }
                        else
                        {
                            con.Close();


                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "insert into tbl_TeacherSubject(nsch_id,nu_id,nc_id,nsbj_id,dtAddDate,bisDeleted)values('" + Session["nschoolid"] + "',@umn ,@cnm,@snm,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                            cmd.Parameters.AddWithValue("@umn", ddtchr.SelectedValue);
                            cmd.Parameters.AddWithValue("@cnm", ddcl.SelectedValue);
                            cmd.Parameters.AddWithValue("@snm", ddsbj.SelectedValue);

                            cmd.ExecuteNonQuery();
                            con.Close();
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This Teacher  is added Successfully.');  window.location = 'AdminManageTeacherSubject.aspx';", true);
                            PopulateData();

                        }
                    }
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

        protected void gvsearchclass_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvsearchclass.PageIndex = e.NewPageIndex;
            PopulateData();
        }
    }
}