using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace SchoolPRO
{
    public partial class TeacherTakeAttendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //if (!IsPostBack)
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
                    cmd.CommandText = "select nc_id,nsc_id from tbl_ClassIncharge where nu_id='" + Session["uid"] + "' and nsch_id='" + Session["nschoolid"] + "' and nc_id='" + Session["cid"] + "' and nsc_id='" + Session["sec"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"]+"'";

                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {

                    }
                    else
                    {
                        //Response.Redirect("TeacherDashBoard.aspx");


                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Sorry Your Not Class Incharge Of this Class.'); window.location ='TeacherDashBoard.aspx';", true);
                    }
                    con.Close();
                }
                else
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", " window.Location='TeacherDashBoard.aspx';", true);
                    //Response.Redirect("TeacherDashBoard.aspx");
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
            //(select nsc_id from tbl_Section where strSection='" + Session["sec"] + "' and nc_id='" + Session["cid"] + "' and bisDeleted='False')
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btnsubmitattend_Click(object sender, EventArgs e)
        {
            Boolean ADDFLAG = true;
            try
            {

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select nc_id,nsc_id from tbl_ClassIncharge where nu_id='" + Session["uid"] + "' and nsch_id='" + Session["nschoolid"] + "' and nc_id='" + Session["cid"] + "' and nsc_id='" + Session["sec"] + "' and bisDeleted='False' ";

                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {

                }
                else
                {
                    //Response.Redirect("TeacherDashBoard.aspx");
                    ADDFLAG = false;

                   // ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Sorry Your Not Class Incharge Of this Class.'); window.Loction='TeacherDashBoard.aspx';", true);
                }
                con.Close();
                if (ADDFLAG)
                {
                    //string date = "";
                    //string m_date = "";
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    //cmd.CommandText = "select dtAddDate from tbl_Attendance where dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) and nsbj_id=(select nsbj_id from tbl_Subject where strCourseCode='" + Session["courscode"] + "') and nsc_id=(select nsc_id from tbl_Section where nc_id='" + Session["cid"] + "') and bisDeleted='False'";
                    cmd.CommandText = "select count(na_id) from tbl_Attendance where dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) and nsbj_id='" + Session["courscode"] + "' and nsc_id='" + Session["sec"] + "' and nc_id='" + Session["cid"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    int result = Convert.ToInt32(cmd.ExecuteScalar());

                    con.Close();
                    if (result != 0)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Attendance has already been marked.');", true);
                    }
                    else
                    {
                        con.Open();
                        foreach (GridViewRow row in gvattnd.Rows)
                        {
                            if (row.RowType == DataControlRowType.DataRow)
                            {
                                string status = ((DropDownList)row.FindControl("ddst")).Text;
                                string remarks = ((TextBox)row.FindControl("txtrem")).Text;
                                Session["eid"] = row.Cells[1].Text;
                                //txtre.Text=gvr.Cells[4].Text;

                                cmd.Connection = con;
                                cmd.CommandType = CommandType.Text;
                                cmd.CommandText = "insert into tbl_Attendance(nsch_id,nc_id,nsc_id,nsbj_id,ne_id,nu_id,strStatus,strRemarks,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "','" + Session["cid"] + "','" + Session["sec"] + "','" + Session["courscode"] + "' ,'" + Session["eid"] + "','" + Session["uid"] + "',@st,@rem,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";

                                cmd.Parameters.AddWithValue("@st", status);
                                cmd.Parameters.AddWithValue("@rem", remarks);
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();
                            }
                        }
                        con.Close();
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Attendance has been marked.'); window.Location='TeacherStudentAttendance.aspx';", true);
                    }
                }
                else
                { }

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
            if(ADDFLAG==false)

              ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Sorry Your Not  Incharge Of this Class.'); window.Location='TeacherDashBoard.aspx';", true);
        }

        protected void gvattnd_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            List<string> stdid = new List<string>();
            string Currentdate = DATE_FORMAT.format();  //DateTime.Now.ToString("dd-MM-yyyy");
            con.Close();
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.Clear();
            cmd.CommandText = "select nG_id from tbl_Leave where nLevel=3 and bPanding= 'Accepted' and dbo.to_date('dd-mm-yyyy', strFrom)<=dbo.to_date('dd-mm-yyyy',@cdate) and dbo.to_date('dd-mm-yyyy',strTo)>=dbo.to_date('dd-mm-yyyy',@cdate);";
            cmd.Parameters.AddWithValue("@cdate",Currentdate);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                stdid.Add(dr["nG_id"].ToString());
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlaccept = (e.Row.FindControl("ddst") as DropDownList);
                foreach(string idd in stdid)
                {
                if (e.Row.Cells[1].Text == idd)
                {
                    //ddlaccept.Enabled = false;
                    ddlaccept.SelectedIndex = 2;
                }
                }
            }
        }
    }
}