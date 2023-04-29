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
    public partial class AdminManagePeriod : System.Web.UI.Page
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
        string dtdate = DATE_FORMAT.format();
        protected void btnsub_Click(object sender, EventArgs e)
        {

        }

        protected void gvsearchclass_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                System.Threading.Thread.Sleep(2000);
                if (e.CommandName == "Search")
                {
                    TextBox txtGrid = (TextBox)gvsearchclass.HeaderRow.FindControl("txtcc");
                    SearchText(txtGrid.Text);
                }
            }
            catch (Exception) { }
        }
        private DataTable GetRecords()
        {
            string bit = "False";
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            //
            cmd.CommandText = "Select p.np_id,p.strPeriod,p.strPeriodCode,p.strStartTime,p.strEndTime,shdl.strtimetable as shdul from tbl_Period p inner join tbl_Schedule shdl on p.nshdul_id=shdl.nshd_id  where p.bisDeleted=@bit and p.nsch_id=@schid";
            cmd.Parameters.AddWithValue("@bit", bit);

            cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
            
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            return objDs.Tables[0];

        }
        private void PopulateData()
        {
            string bit = "False";
            try
            {

                DataTable table = new DataTable();

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
                {

                    string sql = "Select p.np_id,p.strPeriod,p.strPeriodCode,p.strStartTime,p.strEndTime,shdl.strtimetable as shdul from tbl_Period p inner join tbl_Schedule shdl on p.nshdul_id=shdl.nshd_id  where p.bisDeleted=@bit and p.nsch_id=@schid";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@bit", bit);

                        cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
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
                    string.Format("{0} '%{1}%'", gvsearchclass.SortExpression, strSearchText);

                }
                else
                    Response.Redirect("AdminManagePeriod.aspx");
                dv.RowFilter = "strPeriod like" + SearchExpression;
                gvsearchclass.DataSource = dv;
                gvsearchclass.DataBind();
            }
            catch (Exception) { }
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

        protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            gvsearchclass.DataBind();
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
                // Session["cnm"] = gvr.Cells[3].Text;
                //txtcupdate.Text = gvr.Cells[2].Text;

                Label lbl = (Label)gvr.FindControl("lblcname");
                //txteaddexam.Text = lbl.Text;
                //txteaddexamcode.Text = gvr.Cells[4].Text;
                txteaddprd.Text = lbl.Text;
                txteaddprdcode.Text = gvr.Cells[4].Text;
                txteaddprdcode.ReadOnly = true;
                txteaddprdst_time.Text = gvr.Cells[5].Text;
                txteaddprdend_time.Text = gvr.Cells[6].Text;

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
                cmd.CommandText = "update tbl_Period set strPeriod=@prdnm,strStartTime=@sttm,strEndTime=@endtm,dtUpDate=@date,nUpDateBy=@uid where np_id=@pid";

                cmd.Parameters.AddWithValue("@prdnm",txteaddprd.Text);
                cmd.Parameters.AddWithValue("@sttm",txteaddprdst_time.Text);
                cmd.Parameters.AddWithValue("@endtm",txteaddprdend_time.Text);
                cmd.Parameters.AddWithValue("@date", dtdate);
                cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                cmd.Parameters.AddWithValue("@pid", Session["cid"].ToString());
                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());

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

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 2;
            txtaddprd.Focus();
        }

        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            if (ddlTimetable.SelectedIndex != 0)
            {
                string bit = "False";
                try
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    // cmd.CommandText = "select nc_id from tbl_Class where strClass='" + txtaddclass.Text + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    ////CLASS NAME SHOULD BE UNIQUIE IN ALL SCHOOLS///////////   
                    cmd.CommandText = "select np_id from tbl_Period where strPeriodCode=@code and bisDeleted=@bit1 and nsch_id='" + Session["nschoolid"] + "'";
                    cmd.Parameters.AddWithValue("@code", txtaddprdcode.Text);
                    cmd.Parameters.AddWithValue("@bit1", bit);
                    ////CLASS NAME SHOULD BE UNIQUIE IN ALL SCHOOLS///////////      
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Period  already exist.');", true);
                    }
                    else
                    {
                        con.Close();
                        dr.Dispose();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_Period(nshdul_id,strPeriodCode,strPeriod,strStartTime,strEndTime,nsch_id,nu_id,dtAddDate,bisDeleted) values(@shdl,@prdcode,@prdname,@prdst_time,@prdend_time,@schid,@uid,@date3,@bit)";
                        cmd.Parameters.AddWithValue("@prdname", txtaddprd.Text);
                        cmd.Parameters.AddWithValue("@shdl", ddlTimetable.SelectedValue);
                        cmd.Parameters.AddWithValue("@prdcode", txtaddprdcode.Text);
                        cmd.Parameters.AddWithValue("@prdst_time", txtaddprdst_time.Text);
                        cmd.Parameters.AddWithValue("@prdend_time", txtaddprdend_time.Text);
                        cmd.Parameters.AddWithValue("@date3", dtdate);
                        cmd.Parameters.AddWithValue("@bit", bit);
                        cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                        cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());

                        cmd.ExecuteNonQuery();
                        con.Close();
                        txtaddprd.Text = "";
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Period has been registered successfully.'); window.location = 'AdminManagePeriod.aspx';", true);
                        //PopulateData();
                        //MultiView1.ActiveViewIndex = 0;
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
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Select Valid Time Table');", true);

        }

        

        protected void btndel_Click(object sender, EventArgs e)
        {
            string bit = "True";
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string id = gvr.Cells[1].Text;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_Period set bisDeleted=@bit,dtDeleteDate=@date where np_id=@pid";
                cmd.Parameters.AddWithValue("@date", dtdate);
                cmd.Parameters.AddWithValue("@bit", bit);
                cmd.Parameters.AddWithValue("@pid", id);
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

        protected void gvsearchclass_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvsearchclass_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvsearchclass.PageIndex = e.NewPageIndex;
                PopulateData();
            }
            catch (Exception) { }
        }
    }
}