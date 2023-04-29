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
    public partial class AdminManageVehicle : System.Web.UI.Page
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
                //Response.Redirect("Error.aspx");
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
            cmd.CommandText = "select v.nvh_id, v.strBusNumber,v.strRegNumber,v.strBusModel,v.strCapacity,v.strPrice,v.strType,r.strRouteName from tbl_Vehicle v inner join tbl_Route r on v.nrt_id=r.nrt_id where v.bisDeleted='False' and v.nsch_id='" + Session["nschoolid"] + "'";
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
                Response.Redirect("AdminManageVehicle.aspx");
            dv.RowFilter = "strBusNumber like" + SearchExpression;
            gvsearchclass.DataSource = dv;
            gvsearchclass.DataBind();
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
            try
            {
            gvsearchclass.DataBind();
            }
            catch (Exception ex)
            {

            }
            finally
            {
            }
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

            }
            finally
            {
            }
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["vid"] = gvr.Cells[1].Text;
            txtebn.Text = gvr.Cells[4].Text;
            txtern.Text = gvr.Cells[5].Text;
            txtebm.Text = gvr.Cells[6].Text;
            txtecap.Text = gvr.Cells[7].Text;
            txtepr.Text = gvr.Cells[8].Text;
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
            cmd.CommandText = "update tbl_Vehicle set nrt_id='" + ddert.SelectedValue + "', strBusNumber=@ebn, strRegNumber=@ern,strBusModel=@ebm,strCapacity=@ecap,strPrice=@epr,strType=@etype,dtAddDate= CONVERT(VARCHAR(10), GETDATE(), 105 ) where nvh_id='" + Session["vid"] + "'";
            cmd.Parameters.AddWithValue("@ebn",txtebn.Text);
            cmd.Parameters.AddWithValue("@ern", txtern.Text);
            cmd.Parameters.AddWithValue("@ebm", txtebm.Text);
            cmd.Parameters.AddWithValue("@ecap", txtecap.Text);
            cmd.Parameters.AddWithValue("@epr",txtepr.Text);
            cmd.Parameters.AddWithValue("@etype", ddetype.Text);
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
            cmd.CommandText = "insert into tbl_Vehicle(nsch_id,nrt_id,nu_id,strBusNumber,strRegNumber,strBusModel,strCapacity,strType,strPrice,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "','" + ddrt.SelectedValue + "','" + Session["uid"] + "',@bn,@rn,@bm,@cap,@typ,@pr,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
            cmd.Parameters.AddWithValue("@bn", txtbn.Text);
            cmd.Parameters.AddWithValue("@rn",txtrn.Text);
            cmd.Parameters.AddWithValue("@bm", txtbm.Text);
            cmd.Parameters.AddWithValue("@cap", txtcap.Text);
            cmd.Parameters.AddWithValue("@pr", txtpr.Text);
            cmd.Parameters.AddWithValue("@typ",ddtype.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            txtbm.Text = "";
            txtbn.Text = "";
            txtrn.Text = "";
            txtcap.Text = "";
            txtpr.Text = "";
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

                string sql = "select v.nvh_id, v.strBusNumber,v.strRegNumber,v.strBusModel,v.strCapacity,v.strPrice,v.strType,r.strRouteName from tbl_Vehicle v inner join tbl_Route r on v.nrt_id=r.nrt_id where v.bisDeleted='False' and v.nsch_id='" + Session["nschoolid"] + "'";

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
            string del = gvr.Cells[1].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Vehicle set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nvh_id='" + del + "'";
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

        protected void btngoback_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

    }
}