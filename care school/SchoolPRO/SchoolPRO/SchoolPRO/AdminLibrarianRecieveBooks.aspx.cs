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
    public partial class AdminLibrarianRecieveBooks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                BindGrid();

            }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btnrcv_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Label bk_num = (Label)gvr.FindControl("lblcname");
                string bsid = gvr.Cells[1].Text;
                int result = 0;
                int qty = 0;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select nQTY from tbl_Book where strBookNum='" + bk_num.Text + "' and nsch_id= '" + Session["nschoolid"] + "' and bisDeleted='False'";
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    qty = Convert.ToInt32(dr["nQTY"].ToString());
                }
                con.Close();
                result = 1 + qty;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_Book set nQTY='" + result + "' where strBookNum='" + bk_num.Text + "' and nsch_id= '" + Session["nschoolid"] + "' and bisDeleted='False'";
                cmd.ExecuteNonQuery();
                con.Close();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_BookStatus set bisStatus='True' , dtRecvDate=CONVERT(VARCHAR(10), GETDATE(), 105 )  where nbs_id='" + bsid + "' and nsch_id= '" + Session["nschoolid"] + "'";
                cmd.ExecuteNonQuery();
                con.Close();
                PopulateData();
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
        protected void gvsearchclass_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            System.Threading.Thread.Sleep(2000);
            if (e.CommandName == "Search")
            {
                TextBox txtGrid = (TextBox)gvsearchclass.HeaderRow.FindControl("txtcc");
                SearchText(txtGrid.Text);
            }
        }
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select bs.nbs_id,e.strStudentNum,b.strBookNum,bs.dtFromDate,bs.dtToDate from tbl_BookStatus bs inner join tbl_Enrollment e on bs.ne_id=e.ne_id inner join tbl_Book b on bs.nbk_id=b.nbk_id  where bs.nsch_id= '" + Session["nschoolid"] + "' and bs.bisStatus='False'";
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
            DataTable dt = GetRecords();
            DataView dv = new DataView(dt);
            string SearchExpression = null;
            if (!String.IsNullOrEmpty(strSearchText))
            {
                SearchExpression =
                string.Format("{0} '%{1}%'", gvsearchclass.SortExpression, strSearchText);

            }
            else
                Response.Redirect("AdminLibrarianRecieveBooks.aspx");
            dv.RowFilter = "strBookNum like" + SearchExpression;
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


        private void PopulateData()
        {

            try
            {
            DataTable table = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {

                string sql = "select bs.nbs_id, e.strStudentNum,b.strBookNum,bs.dtFromDate,bs.dtToDate from tbl_BookStatus bs inner join tbl_Enrollment e on bs.ne_id=e.ne_id inner join tbl_Book b on bs.nbk_id=b.nbk_id  where bs.nsch_id= '" + Session["nschoolid"] + "' and bs.bisStatus='False'";

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
    }
}