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
    public partial class AdminManageBoardFee : System.Web.UI.Page
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
            cmd.CommandText = "Select bf.nBFee_id,c.strClass,bf.strBoardFee,bf.strBoardCode,bf.strRegBoardFee from tbl_BoardFee bf inner join tbl_Class c on bf.nc_id=c.nc_id where bf.bisDeleted='False' and c.bisDeleted='False'  and bf.nsch_id='" + Session["nschoolid"] + "'";
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
                    Response.Redirect("AdminManageBoardFee.aspx");
                dv.RowFilter = "strClass like" + SearchExpression;
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
                Session["bfid"] = gvr.Cells[1].Text;

                txteaddbregfee.Text = gvr.Cells[4].Text;
                txteaddbfee.Text = gvr.Cells[5].Text;
                txtebcode.Text = gvr.Cells[6].Text;
               // Session["cnm"] = gvr.Cells[3].Text;
                //txtcupdate.Text = gvr.Cells[2].Text;
                //txtcupdate.Enabled = false;
                //Label lbl = (Label)gvr.FindControl("lblcname");
                
                //txtenos.Text = gvr.Cells[4].Text;
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
                cmd.CommandText = "update tbl_BoardFee set strRegBoardFee=@regfee,strBoardFee=@fee where nBFee_id=@bfid";
                cmd.Parameters.AddWithValue("@regfee",txteaddbregfee.Text);
                cmd.Parameters.AddWithValue("@fee", txteaddbfee.Text);
                cmd.Parameters.AddWithValue("@bfid", Session["bfid"].ToString());

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
            //txtaddclass.Focus();
            txtaddbfee.Focus();
        }

        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            if (ddlcls.SelectedIndex != 0)
            {
                try
                {
                    string bit = "False";
                    string date = DATE_FORMAT.format();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    // cmd.CommandText = "select nc_id from tbl_Class where strClass='" + txtaddclass.Text + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    ////CLASS NAME SHOULD BE UNIQUIE IN ALL SCHOOLS///////////   
                    cmd.CommandText = "select nBFee_id from tbl_BoardFee where nc_id=@cid and bisDeleted=@bit";
                    cmd.Parameters.AddWithValue("@bit", bit);
                    cmd.Parameters.AddWithValue("@cid", ddlcls.SelectedValue);
                    ////CLASS NAME SHOULD BE UNIQUIE IN ALL SCHOOLS///////////      
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Class Board Fee already exist.');", true);
                    }
                    else
                    {
                        con.Close();
                        dr.Dispose();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_BoardFee(nc_id,nsch_id,nu_id,strRegBoardFee,strBoardFee,strBoardCode,dtAddDate,bisDeleted) values(@cid2,@schid,@uid,@bregfee,@bfee,@bcode,@date,@bit2)";
                        cmd.Parameters.AddWithValue("@cid2", ddlcls.SelectedValue);
                        cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                        cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
                        cmd.Parameters.AddWithValue("@bit2", bit);

                        cmd.Parameters.AddWithValue("@bfee", txtaddbfee.Text);
                        cmd.Parameters.AddWithValue("@bregfee", txtaddbregfee.Text);
                        cmd.Parameters.AddWithValue("@bcode", txtbcode.Text);
                        cmd.Parameters.AddWithValue("@date", date);

                        cmd.ExecuteNonQuery();
                        con.Close();
                        // txtaddclass.Text = "";
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Class Board Fee has been registered successfully.'); window.location = 'AdminManageBoardFee.aspx';", true);
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
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Select Class.....');", true);
        }

        private void PopulateData()
        {
            try
            {

                DataTable table = new DataTable();

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
                {

                    string sql = "Select bf.nBFee_id,c.strClass,bf.strBoardFee,bf.strBoardCode,bf.strRegBoardFee from tbl_BoardFee bf inner join tbl_Class c on bf.nc_id=c.nc_id where bf.bisDeleted='False' and c.bisDeleted='False'  and bf.nsch_id='" + Session["nschoolid"] + "'";

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

        protected void btndel_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string id = gvr.Cells[1].Text;
                string bit = "True";
                string date = DATE_FORMAT.format();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_BoardFee set bisDeleted=@bit,dtDeleteDate=@date where nBFee_id=@id";
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@date", date);
                cmd.Parameters.AddWithValue("@bit", bit);
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