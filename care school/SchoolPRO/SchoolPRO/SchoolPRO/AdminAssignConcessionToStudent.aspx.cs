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
    public partial class AdminAssignConcessionToStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {

                    BindGrid();
                   // Bind_ddlClass();

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
            cmd.CommandText = "Select concstd.nConcStd,conc.nConc_id,conc.nConcPer,conc.strConcTitle,conc.strConcCode,e.strfname+' '+e.strlname as name,e.strStudentNum as number from tbl_ConcessionStudent concstd inner join  tbl_Concession conc on concstd.nConc_id=conc.nConc_id inner join tbl_Enrollment e on concstd.nStd_id=e.ne_id  where conc.bisDeleted='False' and conc.nsch_id='" + Session["nschoolid"] + "' and concstd.bisDeleted='False' and concstd.nsch_id='" + Session["nschoolid"] + "' and e.bisDeleted='False'";
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
                    Response.Redirect("AdminManageConcession.aspx");
                dv.RowFilter = "strConcTitle like" + SearchExpression;
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
            //try
            //{
            //    GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            //    Session["cid"] = gvr.Cells[1].Text;
            //    txteconccode.Text = gvr.Cells[4].Text;
            //    txteconcper.Text = gvr.Cells[5].Text;
            //    txteconccode.Enabled = false;
            //    Label lb = (Label)gvr.FindControl("lblcname");
            //    txteconctitle.Text = lb.Text;
            //    txteconctitle.Focus();
            //    mvdep.ActiveViewIndex = 1;
            //}
            //catch (Exception ex)
            //{
            //    Response.Redirect("Error.aspx");
            //}
            //finally
            //{
            //    if (con.State == ConnectionState.Open)
            //    {
            //        con.Close();
            //    }
            //}
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    con.Open();
            //    cmd.Connection = con;
            //    cmd.CommandType = CommandType.Text;
            //    cmd.CommandText = "update tbl_Concession set strConcTitle=@edep,nConcPer=@perr,dtAddDate= convert(date,SYSDATETIME()) where nConc_id='" + Session["cid"] + "' and nsch_id='" + Session["nschoolid"] + "'";
            //    cmd.Parameters.AddWithValue("@edep", txteconctitle.Text);
            //    cmd.Parameters.AddWithValue("@perr", txteconcper.Text);
            //    cmd.ExecuteNonQuery();
            //    con.Close();
            //    //txtcupdate.Text = "";
            //    PopulateData();
            //    mvdep.ActiveViewIndex = 0;
            //}
            //catch (Exception ex)
            //{
            //    Response.Redirect("Error.aspx");
            //}
            //finally
            //{
            //    if (con.State == ConnectionState.Open)
            //    {
            //        con.Close();
            //    }
            //}
        }

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            mvdep.ActiveViewIndex = 2;
            Bind_ddlClass();
            //txtconctitle.Focus();
        }

        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            string date = DATE_FORMAT.format();
            if (ddcl.SelectedIndex != 0 && ddsec.SelectedIndex != 0 && ddst.SelectedIndex != 0 && ddlconc.SelectedIndex !=0)
            {
                try
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select nConc_id from tbl_ConcessionStudent where nStd_id=@stdid and nConc_id=@concid and nc_id=@cid and nsc_id=@scid and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    cmd.Parameters.AddWithValue("@stdid", ddst.SelectedValue);
                    cmd.Parameters.AddWithValue("@concid", ddlconc.SelectedValue);
                    cmd.Parameters.AddWithValue("@cid", ddcl.SelectedValue);
                    cmd.Parameters.AddWithValue("@scid", ddsec.SelectedValue);
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Concession  already Given to The Student .');", true);
                    }
                    else
                    {
                        con.Close();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "select nConc_id from tbl_ConcessionStudent where nStd_id=@stdid22 and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                        cmd.Parameters.AddWithValue("@stdid22", ddst.SelectedValue);
                       
                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Concession  already Given to The Student .');", true);
                        }
                        else
                        {
                            con.Close();
                           
                            string bit = "False";
                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "insert into tbl_ConcessionStudent(nsch_id,userid,nStd_id,nConc_id,nc_id,nsc_id,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "','" + Session["uid"] + "',@stdid1,@concid1,@clsid1,@secid1,@date,@bit)";
                            cmd.Parameters.AddWithValue("@stdid1", ddst.SelectedValue);
                            cmd.Parameters.AddWithValue("@concid1", ddlconc.SelectedValue);
                            cmd.Parameters.AddWithValue("@clsid1", ddcl.SelectedValue);
                            cmd.Parameters.AddWithValue("@secid1", ddsec.SelectedValue);
                            cmd.Parameters.AddWithValue("@bit", bit);
                            cmd.Parameters.AddWithValue("@date", date);
                            cmd.ExecuteNonQuery();
                            con.Close();

                            PopulateData();
                            mvdep.ActiveViewIndex = 0;
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
            else
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('All Feilds Required.');", true);
        }

        private void PopulateData()
        {
            try
            {
                DataTable table = new DataTable();

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
                {

                    string sql = "Select concstd.nConcStd,conc.nConc_id,conc.nConcPer,conc.strConcTitle,conc.strConcCode,e.strfname+' '+e.strlname as name,e.strStudentNum as number from tbl_ConcessionStudent concstd inner join  tbl_Concession conc on concstd.nConc_id=conc.nConc_id inner join tbl_Enrollment e on concstd.nStd_id=e.ne_id  where conc.bisDeleted='False' and conc.nsch_id='" + Session["nschoolid"] + "' and concstd.bisDeleted='False' and concstd.nsch_id='" + Session["nschoolid"] + "' and e.bisDeleted='False'";

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
            string date = DATE_FORMAT.format();
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string id = gvr.Cells[1].Text;
                con.Open();
                
                string bit = "True";
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_ConcessionStudent set bisDeleted=@bit,dtDeleteDate=@date where nConcStd='" + id + "' and nsch_id='" + Session["nschoolid"] + "'";
                cmd.Parameters.AddWithValue("@bit", bit);
                cmd.Parameters.AddWithValue("@date", date);
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

        protected void txtconcper_TextChanged(object sender, EventArgs e)
        {
          
        }

        protected void txteconcper_TextChanged(object sender, EventArgs e)
        {
           
        }

        public void Bind_ddlClass()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT [strClass],nc_id FROM [tbl_Class] WHERE ([bisDeleted] = 0) and nsch_id='" + Session["nschoolid"] + "'", con);
                SqlDataReader dr = cmd.ExecuteReader();

                ddcl.Items.Clear();
                ddcl.Items.Add("--Please Select Class--");
                ddcl.DataSource = dr;
                ddcl.DataTextField = "strClass";
                ddcl.DataValueField = "nc_id";
                ddcl.DataBind();
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

        public void Bind_ddlSection()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT [strSection],[nsc_id] FROM [tbl_Section] WHERE [nc_id] ='" + ddcl.SelectedValue + "'  AND [bisDeleted] = 0 and nsch_id='" + Session["nschoolid"] + "'", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddsec.DataSource = dr;
                ddsec.Items.Clear();
                ddsec.Items.Add("--Please Select Section--");
                ddsec.DataTextField = "strSection";
                ddsec.DataValueField = "nsc_id";
                ddsec.DataBind();
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

        public void Bind_ddlStudent()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT [strFname]+' '+[strLname] as name, ne_id FROM [tbl_Enrollment] WHERE (([nc_id] =  '" + ddcl.SelectedValue + "' ) AND ([nsc_id] ='" + Convert.ToInt32(ddsec.SelectedValue) + "')  AND ([bisDeleted] =0) and nsch_id='" + Session["nschoolid"] + "')", con);

                SqlDataReader dr = cmd.ExecuteReader();

                ddst.Items.Clear();
                ddst.Items.Add("--Please Select students--");
                ddst.DataSource = dr;
                ddst.DataTextField = "name";
                ddst.DataValueField = "ne_id";
                ddst.DataBind();
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
        protected void ddcl_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddcl.SelectedIndex != 0)
                Bind_ddlSection();
        }

        protected void ddsec_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddsec.SelectedIndex != 0)
                Bind_ddlStudent();
        }

        protected void gvdep_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvdep.PageIndex = e.NewPageIndex;
            PopulateData();
        }
    }
}