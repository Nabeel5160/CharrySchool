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
    public partial class AdminManageSection : System.Web.UI.Page
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
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        /// <summary>
        /// ////////////////////////////////////DONE///////////////
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnsub_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "select * from tbl_Section where strSection='" + txtsec.Text + "' and nc_id=@cid and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                cmd.CommandText = "select * from tbl_Section where strSection='" + txtsec.Text + "' and nc_id=@cid and bisDeleted='False'";
                cmd.Parameters.AddWithValue("@cid", ddcl.SelectedValue);
                dr=cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Section already exist.');", true);
                }
                else
                {
                    con.Close();
                   
                    dr.Dispose();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_Section(nsch_id,nc_id,nu_id,strSection,dtAddDate,bisDeleted)values('" + Session["nschoolid"] + "',@cid2,'" + Session["uid"] + "',@snm,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                    cmd.Parameters.AddWithValue("@cid2", ddcl.SelectedValue);
                    cmd.Parameters.AddWithValue("@snm", txtsec.Text);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    txtsec.Text = "";
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Section has been registered successfully.'); window.location = 'AdminManageSection.aspx';", true);
                }

                
}
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
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
              //  Response.Redirect("Error.aspx");
            }
            finally
            {
              
            }

        }

        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select s.nsc_id,c.nc_id,c.strClass,s.strSection from tbl_Section s inner join tbl_Class c on s.nc_id=c.nc_id where s.bisDeleted='False' and s.nsch_id='" + Session["nschoolid"] + "' ORDER BY c.strClass,s.strSection";
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
            try
            {
            DataTable dt = GetRecords();
            DataView dv = new DataView(dt);
            string SearchExpression = null;
            if (!String.IsNullOrEmpty(strSearchText))
            {
                SearchExpression =
                string.Format("{0} '%{1}%'", gvsearchsub.SortExpression, strSearchText);

            }
            else
                Response.Redirect("AdminManageSection.aspx");
            dv.RowFilter = "strSection like" + SearchExpression;
            gvsearchsub.DataSource = dv;
            gvsearchsub.DataBind();
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
            txtsec.Focus();
        }

        protected void btnedit_Click(object sender, System.EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["sid"] = gvr.Cells[1].Text;
                //string sc = gvr.Cells[3].Text;
               // gvsearchsub.FindControl("lblcname");
                //ddecl.SelectedItem.Value = gvr.Cells[3].Text;
                //ddecl.Text = gvr.Cells[3].Text;
               // ddecl.Items.FindByText("2").Selected = true;
                //DropDownList_LocalOfficeAssignment.SelectedIndex = DropDownList_LocalOfficeAssignment.Items.IndexOf(DropDownList_LocalOfficeAssignment.Items.FindByText(ct.LocalOfficeName))
                //ddecl.SelectedIndex = ddecl.Items.IndexOf(ddecl.Items.FindByText(gvr.Cells[3].Text));
                ddecl.SelectedValue = gvr.Cells[4].Text;

                txtsbj.Text = gvr.Cells[2].Text;
                
                // Label Sectn = (Label)((Label)sender).NamingContainer;
                //string sc = Sectn.Text;
                mvsub.ActiveViewIndex = 2;
                txtsbj.Focus();
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
        {try
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Section set strSection=@sname, nc_id=@cid, dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nsc_id='" + Session["sid"] + "' and nsch_id='" + Session["nschoolid"] + "'";
            //(select nc_id from tbl_Class where strClass=@cid and bisdeleted=0)
            cmd.Parameters.AddWithValue("@sname", txtsbj.Text);
            cmd.Parameters.AddWithValue("@cid", ddecl.SelectedValue);
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
                cmd.CommandText = "update tbl_Section set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nsc_id='" + Session["sid"] + "' and nsch_id='" + Session["nschoolid"] + "'";
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

                string sql = "select s.nsc_id,c.nc_id,c.strClass,s.strSection from tbl_Section s inner join tbl_Class c on s.nc_id=c.nc_id where s.bisDeleted='False' and s.nsch_id='" + Session["nschoolid"] + "' ORDER BY c.strClass,s.strSection";

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

        protected void gvsearchsub_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvsearchsub.PageIndex = e.NewPageIndex;
                PopulateData();
            }
            catch (Exception ex)
            {
             //   Response.Redirect("Error.aspx");
            }
            finally
            {
               
            }
        }
    }
}