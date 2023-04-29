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
    public partial class AdminBankAccount : System.Web.UI.Page
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
            catch (Exception ex) { }
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
                TextBox txtGrid = (TextBox)gvbnk.HeaderRow.FindControl("txtcc");
                SearchText(txtGrid.Text);
            }
            }
            catch (Exception ex) { }
        }

        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select nbnk_id, strBname, strBrname,strBcode,strAccTitle,strAccNum,strAmount, dtAddDate from tbl_Bank where bisDeleted='False' and nu_id='" + Session["uid"] + "' and nsch_id='" + Session["nschoolid"] + "'";
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
                gvbnk.DataSource = dt;
                gvbnk.DataBind();
            }
            }
            catch (Exception ex) { }
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
                string.Format("{0} '%{1}%'", gvbnk.SortExpression, strSearchText);

            }
            dv.RowFilter = "strBcode like" + SearchExpression;
            gvbnk.DataSource = dv;
            gvbnk.DataBind();
            }
            catch (Exception ex) { }
        }

        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvbnk.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvbnk.HeaderRow.FindControl("txtcc");

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

                string sql = "Select nbnk_id, strBname, strBrname,strBcode,strAccTitle,strAccNum,strAmount, dtAddDate from tbl_Bank where bisDeleted='False' and nu_id='" + Session["uid"] + "' and nsch_id='" + Session["nschoolid"] + "'";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvbnk.DataSource = table;

            gvbnk.DataBind();
              }
              catch (Exception ex) { }

        }
        protected void btnadd_Click(object sender, EventArgs e)
        {
            try
            {
                string date = DATE_FORMAT.format();
                string bit = "False";
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from tbl_Bank where strAccNum='" + txtan.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Account Already Exists.');", true);
                }
                else
                {
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_Bank(nsch_id,nu_id,strBname,strBrname,strBcode,strAccTitle,strAccNum,strTotalAmount,strAmount,dtAddDate,bisDeleted) values(@schid,'" + Session["uid"] + "',@bn,@brn,@bc,@at,@an,@tamnt,@amnt,@date,@bit)";
                    cmd.Parameters.AddWithValue("@bit", bit);
                    cmd.Parameters.AddWithValue("@date", date);
                    cmd.Parameters.AddWithValue("@bn", txtbn.Text);
                    cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);
                    cmd.Parameters.AddWithValue("@brn", txtbrnm.Text);
                    cmd.Parameters.AddWithValue("@bc", txtbrc.Text);
                    cmd.Parameters.AddWithValue("@at", txtat.Text);
                    cmd.Parameters.AddWithValue("@an", txtan.Text);
                    cmd.Parameters.AddWithValue("@tamnt", txtamnt.Text);
                    cmd.Parameters.AddWithValue("@amnt", txtamnt.Text);
                    
                    cmd.ExecuteNonQuery();
                    con.Close();
                    PopulateData();
                    mvbnk.ActiveViewIndex = 0;
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
            txtbn.Text = "";
            txtbrnm.Text = "";
            txtbrc.Text = "";
            txtat.Text = "";
            txtan.Text = "";
            txtamnt.Text = "";
        }

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            mvbnk.ActiveViewIndex = 1;
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["bnkid"] = gvr.Cells[1].Text;
            txtebn.Text = gvr.Cells[2].Text;
            txtebrn.Text = gvr.Cells[3].Text;
            Label lblcn = (Label)gvr.FindControl("lblcname");
            txtebc.Text = lblcn.Text;
            txteat.Text = gvr.Cells[5].Text;
            txtean.Text = gvr.Cells[6].Text;
            txteamnt.Text = gvr.Cells[7].Text;
            mvbnk.ActiveViewIndex = 2;
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
            Session["nbnkd"] = gvr.Cells[1].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            string date = DATE_FORMAT.format();
            string bit = "True";
            cmd.CommandText = "update tbl_Bank set bisDeleted=@bit,dtDeleteDate=@date where nbnk_id='" + Session["nbnkd"] + "'";

            cmd.Parameters.AddWithValue("@bit", bit);
            cmd.Parameters.AddWithValue("@date", date); cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvbnk.ActiveViewIndex = 0;
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
            string date = DATE_FORMAT.format();
            cmd.CommandText = "update tbl_Bank set strBName=@ebn, strBrName=@ebnm,strBCode=@ebc,strAccTitle=@eat,strAccNum=@ean,strAmount=@eamnt, dtUpDate=@date,nUpDatedBy=@uid where nbnk_id='" + Session["bnkid"] + "'";
            cmd.Parameters.AddWithValue("@ebn", txtebn.Text);
            cmd.Parameters.AddWithValue("@ebnm", txtebrn.Text);
            cmd.Parameters.AddWithValue("@ebc", txtebc.Text);
            cmd.Parameters.AddWithValue("@eat", txteat.Text);
            cmd.Parameters.AddWithValue("@ean", txtean.Text);
            cmd.Parameters.AddWithValue("@eamnt", txteamnt.Text);
            cmd.Parameters.AddWithValue("@date", date);
            cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvbnk.ActiveViewIndex = 0;
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
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Changed  Successfully.'); window.location='AdminBankAccount.aspx';", true);
        }

        protected void btntransfer_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminTransferAmount.aspx");
        }

       

       
    }
}