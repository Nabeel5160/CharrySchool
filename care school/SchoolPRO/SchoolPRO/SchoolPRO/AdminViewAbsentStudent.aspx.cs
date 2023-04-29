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
    public partial class AdminViewAbsentStudent : System.Web.UI.Page
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
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT tbl_Attendance.strStatus, tbl_Enrollment.strStudentNum, tbl_Enrollment.strFname, tbl_Class.strClass, tbl_Section.strSection, tbl_Attendance.dtAddDate, tbl_Enrollment.strPhone, tbl_Enrollment.strMobile FROM tbl_Attendance INNER JOIN tbl_Enrollment ON tbl_Attendance.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Class ON tbl_Attendance.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_Attendance.nsc_id = tbl_Section.nsc_id WHERE (SUBSTRING(tbl_Attendance.dtAddDate ,1,2) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,1,2)) AND (SUBSTRING(tbl_Attendance.dtAddDate ,4,2) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2)) AND (tbl_Attendance.bisDeleted = 'False') AND (tbl_Attendance.strStatus = 'Absent') and tbl_Attendance.nsch_id='" + Session["nschoolid"] + "'";
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
               gvabsntstudents.DataSource = dt;
               gvabsntstudents.DataBind();
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
        private void PopulateDataByDate()
        {

            try
            {
            DataTable table = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {


                string sql = "SELECT tbl_Attendance.strStatus, tbl_Enrollment.strStudentNum, tbl_Enrollment.strFname, tbl_Class.strClass, tbl_Section.strSection, tbl_Attendance.dtAddDate, tbl_Enrollment.strPhone, tbl_Enrollment.strMobile FROM tbl_Attendance INNER JOIN tbl_Enrollment ON tbl_Attendance.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Class ON tbl_Attendance.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_Attendance.nsc_id = tbl_Section.nsc_id WHERE  tbl_Attendance.dtAddDate ='" + txtDate.Text + "' AND (tbl_Attendance.bisDeleted = 'False') AND (tbl_Attendance.strStatus = 'Absent') and tbl_Attendance.nsch_id='" + Session["nschoolid"] + "'";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvabsntstudents.DataSource = table;

            gvabsntstudents.DataBind();
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
        protected void txtDate_TextChanged(object sender, EventArgs e)
        {
            PopulateDataByDate();       
        }

    }
}