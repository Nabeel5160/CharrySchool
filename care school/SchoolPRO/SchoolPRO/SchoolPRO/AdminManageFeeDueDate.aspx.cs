using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SchoolPRO
{
    public partial class AdminManageFeeDueDate : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                BindGrid();

            }
        }
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select f.nfee_id,f.strTutionFee,f.dtDueDate+' of the Month' as date,Cast(f.nFine as varchar(MAX))+'/-' as fine,c.strClass from tbl_Fee f inner join tbl_Class c on f.nc_id=c.nc_id where f.bisDeleted='False' and f.nsch_id= '" + Session["nschoolid"] + "'";
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
                gvfee.DataSource = dt;
                gvfee.DataBind();
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

                string sql = "select f.nfee_id,f.strTutionFee,f.dtDueDate+' of the Month' as date,Cast(f.nFine as varchar(MAX))+'/-' as fine,c.strClass from tbl_Fee f inner join tbl_Class c on f.nc_id=c.nc_id where f.bisDeleted='False' and f.nsch_id= '" + Session["nschoolid"] + "'";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvfee.DataSource = table;

            gvfee.DataBind();
            }
            catch (Exception ex)
            {
              //  Response.Redirect("Error.aspx");
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
                Session["edit"] = gvr.Cells[1].Text;
                if (gvr.Cells[3].Text != "0")
                {
                    string datee = gvr.Cells[3].Text;
                    datee=datee.Substring(0, datee.IndexOf('o')-1);
                    dd_date2.SelectedValue = datee;
                }

                string finee = gvr.Cells[4].Text;
                finee = finee.Substring(0, finee.IndexOf('/'));
                txtfine2.Text = finee;
                //ddcl2.SelectedValue = ddcl2.SelectedItem.ToString(); //gvr.Cells[5].Text;
                ddcl2.Text = gvr.Cells[5].Text;
                //ddcl2.SelectedIndex = ddcl2.Items.IndexOf(ddcl2.Items.FindByText(gvr.Cells[5].Text));
                ddcl2.Enabled = false;
                //ddecl.SelectedValue = gvr.Cells[3].Text;

                mvfeeDueDate.ActiveViewIndex = 2;
            }

            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally {
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
                cmd.CommandText = "update tbl_Fee set nFine=0 where nfee_id='" + del + "' and nsch_id= '" + Session["nschoolid"] + "'";
                cmd.ExecuteNonQuery();
                con.Close();
                PopulateData();
                mvfeeDueDate.ActiveViewIndex = 0;
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

        protected void btnfeeDueDate_Click(object sender, EventArgs e)
        {
            try
            {
                if (dd_date.SelectedValue.ToString() != "-1" )
                {
                    if (txtfine.Text == "")
                        txtfine.Text = "0";
                    string sql = "";
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    sql = "Update tbl_Fee Set dtDueDate='" + dd_date.SelectedValue + "',nFine='" + txtfine.Text + "' where ";
                    if (radioOneClass.Checked)
                        sql += "nc_id='" + ddcl.SelectedValue + "' and bisDeleted=0 and nsch_id= '" + Session["nschoolid"] + "'";
                    else if (radioAllClass.Checked)
                        sql += "bisDeleted=0 and nsch_id= '" + Session["nschoolid"] + "'";
                    cmd.CommandText = sql;


                    cmd.ExecuteNonQuery();
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Due Date Added Successfully.');", true);
                    PopulateData();
                    mvfeeDueDate.ActiveViewIndex = 0;
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

        protected void radioAllClass_CheckedChanged(object sender, EventArgs e)
        {
            if(radioAllClass.Checked)
            ddcl.Visible = false;
        }

        protected void radioOneClass_CheckedChanged(object sender, EventArgs e)
        {
            if(radioOneClass.Checked)
            ddcl.Visible = true;
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            try
            {
                string sql = "";
                if (txtfine2.Text == "")
                    txtfine2.Text = "0";
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                sql = "Update tbl_Fee Set dtDueDate='" + dd_date2.SelectedValue + "',nFine='" + txtfine2.Text + "' where ";

                sql += "nfee_id='" + Session["edit"] + "'  and bisDeleted=0 and nsch_id= '" + Session["nschoolid"] + "'";

                cmd.CommandText = sql;


                cmd.ExecuteNonQuery();
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Due Date Updated Successfully.');", true);
                PopulateData();
                mvfeeDueDate.ActiveViewIndex = 0;
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

        protected void btngo_Click(object sender, EventArgs e)
        {
            mvfeeDueDate.ActiveViewIndex = 1;
        }

        protected void gvfee_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
            gvfee.PageIndex = e.NewPageIndex;
            PopulateData();
            }
            catch (Exception ex)
            {
      
            }
            finally
            {
                  
            }
        }
    }
}