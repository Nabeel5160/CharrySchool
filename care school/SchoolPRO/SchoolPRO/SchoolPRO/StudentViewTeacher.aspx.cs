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
    public partial class StudentViewTeacher : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
            string cid = "";
            string scid = "";
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select nc_id,nsc_id from tbl_Enrollment where ne_id='"+Session["eid"]+"' and bisDeleted='False' and nsch_id='"+Session["nschoolid"]+"'";

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                cid = dr["nc_id"].ToString();
                scid = dr["nsc_id"].ToString();
            }
            con.Close();
            teacherDs.SelectParameters["cid"].DefaultValue = cid;
            teacherDs.SelectParameters["scid"].DefaultValue = scid;
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
        protected void btnviewteacher_Click(object sender, EventArgs e)
        {
            //GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            //string eid = gvr.Cells[1].Text;
            //string cid = gvr.Cells[2].Text;
            //string scid = gvr.Cells[3].Text;

            //teacherDs.SelectParameters["cid"].DefaultValue = cid;
            //teacherDs.SelectParameters["scid"].DefaultValue = scid;

            //mvt.ActiveViewIndex = 1;

        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 0;
        }

        protected void btnratingt_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["techid2"]=gvr.Cells[8].Text;
            Response.Redirect("StudentRateTeacher.aspx");
        }

        protected void RatingControl_Changed(object sender, AjaxControlToolkit.RatingEventArgs e)
        {
            try
            {
                string remarks = "";
                if (RatingControl.CurrentRating == 1)
                {
                    remarks = "Poor";
                }
                else if (RatingControl.CurrentRating == 2)
                {
                    remarks = "Average";
                }
                else if (RatingControl.CurrentRating == 3)
                {
                    remarks = "Fair";
                }
                else if (RatingControl.CurrentRating == 4)
                {
                    remarks = "Good";
                }
                else if (RatingControl.CurrentRating == 5)
                {
                    remarks = "Excellent";
                }

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.CommandText = "insert into tbl_StudentRateTeacher(nu_id,nTeach_id,strPoints,strOutOf,strRemarks,dtAddDate,bisDeleted,nsch_id)values(@uid,@ddtid,@points,'5',@rm,@date,@fbit,@sch)";
                cmd.Parameters.AddWithValue("@uid", Session["eid"].ToString());
                cmd.Parameters.AddWithValue("@sch", Session["nschoolid"].ToString());
                cmd.Parameters.AddWithValue("@ddtid", ddcc.SelectedValue);
                cmd.Parameters.AddWithValue("@points", RatingControl.CurrentRating);
                cmd.Parameters.AddWithValue("@rm", remarks);
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@date", DATE_FORMAT.format());

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    Response.Redirect("StudentViewTeacherRating.aspx");
                    con.Close();
                }
            }
        }

        protected void btnleavereq_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["teid"] = gvr.Cells[8].Text;
            Response.Redirect("StudentMarkLeave.aspx");
        }
    }
}