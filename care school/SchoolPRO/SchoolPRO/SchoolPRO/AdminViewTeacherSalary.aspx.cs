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
    public partial class AdminViewTeacherSalary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Select strSchName+'  '+strAddress as school from  tbl_School where nsch_id= '" + Session["nschoolid"] + "' and bisDeleted='False'";
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtSchool.Text = dr["school"].ToString();
                }
                else
                {

                }
                con.Close();
                ///////////////////////////////////////////////////////////////////////////
             
                ///////////////////////////////////////////////////////////////////////////
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
        public void GetTeacher()
        {
            SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
            try
            {
           

            con1.Open();
            cmd.Connection = con1;
            cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Present' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
            cmd.CommandText = "select * from tbl_Salary where nu_id='" + Convert.ToInt32(ddltchr.SelectedValue) + "' and SUBSTRING(dtAddDate ,4,2)='" + ddlmonths.Text + "' and SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) and bisDeleted='False' and nsch_id=@schid";
            cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    txtempName.Text = ddltchr.SelectedItem.ToString();
                    txtempsal.Text = dr["strSalary"].ToString();
                    txtempInvc.Text = dr["nsal_id"].ToString();
                    txtempBonus.Text = dr["strBonus"].ToString();
                    txtempfine.Text = dr["strFine"].ToString();
                    date.Text = dr["dtAddDate"].ToString();

                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('No Salary Found.');", true);
                Reset();
            }
                con1.Close();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con1.State == ConnectionState.Open)
                {
                    con1.Close();
                }
            }
        }
        void Reset()
        {
            txtempName.Text = "";
            txtempsal.Text = "0";
            txtempInvc.Text = "0";
            txtempBonus.Text = "0";
            txtempfine.Text = "0";
            txtempprsnt.Text = "0";
            date.Text = "0/0/0";
        }
        public void status()
        {
            SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
            try
            {
                

                con1.Open();
                cmd.Connection = con1;
                cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Present' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Present' and nu_id='" + Convert.ToInt32(ddltchr.SelectedValue) + "' and SUBSTRING(dtAddDate ,4,2)='" + ddlmonths.Text + "' and SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) and bisDeleted='False' and nsch_id=@schid44";
                cmd.Parameters.AddWithValue("@schid44", Session["nschoolid"]);
                int present = Convert.ToInt32(cmd.ExecuteScalar());
                //if (present > 0)
                //{
                 txtempprsnt.Text = present.ToString();
                //}
                con1.Close();
                con1.Open();
                cmd.Connection = con1;
                cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Abscent' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Abscent' and nu_id='" + Convert.ToInt32(ddltchr.SelectedValue) + "' and SUBSTRING(dtAddDate ,4,2)='" + ddlmonths.Text + "' and SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) and bisDeleted='False' and nsch_id=@schid1";
                cmd.Parameters.AddWithValue("@schid1", Session["nschoolid"]);
                int Abscent = Convert.ToInt32(cmd.ExecuteScalar());
                //if (Abscent > 0)
                //{
                txtempAbsnt.Text = Abscent.ToString();
                //}
                con1.Close();
                con1.Open();
                cmd.Connection = con1;
                cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Half Leave Application' OR strStatus='Full Leave Application' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where nu_id='" + Convert.ToInt32(ddltchr.SelectedValue) + "' and strStatus='Half Leave Application' and SUBSTRING(dtAddDate ,4,2)='" + ddlmonths.Text + "' and SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) and bisDeleted='False' and nsch_id=@schid2";
                cmd.Parameters.AddWithValue("@schid2", Session["nschoolid"]);
                int Leave = Convert.ToInt32(cmd.ExecuteScalar());
                //if (Leave > 0)
                //{
                txtemphalfleaves.Text = Leave.ToString();
                //}
                con1.Close();
                con1.Open();
                cmd.Connection = con1;
                cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Half Leave Application' OR strStatus='Full Leave Application' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where nu_id='" + Convert.ToInt32(ddltchr.SelectedValue) + "' and strStatus='Full Leave Application' and SUBSTRING(dtAddDate ,4,2)='" + ddlmonths.Text + "' and SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) and bisDeleted='False'and nsch_id=@schid3";
                cmd.Parameters.AddWithValue("@schid3", Session["nschoolid"]);
                int fulLeave = Convert.ToInt32(cmd.ExecuteScalar());
                //if (Leave > 0)
                //{
                txtempfulleaves.Text = fulLeave.ToString();
                //}
                con1.Close();
                //con1.Open();
                //cmd.Connection = con1;
                //cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Late' and nu_id='" + Convert.ToInt32(ddenm.SelectedValue) + "' and DATEPART(m,dtAddDate)=DATEPART(m,CONVERT(VARCHAR(10), GETDATE(), 105 )) and bisDeleted='False'";
                //int Late = Convert.ToInt32(cmd.ExecuteScalar());
                ////if (Late > 0)
                ////{
                ////= Late.ToString();
                ////}

                //con1.Close();



            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con1.State == ConnectionState.Open)
                {
                    con1.Close();
                }
            }
        }

        protected void ddltchr_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlmonths.SelectedValue != "00" && ddltchr.SelectedIndex != -1)
            {
                GetTeacher();
                status();
            }
        }

        protected void ddlmonths_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlmonths.SelectedValue != "00" && ddltchr.SelectedIndex != -1)
            {
                GetTeacher();
                status();
            }
        }

    }
}