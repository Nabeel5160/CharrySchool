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
    public partial class AdminManageFee : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
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
        protected void btnsub_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtfolderfee.Text == "")
                {
                    txtfolderfee.Text = "0";
                }
                if (txtbookfee.Text == "")
                {
                    txtbookfee.Text = "0";
                }
                if (txtstatfee.Text == "")
                {
                    txtstatfee.Text = "0";
                }
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from tbl_Fee where nc_id=@cid1 and bisDeleted='False' and nsch_id= '" + Session["nschoolid"] + "'";
                cmd.Parameters.AddWithValue("@cid1", ddcl.SelectedValue);
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Fee already exist for this Class.');", true);
                }
                else
                {
                    con.Close();
                    con.Open();
                    string date = DATE_FORMAT.format();
                    string bit = "False";
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_Fee(strRegFee,strFolderFee,strGeneratorFee,strBookFee,strStationaryFee,strAnnualExamFee,strTutionFee,strAdmsFee,strLeaveFee,nc_id,nu_id,dtAddDate,bisDeleted,nsch_id)values(@regfee,@fldrfee,@genfee,@bookfee,@statfee,@examfee,@fa,@afa,@lfee,@cid,@uid,@date,@bit,@schid)";
                    cmd.Parameters.AddWithValue("@cid", ddcl.SelectedValue);
                    cmd.Parameters.AddWithValue("@fa", txtclfee.Text);
                    cmd.Parameters.AddWithValue("@afa", txtadm.Text);
                    cmd.Parameters.AddWithValue("@lfee", txtLvFee.Text);
                    cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
                    cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                    cmd.Parameters.AddWithValue("@bit", bit);
                    cmd.Parameters.AddWithValue("@date", date);
                    cmd.Parameters.AddWithValue("@regfee", txtregfee.Text);
                    cmd.Parameters.AddWithValue("@fldrfee", txtfolderfee.Text);
                    cmd.Parameters.AddWithValue("@genfee", txtgenfee.Text);
                    cmd.Parameters.AddWithValue("@bookfee", txtbookfee.Text);
                    cmd.Parameters.AddWithValue("@statfee", txtstatfee.Text);
                    cmd.Parameters.AddWithValue("@examfee", txtexamfee.Text);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    txtclfee.Text = "";
                    txtadm.Text = "";
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Fee is Added SuccessFully.');", true);
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
                PopulateData();
                mvsub.ActiveViewIndex = 0;
            }
        }
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select f.strLeaveFee,f.nfee_id,f.strTutionFee,f.strAdmsFee,c.strClass,f.strRegFee,f.strFolderFee,f.strGeneratorFee,f.strBookFee,f.strStationaryFee,f.strAnnualExamFee from tbl_Fee f inner join tbl_Class c on f.nc_id=c.nc_id where f.bisDeleted='False' and f.nsch_id= '" + Session["nschoolid"] + "'";
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

                    string sql = "select f.strLeaveFee,f.nfee_id,f.strTutionFee,f.strAdmsFee,c.strClass,f.strRegFee,f.strFolderFee,f.strGeneratorFee,f.strBookFee,f.strStationaryFee,f.strAnnualExamFee from tbl_Fee f inner join tbl_Class c on f.nc_id=c.nc_id where f.bisDeleted='False' and f.nsch_id= '" + Session["nschoolid"] + "'";

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
            mvsub.ActiveViewIndex = 1;
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
                cmd.CommandText = "update tbl_Fee set dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ),bisDeleted='True' where nfee_id='" + del + "' and nsch_id= '" + Session["nschoolid"] + "' and bisDeleted='False'";
                cmd.ExecuteNonQuery();
                con.Close();
                PopulateData();
                mvsub.ActiveViewIndex = 0;
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
        protected void gvfee_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvfee.PageIndex = e.NewPageIndex;
                PopulateData();
            }
            catch (Exception) { }
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["feeid"] = gvr.Cells[1].Text;
                txttutifee.Text = gvr.Cells[2].Text;
                Session["txttutifee"] = gvr.Cells[2].Text;
                txtadfee.Text = gvr.Cells[3].Text;
                Session["txtadfee"] = gvr.Cells[3].Text;
                txtregfe.Text = gvr.Cells[4].Text;
                Session["txtregfe"] = gvr.Cells[4].Text;
                txtgenfee1.Text = gvr.Cells[6].Text;
                Session["txtgenfee1"] = gvr.Cells[6].Text;
                txtfolfee.Text = gvr.Cells[5].Text;
                Session["txtfolfee"] = gvr.Cells[5].Text;
                txtbookfee1.Text = gvr.Cells[7].Text;
                Session["txtbookfee1"] = gvr.Cells[7].Text;
                txtstanfee.Text = gvr.Cells[8].Text;
                Session["txtstanfee"] = gvr.Cells[8].Text;
                txtannulfees.Text = gvr.Cells[9].Text;
                Session["txtannulfees"] = gvr.Cells[9].Text;
                txtleavfee.Text = gvr.Cells[10].Text;
                Session["txtleavfee"] = gvr.Cells[10].Text;
                
                mvsub.ActiveViewIndex = 2;

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

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {


                con.Close();
                con.Open();
                string date = DATE_FORMAT.format();
                string bit = "False";
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into tbl_FeeHistory(strRegFee,strFolderFee,strGeneratorFee,strBookFee,strStationaryFee,strAnnualExamFee,strTutionFee,strAdmsFee,strLeaveFee,nu_id,dtAddDate,bisDeleted,nsch_id)values(@regfee,@fldrfee,@genfee,@bookfee,@statfee,@examfee,@fa,@afa,@lfee,@uid,@date,@bit,@schid)";
                cmd.Parameters.AddWithValue("@fa", Session["txttutifee"].ToString());
                cmd.Parameters.AddWithValue("@afa", Session["txtadfee"].ToString());
                cmd.Parameters.AddWithValue("@lfee", Session["txtleavfee"].ToString());
                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
                cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                cmd.Parameters.AddWithValue("@bit", bit);
                cmd.Parameters.AddWithValue("@date", date);
                cmd.Parameters.AddWithValue("@regfee", Session["txtregfe"].ToString());
                cmd.Parameters.AddWithValue("@fldrfee", Session["txtfolfee"].ToString());
                cmd.Parameters.AddWithValue("@genfee", Session["txtgenfee1"].ToString());
                cmd.Parameters.AddWithValue("@bookfee", Session["txtbookfee1"].ToString());
                cmd.Parameters.AddWithValue("@statfee", Session["txtstanfee"].ToString());
                cmd.Parameters.AddWithValue("@examfee", Session["txtannulfees"].ToString());
                cmd.ExecuteNonQuery();
                con.Close();
                //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Fee is Added SuccessFully.');", true);



                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_Fee set strTutionFee=@efee, strAdmsFee=@efa ,strLeaveFee=@lfee1,strRegFee=@reg ,strFolderFee=@fol, strGeneratorFee=@gen ,strBookFee=@bokf ,strStationaryFee=@stan ,strAnnualExamFee=@annul where nfee_id='" + Session["feeid"] + "' and nsch_id= '" + Session["nschoolid"] + "' and bisDeleted='False'";
                cmd.Parameters.AddWithValue("@efee", txttutifee.Text);
                cmd.Parameters.AddWithValue("@efa", txtadfee.Text);
                cmd.Parameters.AddWithValue("@lfee1", txtleavfee.Text);
                cmd.Parameters.AddWithValue("@reg", txtregfe.Text);
                cmd.Parameters.AddWithValue("@fol", txtfolfee.Text);
                cmd.Parameters.AddWithValue("@gen", txtgenfee1.Text);
                cmd.Parameters.AddWithValue("@bokf", txtbookfee1.Text);
                cmd.Parameters.AddWithValue("@stan", txtstanfee.Text);
                cmd.Parameters.AddWithValue("@annul", txtannulfees.Text);
                cmd.ExecuteNonQuery();
                con.Close();

                txttutifee.Text = "";
                txtadfee.Text = "";
                txtleavfee.Text = "";
                txtregfe.Text = "";
                txtfolfee.Text = "";
                txtgenfee1.Text = "";
                txtbookfee1.Text = "";
                txtstanfee.Text = "";
                txtannulfees.Text = "";

                PopulateData();
                mvsub.ActiveViewIndex = 0;
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