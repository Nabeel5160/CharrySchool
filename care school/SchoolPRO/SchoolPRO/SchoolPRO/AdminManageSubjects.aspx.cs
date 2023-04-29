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
    public partial class AdminManageSubjects : System.Web.UI.Page
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
        protected void btnsub_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtsub.Text == "" && txtcc.Text == "")
                {
                    Response.Write("fill the fields");
                }
                else
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from tbl_Subject where strCourseCode='" + txtcc.Text + "' and nc_id=@cid1 and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    cmd.Parameters.AddWithValue("@cid1", ddcl.SelectedValue);
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Subject  already exist in This Class.');", true);
                    }
                    else
                    {
                        con.Close();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_Subject(nsch_id,nc_id,nu_id,strSubject,strCourseCode,dtAddDate,bisDeleted)values('" + Session["nschoolid"] + "',@cid,'" + Session["uid"] + "',@snm,@cc,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                        cmd.Parameters.AddWithValue("@cid", ddcl.SelectedValue);
                        cmd.Parameters.AddWithValue("@snm", txtsub.Text);
                        cmd.Parameters.AddWithValue("@cc", txtcc.Text);
                        cmd.ExecuteNonQuery();
                        con.Close();
                        txtsub.Text = "";
                        txtcc.Text = "";
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Subject has been registered successfully.'); window.location = 'AdminManageSubjects.aspx';", true);
                        PopulateData();

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
            mvsub.ActiveViewIndex = 0;
        }
          
                
            
        }

        protected void gvsearchsub_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gvsearchsub_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
            System.Threading.Thread.Sleep(2000);
            if (e.CommandName == "Search")
            {
                TextBox txtGrid = (TextBox)gvsearchsub.HeaderRow.FindControl("txtcc");
                SearchText(txtGrid.Text);
            }
            }
            catch (Exception ex)
            {
                //Response.Redirect("Error.aspx");
            }
           
        }

        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select s.nsbj_id,s.nc_id,c.strClass,s.strSubject,s.strCourseCode from tbl_Subject s inner join tbl_Class c on s.nc_id=c.nc_id where s.bisDeleted='False' and c.bisDeleted='False' and s.nsch_id='" + Session["nschoolid"] + "'";
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
                gvsearchsub.DataSource = dt;
                gvsearchsub.DataBind();
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

        private void SearchText(string strSearchText)
        {
            DataTable dt = GetRecords();
            DataView dv = new DataView(dt);
            string SearchExpression = null;
            if (!String.IsNullOrEmpty(strSearchText))
            {
                SearchExpression =
                string.Format("{0} '%{1}%'", gvsearchsub.SortExpression, strSearchText);

            }
            dv.RowFilter = "strSubject like" + SearchExpression;
            gvsearchsub.DataSource = dv;
            gvsearchsub.DataBind();
        }

        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvsearchsub.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvsearchsub.HeaderRow.FindControl("txtcc");

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

        protected void btngotoAdd_Click(object sender, System.EventArgs e)
        {
            mvsub.ActiveViewIndex = 1;
            ddcl.Focus();
        }

        protected void btnedit_Click(object sender, System.EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["sid"] = gvr.Cells[1].Text;
            //txtsbj.Text = gvr.Cells[3].Text;
            Label lbl = (Label)gvr.FindControl("lblcname");
            txtsbj.Text = lbl.Text;
            txtccode.Text = gvr.Cells[5].Text;
            ddecl.Enabled = false;
            ddecl.SelectedValue = gvr.Cells[6].Text;
            mvsub.ActiveViewIndex = 2;
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

        protected void btnupdate_Click(object sender, System.EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Subject set nc_id=@cl, strSubject=@sname,strCourseCode=@ccode, dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nsbj_id='" + Session["sid"] + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
            cmd.Parameters.AddWithValue("@sname", txtsbj.Text);
            cmd.Parameters.AddWithValue("@ccode", txtccode.Text);
            cmd.Parameters.AddWithValue("@cl", ddecl.SelectedValue);
            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvsub.ActiveViewIndex = 0;
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

        protected void btndel_Click(object sender, System.EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["sid"] = gvr.Cells[1].Text;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_Subject set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nsbj_id='" + Session["sid"] + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
                cmd.ExecuteNonQuery();
                con.Close();
                PopulateData();
                mvsub.ActiveViewIndex = 0;
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

                string sql = "select s.nsbj_id,s.nc_id,c.strClass,s.strSubject,s.strCourseCode from tbl_Subject s inner join tbl_Class c on s.nc_id=c.nc_id where s.bisDeleted='False' and s.nsch_id='" + Session["nschoolid"] + "'";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvsearchsub.DataSource = table;

            gvsearchsub.DataBind();
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

        protected void sqlclass_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void gvsearchsub_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
            gvsearchsub.PageIndex = e.NewPageIndex;
            PopulateData();
            }
            catch (Exception ex)
            {
              
            }
            finally
            {
              

            }
        }
    }
}