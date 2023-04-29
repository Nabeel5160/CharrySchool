using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class TeacherStudentAttendance : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
          
            string day = "";
            if (!IsPostBack)
            {
                day = DateTime.Now.DayOfWeek.ToString();
                sqlst.SelectParameters["day"].DefaultValue = day;
                txtdate.Text = DATE_FORMAT.format();
            }
            else
            {
                //day = Convert.ToDateTime(txtdate.Text).DayOfWeek.ToString();
                ////sqlst.SelectParameters["day"].DefaultValue = day;
                //sqlst.SelectCommand = "SELECT c.nc_id,c.strClass, sc.strSection, s.strCourseCode, s.strSubject FROM tbl_TimeTable AS t inner join tbl_Section sc on t.nsc_id=sc.nsc_id INNER JOIN tbl_Class AS c ON t.nc_id = c.nc_id INNER JOIN tbl_Subject AS s ON t.nsbj_id = s.nsbj_id INNER JOIN tbl_Users AS u ON t.nu_id = u.nu_id WHERE (u.strEmail ='" + Session["userval"] + "' ) and t.bisDeleted='False' and strDay='" + day + "'";
                //sqlst.DataBind();

                //// gvsubst.DataSource = sqlst;
                //gvsubst.DataBind();
            }
                try
            {
                string Status1 = "";
                string Status2 = "";

                string uid = Session["uid"].ToString();
                string scholid = Session["nschoolid"].ToString();

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from tbl_AttendenceMarking";

                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Status1 = dr["bisClassTeacher"].ToString();
                    //Status2 = dr["bisAllTeacher"].ToString();

                }
                else
                {
                    //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalid User Name or Password.');", true);
                }
                con.Close();
                if (Status1 == "True")
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select nc_id,nsc_id from tbl_ClassIncharge where nu_id='" + Convert.ToInt32(uid) + "' and nsch_id='" + Convert.ToInt32(scholid) + "' and bisDeleted='False'";

                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                       
                       
                        con.Close();


                    }
                    else
                    {
                        con.Close();

                        //Response.Redirect("TeacherDashBoard.aspx");
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('You Are Not Allowed to Take Attendence ,Only Class Incharge is Allowed to Take Attendence.'); window.Location='TeacherDashBoard.aspx';", true);
                    }
                    
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('" + ex.Message + "');", true);
            }

         
            finally {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            

        }
        public Boolean CheckClass()
        {
           

            return false;
        }
        protected void btndattnd_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["cid"] = gvr.Cells[1].Text;
                Session["cname"] = gvr.Cells[2].Text;
                Session["sec"] = gvr.Cells[7].Text;
                Session["courscode"] = gvr.Cells[8].Text;
               
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
            Response.Redirect("TeacherTakeAttendance.aspx");
        }

        protected void txtdate_TextChanged(object sender, EventArgs e)
        {

        }

        

    }
}