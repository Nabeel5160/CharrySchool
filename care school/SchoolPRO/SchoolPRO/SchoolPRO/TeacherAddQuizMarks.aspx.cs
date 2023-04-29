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
    public partial class TeacherAddQuizMarks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btnAddMarks_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                TextBox tb = (TextBox)gvr.FindControl("txtroll");
                //Session["cname"] = gvr.Cells[0].Text;
                //Session["section"] = gvr.Cells[1].Text;
                //Session["courscode"] = gvr.Cells[2].Text;
                Session["cname"] = gvr.Cells[6].Text;
                Session["section"] = gvr.Cells[7].Text;
                Session["courscode"] = gvr.Cells[8].Text;

                mvmarks.ActiveViewIndex = 1;
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

        public void refresh()
        {
            try
            {
                //string query = "SELECT e.strStudentNum, e.strFname, e.strLname, ex.strTotalMarks,ex.strObtMarks,ex.strRemarks from tbl_Result ex inner join tbl_Enrollment e on ex.ne_id=e.ne_id WHERE (e.nc_id = (SELECT nc_id FROM tbl_Class WHERE (strClass = '" + Session["cname"] + "') and e.bisDeleted='False') and e.bisDeleted='False') and ex.nsbj_id=(select nsbj_id from tbl_Subject where strCourseCode='" + Session["coursecode"] + "' and bisDeleted='False') AND (strStudentNum IS NOT NULL) and e.nsch_id='" + Session["nschoolid"] + "' and ex.bisDeleted='False'";
                //cmd.Connection = con;
                //con.Open();
                //cmd.CommandType = System.Data.CommandType.Text;
                //cmd.CommandText = query;
                //cmd.ExecuteNonQuery();
                //con.Close();
                PopulateData(Session["cname1"].ToString().Trim(), Session["sec11"].ToString().Trim(), Session["courscode1"].ToString().Trim());
               // gvshowmarks.DataBind();
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
        /// <summary>
        /// //////////////////////////WORKING BUT NOT USINGGG/////////////
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        //protected void btnsubmitattend_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //    //string class_name = null;
        //    //int percentage = 0;
        //    bool flag = true;
        //    if (ddexams.Text == "Final Exam")
        //    {
        //        //con.Open();
        //        //cmd.Connection = con;
        //        //cmd.CommandType = CommandType.Text;
        //        //cmd.CommandText = "select strPercentage from tbl_Percentage";
        //        //dr = cmd.ExecuteReader();
        //        //if (dr.Read())
        //        //{
        //        //    percentage = Convert.ToInt32(dr["strPercentage"]);
        //        //}
        //        //con.Close();
        //        foreach (GridViewRow row in GridView2.Rows)
        //        {
        //            if (row.RowType == DataControlRowType.DataRow)
        //            {
        //                //double result = 0;
        //                string marks = ((TextBox)row.FindControl("txtmarks")).Text;
        //                string remarks = ((TextBox)row.FindControl("txtrem")).Text;

        //                if (marks != "")
        //                {
        //                    if (row.Enabled == true)
        //                    {
        //                        //result = (Convert.ToInt32(marks) / Convert.ToInt32(txttmrks.Text))*100;
        //                        //result = (Convert.ToDouble(marks) / Convert.ToDouble(txttmrks.Text))*100;
        //                        //string tmarks = ((TextBox)row.FindControl("txttmrks")).Text;
        //                        string student_num = row.Cells[5].Text;
        //                        //txtre.Text=gvr.Cells[4].Text;
        //                        con.Open();
        //                        cmd.Connection = con;
        //                        cmd.CommandType = CommandType.Text;
        //                        cmd.CommandText = "insert into tbl_Result(nsch_id,nc_id,nsc_id,nsbj_id,ne_id,nu_id,strTotalMarks,strObtMarks,strRemarks,strType,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "','" + Session["cname"] + "','" + Session["section"] + "','" + Session["courscode"] + "','" + student_num + "',(select nu_id from tbl_Users where strEmail='" + Session["userval"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),@obt,@st,@rem,'" + ddexams.Text + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
        //                        cmd.Parameters.AddWithValue("@st", marks);
        //                        cmd.Parameters.AddWithValue("@obt", txttmrks.Text);
        //                        cmd.Parameters.AddWithValue("@rem", remarks);
        //                        cmd.ExecuteNonQuery();

        //                        cmd.Parameters.Clear();
        //                        con.Close();
        //                    }
        //                }
        //                else
        //                {
        //                    row.BackColor = System.Drawing.Color.LightPink;
        //                    flag = false;
        //                }

        //                // ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "alert('Result Not Added');", true);
        //                //con.Open();
        //                //cmd.Connection = con;
        //                //cmd.CommandType = CommandType.Text;
        //                //cmd.CommandText = "select nc_id from tbl_Enrollment where strStudentNum='" + student_num + "'";
        //                //dr = cmd.ExecuteReader();
        //                //if (dr.Read())
        //                //{
        //                //    class_name = dr["nc_id"].ToString();
        //                //}
        //                //int actual_Class = 1 + Convert.ToInt32(class_name);
        //                //con.Close();
        //                //if (result > percentage)
        //                //{

        //                //    con.Open();
        //                //    cmd.Connection = con;
        //                //    cmd.CommandType = CommandType.Text;
        //                //    cmd.CommandText = "insert into tbl_Promotion(ne_id,nc_id,nr_id,strStatus,dtAddDate,bisDeleted) values ((select ne_id from tbl_Enrollment where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "') and strStudentNum='" + student_num + "'),'" + actual_Class + "',(select max(nr_id) from tbl_Result),'Pass',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
        //                //    cmd.ExecuteNonQuery();
        //                //    con.Close();
        //                //    con.Open();
        //                //    cmd.Connection = con;
        //                //    cmd.CommandType = CommandType.Text;
        //                //    cmd.CommandText = "update tbl_Enrollment set nc_id='" + actual_Class + "' where strStudentNum='" + student_num + "'";
        //                //    cmd.ExecuteNonQuery();
        //                //    con.Close();
        //                //}
        //                //else
        //                //{
        //                //    con.Open();
        //                //    cmd.Connection = con;
        //                //    cmd.CommandType = CommandType.Text;
        //                //    cmd.CommandText = "insert into tbl_Promotion(ne_id,nc_id,nr_id,strStatus,dtAddDate,bisDeleted) values ((select ne_id from tbl_Enrollment where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "') and strStudentNum='" + student_num + "'),'" + actual_Class + "',(select max(nr_id) from tbl_Result),'Fail',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
        //                //    cmd.ExecuteNonQuery();
        //                //    con.Close();
        //                //    //con.Open();
        //                //    //cmd.Connection = con;
        //                //    //cmd.CommandType = CommandType.Text;
        //                //    //cmd.CommandText = "update tbl_Enrollment set nc_id='" + actual_Class + "' where strStudentNum='" + Session["stnum"] + "'";
        //                //    //cmd.ExecuteNonQuery();
        //                //    //con.Close();
        //                //}
        //            }
        //        }

        //    }
        //    else if (ddexams.Text == "Quiz")
        //    {

        //        con.Open();
        //        foreach (GridViewRow row in GridView2.Rows)
        //        {
        //            if (row.RowType == DataControlRowType.DataRow)
        //            {

        //                string marks = ((TextBox)row.FindControl("txtmarks")).Text;
        //                string remarks = ((TextBox)row.FindControl("txtrem")).Text;
        //                if (marks != "")
        //                {
        //                    if (row.Enabled == true)
        //                    {
        //                        //string tmarks = ((TextBox)row.FindControl("txttmrks")).Text;
        //                        Session["stnum"] = row.Cells[5].Text;
        //                        //txtre.Text=gvr.Cells[4].Text;

        //                        cmd.Connection = con;
        //                        cmd.CommandType = CommandType.Text;
        //                        //cmd.CommandText = "insert into tbl_Result(nsbj_id,ne_id,nu_id,strTotalMarks,strObtMarks,strRemarks,strType,dtAddDate,bisDeleted) values((select nsbj_id from tbl_Subject where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False') and strCourseCode='" + Session["courscode"] + "' and bisDeleted='False'),(select ne_id from tbl_Enrollment where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False') and strStudentNum='" + Session["stnum"] + "' and bisDeleted='False'),(select nu_id from tbl_Users where strEmail='" + Session["userval"] + "' and bisDeleted='False'),@obt,@st,@rem,'" + ddexams.Text + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
        //                        //cmd.CommandText = "insert into tbl_Result(nsch_id,nc_id,nsc_id,nsbj_id,ne_id,nu_id,strTotalMarks,strObtMarks,strRemarks,strType,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "',(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),(select nsc_id from tbl_Section where strSection='" + Session["section"] + "' and  nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),(select nsbj_id from tbl_Subject where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') and strCourseCode='" + Session["courscode"] + "' and bisDeleted='False'),(select ne_id from tbl_Enrollment where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') and strStudentNum='" + Session["stnum"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),(select nu_id from tbl_Users where strEmail='" + Session["userval"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),@obt,@st,@rem,'" + ddexams.Text + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
        //                        cmd.CommandText = "insert into tbl_Result(nsch_id,nc_id,nsc_id,nsbj_id,ne_id,nu_id,strTotalMarks,strObtMarks,strRemarks,strType,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "','" + Session["cname"] + "','" + Session["section"] + "','" + Session["courscode"] + "','" + Session["stnum"] + "',(select nu_id from tbl_Users where strEmail='" + Session["userval"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),@obt,@st,@rem,'" + ddexams.Text + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
        //                        cmd.Parameters.AddWithValue("@st", marks);
        //                        cmd.Parameters.AddWithValue("@obt", txttmrks.Text);
        //                        cmd.Parameters.AddWithValue("@rem", remarks);
        //                        cmd.ExecuteNonQuery();
        //                        cmd.Parameters.Clear();
        //                    }
        //                }
        //                else
        //                {
        //                    row.BackColor = System.Drawing.Color.LightPink;
        //                    flag = false;
        //                }
        //            }
        //        }
        //        con.Close();

        //    }
        //    else if (ddexams.Text == "1st Term Exam")
        //    {
        //        con.Open();
        //        foreach (GridViewRow row in GridView2.Rows)
        //        {
        //            if (row.RowType == DataControlRowType.DataRow)
        //            {

        //                string marks = ((TextBox)row.FindControl("txtmarks")).Text;
        //                string remarks = ((TextBox)row.FindControl("txtrem")).Text;
        //                if (marks != "")
        //                {
        //                    if (row.Enabled == true)
        //                    {
        //                        //string tmarks = ((TextBox)row.FindControl("txttmrks")).Text;
        //                        Session["stnum"] = row.Cells[5].Text;
        //                        //txtre.Text=gvr.Cells[4].Text;

        //                        cmd.Connection = con;
        //                        cmd.CommandType = CommandType.Text;
        //                       // cmd.CommandText = "insert into tbl_Result(nsbj_id,ne_id,nu_id,strTotalMarks,strObtMarks,strRemarks,strType,dtAddDate,bisDeleted) values((select nsbj_id from tbl_Subject where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False') and strCourseCode='" + Session["courscode"] + "' and bisDeleted='False'),(select ne_id from tbl_Enrollment where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False') and strStudentNum='" + Session["stnum"] + "' and bisDeleted='False'),(select nu_id from tbl_Users where strEmail='" + Session["userval"] + "' and bisDeleted='False'),@obt,@st,@rem,'" + ddexams.Text + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
        //                        //cmd.CommandText = "insert into tbl_Result(nsch_id,nc_id,nsc_id,nsbj_id,ne_id,nu_id,strTotalMarks,strObtMarks,strRemarks,strType,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "',(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),(select nsc_id from tbl_Section where strSection='" + Session["section"] + "' and  nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') and bisDeleted='False'),(select nsbj_id from tbl_Subject where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') and strCourseCode='" + Session["courscode"] + "' and bisDeleted='False'),(select ne_id from tbl_Enrollment where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') and nsch_id='" + Session["nschoolid"] + "' and strStudentNum='" + Session["stnum"] + "' and bisDeleted='False'),(select nu_id from tbl_Users where strEmail='" + Session["userval"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),@obt,@st,@rem,'" + ddexams.Text + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
        //                        cmd.CommandText = "insert into tbl_Result(nsch_id,nc_id,nsc_id,nsbj_id,ne_id,nu_id,strTotalMarks,strObtMarks,strRemarks,strType,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "','" + Session["cname"] + "','" + Session["section"] + "','" + Session["courscode"] + "','" + Session["stnum"] + "',(select nu_id from tbl_Users where strEmail='" + Session["userval"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),@obt,@st,@rem,'" + ddexams.Text + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
        //                        cmd.Parameters.AddWithValue("@st", marks);
        //                        cmd.Parameters.AddWithValue("@obt", txttmrks.Text);
        //                        cmd.Parameters.AddWithValue("@rem", remarks);
        //                        cmd.ExecuteNonQuery();
        //                        cmd.Parameters.Clear();
        //                    }
        //                }

        //                else
        //                {
        //                    row.BackColor = System.Drawing.Color.LightPink;
        //                    flag = false;
        //                }
        //            }
        //        }
        //        con.Close();
        //    }
        //    else if (ddexams.Text == "2nd Term Exam")
        //    {
        //        con.Open();
        //        foreach (GridViewRow row in GridView2.Rows)
        //        {
        //            if (row.RowType == DataControlRowType.DataRow)
        //            {

        //                string marks = ((TextBox)row.FindControl("txtmarks")).Text;
        //                string remarks = ((TextBox)row.FindControl("txtrem")).Text;
        //                //string tmarks = ((TextBox)row.FindControl("txttmrks")).Text;
        //                if (marks != "")
        //                {
        //                    if (row.Enabled == true)
        //                    {
        //                        Session["stnum"] = row.Cells[5].Text;
        //                        //txtre.Text=gvr.Cells[4].Text;

        //                        cmd.Connection = con;
        //                        cmd.CommandType = CommandType.Text;
        //                        //cmd.CommandText = "insert into tbl_Result(nsbj_id,ne_id,nu_id,strTotalMarks,strObtMarks,strRemarks,strType,dtAddDate,bisDeleted) values((select nsbj_id from tbl_Subject where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False') and strCourseCode='" + Session["courscode"] + "' and bisDeleted='False'),(select ne_id from tbl_Enrollment where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False') and strStudentNum='" + Session["stnum"] + "' and bisDeleted='False'),(select nu_id from tbl_Users where strEmail='" + Session["userval"] + "' and bisDeleted='False'),@obt,@st,@rem,'" + ddexams.Text + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
        //                       // cmd.CommandText = "insert into tbl_Result(nsch_id,nc_id,nsc_id,nsbj_id,ne_id,nu_id,strTotalMarks,strObtMarks,strRemarks,strType,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "',(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),(select nsc_id from tbl_Section where strSection='" + Session["section"] + "' and  nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),(select nsbj_id from tbl_Subject where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') and strCourseCode='" + Session["courscode"] + "' and bisDeleted='False'),(select ne_id from tbl_Enrollment where nc_id=(select nc_id from tbl_Class where strClass='" + Session["cname"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') and nsch_id='" + Session["nschoolid"] + "' and strStudentNum='" + Session["stnum"] + "' and bisDeleted='False'),(select nu_id from tbl_Users where strEmail='" + Session["userval"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),@obt,@st,@rem,'" + ddexams.Text + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
        //                        cmd.CommandText = "insert into tbl_Result(nsch_id,nc_id,nsc_id,nsbj_id,ne_id,nu_id,strTotalMarks,strObtMarks,strRemarks,strType,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "','" + Session["cname"] + "','" + Session["section"] + "','" + Session["courscode"] + "','" + Session["stnum"] + "',(select nu_id from tbl_Users where strEmail='" + Session["userval"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),@obt,@st,@rem,'" + ddexams.Text + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
        //                        cmd.Parameters.AddWithValue("@st", marks);
        //                        cmd.Parameters.AddWithValue("@obt", txttmrks.Text);
        //                        cmd.Parameters.AddWithValue("@rem", remarks);
        //                        cmd.ExecuteNonQuery();
        //                        cmd.Parameters.Clear();
        //                    }
        //                }
        //                else
        //                {
        //                    row.BackColor = System.Drawing.Color.LightPink;
        //                    flag = false;
        //                }
        //            }
        //        }
        //        con.Close();
        //    }
        //    else
        //        flag = false;
        //    if (flag == true)
        //    {
        //        ddexams.SelectedIndex = 0;
        //        foreach(GridViewRow row in GridView2.Rows)
        //        {
        //               ((TextBox)row.FindControl("txtmarks")).Text = "";
        //                ((TextBox)row.FindControl("txtrem")).Text = "";
        //                txttmrks.Text = "";
        //        }
        //        refresh();
        //        mvmarks.ActiveViewIndex = 2;
        //    }
        //        //PopulateData();
        //    }
        //    catch (Exception ex)
        //    {
        //        Response.Redirect("Error.aspx");
        //    }
        //    finally
        //    {
        //        if (con.State == ConnectionState.Open)
        //        {
        //            con.Close();
        //        }
        //    }
        //}
        ////////////////////////////////////////////////////////////////////


        protected void btnsubmitattend_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean CanADDFLAG = false;
                //string class_name = null;
                //int percentage = 0;
                bool flag = true;
                if (ddexams.SelectedIndex != 0 && txttmrks.Text != "")
                {
                    foreach (GridViewRow row in GridView2.Rows)
                    {
                        if (row.RowType == DataControlRowType.DataRow)
                        {
                            //double result = 0;

                            TextBox txtmk=(TextBox)row.FindControl("txtmarks");
                            TextBox txtrm=(TextBox)row.FindControl("txtrem");

                            string marks = (txtmk).Text;
                            string remarks = (txtrm).Text;

                            if (txtmk.Text != "")
                            {
                                for (int i = 0; i < txtmk.Text.Length; i++)
                                {
                                    if ((txtmk.Text[i] >= 'A' && txtmk.Text[i] <= 'Z') || (txtmk.Text[i] >= 'a' && txtmk.Text[i] <= 'z') || txtmk.Text[i] == '!' || txtmk.Text[i] == '@' || txtmk.Text[i] == '#' || txtmk.Text[i] == '$' || txtmk.Text[i] == '`' || txtmk.Text[i] == '~' || txtmk.Text[i] == '%' || txtmk.Text[i] == '^' || txtmk.Text[i] == '&' || txtmk.Text[i] == '*' || txtmk.Text[i] == '(' || txtmk.Text[i] == ')' || txtmk.Text[i] == '-' || txtmk.Text[i] == '+' || txtmk.Text[i] == '_' || txtmk.Text[i] == '=' || txtmk.Text[i] == ',' || txtmk.Text[i] == '.' || txtmk.Text[i] == '/' || txtmk.Text[i] == '?' || txtmk.Text[i] == ';' || txtmk.Text[i] == ':' || txtmk.Text[i] == '\'' || txtmk.Text[i] == '\"' || txtmk.Text[i] == '|' || txtmk.Text[i] == '\\' || txtmk.Text[i] == '/' || txtmk.Text[i] == '[' || txtmk.Text[i] == ']' || txtmk.Text[i] == '{' || txtmk.Text[i] == '}')
                                    {
                                        //txtmk.Text[i] >= 'A' || txtmk.Text[i] <= 'Z' || txtmk.Text[i] >= 'a' || txtmk.Text[i] <= 'z' ||
                                        // checkflag = false;
                                        //MessageBox.Show("Invalid Entry");
                                        txtmk.Focus();
                                        txtmk.Text = "";
                                        break;
                                    }
                                }
                            }

                            if (marks != "" && txttmrks.Text != "")
                            {
                                if (Convert.ToInt32(marks) <= Convert.ToInt32(txttmrks.Text))
                                {
                                    if (row.Enabled == true)
                                    {
                                        CanADDFLAG = true;
                                        txtmk.Style["border"] = "2px solid rgb(213, 213, 213)";
                                    }

                                    //border: 2px solid rgb(213, 213, 213)
                                    //txtmk.Attributes.Add("border", "2px solid rgb(213, 213, 213)");
                                    //txtrm.Attributes.Add("border", "2px solid rgb(213, 213, 213)");
                                   

                                }
                                else
                                {
                                    //row.BackColor = System.Drawing.Color.LightPink;
                                    //txtmk.Attributes.Add("border", "3px solid red");
                                    //txtrm.Attributes.Add("border", "3px solid red");
                                    txtmk.Style["border"] = "2px solid red";


                                    flag = false;
                                    CanADDFLAG = false;
                                }
                            }
                            else
                            {
                                //row.BackColor = System.Drawing.Color.LightPink;
                                //txtmk.Attributes.Add("border", "3px solid red");
                                //txtrm.Attributes.Add("border", "3px solid red");

                                txtmk.Style["border"] = "2px solid red";

                                flag = false;
                                CanADDFLAG = false;
                            }


                        }
                    }
                    if (CanADDFLAG)
                    {
                        foreach (GridViewRow row in GridView2.Rows)
                        {
                            if (row.RowType == DataControlRowType.DataRow)
                            {

                                TextBox txtmk = (TextBox)row.FindControl("txtmarks");
                                TextBox txtrm = (TextBox)row.FindControl("txtrem");

                                string marks = (txtmk).Text;
                                string remarks = (txtrm).Text;

                                if (txtmk.Text != "")
                                {
                                    for (int i = 0; i < txtmk.Text.Length; i++)
                                    {
                                        if ((txtmk.Text[i] >= 'A' && txtmk.Text[i] <= 'Z') || (txtmk.Text[i] >= 'a' && txtmk.Text[i] <= 'z') || txtmk.Text[i] == '!' || txtmk.Text[i] == '@' || txtmk.Text[i] == '#' || txtmk.Text[i] == '$' || txtmk.Text[i] == '`' || txtmk.Text[i] == '~' || txtmk.Text[i] == '%' || txtmk.Text[i] == '^' || txtmk.Text[i] == '&' || txtmk.Text[i] == '*' || txtmk.Text[i] == '(' || txtmk.Text[i] == ')' || txtmk.Text[i] == '-' || txtmk.Text[i] == '+' || txtmk.Text[i] == '_' || txtmk.Text[i] == '=' || txtmk.Text[i] == ',' || txtmk.Text[i] == '.' || txtmk.Text[i] == '/' || txtmk.Text[i] == '?' || txtmk.Text[i] == ';' || txtmk.Text[i] == ':' || txtmk.Text[i] == '\'' || txtmk.Text[i] == '\"' || txtmk.Text[i] == '|' || txtmk.Text[i] == '\\' || txtmk.Text[i] == '/' || txtmk.Text[i] == '[' || txtmk.Text[i] == ']' || txtmk.Text[i] == '{' || txtmk.Text[i] == '}')
                                        {
                                            //txtmk.Text[i] >= 'A' || txtmk.Text[i] <= 'Z' || txtmk.Text[i] >= 'a' || txtmk.Text[i] <= 'z' ||
                                            // checkflag = false;
                                            //MessageBox.Show("Invalid Entry");
                                            txtmk.Focus();
                                            txtmk.Text = "";
                                            break;
                                        }
                                    }
                                }

                                if (marks != "" && txttmrks.Text != "")
                                {
                                    if (Convert.ToInt32(marks) <= Convert.ToInt32(txttmrks.Text))
                                    {
                                        if (row.Enabled == true)
                                        {
                                            //result = (Convert.ToInt32(marks) / Convert.ToInt32(txttmrks.Text))*100;
                                            //result = (Convert.ToDouble(marks) / Convert.ToDouble(txttmrks.Text))*100;
                                            //string tmarks = ((TextBox)row.FindControl("txttmrks")).Text;
                                            string student_num = row.Cells[5].Text;
                                            //txtre.Text=gvr.Cells[4].Text;
                                            con.Open();
                                            cmd.Connection = con;
                                            cmd.CommandType = CommandType.Text;
                                            cmd.CommandText = "insert into tbl_Result(nsch_id,nc_id,nsc_id,nsbj_id,ne_id,nu_id,strTotalMarks,strObtMarks,strRemarks,strType,nQuiz_id,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "','" + Session["cname"] + "','" + Session["section"] + "','" + Session["courscode"] + "','" + student_num + "',(select nu_id from tbl_Users where strEmail='" + Session["userval"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),@obt,@st,@rem,@examname,@examtypeid,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                                            cmd.Parameters.AddWithValue("@st", marks);
                                            cmd.Parameters.AddWithValue("@obt", txttmrks.Text);
                                            cmd.Parameters.AddWithValue("@rem", remarks);
                                            cmd.Parameters.AddWithValue("@examtypeid", ddexams.SelectedValue);
                                            cmd.Parameters.AddWithValue("@examname", ddexams.SelectedItem.ToString());
                                            cmd.ExecuteNonQuery();

                                            cmd.Parameters.Clear();
                                            con.Close();
                                           // flag = true;
                                            txtmk.Style["border"] = "2px solid rgb(213, 213, 213)";
                                        }
                                    }
                                    else
                                    {
                                        row.BackColor = System.Drawing.Color.LightPink;
                                        txtmk.Style["border"] = "2px solid red";

                                        flag = false;
                                    }
                                }
                                else
                                {
                                    row.BackColor = System.Drawing.Color.LightPink;
                                    txtmk.Style["border"] = "2px solid red";

                                    flag = false;
                                }


                            }
                        }
                    }
                    else
                    { 
                        
                    }



                }
                else
                    flag = false;

                if (flag == true)
                {
                    ddexams.SelectedIndex = 0;
                    foreach (GridViewRow row in GridView2.Rows)
                    {
                        ((TextBox)row.FindControl("txtmarks")).Text = "";
                        ((TextBox)row.FindControl("txtrem")).Text = "";
                        txttmrks.Text = "";
                        ((TextBox)row.FindControl("txtmarks")).Style["border"] = "2px solid rgb(213, 213, 213)";
                    }
                    refresh();
                    mvmarks.ActiveViewIndex = 2;

                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('QUIZ MARKS Successfully Added .');", true);
                }
                else
                { 
                    
                }
                //PopulateData();
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


        private void PopulateData(string  cls,string sec,string sub)
        {

            DataTable table = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {

                string sql = "SELECT ex.nr_id, e.strStudentNum, e.strFname, e.strLname,ex.strTotalMarks, ex.strObtMarks, ex.strRemarks FROM tbl_Enrollment AS e INNER JOIN tbl_Result AS ex ON e.ne_id = ex.ne_id WHERE (ex.nc_id = @cname) AND (ex.nsbj_id = @cc) and (ex.nsc_id=@sce111) and ex.nu_id=@uem AND (ex.bisDeleted = 'False') and ex.nsch_id=@schid2  and ex.nExam_id is Null";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@uem",Session["uid"].ToString().Trim());
                    cmd.Parameters.AddWithValue("@sce111",sec.Trim());
                    cmd.Parameters.AddWithValue("@cname",cls.Trim());
                    cmd.Parameters.AddWithValue("@cc",sub.Trim());
                    cmd.Parameters.AddWithValue("@schid1", Session["nschoolid"].ToString().Trim());
                    cmd.Parameters.AddWithValue("@schid2", Session["nschoolid"].ToString().Trim());
                                                                            

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvshowmarks.DataSource = table;

            gvshowmarks.DataBind();

        }

        protected void gottoback_Click(object sender, EventArgs e)
        {
            try
            {
                mvmarks.ActiveViewIndex = 0;
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

        protected void btnviewMarks_Click(object sender, EventArgs e)
        {
            try{

            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            TextBox tb = (TextBox)gvr.FindControl("txtroll");
            //Session["cname1"] = gvr.Cells[0].Text;
            //Session["coursecode1"] = gvr.Cells[2].Text;
            Session["cname1"] = gvr.Cells[6].Text;
            Session["sec11"] = gvr.Cells[7].Text;
            Session["courscode1"] = gvr.Cells[8].Text;

            PopulateData(gvr.Cells[6].Text, gvr.Cells[7].Text, gvr.Cells[8].Text);

            mvmarks.ActiveViewIndex = 2;

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

        protected void btned_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["neditid"] = gvr.Cells[1].Text;
            //marks = gvr.Cells[4].Text;
            txttol.Text = gvr.Cells[5].Text;
            txteditmarks.Text = gvr.Cells[6].Text;
            txtremarks.Text = gvr.Cells[7].Text;
            mvmarks.ActiveViewIndex = 3;
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

        protected void btndel_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["ndelid"] = gvr.Cells[1].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Result set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nr_id='" + Session["ndelid"] + "'";
            cmd.ExecuteNonQuery();
            con.Close();

            PopulateData(Session["cname1"].ToString().Trim(), Session["sec11"].ToString().Trim(), Session["courscode1"].ToString().Trim());
            mvmarks.ActiveViewIndex = 2;
            refresh();
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
     
        protected void btnupdate_Click(object sender, EventArgs e)
        {
            try
            {
            //txteditmarks.Text = marks;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Result set strObtMarks=@emarks,strRemarks=@remarks, dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nr_id='" + Session["neditid"] + "'";
            cmd.Parameters.AddWithValue("@tmarks", txttol.Text);
            cmd.Parameters.AddWithValue("@emarks", txteditmarks.Text);
            cmd.Parameters.AddWithValue("@remarks", txtremarks.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            mvmarks.ActiveViewIndex = 2;
            refresh();
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

        public void ddexams_SelectedIndexChanged(object sender, EventArgs e)
        {
            try

            {
            
            int count = 0;
            foreach (GridViewRow row in GridView2.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    if (ddexams.SelectedIndex != 0)
                    {
                        string id = row.Cells[5].Text.ToString();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                       
                            cmd.CommandText = "Select nr_id,strObtMarks,strRemarks,strTotalMarks from tbl_Result Where nQuiz_id='" + ddexams.SelectedValue + "' and ne_id='" + id + "' AND SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) AND SUBSTRING(dtAddDate ,4,2)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2) and nsbj_id='" + Session["courscode"] + "' and bisDeleted=0  and nsch_id='" + Session["nschoolid"] + "'";
                        
                        //else
                        //    cmd.CommandText = "Select nr_id,strObtMarks,strRemarks,strTotalMarks from tbl_Result Where nExam_id='" + ddexams.SelectedValue + "' and ne_id='" + id + "' AND DATEPART(yyyy,dtAddDate)=DATEPART(yyyy,CONVERT(VARCHAR(10), GETDATE(), 105 )) and nsbj_id='" + Session["courscode"] + "'  and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "' ";

                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            dr.Read();
                            row.BackColor = System.Drawing.Color.LightPink;
                            //row.BorderColor = System.Drawing.Color.Red;
                            row.Enabled = false;
                            ((TextBox)row.FindControl("txtmarks")).Text = dr["strObtMarks"].ToString();
                            ((TextBox)row.FindControl("txtrem")).Text = dr["strRemarks"].ToString();
                            txttmrks.Text = dr["strTotalMarks"].ToString();
                            count++;
                        }
                        else
                        {
                            row.BackColor = System.Drawing.Color.Empty;
                            //row.BorderColor = System.Drawing.Color.Empty;
                            row.Enabled = true;
                            ((TextBox)row.FindControl("txtmarks")).Text = "";
                            ((TextBox)row.FindControl("txtrem")).Text = "";

                            btnsubmitattend.Enabled = true;
                        }
                        con.Close();


                    }
                    else
                    {
                        ((TextBox)row.FindControl("txtmarks")).Text = "";
                        ((TextBox)row.FindControl("txtrem")).Text = "";
                        txttmrks.Text = "";
                    }

                }
            }
            if (count == GridView2.Rows.Count)
            {
                btnsubmitattend.Enabled = false;
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
            // GridView2.Columns[5].Visible = false;
        }

        protected void txteditmarks_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (txteditmarks.Text != "")
                {
                    for (int i = 0; i < txteditmarks.Text.Length; i++)
                    {
                        if ((txteditmarks.Text[i] >= 'A' && txteditmarks.Text[i] <= 'Z') || (txteditmarks.Text[i] >= 'a' && txteditmarks.Text[i] <= 'z') || txteditmarks.Text[i] == '!' || txteditmarks.Text[i] == '@' || txteditmarks.Text[i] == '#' || txteditmarks.Text[i] == '$' || txteditmarks.Text[i] == '`' || txteditmarks.Text[i] == '~' || txteditmarks.Text[i] == '%' || txteditmarks.Text[i] == '^' || txteditmarks.Text[i] == '&' || txteditmarks.Text[i] == '*' || txteditmarks.Text[i] == '(' || txteditmarks.Text[i] == ')' || txteditmarks.Text[i] == '-' || txteditmarks.Text[i] == '+' || txteditmarks.Text[i] == '_' || txteditmarks.Text[i] == '=' || txteditmarks.Text[i] == ',' || txteditmarks.Text[i] == '.' || txteditmarks.Text[i] == '/' || txteditmarks.Text[i] == '?' || txteditmarks.Text[i] == ';' || txteditmarks.Text[i] == ':' || txteditmarks.Text[i] == '\'' || txteditmarks.Text[i] == '\"' || txteditmarks.Text[i] == '|' || txteditmarks.Text[i] == '\\' || txteditmarks.Text[i] == '/' || txteditmarks.Text[i] == '[' || txteditmarks.Text[i] == ']' || txteditmarks.Text[i] == '{' || txteditmarks.Text[i] == '}')
                        {
                            //txteditmarks.Text[i] >= 'A' || txteditmarks.Text[i] <= 'Z' || txteditmarks.Text[i] >= 'a' || txteditmarks.Text[i] <= 'z' ||
                            // checkflag = false;
                            //MessageBox.Show("Invalid Entry");
                            txteditmarks.Focus();
                            txteditmarks.Text = "";
                            break;
                        }
                    }

                    if (txteditmarks.Text != "")
                    {
                        if (Convert.ToInt32(txteditmarks.Text) > Convert.ToInt32(txttol.Text))
                        {
                            txteditmarks.Text = "";
                            txteditmarks.Focus();
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('OBT MARKS SHOULD BE LESS THEN OR EQUA TO TOTAL MARKS..');", true);

                        }
                    }
                }
            }
            catch (Exception)
            {
                // Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                    cmd.Parameters.Clear();
                }

            }
        }
    }
}