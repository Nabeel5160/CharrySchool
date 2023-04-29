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
    public partial class AdminLibrarianBooks : System.Web.UI.Page
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
           
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
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
            catch (Exception ex)
            {
               
            }
           
        }
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select b.nbk_id,b.strBook,b.strAuthorName,b.strPublisherName,b.nQTY,b.strBookNum,b.strPrice,b.ncat_id,c.strCategory from tbl_Book b inner join tbl_Category c on b.ncat_id=c.ncat_id where b.bisDeleted='False' and b.nsch_id= '" + Session["nschoolid"] + "'";
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
            catch (Exception ex)
            {
                //Response.Redirect("Error.aspx");
            }
            
        }

        private void SearchText(string strSearchText)
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
                Response.Redirect("AdminLibrarianBooks.aspx");
            dv.RowFilter = "strAuthorName like" + SearchExpression;
            gvsearchclass.DataSource = dv;
            gvsearchclass.DataBind();
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
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["cid"] = gvr.Cells[1].Text;
            Session["cnm"] = gvr.Cells[4].Text;
            txtebk.Text = gvr.Cells[5].Text;
            txtebn.Text = gvr.Cells[8].Text;
            Label auth = (Label)gvr.FindControl("lblcname");

            txteath.Text = auth.Text;
            txtepn.Text = gvr.Cells[6].Text;
            txteqty.Text = gvr.Cells[7].Text;
            txtepri.Text = gvr.Cells[9].Text;

            MultiView1.ActiveViewIndex = 1;
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_Book set ncat_id='" + ddecat.SelectedValue + "',strBook=@ebk,strAuthorName=@eath,strPublisherName=@epn,nQTY=@eqty,strBookNum=@ebn,strPrice=@epri,dtAddDate= CONVERT(VARCHAR(10), GETDATE(), 105)  where nbk_id='" + Session["cid"] + "' AND bisDeleted='False'";
                cmd.Parameters.AddWithValue("@ebk", txtebk.Text);
                cmd.Parameters.AddWithValue("@eath", txteath.Text);
                cmd.Parameters.AddWithValue("@epn", txtepn.Text);
                cmd.Parameters.AddWithValue("@eqty", txteqty.Text);
                cmd.Parameters.AddWithValue("@ebn", txtebn.Text);
                cmd.Parameters.AddWithValue("@epri", txtepri.Text);
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
        }

        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tbl_Book(ncat_id,nsch_id,nu_id,strBook,strAuthorName,strPublisherName,nQTY,strBookNum,strPrice,dtAddDate,bisDeleted) values('" + ddcat.SelectedValue + "','" + Session["nschoolid"] + "','" + Session["uid"] + "',@bk,@ath,@pnm,@qty,@bnum,@price,CONVERT(VARCHAR(10), GETDATE(), 105) ,'False')";
            cmd.Parameters.AddWithValue("@bk", txtbk.Text);
            cmd.Parameters.AddWithValue("@ath", txtath.Text);
            cmd.Parameters.AddWithValue("@pnm", txtpnm.Text);
            cmd.Parameters.AddWithValue("@qty", txtqty.Text);
            cmd.Parameters.AddWithValue("@bnum", txtbnum.Text);
            cmd.Parameters.AddWithValue("@price", txtprice.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            txtbk.Text = "";
            txtath.Text = "";
            txtbnum.Text = "";
            txtqty.Text = "";
            txtprice.Text = "";
            txtpnm.Text = "";
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

        private void PopulateData()
        {
            try
            {

            DataTable table = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {

                string sql = "select b.ncat_id,b.nbk_id, b.strBook,b.strAuthorName,b.strPublisherName,b.nQTY,b.strBookNum,b.strPrice,c.strCategory from tbl_Book b inner join tbl_Category c on b.ncat_id=c.ncat_id where b.bisDeleted='False' and b.nsch_id= '" + Session["nschoolid"] + "'";

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
            Session["cid"] = gvr.Cells[1].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Book set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 )  where nbk_id='" + Session["cid"] + "' and nsch_id= '" + Session["nschoolid"] + "'";
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
    }
}