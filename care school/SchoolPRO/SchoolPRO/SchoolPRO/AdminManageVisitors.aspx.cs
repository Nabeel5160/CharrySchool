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
    public partial class AdminManageVisitors : System.Web.UI.Page
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
            string bit = "False";
            cmd.CommandText = "Select nv_id,strPhone,strFname +' '+strLname as name, strCNIC,strVReason from tbl_VisitorRecord where bisDeleted=@bit and nsch_id=@schid";
            cmd.Parameters.AddWithValue("bit", bit);
            cmd.Parameters.AddWithValue("schid", Session["nschoolid"].ToString());
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
                dv.RowFilter = "name like" + SearchExpression;
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
                //GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                //Session["cid"] = gvr.Cells[1].Text;
                //Session["cnm"] = gvr.Cells[3].Text;
                ////txtcupdate.Text = gvr.Cells[2].Text;
                //txtcupdate.Enabled = false;
                //Label lbl = (Label)gvr.FindControl("lblcname");
                //txtcupdate.Text = lbl.Text;
                //txtenos.Text = gvr.Cells[4].Text;
                //MultiView1.ActiveViewIndex = 1;
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
                //con.Open();
                //cmd.Connection = con;
                //cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "update tbl_VisitorRecord set strNOSeats=@enos,dtAddDate= CONVERT(VARCHAR(10), GETDATE(), 105 ) where nc_id='" + Session["cid"] + "'";
                //cmd.Parameters.AddWithValue("@cname", txtcupdate.Text);
                //cmd.Parameters.AddWithValue("@enos", txtenos.Text);
                //cmd.ExecuteNonQuery();
                //con.Close();
                ////txtcupdate.Text = "";
                //PopulateData();
                //MultiView1.ActiveViewIndex = 0;
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
            txtfname.Focus();
        }

        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try
            {
                //con.Open();
                //cmd.Connection = con;
                //cmd.CommandType = CommandType.Text;
                //// cmd.CommandText = "select nc_id from tbl_Class where strClass='" + txtaddclass.Text + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                //////CLASS NAME SHOULD BE UNIQUIE IN ALL SCHOOLS///////////   
                //cmd.CommandText = "select nc_id from tbl_Class where strClass='" + txtaddclass.Text + "' and bisDeleted='False'";
                //////CLASS NAME SHOULD BE UNIQUIE IN ALL SCHOOLS///////////      
                //dr = cmd.ExecuteReader();
                //if (dr.HasRows)
                //{
                //    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Class already exist.');", true);
                //}
                //else
                //{
                //    con.Close();
                   // dr.Dispose();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    string date = DATE_FORMAT.format();
                    string bit = "False";
                    cmd.CommandText = "insert into tbl_VisitorRecord(nsch_id,nu_id,strFname,strLname,strPhone,strCNIC,strVReason,dtAddDate,bisDeleted) values(@schid,@uid,@fname,@lname,@phone,@cnic,@reason,@date,@bit)";
                    cmd.Parameters.AddWithValue("@fname",txtfname.Text);
                    cmd.Parameters.AddWithValue("@lname", txtlname.Text);
                    cmd.Parameters.AddWithValue("@phone", txtphone.Text);
                    cmd.Parameters.AddWithValue("@cnic", txtcnic.Text);
                    cmd.Parameters.AddWithValue("@reason",txtreason.Text);
                    cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
                    cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                    cmd.Parameters.AddWithValue("@bit", bit);
                    cmd.Parameters.AddWithValue("@date", date );
                    
                   
                    cmd.ExecuteNonQuery();
                    con.Close();
                   // txtaddclass.Text = "";
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Visitor has been registered successfully.'); window.location = 'AdminManageVisitors.aspx';", true);
                    //PopulateData();
                    //MultiView1.ActiveViewIndex = 0;
               // }
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
                string bit = "False";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
                {

                    string sql = "Select nv_id,strPhone,strFname +' '+strLname as name, strCNIC,strVReason from tbl_VisitorRecord where bisDeleted=@bit and nsch_id=@schid";

                    using (SqlCommand cmd = new SqlCommand(sql, con))

                    {
                        cmd.Parameters.AddWithValue("bit", bit);
                        cmd.Parameters.AddWithValue("schid", Session["nschoolid"].ToString());

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
                con.Open();
                string bit = "True";
                string date = DATE_FORMAT.format();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_VisitorRecord set bisDeleted=@bit,dtDeleteDate=@date where nv_id=@id";
                cmd.Parameters.AddWithValue("@bit", bit);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@date", date);
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

        protected void txtcnic_TextChanged(object sender, EventArgs e)
        {
            try
            {
                Boolean flag = true;
                for (int i = 0; i < txtcnic.Text.Length; i++)
                {
                    if (txtcnic.Text != "")
                    {
                        if (txtcnic.Text[i] >= 'a' && txtcnic.Text[i] <= 'z' || txtcnic.Text[i] >= 'A' && txtcnic.Text[i] <= 'Z' || txtcnic.Text[i] == '!' || txtcnic.Text[i] == '@' || txtcnic.Text[i] == '#' || txtcnic.Text[i] == '$' || txtcnic.Text[i] == '`' || txtcnic.Text[i] == '~' || txtcnic.Text[i] == '%' || txtcnic.Text[i] == '^' || txtcnic.Text[i] == '&' || txtcnic.Text[i] == '*' || txtcnic.Text[i] == '(' || txtcnic.Text[i] == ')' || txtcnic.Text[i] == '-' || txtcnic.Text[i] == '+' || txtcnic.Text[i] == '_' || txtcnic.Text[i] == '=' || txtcnic.Text[i] == ',' || txtcnic.Text[i] == '.' || txtcnic.Text[i] == '/' || txtcnic.Text[i] == '?' || txtcnic.Text[i] == ';' || txtcnic.Text[i] == ':' || txtcnic.Text[i] == '\'' || txtcnic.Text[i] == '\"' || txtcnic.Text[i] == '|' || txtcnic.Text[i] == '\\' || txtcnic.Text[i] == '/' || txtcnic.Text[i] == '[' || txtcnic.Text[i] == ']' || txtcnic.Text[i] == '{' || txtcnic.Text[i] == '}')
                        {

                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalid Entry.');", true);
                            txtcnic.Text = "";
                            txtcnic.Focus();
                            flag = false;
                            break;
                        }
                    }
                }
                if (txtcnic.Text != "" && flag)
                {
                    if (txtcnic.Text.Length == 13)
                    {
                        txtphone.Focus();
                    }
                    else
                    {
                        txtcnic.Focus();
                        txtcnic.Text = "";
                        
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Enter 13 Digit NIC Number.');", true);
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

        protected void txtphone_TextChanged(object sender, EventArgs e)
        {
         
            Boolean flag = true;
            for (int i = 0; i < txtphone.Text.Length; i++)
            {
                if (txtphone.Text != "")
                {
                    if (txtphone.Text[i] >= 'a' && txtphone.Text[i] <= 'z' || txtphone.Text[i] >= 'A' && txtphone.Text[i] <= 'Z' || txtphone.Text[i] == '!' || txtphone.Text[i] == '@' || txtphone.Text[i] == '#' || txtphone.Text[i] == '$' || txtphone.Text[i] == '`' || txtphone.Text[i] == '~' || txtphone.Text[i] == '%' || txtphone.Text[i] == '^' || txtphone.Text[i] == '&' || txtphone.Text[i] == '*' || txtphone.Text[i] == '(' || txtphone.Text[i] == ')' || txtphone.Text[i] == '-' || txtphone.Text[i] == '+' || txtphone.Text[i] == '_' || txtphone.Text[i] == '=' || txtphone.Text[i] == ',' || txtphone.Text[i] == '.' || txtphone.Text[i] == '/' || txtphone.Text[i] == '?' || txtphone.Text[i] == ';' || txtphone.Text[i] == ':' || txtphone.Text[i] == '\'' || txtphone.Text[i] == '\"' || txtphone.Text[i] == '|' || txtphone.Text[i] == '\\' || txtphone.Text[i] == '/' || txtphone.Text[i] == '[' || txtphone.Text[i] == ']' || txtphone.Text[i] == '{' || txtphone.Text[i] == '}')
                    {

                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalide Entry.');", true);
                        txtphone.Text = "";
                        txtphone.Focus();
                        flag = false;
                        break;
                    }
                }
            }
            if (txtphone.Text != "" && flag)
            {
                if (txtphone.Text.Length <= 15 && txtphone.Text.Length >= 7)
                {
                    //txtmobile.Focus();
                    txtreason.Focus();
                }
                else
                {
                    txtphone.Text = "";
                    txtphone.Focus();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Enter Valid Number.');", true);
                }
            }
        }
    }
}