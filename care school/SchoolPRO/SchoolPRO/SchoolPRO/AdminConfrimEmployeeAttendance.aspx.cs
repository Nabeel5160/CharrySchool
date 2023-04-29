using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace SchoolPRO
{
    public partial class AdminConfrimEmployeeAttendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {

                    BindGrid();

                }
                if (ddstatus.Text == "Full Leave Application" || ddstatus.Text == "Half Leave Application")
                {
                    fulv.Visible = true;
                }
                else
                {
                    fulv.Visible = false;
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
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            string date = DATE_FORMAT.format();
            string bit = "False";
            cmd.CommandText = "Select u.strfname+' '+u.strlname as name,u.strNIC,u.strCell,t.nta_id,t.strPresentTime,t.strLeaveTime,t.strStatus,strLeaveReason,t.strLeaveDoc,t.bisConfirm,t.dtAddDate from tbl_EmployeeAttendance t inner join tbl_Users u on t.nu_id=u.nu_id where t.nsch_id='" + Session["nschoolid"] + "' and t.dtAddDate=@date and t.bisDeleted=@bit and u.bisDeleted=@bit  and (u.nLevel =@am_emp OR u.nLevel = @adm_emp OR u.nLevel = @lib_emp OR u.nLevel= @hstl_emp )";
            cmd.Parameters.AddWithValue("@am_emp",UsersLevel.getAmLevel());
            cmd.Parameters.AddWithValue("@adm_emp", UsersLevel.getAdminLevel());
            cmd.Parameters.AddWithValue("@lib_emp", UsersLevel.getLibLevel());
            cmd.Parameters.AddWithValue("@hstl_emp", UsersLevel.getHostelLevel());

            cmd.Parameters.AddWithValue("@bit", bit);
            cmd.Parameters.AddWithValue("@date", date);

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

        private void PopulateData()
        {
            try
            {
                DataTable table = new DataTable();
                string date = DATE_FORMAT.format();
                string bit = "False";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
                {

                    string sql = "Select u.strfname+' '+u.strlname as name,u.strNIC,u.strCell,t.nta_id,t.strPresentTime,t.strLeaveTime,t.strStatus,strLeaveReason,t.strLeaveDoc,t.bisConfirm,t.dtAddDate from tbl_EmployeeAttendance t inner join tbl_Users u on t.nu_id=u.nu_id where t.nsch_id='" + Session["nschoolid"] + "' and t.dtAddDate=@date and t.bisDeleted=@bit and u.bisDeleted=@bit and (u.nLevel =@am_emp OR u.nLevel = @adm_emp OR u.nLevel = @lib_emp OR u.nLevel= @hstl_emp )";
               

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@am_emp", UsersLevel.getAmLevel());
                        cmd.Parameters.AddWithValue("@adm_emp", UsersLevel.getAdminLevel());
                        cmd.Parameters.AddWithValue("@lib_emp", UsersLevel.getLibLevel());
                        cmd.Parameters.AddWithValue("@hstl_emp", UsersLevel.getHostelLevel());
                        cmd.Parameters.AddWithValue("@bit", bit);
                        cmd.Parameters.AddWithValue("@date", date);

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
        private void PopulateDataByDate()
        {
            try
            {
                DataTable table = new DataTable();

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
                {


                    string sql = "Select u.strfname+' '+u.strlname as name,u.strNIC,u.strCell,t.nta_id,t.strPresentTime,t.strLeaveTime,t.strStatus,strLeaveReason,t.strLeaveDoc,t.bisConfirm,t.dtAddDate from tbl_EmployeeAttendance t inner join tbl_Users u on t.nu_id=u.nu_id where t.nsch_id='" + Session["nschoolid"] + "' and (t.dtAddDate>='" + txtFrom.Text + "'  and t.dtAddDate<='" + txtTo.Text + "') and t.bisDeleted='False' and u.bisDeleted='False' and (u.nLevel =@am_emp OR u.nLevel = @adm_emp OR u.nLevel = @lib_emp OR u.nLevel= @hstl_emp )"; 
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@am_emp", UsersLevel.getAmLevel());
                        cmd.Parameters.AddWithValue("@adm_emp", UsersLevel.getAdminLevel());
                        cmd.Parameters.AddWithValue("@lib_emp", UsersLevel.getLibLevel());
                        cmd.Parameters.AddWithValue("@hstl_emp", UsersLevel.getHostelLevel());

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

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            mvatnd.ActiveViewIndex = 1;
        }

        protected void btnadd_Click(object sender, EventArgs e)
        {
            try
            {
                string date = DATE_FORMAT.format();
                string bit = "False";
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select count(nta_id) from tbl_EmployeeAttendance where dtAddDate=@date1 and nu_id='" + Convert.ToInt32(ddtch.SelectedValue) + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
                cmd.Parameters.AddWithValue("@date1", date);
                int result = Convert.ToInt32(cmd.ExecuteScalar());

                con.Close();
                if (result != 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Attendance has already been marked.');", true);
                }
                else
                {

                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_EmployeeAttendance(strStatus,strLeaveReason,nu_id,nsch_id,bisConfirm,strLeaveDoc,dtAddDate,bisDeleted,userid)values('" + ddstatus.Text + "',@reason,'" + Convert.ToInt32(ddtch.SelectedValue) + "','" + Session["nschoolid"] + "',@cnfrm,@leave,@date,@bit,@uid)";
                    cmd.Parameters.AddWithValue("@bit", bit);
                    cmd.Parameters.AddWithValue("@date", date);
                    cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                    if (ddstatus.Text == "Present")
                    {
                        cmd.Parameters.AddWithValue("@cnfrm", "True");
                        cmd.Parameters.AddWithValue("@leave", "nil");//@reason
                        cmd.Parameters.AddWithValue("@reason", "nil");
                    }
                    else if (ddstatus.Text == "Absent")
                    {
                        cmd.Parameters.AddWithValue("@cnfrm", "True");
                        cmd.Parameters.AddWithValue("@leave", "nil");
                        cmd.Parameters.AddWithValue("@reason", "nil");
                    }
                    else if (ddstatus.Text == "Full Leave Application")
                    {
                        cmd.Parameters.AddWithValue("@cnfrm", "True");
                        cmd.Parameters.AddWithValue("@leave", "Full");
                        cmd.Parameters.AddWithValue("@reason", fulv.Text);
                    }
                    else if (ddstatus.Text == "Half Leave Application")
                    {
                        cmd.Parameters.AddWithValue("@cnfrm", "True");
                        cmd.Parameters.AddWithValue("@leave", "Half");
                        cmd.Parameters.AddWithValue("@reason", fulv.Text);
                    }


                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                PopulateData();
                mvatnd.ActiveViewIndex = 0;
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

        protected void gvsearchclass_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvsearchclass.PageIndex = e.NewPageIndex;
                PopulateData();
            }
            catch (Exception ex)
            {
                //Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        protected void txtTo_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (txtFrom.Text != "" && txtTo.Text != "")
                    PopulateDataByDate();
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

        protected void btnaddLeave_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                string date = DATE_FORMAT.format();
                string bit = "False";
                cmd.CommandText = "select count(nta_id) from tbl_EmployeeAttendance where dtAddDate=@date and nu_id='" + Convert.ToInt32(ddltchr.SelectedValue) + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
                cmd.Parameters.AddWithValue("@date", date);
                int result = Convert.ToInt32(cmd.ExecuteScalar());

                con.Close();
                if (result != 0)
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    //cmd.CommandText = "Update tbl_EmployeeAttendance Set strStatus='" + ddlstatus.Text + "' ,strLeaveReason='" + txtReason.Text + "' where dtAddDate=convert(date,SYSDATETIME()) and nu_id='" + Convert.ToInt32(ddltchr.SelectedValue) + "' and (strStatus='Present' OR strStatus='Abscent') and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
                    cmd.CommandText = "Update tbl_EmployeeAttendance Set strStatus='" + ddlstatus.Text + "' ,strLeaveReason='" + txtReason.Text + "' where dtAddDate=@date2 and nu_id='" + Convert.ToInt32(ddltchr.SelectedValue) + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
                    cmd.Parameters.AddWithValue("@date2", date);

                    cmd.ExecuteNonQuery();
                    con.Close();
                    // ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Attendance has already been marked.');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Cannot Mark Leave Because Attendance Not marked. First Mark the Attendence Please (Present or Absent)');", true);
                }
                PopulateData();
                mvatnd.ActiveViewIndex = 0;
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

        protected void btnprint_Click(object sender, EventArgs e)
        {

        }

        protected void btnleave_Click(object sender, EventArgs e)
        {
            mvatnd.ActiveViewIndex = 2;
        }

        protected void txtFrom_TextChanged(object sender, EventArgs e)
        {
            try
            {

                if (txtFrom.Text != "")
                {
                    btnleave.Enabled = false;

                }
                if (txtFrom.Text != "" && txtTo.Text != "")
                {
                    PopulateDataByDate();
                    btnleave.Enabled = false;
                }
                if (txtFrom.Text == "" && txtTo.Text == "")
                {
                    btnleave.Enabled = true;
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

        protected void txtTo_TextChanged1(object sender, EventArgs e)
        {
            try
            {
                if (txtTo.Text != "")
                {
                    btnleave.Enabled = false;

                }

                if (txtFrom.Text != "" && txtTo.Text != "")
                {
                    PopulateDataByDate();
                    btnleave.Enabled = false;
                }
                if (txtFrom.Text == "" && txtTo.Text == "")
                {
                    btnleave.Enabled = true;
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
    }
}