using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;

using System.Security.Cryptography;
using System.IO;
using System.Text;
namespace SchoolPRO
{
    public partial class AdminFullResultReport : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();

        SqlDataReader dr;
        private string Decrypt(string cipherText)
        {
            
            string EncryptionKey = "MAKV2SPBNI99212";
            cipherText = cipherText.Replace(" ", "+");
            try
            {
                byte[] cipherBytes = Convert.FromBase64String(cipherText);
                using (Aes encryptor = Aes.Create())
                {
                    Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                        {
                            cs.Write(cipherBytes, 0, cipherBytes.Length);
                            cs.Close();
                        }
                        cipherText = Encoding.Unicode.GetString(ms.ToArray());
                    }
                }
            }
            catch (Exception ex)
            {
               // Response.Redirect("Error.aspx");
            }
            
                return cipherText;
            
        }
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
            string neid = Decrypt(HttpUtility.UrlDecode(Request.QueryString["eid"]));
            string ncid = Decrypt(HttpUtility.UrlDecode(Request.QueryString["cid"]));
            string nscid = Decrypt(HttpUtility.UrlDecode(Request.QueryString["scid"]));

            ShowStudentResult(neid, ncid, nscid);
            ///////////////////////////////////////////////////////////////////////////
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

        }
        protected void btnback_Click(object sender, EventArgs e)
        {
            //mvstlist.ActiveViewIndex = 0;

            Response.Redirect("AdminExaminationResult.aspx");
        }
        public void ShowStudentResult(string neid, string clas, string sec)
        {
            //mvstlist.ActiveViewIndex = 1;


            try
            {
                //txtstnum.Text = ddst.SelectedValue;
                //string stnumid = ddst.SelectedValue;
                //int dashe = stnumid.IndexOf('_');
                //string neid = stnumid.Substring(dashe + 1, stnumid.Length - (dashe + 1));
                //string stnumber = stnumid.Substring(0, dashe);

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                List<StudentResult> data1 = new List<StudentResult>();
                List<StudentResult> data2 = new List<StudentResult>();
                List<StudentResult> data3 = new List<StudentResult>();
                cmd.CommandText = "SELECT tbl_Result.strTotalMarks,tbl_Result.strObtMarks,tbl_Enrollment.strImage, tbl_Enrollment.strStudentNum,tbl_Enrollment.strFname+' '+tbl_Enrollment.strLname as Name ,tbl_Subject.strSubject,tbl_Subject.strCourseCode, tbl_ExamType.strExamName as strType, tbl_Class.strClass, tbl_Section.strSection,CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 AS SubjectPer, CAST(CASE WHEN CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 >= CAST(tbl_Percentage.strPercentage AS float) THEN 1 ELSE 0 END AS bit) AS Status, tbl_Percentage.strPercentage FROM  tbl_Result INNER JOIN tbl_Enrollment ON tbl_Result.ne_id = tbl_Enrollment.ne_id INNER JOIN   tbl_Subject ON tbl_Result.nsbj_id = tbl_Subject.nsbj_id INNER JOIN  tbl_Class ON tbl_Enrollment.nc_id = tbl_Class.nc_id  INNER JOIN  tbl_ExamType on tbl_Result.nExam_id=tbl_ExamType.nExam_id  INNER JOIN  tbl_Section ON tbl_Enrollment.nsc_id = tbl_Section.nsc_id CROSS JOIN  tbl_Percentage WHERE  (tbl_Result.bisDeleted = 0) AND (SUBSTRING(tbl_Result.dtAddDate ,7,10) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10)) AND (tbl_Result.nc_id=@cid)AND (tbl_Result.nsc_id=@scid) AND (tbl_Enrollment.nc_id = @cid) AND (tbl_Enrollment.nsc_id = @scid) AND (tbl_Enrollment.ne_id = @neid) AND (tbl_Result.nsch_id = @schid) and tbl_Percentage.nsch_id=@schid";
                cmd.Parameters.AddWithValue("@neid", neid);
                cmd.Parameters.AddWithValue("@cid", clas);
                cmd.Parameters.AddWithValue("@scid", sec);
                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);
                dr = cmd.ExecuteReader();
                int fi = 1;
                int si = 1;
                int fulli = 1;
                if (dr.HasRows)
                {
                    Boolean oncerunflag = true;
                    while (dr.Read())
                    {
                        StudentResult st = new StudentResult();
                        // lblsno.Text = i.ToString();
                        if (oncerunflag)
                        {
                            imgstdnt.ImageUrl = dr["strImage"].ToString();
                            txtstName.Text = dr["Name"].ToString();
                            txtstRoll.Text = dr["strStudentNum"].ToString();
                            date.Text = DateTime.Today.Date.ToString();
                            txtstClass.Text = dr["strClass"].ToString();
                            txtstSec.Text = dr["strSection"].ToString();
                            oncerunflag = false;
                        }
                        if (dr["strType"].ToString() == "1st Term Exam")
                        {
                            st.nc_id = fi.ToString();
                            st.Name = dr["strCourseCode"].ToString();
                            st.Class = dr["strSubject"].ToString();
                            st.Section = dr["strTotalMarks"].ToString();
                            st.Roll_Number = dr["strObtMarks"].ToString();
                            st.S_No = dr["SubjectPer"].ToString();
                            st.Status = dr["Status"].ToString();
                            if (st.Status == "True")
                                st.Status = "Pass";
                            else if (st.Status == "False")
                                st.Status = "Fail";
                            data1.Add(st);

                            fi++;
                        }
                        if (dr["strType"].ToString() == "2nd Term Exam")
                        {
                            st.nc_id = si.ToString();
                            st.Name = dr["strCourseCode"].ToString();
                            st.Class = dr["strSubject"].ToString();
                            st.Section = dr["strTotalMarks"].ToString();
                            st.Roll_Number = dr["strObtMarks"].ToString();
                            st.S_No = dr["SubjectPer"].ToString();
                            st.Status = dr["Status"].ToString();
                            if (st.Status == "True")
                                st.Status = "Pass";
                            else if (st.Status == "False")
                                st.Status = "Fail";
                            data2.Add(st);

                            si++;
                        }
                        if (dr["strType"].ToString() == "Final Exam")
                        {
                            st.nc_id = fulli.ToString();
                            st.Name = dr["strCourseCode"].ToString();
                            st.Class = dr["strSubject"].ToString();
                            st.Section = dr["strTotalMarks"].ToString();
                            st.Roll_Number = dr["strObtMarks"].ToString();
                            st.S_No = dr["SubjectPer"].ToString();
                            st.Status = dr["Status"].ToString();
                            if (st.Status == "True")
                                st.Status = "Pass";
                            else if (st.Status == "False")
                                st.Status = "Fail";
                            data3.Add(st);

                            fulli++;
                        }
                    }
                    gvresult1.DataSource = data1;
                    gvresult1.DataBind();
                    gvresult2.DataSource = data2;
                    gvresult2.DataBind();
                    gvresult3.DataSource = data3;
                    gvresult3.DataBind();


                    string totmrks, totobtmarks, statuss = "";
                    Int64 TOT = 0, TOTOBT = 0;
                    Boolean allpassflag = true;
                    foreach (GridViewRow row in gvresult1.Rows)
                    {
                        totmrks = row.Cells[3].Text;
                        totobtmarks = row.Cells[4].Text;
                        TOT += Convert.ToInt64(totmrks);
                        TOTOBT += Convert.ToInt64(totobtmarks);
                        if (row.Cells[6].Text == "Pass" && allpassflag)
                        {
                            statuss = "Pass";
                        }
                        else
                        {
                            statuss = "Fail";
                            allpassflag = false;
                        }


                    }
                    txttotobtmarks1.Text = TOTOBT.ToString();
                    txttotAllsubmarks1.Text = TOT.ToString();
                    txtPercentage1.Text = statuss;
                    /////////////////////////////////////////
                    totmrks = ""; totobtmarks = "";
                    TOT = 0;
                    TOTOBT = 0;
                    allpassflag = true;
                    foreach (GridViewRow row in gvresult2.Rows)
                    {
                        totmrks = row.Cells[3].Text;
                        totobtmarks = row.Cells[4].Text;
                        TOT += Convert.ToInt64(totmrks);
                        TOTOBT += Convert.ToInt64(totobtmarks);
                        if (row.Cells[6].Text == "Pass" && allpassflag)
                        {
                            statuss = "Pass";
                        }
                        else
                        {
                            statuss = "Fail";
                            allpassflag = false;
                        }

                    }
                    txttotobtmarks2.Text = TOTOBT.ToString();
                    txttotAllsubmarks2.Text = TOT.ToString();
                    txtPercentage2.Text = statuss;
                    /////////////////////////////////////////
                    totmrks = ""; totobtmarks = "";
                    TOT = 0;
                    TOTOBT = 0;
                    allpassflag = true;
                    foreach (GridViewRow row in gvresult3.Rows)
                    {
                        totmrks = row.Cells[3].Text;
                        totobtmarks = row.Cells[4].Text;
                        TOT += Convert.ToInt64(totmrks);
                        TOTOBT += Convert.ToInt64(totobtmarks);

                        if (row.Cells[6].Text == "Pass" && allpassflag)
                        {
                            statuss = "Pass";
                        }
                        else
                        {
                            statuss = "Fail";
                            allpassflag = false;
                        }

                    }
                    txttotobtmarks3.Text = TOTOBT.ToString();
                    txttotAllsubmarks3.Text = TOT.ToString();
                    txtPercentage3.Text = statuss;
                    //txtPercentage1.Text = gvr.Cells[8].Text;


                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('No Subject Found.');", true);
                }
                con.Close();
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