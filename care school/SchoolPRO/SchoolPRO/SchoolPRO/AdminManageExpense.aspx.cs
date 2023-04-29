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
    public partial class AdminManageExpense : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {try
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

        protected void gvvend_RowCommand(object sender, GridViewCommandEventArgs e)
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
            catch (Exception ex)
            {
             //   Response.Redirect("Error.aspx");
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
            cmd.CommandText = "Select ex.nex_id,ex.strVoucherNum,emp.strfname,ex.strReason,ex.strAmount,ex.strPaymentMethod,ex.dtAddDate,b.strAccNum from tbl_Expense ex inner join tbl_Users emp on ex.nu_id=emp.nu_id inner join tbl_Bank b on ex.nbnk_id=b.nbnk_id where ex.bisDeleted='False' and ex.nsch_id='" + Session["nschoolid"] + "'";
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
                string.Format("{0} '%{1}%'", gvbnk.SortExpression, strSearchText);

            }
            else
                Response.Redirect("AdminManageExpense.aspx");

            dv.RowFilter = "strfname like" + SearchExpression;
            gvbnk.DataSource = dv;
            gvbnk.DataBind();
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

                string sql = "Select ex.nex_id,ex.strVoucherNum,emp.strfname,ex.strReason,ex.strAmount,ex.strPaymentMethod,ex.dtAddDate,b.strAccNum from tbl_Expense ex inner join tbl_Users emp on ex.nu_id=emp.nu_id inner join tbl_Bank b on ex.nbnk_id=b.nbnk_id where ex.bisDeleted='False' and ex.nsch_id='" + Session["nschoolid"] + "'";

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
            mvbnk.ActiveViewIndex = 1;
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["vid"] = gvr.Cells[1].Text;
            Label lbl = (Label)gvr.FindControl("lblcname");
            txterzn.Text = lbl.Text;
            txtemnt.Text = gvr.Cells[4].Text;
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
            Session["nvid"] = gvr.Cells[1].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Expense set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nex_id='" + Session["nvid"] + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
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

        }

        protected void btnadd_Click(object sender, EventArgs e)
        {
            try
            {
            int t_amount = 0;
            int actual_amount = 0;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select strAmount from tbl_Bank where strAccNum='" + ddacnum.Text + "' and nsch_id='" + Session["nschoolid"] + "'";
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                t_amount = Convert.ToInt32(dr["strAmount"]);
            }
            if (t_amount <= 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Account Balance is Nill.');", true);
            }
            else
            {
                actual_amount = t_amount - Convert.ToInt32(txtamnt.Text);
            
            con.Close();
                // deduct from actual amount....
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Bank set strAmount=@am where strAccNum='" + ddacnum.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
            cmd.Parameters.AddWithValue("@am", actual_amount);
            cmd.ExecuteNonQuery();
            con.Close();
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tbl_Expense(nsch_id,nu_id,nbnk_id,strVoucherNum,strReason,strAmount,strPerson,strPaymentMethod,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "','" + Session["uid"] + "',(select nbnk_id from tbl_Bank where strAccNum='" + ddacnum.Text + "'),@vnum,@rezn,@amnt,@prsn,@pm,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
            cmd.Parameters.AddWithValue("@vnum", txtvnum.Text);
            cmd.Parameters.AddWithValue("@prsn", txtname.Text);
            cmd.Parameters.AddWithValue("@rezn", txtrzn.Text);
            cmd.Parameters.AddWithValue("@amnt", txtamnt.Text);
            cmd.Parameters.AddWithValue("@pm", ddpm.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvbnk.ActiveViewIndex = 0;
            txtrzn.Text = "";
            txtamnt.Text = "";
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
            cmd.CommandText = "update tbl_Expense set nu_id='" + ddemn.SelectedValue + "', strReason=@erezn, strAmount=@eamnt, strPaymentMethod=@epm,dtAddDate= CONVERT(VARCHAR(10), GETDATE(), 105 ) where nex_id='" + Session["vid"] + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
            cmd.Parameters.AddWithValue("@enm", ddemn.Text);
            cmd.Parameters.AddWithValue("@erezn", txterzn.Text);
            cmd.Parameters.AddWithValue("@eamnt", txtemnt.Text);
            cmd.Parameters.AddWithValue("@epm", ddepm.Text);
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
        }
    }
}