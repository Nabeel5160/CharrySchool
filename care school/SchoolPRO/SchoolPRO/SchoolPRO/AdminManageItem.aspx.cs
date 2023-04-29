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
    public partial class AdminManageItem : System.Web.UI.Page
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
        protected void gvsearchclass_RowCommand(object sender, GridViewCommandEventArgs e)
        {try
        {

            System.Threading.Thread.Sleep(2000);
            if (e.CommandName == "Search")
            {
                TextBox txtGrid = (TextBox)gvpro.HeaderRow.FindControl("txtcc");
                SearchText(txtGrid.Text);
            }
        }
        catch (Exception ex)
        {
            
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
            cmd.CommandText = "Select p.npro_id,p.strQuant,c.strCategory,d.strDepartment,p.strProduct,p.nSKU,p.strDescription from tbl_Product p inner join tbl_Department d on p.ndep_id=d.ndep_id inner join tbl_Category c on p.ncat_id=c.ncat_id where p.bisDeleted='False' and p.nsch_id='"+Session["nschoolid"]+"' ";
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
                gvpro.DataSource = dt;
                gvpro.DataBind();
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
                string.Format("{0} '%{1}%'", gvpro.SortExpression, strSearchText);

            }
            else
                Response.Redirect("AdminManageItem.aspx");

            dv.RowFilter = "strProduct like" + SearchExpression;
            gvpro.DataSource = dv;
            gvpro.DataBind();
            }
            catch (Exception ex)
            {
               
            }
            finally
            {
                
            }
        }

        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvpro.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvpro.HeaderRow.FindControl("txtcc");

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
            gvpro.DataBind();
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

        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
               // ddecat.SelectedIndex=ddecat.
            Session["cid"] = gvr.Cells[1].Text;
            Label pname = (Label)gvr.FindControl("lblcname");

            //foreach (ListItem item in ddecat.Items)
            //{
            //    if (item.Text == gvr.Cells[4].Text)
            //    {
            //        item.Selected = true;
            //    }
            //}
            //foreach (ListItem item in ddedep.Items)
            //{
            //    if (item.Text == gvr.Cells[3].Text)
            //    {
            //        item.Selected = true;
            //    }
            //}

            
            txtepro.Text = pname.Text;
            txtesku.Text = gvr.Cells[6].Text;
            txtedesc.Text = gvr.Cells[7].Text;
            txtequant.Text = gvr.Cells[8].Text;
            mvdep.ActiveViewIndex = 1;
            ddedep.DataBind();
            
            ddedep.SelectedValue = ddedep.Items.FindByText(gvr.Cells[3].Text).Value;
            ddecat.DataBind();
            ddecat.SelectedValue = ddecat.Items.FindByText(gvr.Cells[4].Text).Value;
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
            cmd.CommandText = "update tbl_Product set strQuant='"+txtequant.Text+"',ncat_id='" + ddecat.SelectedValue + "',strProduct=@epro,nSKU=@esku,ndep_id='" + ddedep.SelectedValue + "',strDescription=@edesc,dtAddDate= CONVERT(VARCHAR(10), GETDATE(), 105 ) where npro_id='" + Session["cid"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "' ";
            cmd.Parameters.AddWithValue("@epro", txtepro.Text);
            cmd.Parameters.AddWithValue("@esku", txtesku.Text);
            cmd.Parameters.AddWithValue("@edesc", txtedesc.Text);
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
        }
        public void code()
        {
            try
            {
            string dep_code = null, cat_code = null;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select nDepCode from tbl_Department where ndep_id='" + dddep.SelectedValue + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                dep_code = dr["nDepCode"].ToString();
            }
            con.Close();
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select nCatCode from tbl_Category where ncat_id='" + ddcat.SelectedValue + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                cat_code = dr["nCatCode"].ToString();
            }
            con.Close();
            txtsku.Text = dep_code + "" + cat_code+""+txtpro.Text;
            txtquant.Focus();
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
        public void Updatecode()
        {
            try
            {
                string dep_code = null, cat_code = null;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select nDepCode from tbl_Department where ndep_id='" + ddedep.SelectedValue + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    dep_code = dr["nDepCode"].ToString();
                }
                con.Close();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select nCatCode from tbl_Category where ncat_id='" + ddecat.SelectedValue + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    cat_code = dr["nCatCode"].ToString();
                }
                con.Close();
                txtesku.Text = dep_code + "" + cat_code + "" + txtepro.Text;
                txtequant.Focus();
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
        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try
            {

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from tbl_Product where nSKU='" + txtsku.Text + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Item  already exist.');", true);
                }
                else
                {
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_Product(strQuant,ndep_id,ncat_id,nsch_id,nu_id,strProduct,nSKU,strDescription,dtAddDate,bisDeleted) values(@quant,'" + dddep.SelectedValue + "','" + ddcat.SelectedValue + "','" + Session["nschoolid"] + "','" + Session["uid"] + "',@pro,@sku,@desc,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                    cmd.Parameters.AddWithValue("@quant", txtquant.Text);
                    cmd.Parameters.AddWithValue("@pro", txtpro.Text);

                    cmd.Parameters.AddWithValue("@sku", txtsku.Text);
                    cmd.Parameters.AddWithValue("@desc", txtdesc.Text);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    txtsku.Text = "";
                    txtpro.Text = "";
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

                string sql = "Select p.npro_id,p.strQuant, c.strCategory,d.strDepartment,p.strProduct,p.nSKU,p.strDescription from tbl_Product p inner join tbl_Department d on p.ndep_id=d.ndep_id inner join tbl_Category c on p.ncat_id=c.ncat_id where p.bisDeleted='False' and p.nsch_id='" + Session["nschoolid"] + "' ";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvpro.DataSource = table;

            gvpro.DataBind();
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
            cmd.CommandText = "update tbl_Product set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where npro_id='" + Session["cid"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "' ";
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

        protected void txtepro_TextChanged(object sender, EventArgs e)
        {
            Updatecode();

        }

        protected void txtpro_TextChanged(object sender, EventArgs e)
        {
            code();
        }

        protected void ddecat_SelectedIndexChanged(object sender, EventArgs e)
        {
            Updatecode();
        }
    }
}