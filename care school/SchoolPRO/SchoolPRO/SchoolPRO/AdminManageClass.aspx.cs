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
    public partial class AdminManageClass : System.Web.UI.Page
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

    //protected void gvsearchclass_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    try
    //    {
    //    System.Threading.Thread.Sleep(2000);
    //    if (e.CommandName == "Search")
    //    {
    //        TextBox txtGrid = (TextBox)gvsearchclass.HeaderRow.FindControl("txtcc");
    //        SearchText(txtGrid.Text);
    //    }
    //    }
    //    catch (Exception) { }
    //}
    private DataTable GetRecords()
    {

        con.Open();
        cmd.Connection = con;
        cmd.CommandType = CommandType.Text;
        //
        cmd.CommandText = "Select nc_id,strClass,strNOSeats from tbl_Class where bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
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
            gvsearchclass.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
        }
        catch (Exception) { }
    }

    //private void SearchText(string strSearchText)
    //{
    //    try
    //    {
    //    DataTable dt = GetRecords();
    //    DataView dv = new DataView(dt);
    //    string SearchExpression = null;
    //    if (!String.IsNullOrEmpty(strSearchText))
    //    {
    //        SearchExpression =
    //        string.Format("{0} '%{1}%'", gvsearchclass.SortExpression, strSearchText);

    //    }
    //    else
    //        Response.Redirect("AdminManageClass.aspx");
    //    dv.RowFilter = "strClass like" + SearchExpression;
    //    gvsearchclass.DataSource = dv;
    //    gvsearchclass.DataBind();
    //    }
    //    catch (Exception) { }
    //}

    //public string Highlight(string InputTxt)
    //{
    //    GridViewRow gvr = gvsearchclass.HeaderRow;
    //    if (gvr != null)
    //    {
    //        TextBox txtExample = (TextBox)gvsearchclass.HeaderRow.FindControl("txtcc");

    //        if (txtExample.Text != null)
    //        {
    //            string strSearch = txtExample.Text;
    //            Regex RegExp = new Regex(strSearch.Replace(" ", "|").Trim(), RegexOptions.IgnoreCase);
    //            return RegExp.Replace(InputTxt, new MatchEvaluator(ReplaceKeyWords));
    //            RegExp = null;
    //        }
    //        else
    //            return InputTxt;
    //    }
    //    else
    //    {
    //        return InputTxt;
    //    }
    //}

    //public string ReplaceKeyWords(Match m)
    //{
    //    return "<span class='highlight'>" + m.Value + "</span>";
    //}

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
        GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
        Session["cid"] = gvr.Cells[1].Text;
        Session["cnm"] = gvr.Cells[3].Text;
        //txtcupdate.Text = gvr.Cells[2].Text;
        //txtcupdate.Enabled = false;
        Label lbl = (Label)gvr.FindControl("lblcname");
        txtcupdate.Text = lbl.Text;
        txtenos.Text = gvr.Cells[3].Text;
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
        cmd.CommandText = "update tbl_Class set strNOSeats=@enos,dtAddDate= CONVERT(VARCHAR(10), GETDATE(), 105 ) where nc_id='" + Session["cid"] + "'";
        cmd.Parameters.AddWithValue("@cname", txtcupdate.Text);
        cmd.Parameters.AddWithValue("@enos", txtenos.Text);
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
        txtaddclass.Focus();
    }

    protected void btnaddclass_Click(object sender, EventArgs e)
    {
        try
        {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
               // cmd.CommandText = "select nc_id from tbl_Class where strClass='" + txtaddclass.Text + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
            ////CLASS NAME SHOULD BE UNIQUIE IN ALL SCHOOLS///////////   
            cmd.CommandText = "select nc_id from tbl_Class where strClass='" + txtaddclass.Text + "' and bisDeleted='False'";
            ////CLASS NAME SHOULD BE UNIQUIE IN ALL SCHOOLS///////////      
            dr=cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Class already exist.');", true);
                }
                else
                {
                    con.Close();
                    dr.Dispose();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_Class(strClass,nsch_id,nu_id,strNOSeats,dtAddDate,bisDeleted) values(@cname,'" + Session["nschoolid"] + "','" + Session["uid"] + "',@nos,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                    cmd.Parameters.AddWithValue("@cname", txtaddclass.Text);
                    cmd.Parameters.AddWithValue("@nos", txtnos.Text);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    txtaddclass.Text = "";
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Class has been registered successfully.'); window.location = 'AdminManageClass.aspx';", true);
                    //PopulateData();
                    //MultiView1.ActiveViewIndex = 0;
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

            string sql = "Select nc_id,strClass,strNOSeats from tbl_Class where bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";

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
        cmd.CommandText = "update tbl_Class set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nc_id='" + Session["cid"] + "'";
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

}
}