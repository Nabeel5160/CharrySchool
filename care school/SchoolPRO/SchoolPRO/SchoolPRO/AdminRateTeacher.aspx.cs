using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminRateTeacher : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {

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
                cmd.CommandText = "insert into tbl_TeacherRating(nu_id,nTeach_id,strPoints,strOutOf,strRemarks,dtAddDate,bisDeleted,nsch_id)values(@uid,@ddtid,@points,'5',@rm,@date,@fbit,@sch)";
                cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                cmd.Parameters.AddWithValue("@sch", Session["nschoolid"].ToString());
                cmd.Parameters.AddWithValue("@ddtid", ddcc.SelectedValue);
                cmd.Parameters.AddWithValue("@points", RatingControl.CurrentRating);
                cmd.Parameters.AddWithValue("@rm", remarks);
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@date", DATE_FORMAT.format());

                cmd.ExecuteNonQuery();
                con.Close();
                mvquiz.ActiveViewIndex = 0;
                gvrteachrate.DataBind();
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
            mvquiz.ActiveViewIndex = 1;
        }

        protected void btndel_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string delid = gvr.Cells[1].Text;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.CommandText = "update tbl_TeacherRating set bisDeleted=@tbit,dtDeleteDate=@date where nTRate_id=@did";
                cmd.Parameters.AddWithValue("@tbit", BIT_T_F.TrueBit());
                cmd.Parameters.AddWithValue("@date", DATE_FORMAT.format());
                cmd.Parameters.AddWithValue("@did", delid);
                cmd.ExecuteNonQuery();
                con.Close();
                mvquiz.ActiveViewIndex = 0;
                gvrteachrate.DataBind();
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