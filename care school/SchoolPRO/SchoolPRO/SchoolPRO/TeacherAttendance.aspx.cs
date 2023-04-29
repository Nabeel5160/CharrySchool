using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class TeacherAttendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
            if (!IsPostBack)
            {

                BindGrid();

            }
            if (ddstatus.Text == "Leave Application")
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
            cmd.CommandText = "Select u.strfname,t.nta_id,t.strPresentTime,t.strLeaveTime,t.bisConfirm,t.dtAddDate from tbl_TeacherAttendance t inner join tbl_Users u on t.nu_id=u.nu_id where t.nu_id='" + Session["uid"] + "' and t.nsch_id='" + Session["nschoolid"] + "'";
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

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {

                string sql = "Select u.strfname,t.nta_id,t.strPresentTime,t.strLeaveTime,t.bisConfirm,t.dtAddDate from tbl_TeacherAttendance t inner join tbl_Users u on t.nu_id=u.nu_id where t.nu_id='" + Session["uid"] + "' and t.nsch_id='" + Session["nschoolid"] + "'";

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
        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            mvatnd.ActiveViewIndex = 1;
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            try
            {
            if (ddstatus.Text == "Leaving")
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_TeacherAttendance set strLeaveTime=convert(time,SYSDATETIME()) where nu_id='" + Session["uid"] + "' and dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 )";
                cmd.ExecuteNonQuery();
                con.Close();
            }
            else if(ddstatus.Text=="Present")
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select count(nta_id) from tbl_TeacherAttendance where dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) and nu_id='" + Session["uid"] + "' and nsch_id='" + Session["nschoolid"] + "'";
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
                    cmd.CommandText = "insert into tbl_TeacherAttendance(nu_id,nsch_id,strStatus,bisConfirm,strPresentTime,strLeaveDoc,dtAddDate,bisDeleted)values('" + Session["uid"] + "','" + Session["nschoolid"] + "','Present','False',convert(time,SYSDATETIME()),@leave,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                    cmd.Parameters.AddWithValue("@leave", "nil");
                    //if (fulv.HasFile)
                    //{
                    //    string img = @"~\Uploaded-Files\" + Path.GetFileName(fulv.PostedFile.FileName);
                    //    fulv.SaveAs(Server.MapPath(img));
                    //    cmd.Parameters.AddWithValue("@leave", img);
                    //}
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            else if (ddstatus.Text == "Leave Application")
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into tbl_TeacherAttendance(nu_id,nsch_id,strStatus,bisConfirm,strPresentTime,strLeaveDoc,dtAddDate,bisDeleted)values('" + Session["uid"] + "','" + Session["nschoolid"] + "','Abscent','False',convert(time,SYSDATETIME()),@leave,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                cmd.Parameters.AddWithValue("@leave", "nil");
                if (fulv.HasFile)
                {
                    string img = @"~\Uploaded-Files\" + Path.GetFileName(fulv.PostedFile.FileName);
                    fulv.SaveAs(Server.MapPath(img));
                    cmd.Parameters.AddWithValue("@leave", img);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@leave", "nil");
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
    }
}