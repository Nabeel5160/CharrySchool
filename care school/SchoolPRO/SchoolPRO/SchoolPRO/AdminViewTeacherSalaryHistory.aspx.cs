using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminViewTeacherSalaryHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        //SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        //SqlCommand cmd = new SqlCommand();
        //SqlDataReader dr;
        //public void GetTeacher()
        //{
        //    SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());

        //    con1.Open();
        //    cmd.Connection = con1;
        //    cmd.CommandType = CommandType.Text;
        //    //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Present' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
        //    cmd.CommandText = "select * from tbl_Salary where nu_id='" + Convert.ToInt32(ddltchr.SelectedValue) + "' and DATEPART(m,dtAddDate)='" + ddlmonths.Text + "' and bisDeleted='False'";
        //    dr = cmd.ExecuteReader();
        //    if (dr.HasRows)
        //    {
        //        while (dr.Read())
        //        {
        //            txtempName.Text = ddltchr.SelectedItem.ToString();
        //            txtempsal.Text = dr["strSalary"].ToString();
        //            txtempInvc.Text = dr["nsal_id"].ToString();
        //            txtempBonus.Text = dr["strBonus"].ToString();
        //            txtempfine.Text = dr["strFine"].ToString();
        //            date.Text = dr["dtAddDate"].ToString();

        //        }
        //    }
        //    else
        //    {
        //        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('No Salary Found.');", true);
        //    }
        //    con1.Close();
        //}

        //public void status()
        //{
        //    try
        //    {
        //        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());

        //        con1.Open();
        //        cmd.Connection = con1;
        //        cmd.CommandType = CommandType.Text;
        //        //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Present' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
        //        cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Present' and nu_id='" + Convert.ToInt32(ddltchr.SelectedValue) + "' and DATEPART(m,dtAddDate)='" + ddlmonths.Text + "' and bisDeleted='False'";
        //        int present = Convert.ToInt32(cmd.ExecuteScalar());
        //        //if (present > 0)
        //        //{
        //        txtempprsnt.Text = present.ToString();
        //        //}
        //        con1.Close();
        //        con1.Open();
        //        cmd.Connection = con1;
        //        cmd.CommandType = CommandType.Text;
        //        //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Abscent' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
        //        cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Abscent' and nu_id='" + Convert.ToInt32(ddltchr.SelectedValue) + "' and DATEPART(m,dtAddDate)='" + ddlmonths.Text + "' and bisDeleted='False'";
        //        int Abscent = Convert.ToInt32(cmd.ExecuteScalar());
        //        //if (Abscent > 0)
        //        //{
        //        txtempAbsnt.Text = Abscent.ToString();
        //        //}
        //        con1.Close();
        //        con1.Open();
        //        cmd.Connection = con1;
        //        cmd.CommandType = CommandType.Text;
        //        //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Half Leave Application' OR strStatus='Full Leave Application' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
        //        cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where nu_id='" + Convert.ToInt32(ddltchr.SelectedValue) + "' and strStatus='Half Leave Application' and DATEPART(m,dtAddDate)='" + ddlmonths.Text + "' and bisDeleted='False'";
        //        int Leave = Convert.ToInt32(cmd.ExecuteScalar());
        //        //if (Leave > 0)
        //        //{
        //        txtemphalfleaves.Text = Leave.ToString();
        //        //}
        //        con1.Close();
        //        con1.Open();
        //        cmd.Connection = con1;
        //        cmd.CommandType = CommandType.Text;
        //        //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Half Leave Application' OR strStatus='Full Leave Application' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
        //        cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where nu_id='" + Convert.ToInt32(ddltchr.SelectedValue) + "' and strStatus='Full Leave Application' and DATEPART(m,dtAddDate)='" + ddlmonths.Text + "' and bisDeleted='False'";
        //        int fulLeave = Convert.ToInt32(cmd.ExecuteScalar());
        //        //if (Leave > 0)
        //        //{
        //        txtempfulleaves.Text = fulLeave.ToString();
        //        //}
        //        con1.Close();
        //        //con1.Open();
        //        //cmd.Connection = con1;
        //        //cmd.CommandType = CommandType.Text;
        //        //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Late' and nu_id='" + Convert.ToInt32(ddenm.SelectedValue) + "' and DATEPART(m,dtAddDate)=DATEPART(m,convert(date,SYSDATETIME())) and bisDeleted='False'";
        //        //int Late = Convert.ToInt32(cmd.ExecuteScalar());
        //        ////if (Late > 0)
        //        ////{
        //        ////= Late.ToString();
        //        ////}

        //        //con1.Close();



        //    }
        //    catch (Exception ex)
        //    {
        //        Response.Redirect("Error.aspx?msg=AdminManageSalary.aspx");
        //    }
        //}
    }
}