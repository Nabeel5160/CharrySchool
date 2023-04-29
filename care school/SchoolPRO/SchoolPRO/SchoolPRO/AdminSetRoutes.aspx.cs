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
    public partial class AdminSetRoutes : System.Web.UI.Page
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
               // Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select nrt_id,strCity,strRouteName,strRouteNumber,strPickTime,strDropTime,strAmount from tbl_Route where nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            return objDs.Tables[0];

        }
        private void BindGrid()
        {try
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
                Response.Redirect("AdminSetRoutes.aspx");

            dv.RowFilter = "strRouteName like" + SearchExpression;
            gvsearchclass.DataSource = dv;
            gvsearchclass.DataBind();
            }
            catch (Exception ex)
            {
               // Response.Redirect("Error.aspx");
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
               // Response.Redirect("Error.aspx");
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
            Session["rid"] = gvr.Cells[1].Text;
            txtertnum.Text = gvr.Cells[4].Text;
            txtedp.Text = gvr.Cells[7].Text;
            txtept.Text = gvr.Cells[6].Text;
            txtect.Text = gvr.Cells[5].Text;
            txteamnt.Text = gvr.Cells[8].Text;
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
            string route_name=txtertfrm.Text+" to "+txtertto.Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Route set strAmount=@eamnt, strCity=@cty,strRouteName=@ernm,strRouteNumber=@ern,strPickTime=@ept,strDropTime=@edp,dtAddDate= CONVERT(VARCHAR(10), GETDATE(), 105 ) where nrt_id='" + Session["rid"] + "' and bisDeleted='False' and nsch_id='"+Session["nschoolid"]+"'";
            cmd.Parameters.AddWithValue("@cty", txtect.Text);
            cmd.Parameters.AddWithValue("@ernm", route_name);
            cmd.Parameters.AddWithValue("@ern", txtertnum.Text);
            cmd.Parameters.AddWithValue("@ept", txtept.Text);
            cmd.Parameters.AddWithValue("@edp", txtedp.Text);
            cmd.Parameters.AddWithValue("@eamnt", txteamnt.Text);
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
            string route_name=txtfrm.Text+" to "+txtto.Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tbl_Route(nsch_id,nu_id,strCity,strRouteName,strRouteNumber,strPickTime,strDropTime,strAmount,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "','" + Session["uid"] + "',@ct,@rnm,@rn,@pt,@dp,@amnt,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
            cmd.Parameters.AddWithValue("@ct", txtct.Text);
            cmd.Parameters.AddWithValue("@rnm", route_name);
            cmd.Parameters.AddWithValue("@rn", txtrtnum.Text);
            cmd.Parameters.AddWithValue("@pt", txtpt.Text);
            cmd.Parameters.AddWithValue("@dp", txtdp.Text);
            cmd.Parameters.AddWithValue("@amnt", txtamnt.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            txtct.Text = "";
            txtrtnum.Text = "";
            txtto.Text = "";
            txtfrm.Text = "";
            txtpt.Text = "";
            txtdp.Text = "";
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

                string sql = "select nrt_id,strCity,strRouteName,strRouteNumber,strPickTime,strDropTime,strAmount from tbl_Route where nsch_id='"+Session["nschoolid"]+"' and bisDeleted='False'";

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
        {try
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            string del = gvr.Cells[0].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Route set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nrt_id='" + del + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
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