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
    public partial class TeacherPromoteStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        public void total_sale()
        {try
        {
            int total = 0;
            int obt = 0;
            
            foreach (GridViewRow row in gvrzlt.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    string total_marks = row.Cells[5].Text;
                    string obt_marks = row.Cells[6].Text;
                    total = Convert.ToInt32(total_marks) + total;
                    obt = Convert.ToInt32(obt_marks) + obt;
                }
            }
            lblobtmarks.Text = obt.ToString();
            lbltmarks.Text = total.ToString();
        }
        catch (Exception ex)
        {
           // Response.Redirect("Error.aspx");
        }
        finally
        {
          
        }
        }
        protected void btnview_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["cid"] = gvr.Cells[1].Text;
            Session["section"] = gvr.Cells[3].Text;
            mvmarks.ActiveViewIndex = 1;
            total_sale();
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

        protected void btnsubmitattend_Click(object sender, EventArgs e)
        {
            try
            {
                string class_name = null;
                int percentage = 0;
                double result = 0;
                string student_num = null;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select strPercentage from tbl_Percentage where nsch_id='"+Session["nschoolid"]+"'";
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    percentage = Convert.ToInt32(dr["strPercentage"]);
                }
                con.Close();
                result = (Convert.ToDouble(lblobtmarks.Text) / Convert.ToDouble(lbltmarks.Text)) * 100;
                foreach (GridViewRow row in gvrzlt.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        student_num = row.Cells[1].Text;

                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "select nc_id from tbl_Enrollment where ne_id='" + student_num + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                        dr = cmd.ExecuteReader();
                        if (dr.Read())
                        {
                            class_name = dr["nc_id"].ToString();
                        }
                        int actual_Class = 1 + Convert.ToInt32(class_name);
                        con.Close();
                        if (result > percentage)
                        {

                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "insert into tbl_Promotion(ne_id,nc_id,nr_id,strStatus,dtAddDate,bisDeleted) values ('" + student_num + "','" + actual_Class + "',(select max(nr_id) from tbl_Result),'Pass',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                            cmd.ExecuteNonQuery();
                            con.Close();
                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "update tbl_Enrollment set nc_id='" + actual_Class + "' where ne_id='" + student_num + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                        else
                        {
                            /////////////////////////////////////////Code Runssss
                            //con.Open();
                            //cmd.Connection = con;
                            //cmd.CommandType = CommandType.Text;
                            //cmd.CommandText = "insert into tbl_Promotion(ne_id,nc_id,nr_id,strStatus,dtAddDate,bisDeleted) values ((select ne_id from tbl_Enrollment where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "') and strStudentNum='" + student_num + "'),'" + actual_Class + "',(select max(nr_id) from tbl_Result),'Fail',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                            //cmd.ExecuteNonQuery();
                            //con.Close();
                            ///////////////////////////////////////////////////////
                            //con.Open();
                            //cmd.Connection = con;
                            //cmd.CommandType = CommandType.Text;
                            //cmd.CommandText = "update tbl_Enrollment set nc_id='" + actual_Class + "' where strStudentNum='" + Session["stnum"] + "'";
                            //cmd.ExecuteNonQuery();
                            //con.Close();
                        }

                    }
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
    }
}