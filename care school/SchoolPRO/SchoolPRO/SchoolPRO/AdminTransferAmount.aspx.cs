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
    public partial class AdminTransferAmount : System.Web.UI.Page
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
        double t_amount1 = 0;
        double t_amount2 = 0;
        double account1, account2;

        protected void gvuser_RowCommand(object sender, GridViewCommandEventArgs e)
        {try
        {
            System.Threading.Thread.Sleep(2000);
            if (e.CommandName == "Search")
            {
                TextBox txtGrid = (TextBox)gvuser.HeaderRow.FindControl("txtcc");
                SearchText(txtGrid.Text);
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

        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * from tbl_Money_Transfer where bisDeleted='False' and nsch_id='"+Session["nschoolid"]+"'";
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
                gvuser.DataSource = dt;
                gvuser.DataBind();
            }
            }
            catch (Exception ex)
            {
                
            }
            finally
            {
                
            }
        }

        private void SearchText(string strSearchText)
        {try
        {
            DataTable dt = GetRecords();
            DataView dv = new DataView(dt);
            string SearchExpression = null;
            if (!String.IsNullOrEmpty(strSearchText))
            {
                SearchExpression =
                string.Format("{0} '%{1}%'", gvuser.SortExpression, strSearchText);

            }
            else
                Response.Redirect("AdminTransferAmount.aspx");


            dv.RowFilter = "strBCode like" + SearchExpression;
            gvuser.DataSource = dv;
            gvuser.DataBind();
        }
        catch (Exception ex)
        {

        }
        }

        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvuser.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvuser.HeaderRow.FindControl("txtcc");

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

                string sql = "select * from tbl_Money_Transfer where bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvuser.DataSource = table;

            gvuser.DataBind();
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
            if (ddfrom.SelectedValue != ddto.SelectedValue)
            {
                try
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select strAmount from tbl_Bank where strAccNum=@tacn and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    cmd.Parameters.AddWithValue("@tacn", ddfrom.Text);
                    dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        t_amount1 = Convert.ToInt64(dr["strAmount"]);
                    }
                    account1 = t_amount1 - Convert.ToInt64(txtamount.Text);
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "update tbl_Bank set strAmount=@famnt where strAccNum=@faccnum and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    cmd.Parameters.AddWithValue("@famnt", account1);
                    cmd.Parameters.AddWithValue("@faccnum", ddfrom.Text);
                    cmd.ExecuteNonQuery();
                    con.Close();

                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select strAmount from tbl_Bank where strAccNum=@facn and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    cmd.Parameters.AddWithValue("@facn", ddto.Text);
                    dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        t_amount2 = Convert.ToInt64(dr["strAmount"]);
                    }
                    account2 = t_amount2 + Convert.ToInt64(txtamount.Text);
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "update tbl_Bank set strAmount=@tamnt where strAccNum=@taccnum and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    cmd.Parameters.AddWithValue("@tamnt", account2);
                    cmd.Parameters.AddWithValue("@taccnum", ddto.Text);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    con.Open();
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_Money_Transfer(nsch_id,nFromAcc,nToAcc,strAmount,strReason,dtAddDate,bisDeleted)values('" + Session["nschoolid"] + "',@facc,@tacc,@amntc,@rzn,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                    cmd.Parameters.AddWithValue("@facc", ddfrom.Text);
                    cmd.Parameters.AddWithValue("@tacc", ddto.Text);
                    cmd.Parameters.AddWithValue("@amntc", txtamount.Text);
                    cmd.Parameters.AddWithValue("@rzn", txtrzn.Text);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    txtamount.Text = "";

                    txtrzn.Text = "";
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
            else  {
                ScriptManager.RegisterStartupScript(this, GetType(), "", "alert('Same Account Selected')", true);
            }
        }

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminBankAccount.aspx");
        }

        protected void btntransfer_Click(object sender, EventArgs e)
        {
            mvbnk.ActiveViewIndex = 1;
        }
    }
}