using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminManageResultDecalaration : System.Web.UI.Page
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

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            //
            cmd.CommandText = "Select rr.nRShw_id,rr.strStartDate,rr.strEndDate,ex.strExamName+' '+ex.strExamCode as exam from tbl_ResultShow rr inner join tbl_ExamType ex on rr.nExam_id=ex.nExam_id where rr.bisDeleted=@fbit and rr.nsch_id=@schid";
            cmd.Parameters.Add("@fbit", BIT_T_F.FalseBit());
            cmd.Parameters.Add("@schid", Session["nschoolid"].ToString());
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
                    Response.Redirect("AdminManageClass.aspx");
                dv.RowFilter = "exam like" + SearchExpression;
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
                txteexam.Text = lbl.Text;
                txtestdate.Text= gvr.Cells[4].Text;
                txteendtate.Text = gvr.Cells[5].Text;
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
                cmd.CommandText = "update tbl_ResultShow set strStartDate=@stdt,strEndDate=@eddt,dtUpDate= @dt,nUpDateBy=@uid where nRShw_id=@id";

                cmd.Parameters.AddWithValue("@stdt",txtestdate.Text);
                cmd.Parameters.AddWithValue("@eddt", txteendtate.Text);
               // cmd.Parameters.Add("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.Add("@id",Session["cid"].ToString());
                cmd.Parameters.Add("@uid", Session["uid"].ToString());
                cmd.Parameters.Add("@dt", DATE_FORMAT.format());
                cmd.ExecuteNonQuery();
                con.Close();
                //txtcupdate.Text = "";
                BindGrid();
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
            dddlexam.Focus();
        }

        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try
            {
                if (dddlexam.SelectedIndex != 0)
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    // cmd.CommandText = "select nc_id from tbl_Class where strClass='" + txtaddclass.Text + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    ////CLASS NAME SHOULD BE UNIQUIE IN ALL SCHOOLS///////////   
                    cmd.CommandText = "select nExam_id from tbl_ResultShow where nExam_id=@eid and bisDeleted=@fbit";
                    cmd.Parameters.Add("@fbit", BIT_T_F.FalseBit());
                    cmd.Parameters.Add("@eid", dddlexam.SelectedValue);

                    ////CLASS NAME SHOULD BE UNIQUIE IN ALL SCHOOLS///////////      
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This Exam already  exist.');", true);
                    }
                    else
                    {
                        con.Close();
                        cmd.Parameters.Clear();
                        dr.Dispose();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_ResultShow(strStartDate,strEndDate,nExam_id,nsch_id,nu_id,dtAddDate,bisDeleted) values(@stdt,@eddt,@examid,@schid,@uid,@dt,@fbit)";
                        cmd.Parameters.AddWithValue("@stdt", txtstdate.Text);
                        cmd.Parameters.AddWithValue("@eddt", txtenddate.Text);
                        cmd.Parameters.Add("@examid", dddlexam.SelectedValue);
                        cmd.Parameters.Add("@fbit", BIT_T_F.FalseBit());
                        cmd.Parameters.Add("@schid", Session["nschoolid"].ToString());
                        cmd.Parameters.Add("@uid", Session["uid"].ToString());
                        cmd.Parameters.Add("@dt", DATE_FORMAT.format());

                        cmd.ExecuteNonQuery();
                        con.Close();
                        cmd.Parameters.Clear();
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Exam Result Dates has been registered successfully.'); window.location = 'AdminManageResultDecalaration.aspx';", true);
                        //PopulateData();
                        //MultiView1.ActiveViewIndex = 0;
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
                    cmd.Parameters.Clear();
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

                    string sql = "Select rr.nRShw_id,rr.strStartDate,rr.strEndDate,ex.strExamName+' '+ex.strExamCode as exam from tbl_ResultShow rr inner join tbl_ExamType ex on rr.nExam_id=ex.nExam_id where rr.bisDeleted=@fbit and rr.nsch_id=@schid";


                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.Add("@fbit", BIT_T_F.FalseBit());
                        cmd.Parameters.Add("@schid", Session["nschoolid"].ToString());

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
                    cmd.Parameters.Clear();
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
                cmd.CommandText = "update tbl_ResultShow set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nRShw_id='" + id + "'";
                cmd.ExecuteNonQuery();
                con.Close();
                PopulateData();
                MultiView1.ActiveViewIndex = 0;
            }
            catch (Exception ex)
            {
               // Response.Redirect("Error.aspx");
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

        protected void txtenddate_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (txtstdate.Text != null && txtenddate.Text != null)
                {
                    DateTime st = DateTime.ParseExact(txtstdate.Text,"dd-MM-yyyy",null);
                    DateTime ed = DateTime.ParseExact(txtenddate.Text, "dd-MM-yyyy", null);

                    if (st > ed)
                    {
                        txtenddate.Text = "";
                        
                        txtenddate.Focus();
                    }
                    else
                    {
                        
                        btnaddclass.Focus();
                    }
                }
                else
                {

                }
            }
            catch (Exception)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                    cmd.Parameters.Clear();
                }

            }
        }

        protected void txteendtate_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (txtestdate.Text != null && txteendtate.Text != null)
                {
                    DateTime st = DateTime.ParseExact(txtestdate.Text, "dd-MM-yyyy", null);
                    DateTime ed = DateTime.ParseExact(txteendtate.Text, "dd-MM-yyyy", null);
                   

                    if (st > ed)
                    {
                        lblwarning.Visible = true;
                        lblwarning.Text = "Your End Date is smaller then Start Date";
                        txteendtate.Text = "";
                        txteendtate.Focus();
                    }
                    else
                    {
                        lblwarning.Text = "";
                        lblwarning.Visible = false;
                        btnupdate.Focus();
                    }
                }
                else
                {

                }
            }
            catch (Exception)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                    cmd.Parameters.Clear();
                }

            }
        }
    }
}