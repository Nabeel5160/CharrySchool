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
    public partial class AdminManageConcession : System.Web.UI.Page
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
            cmd.CommandText = "Select nConc_id,nConcPer,strConcTitle,strConcCode,strConcType from tbl_Concession where bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
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
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["cid"] = gvr.Cells[1].Text;
                txteconccode.Text = gvr.Cells[4].Text;
                txteconcper.Text = gvr.Cells[5].Text;
                txteconccode.Enabled = false;
                Label lb = (Label)gvr.FindControl("lblcname");
               txteconctitle.Text = lb.Text;
               txteconctitle.Focus();
                mvdep.ActiveViewIndex = 1;
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
                cmd.CommandText = "update tbl_Concession set strConcTitle=@edep,nConcPer=@perr,dtAddDate= CONVERT(VARCHAR(10), GETDATE(), 105 ) where nConc_id='" + Session["cid"] + "' and nsch_id='" + Session["nschoolid"] + "'";
                cmd.Parameters.AddWithValue("@edep",txteconctitle.Text);
                cmd.Parameters.AddWithValue("@perr", txteconcper.Text);
                cmd.ExecuteNonQuery();
                con.Close();
                //txtcupdate.Text = "";
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

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            mvdep.ActiveViewIndex = 2;
            txtconctitle.Focus();
        }

        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select nConc_id from tbl_Concession where strConcCode=@dcode1 and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                cmd.Parameters.AddWithValue("@dcode1",txtconccode.Text);
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Concession Code already exist.');", true);
                }
                else
                {
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_Concession(strConcType,strConcTitle,nsch_id,nuserid,strConcCode,nConcPer,dtAddDate,bisDeleted) values(@type,@dep,'" + Session["nschoolid"] + "','" + Session["uid"] + "',@dcode,@per,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                    cmd.Parameters.AddWithValue("@dep",txtconctitle.Text);
                    cmd.Parameters.AddWithValue("@type", ddconctype.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@dcode",txtconccode.Text);
                    cmd.Parameters.AddWithValue("@per", txtconcper.Text);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    txtconctitle.Text = "";
                    txtconccode.Text = "";
                    txtconcper.Text = "";
                    PopulateData();
                    mvdep.ActiveViewIndex = 0;
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

        private void PopulateData()
        {
            try
            {
                DataTable table = new DataTable();

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
                {

                    string sql = "Select nConc_id,strConcType,nConcPer,strConcTitle,strConcCode from tbl_Concession where bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";

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
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["cid"] = gvr.Cells[1].Text;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_Concession set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nConc_id='" + Session["cid"] + "' and nsch_id='" + Session["nschoolid"] + "'";
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
            Boolean flag = true;
            for (int i = 0; i < txtconcper.Text.Length; i++)
            {
                if (txtconcper.Text != "")
                {
                    if (txtconcper.Text[i] >= 'a' && txtconcper.Text[i] <= 'z' || txtconcper.Text[i] >= 'A' && txtconcper.Text[i] <= 'Z' || txtconcper.Text[i] == '!' || txtconcper.Text[i] == '@' || txtconcper.Text[i] == '#' || txtconcper.Text[i] == '$' || txtconcper.Text[i] == '`' || txtconcper.Text[i] == '~' || txtconcper.Text[i] == '%' || txtconcper.Text[i] == '^' || txtconcper.Text[i] == '&' || txtconcper.Text[i] == '*' || txtconcper.Text[i] == '(' || txtconcper.Text[i] == ')' || txtconcper.Text[i] == '-' || txtconcper.Text[i] == '+' || txtconcper.Text[i] == '_' || txtconcper.Text[i] == '=' || txtconcper.Text[i] == ',' || txtconcper.Text[i] == '.' || txtconcper.Text[i] == '/' || txtconcper.Text[i] == '?' || txtconcper.Text[i] == ';' || txtconcper.Text[i] == ':' || txtconcper.Text[i] == '\'' || txtconcper.Text[i] == '\"' || txtconcper.Text[i] == '|' || txtconcper.Text[i] == '\\' || txtconcper.Text[i] == '/' || txtconcper.Text[i] == '[' || txtconcper.Text[i] == ']' || txtconcper.Text[i] == '{' || txtconcper.Text[i] == '}')
                    {

                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalid Entry.');", true);
                        txtconcper.Text = "";
                        txtconcper.Focus();
                        flag = false;
                        break;
                    }
                }
            }
            if (flag)
            {
                Int32 sal = Convert.ToInt32(txtconcper.Text);
                if (sal > 0)
                {

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Enter Concession in Figures(1-100) Entry.');", true);
                    txtconcper.Text = "";
                    txtconcper.Focus();
                }
            }
        }

        protected void txteconcper_TextChanged(object sender, EventArgs e)
        {
            Boolean flag = true;
            for (int i = 0; i < txteconcper.Text.Length; i++)
            {
                if (txteconcper.Text != "")
                {
                    if (txteconcper.Text[i] >= 'a' && txteconcper.Text[i] <= 'z' || txteconcper.Text[i] >= 'A' && txteconcper.Text[i] <= 'Z' || txteconcper.Text[i] == '!' || txteconcper.Text[i] == '@' || txteconcper.Text[i] == '#' || txteconcper.Text[i] == '$' || txteconcper.Text[i] == '`' || txteconcper.Text[i] == '~' || txteconcper.Text[i] == '%' || txteconcper.Text[i] == '^' || txteconcper.Text[i] == '&' || txteconcper.Text[i] == '*' || txteconcper.Text[i] == '(' || txteconcper.Text[i] == ')' || txteconcper.Text[i] == '-' || txteconcper.Text[i] == '+' || txteconcper.Text[i] == '_' || txteconcper.Text[i] == '=' || txteconcper.Text[i] == ',' || txteconcper.Text[i] == '.' || txteconcper.Text[i] == '/' || txteconcper.Text[i] == '?' || txteconcper.Text[i] == ';' || txteconcper.Text[i] == ':' || txteconcper.Text[i] == '\'' || txteconcper.Text[i] == '\"' || txteconcper.Text[i] == '|' || txteconcper.Text[i] == '\\' || txteconcper.Text[i] == '/' || txteconcper.Text[i] == '[' || txteconcper.Text[i] == ']' || txteconcper.Text[i] == '{' || txteconcper.Text[i] == '}')
                    {

                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalid Entry.');", true);
                        txteconcper.Text = "";
                        txteconcper.Focus();
                        flag = false;
                        break;
                    }
                }
            }
            if (flag)
            {
                Int32 sal = Convert.ToInt32(txteconcper.Text);
                if (sal > 0)
                {

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Enter Concession in Figures(1-100) Entry.');", true);
                    txteconcper.Text = "";
                    txteconcper.Focus();
                }
            }
        }

        protected void gvdep_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvdep.PageIndex = e.NewPageIndex;
                PopulateData();
            }
            catch (Exception) { }
        }
    }
}