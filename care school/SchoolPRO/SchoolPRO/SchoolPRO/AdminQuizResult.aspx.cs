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

namespace SchoolPRO
{
    public partial class AdminQuizResult : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        string dtdate = DATE_FORMAT.format();
        SqlDataReader dr;
        DataTable dt1;
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
                // dt1 = new DataTable();
                // MakeDataTable();
                if (!IsPostBack)
                {
                    Bind_ddlClass();

                }
                //if (ddlType.SelectedIndex == 0 || ddlType.SelectedIndex == 1 || ddlType.SelectedIndex == 2 || ddlType.SelectedIndex == 3)
                //{
                //    btnPromote.Enabled = false;

                //}
                //else
                //    btnPromote.Enabled = true;
            }
            catch (Exception ex)
            {
                //Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

        }

        private void MakeDataTable()
        {
            // dt = new DataTable();


            // dt.Columns.Add("Select", System.Type.GetType("System.Boolean"));
        }

        private DataTable GetRecordsOfStudents()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            //if (ddlType.SelectedValue == "Admission Marks")
            //{
            //    cmd.CommandText = "SELECT ne_id, nc_id, nsc_id, nsch_id, strStudentNum, dtAddDate FROM  tbl_Enrollment WHERE (bisDeleted = 1) AND (nsch_id ='" + Session["nschoolid"] + "')  AND (strStatus ='Pending')";
            //}
            //else
                cmd.CommandText = "SELECT ne_id, nc_id, nsc_id, nsch_id, strStudentNum, dtAddDate FROM  tbl_Enrollment WHERE (bisDeleted = 0) AND (nsch_id ='" + Session["nschoolid"] + "')";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();

            dAdapter.Fill(objDs);
            con.Close();
            return objDs.Tables[0];

        }
        private void BindGrid()
        {
            try
            {

                DataTable dt = GetRecordsOfStudents();
                if (dt.Rows.Count > 0)
                {
                    List<StudentResult> data = new List<StudentResult>();
                    int i = 1;
                    foreach (DataRow re in dt.Rows)
                    {
                        //re["strTotal"]
                        string neid = re["ne_id"].ToString();

                        string cid = ddcl.SelectedValue;//re["nc_id"].ToString();
                        string scid = ddsec.SelectedValue; //re["nsc_id"].ToString();
                        //string cid = re["nc_id"].ToString();
                        //string scid =re["nsc_id"].ToString();
                        DataTable dt2 = GetRecordsOfSingleStudents(neid, cid, scid);
                        if (dt2.Rows.Count > 0)
                        {
                            Boolean passflag = true;
                            string PF = "";
                            string stnum = "";
                            string ststatus = "";
                            string name = "";
                            string cls = "";
                            string sec = "";
                            string secid = "";
                            string clasid = "";
                            string feeid = "";

                            StudentResult c = new StudentResult();
                            foreach (DataRow row in dt2.Rows)
                            {
                                stnum = row["strStudentNum"].ToString();
                                ststatus = row["Status"].ToString();
                                name = row["Name"].ToString();
                                cls = row["strClass"].ToString();
                                sec = row["strSection"].ToString();
                                clasid = row["nc_id"].ToString();
                                secid = row["nsc_id"].ToString();
                                feeid = row["nfee_id"].ToString();
                                if (ststatus == "True")
                                    PF = "Pass";
                                else
                                {
                                    PF = "Fail";
                                    passflag = false;
                                }
                            }
                            c.feeid = feeid;
                            c.sno = i.ToString();
                            c.S_No = neid;
                            c.Class = cls;
                            c.Section = sec;
                            c.Roll_Number = stnum;
                            c.Name = name;
                            c.nc_id = clasid;
                            c.nsc_id = secid;
                            if (passflag)
                                c.Status = "Pass";
                            else
                                c.Status = "Fail";

                            i++;
                            data.Add(c);
                        }

                    }

                    gv_detail_list.DataSource = data;
                    gv_detail_list.DataBind();

                    foreach (GridViewRow rr in gv_detail_list.Rows)
                    {
                        DropDownList ddll = (DropDownList)rr.FindControl("ddlstatus");
                        ddll.SelectedValue = rr.Cells[8].Text;
                    }
                    // gv_detail_list.Columns[7].Visible = false;
                    //  gv_detail_list.Columns[1].Visible = false;
                    // gv_detail_list.Columns[2].Visible = false;
                    //gv_detail_list.DataSource = dt;
                    //gv_detail_list.DataBind();
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
        private DataTable GetRecordsOfSingleStudents(string neid, string cid, string scid)
        {

            if (ddcl.SelectedIndex != 0 && ddsec.SelectedIndex != 0 && ddlType.SelectedIndex != 0)
            {
                try
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    //if (ddlType.Text == "All Exam")
                    //{
                    //    cmd.CommandText = "SELECT tbl_Fee.nfee_id,tbl_Result.strTotalMarks,tbl_Enrollment.strFname+' '+tbl_Enrollment.strLname as Name , tbl_Enrollment.strStudentNum, tbl_Subject.strSubject, tbl_Result.strType, tbl_Class.strClass ,tbl_Class.nc_id, tbl_Section.strSection,tbl_Section.nsc_id, CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 AS SubjectPer, CAST(CASE WHEN CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 >= CAST(tbl_Percentage.strPercentage AS float) THEN 1 ELSE 0 END AS bit) AS Status, tbl_Percentage.strPercentage FROM tbl_Result INNER JOIN tbl_Enrollment ON tbl_Result.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Subject ON tbl_Result.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Class ON tbl_Enrollment.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_Enrollment.nsc_id = tbl_Section.nsc_id CROSS JOIN tbl_Percentage INNER JOIN tbl_Fee ON tbl_Enrollment.nfee_id = tbl_Fee.nfee_id WHERE (tbl_Result.nQuiz_id <> '" + ddlType.SelectedValue + "') AND (tbl_Result.bisDeleted = 0)   AND (tbl_Result.nc_id='" + cid + "')AND (tbl_Result.nsc_id='" + scid + "')  AND (tbl_Enrollment.nsc_id = '" + scid + "') AND (tbl_Enrollment.nc_id = '" + cid + "') AND (tbl_Enrollment.ne_id = '" + neid + "') and tbl_Result.nsch_id= '" + Session["nschoolid"] + "' AND (tbl_Enrollment.bisDeleted = 'False')";
                    //}
                    //else if (ddlType.Text == "Admission Marks")
                    //{
                    //    cmd.CommandText = "SELECT tbl_Fee.nfee_id,tbl_Result.strTotalMarks,tbl_Enrollment.strFname+' '+tbl_Enrollment.strLname as Name , tbl_Enrollment.strStudentNum, tbl_Subject.strSubject, tbl_Result.strType, tbl_Class.strClass ,tbl_Class.nc_id, tbl_Section.strSection,tbl_Section.nsc_id, CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 AS SubjectPer, CAST(CASE WHEN CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 >= CAST(tbl_Percentage.strPercentage AS float) THEN 1 ELSE 0 END AS bit) AS Status, tbl_Percentage.strPercentage FROM tbl_Result INNER JOIN tbl_Enrollment ON tbl_Result.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Subject ON tbl_Result.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Class ON tbl_Enrollment.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_Enrollment.nsc_id = tbl_Section.nsc_id CROSS JOIN tbl_Percentage INNER JOIN tbl_Fee ON tbl_Enrollment.nfee_id = tbl_Fee.nfee_id WHERE (tbl_Result.nExam_id = '" + ddlType.SelectedValue + "') AND (tbl_Result.bisDeleted = 0)   AND (tbl_Result.nc_id='" + cid + "')AND (tbl_Result.nsc_id='" + scid + "')  AND (tbl_Enrollment.nsc_id = '" + scid + "') AND (tbl_Enrollment.nc_id = '" + cid + "') AND (tbl_Enrollment.ne_id = '" + neid + "') and tbl_Result.nsch_id= '" + Session["nschoolid"] + "' AND (tbl_Enrollment.bisDeleted = 'True') AND (tbl_Enrollment.strStatus = 'Pending') ";
                    //}
                    //else
                    cmd.CommandText = "SELECT tbl_Fee.nfee_id,tbl_Result.strTotalMarks,tbl_Enrollment.strFname+' '+tbl_Enrollment.strLname as Name , tbl_Enrollment.strStudentNum, tbl_Subject.strSubject, tbl_Result.strType, tbl_Class.strClass ,tbl_Class.nc_id, tbl_Section.strSection,tbl_Section.nsc_id, CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 AS SubjectPer, CAST(CASE WHEN CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 >= CAST(tbl_Percentage.strPercentage AS float) THEN 1 ELSE 0 END AS bit) AS Status, tbl_Percentage.strPercentage FROM tbl_Result INNER JOIN tbl_Quiz on tbl_Result.nQuiz_id=tbl_Quiz.nExam_id INNER JOIN tbl_Enrollment ON tbl_Result.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Subject ON tbl_Result.nsbj_id = tbl_Subject.nsbj_id  INNER JOIN tbl_Class ON tbl_Enrollment.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_Enrollment.nsc_id = tbl_Section.nsc_id CROSS JOIN tbl_Percentage INNER JOIN tbl_Fee ON tbl_Enrollment.nfee_id = tbl_Fee.nfee_id WHERE (tbl_Result.nQuiz_id = '" + ddlType.SelectedValue + "') AND (tbl_Result.bisDeleted = 0)   AND (tbl_Result.nc_id='" + cid + "')AND (tbl_Result.nsc_id='" + scid + "')  AND (tbl_Enrollment.nsc_id = '" + scid + "') AND (tbl_Enrollment.nc_id = '" + cid + "') AND (tbl_Enrollment.ne_id = '" + neid + "') and tbl_Result.nsch_id= '" + Session["nschoolid"] + "' AND (tbl_Enrollment.bisDeleted = 'False')";
                    // AND (tbl_Enrollment.ne_id = '" + neid + "') //AND (DATEPART(yyyy, tbl_Result.dtAddDate) = DATEPART(yyyy, CONVERT (date, SYSDATETIME())))
                    SqlDataAdapter dAdapter = new SqlDataAdapter();
                    dAdapter.SelectCommand = cmd;
                    DataSet objDs = new DataSet();

                    dAdapter.Fill(objDs);
                    con.Close();


                    return objDs.Tables[0];
                }
                catch (Exception ex)
                {
                    return null;
                    // Response.Redirect("Error.aspx");
                }
            }
            else
                return null;
        }
        private void BindGrid2()
        {
            //DataTable dt = GetRecordsOfSingleStudents();
            //if (dt.Rows.Count > 0)
            //{
            //    foreach (DataRow re in dt.Rows)
            //    { 
            //       // re["strTotal"]
            //    }
            //    //gv_detail_list.DataSource = dt;
            //    //gv_detail_list.DataBind();
            //}
        }

        public void Bind_ddlClass()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT [strClass],[nc_id] FROM [tbl_Class] WHERE ([bisDeleted] = 0) and nsch_id= '" + Session["nschoolid"] + "'", con);
                SqlDataReader dr = cmd.ExecuteReader();

                ddcl.Items.Clear();
                ddcl.Items.Add("--Please Select Class--");
                ddcl.DataSource = dr;
                ddcl.DataTextField = "strClass";
                ddcl.DataValueField = "nc_id";
                ddcl.DataBind();
                con.Close();
            }
            catch (Exception) { }
        }

        public void Bind_ddlSection()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT [strSection],[nsc_id] FROM [tbl_Section] WHERE (([nc_id] ='" + ddcl.SelectedValue + "') AND ([bisDeleted] = 0) and nsch_id= '" + Session["nschoolid"] + "')", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddsec.DataSource = dr;
                ddsec.Items.Clear();
                ddsec.Items.Add("--Please Select Section--");
                ddsec.DataTextField = "strSection";
                ddsec.DataValueField = "nsc_id";
                ddsec.DataBind();
                con.Close();
            }
            catch (Exception) { }
        }

        protected void btnview_Click(object sender, EventArgs e)
        {

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
                List<StudentResult> data = new List<StudentResult>();
                cmd.CommandText = "SELECT tbl_Result.strTotalMarks,tbl_Result.strObtMarks, tbl_Enrollment.strStudentNum,tbl_Enrollment.strFname+' '+tbl_Enrollment.strLname as Name ,tbl_Subject.strSubject,tbl_Subject.strCourseCode, tbl_Result.strType, tbl_Class.strClass, tbl_Section.strSection,CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 AS SubjectPer, CAST(CASE WHEN CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 >= CAST(tbl_Percentage.strPercentage AS float) THEN 1 ELSE 0 END AS bit) AS Status, tbl_Percentage.strPercentage FROM  tbl_Result INNER JOIN tbl_Quiz on tbl_Result.nQuiz_id=tbl_Quiz.nExam_id INNER JOIN tbl_Enrollment ON tbl_Result.ne_id = tbl_Enrollment.ne_id INNER JOIN   tbl_Subject ON tbl_Result.nsbj_id = tbl_Subject.nsbj_id INNER JOIN  tbl_Class ON tbl_Enrollment.nc_id = tbl_Class.nc_id INNER JOIN  tbl_Section ON tbl_Enrollment.nsc_id = tbl_Section.nsc_id CROSS JOIN  tbl_Percentage WHERE tbl_Result.nQuiz_id='"+ddlType.SelectedValue+"' and (tbl_Result.bisDeleted = 0) AND (SUBSTRING(tbl_Result.dtAddDate ,7,10) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10)) AND (tbl_Result.nc_id=@cid)AND (tbl_Result.nsc_id=@scid) AND (tbl_Enrollment.nc_id = @cid) AND (tbl_Enrollment.nsc_id = @scid) AND (tbl_Enrollment.ne_id = @neid) AND (tbl_Result.nsch_id = @schid) and tbl_Percentage.nsch_id=@schid";
                cmd.Parameters.AddWithValue("@neid", neid);
                cmd.Parameters.AddWithValue("@cid", clas);
                cmd.Parameters.AddWithValue("@scid", sec);
                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);
                dr = cmd.ExecuteReader();
                int i = 1;

                if (dr.HasRows)
                {
                    Boolean oncerunflag = true;
                    while (dr.Read())
                    {
                        StudentResult st = new StudentResult();
                        // lblsno.Text = i.ToString();
                        if (oncerunflag)
                        {

                            txtstName.Text = dr["Name"].ToString();
                            txtstRoll.Text = dr["strStudentNum"].ToString();
                            date.Text = DateTime.Today.Date.ToString();
                            txtstClass.Text = dr["strClass"].ToString();
                            txtstSec.Text = dr["strSection"].ToString();

                            txtterm.Text = dr["strType"].ToString();
                            oncerunflag = false;
                        }
                        st.nc_id = i.ToString();
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
                        data.Add(st);

                        i++;
                    }
                    gvresult.DataSource = data;
                    gvresult.DataBind();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('No Subject Found.');", true);
                }
                con.Close();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminStudentLeavingCert.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

        }
        protected void btnViewDetail_Click(object sender, EventArgs e)
        {
            try
            {
                mvstlist.ActiveViewIndex = 1;
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                //TextBox tb = (TextBox)gvr.FindControl("txtroll");
                string neid = gvr.Cells[1].Text;
                string clas = gvr.Cells[2].Text;
                string sec = gvr.Cells[3].Text;
                ShowStudentResult(neid, clas, sec);
                string totmrks, totobtmarks;
                Int64 TOT = 0, TOTOBT = 0;
                foreach (GridViewRow row in gvresult.Rows)
                {
                    totmrks = row.Cells[3].Text;
                    totobtmarks = row.Cells[4].Text;
                    TOT += Convert.ToInt64(totmrks);
                    TOTOBT += Convert.ToInt64(totobtmarks);

                }
                txttotobtmarks.Text = TOTOBT.ToString();
                txttotAllsubmarks.Text = TOT.ToString();
                txtPercentage.Text = gvr.Cells[8].Text;
                // txtPercentage.Text =Convert.ToString((TOTOBT / TOT) * 100);
            }
            catch (Exception ex)
            {
                //Response.Redirect("Error.aspx?msg=AdminStudentLeavingCert.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        protected void btnPromote_Click(object sender, EventArgs e)
        {
            //Boolean InsertFlag = true;
            //try
            //{
            //    if (ddlType.SelectedIndex != 0 || ddlType.SelectedIndex != 1 || ddlType.SelectedIndex != 2 || ddlType.SelectedIndex != 3)
            //    {




            //        // GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            //        //TextBox tb = (TextBox)gvr.FindControl("txtroll");
            //        foreach (GridViewRow gvr in gv_detail_list.Rows)
            //        {
            //            DropDownList dd = (DropDownList)gvr.FindControl("ddlstatus");
            //            string status = dd.SelectedValue;

            //            if (status == "Pass")
            //            {

            //                // if (status == "Pass")
            //                // {
            //                string neid = gvr.Cells[1].Text;
            //                string clas = gvr.Cells[2].Text;
            //                string sec = gvr.Cells[3].Text;
            //                string feeid = gvr.Cells[13].Text;
            //                string rollno = gvr.Cells[4].Text;
            //                status = gvr.Cells[8].Text;
            //                con.Open();
            //                cmd.Connection = con;
            //                cmd.CommandType = CommandType.Text;

            //                cmd.CommandText = "insert into tbl_PromoteStudent (nu_id,ne_id,nc_id,nsc_id,nsch_id,nfee_id,strStudentNumber,strStatus,dtAddDate,bisDeleted) values('" + Session["uid"] + "','" + neid + "','" + clas + "','" + sec + "','" + Session["nschoolid"] + "','" + feeid + "','" + rollno + "','" + status + "',@date,'False')";
            //                cmd.Parameters.AddWithValue("@date", dtdate);
            //                //    cmd.Parameters.AddWithValue("@uid",Session["uid"]);
            //                //    cmd.Parameters.AddWithValue("@eid",neid);
            //                //    cmd.Parameters.AddWithValue("@cid",clas);
            //                //cmd.Parameters.AddWithValue("@scid",sec);
            //                //cmd.Parameters.AddWithValue("@feeid",feeid);
            //                //cmd.Parameters.AddWithValue("@rollno",rollno);
            //                //cmd.Parameters.AddWithValue("@schid",Session["nschoolid"]);
            //                //cmd.Parameters.AddWithValue("@status",status);
            //                if (cmd.ExecuteNonQuery() == -1)
            //                {
            //                    InsertFlag = false;
            //                }
            //                con.Close();
            //                if (InsertFlag)
            //                {
            //                    string newfeeid = "";
            //                    DropDownList ddclass1 = (DropDownList)gvr.FindControl("ddlclas");
            //                    DropDownList ddsec1 = (DropDownList)gvr.FindControl("ddlsec");

            //                    con.Open();
            //                    cmd.Connection = con;
            //                    cmd.CommandType = CommandType.Text;
            //                    cmd.CommandText = "Select nfee_id from tbl_Fee where nc_id='" + ddclass1.SelectedValue + "' and bisDeleted='False' and nsch_id= '" + Session["nschoolid"] + "'";
            //                    dr = cmd.ExecuteReader();
            //                    if (dr.Read())
            //                    {
            //                        newfeeid = dr["nfee_id"].ToString();
            //                    }
            //                    con.Close();

            //                    string Newstnum = GenrerateStudentNumber(ddclass1.SelectedValue, ddsec1.SelectedValue);

            //                    con.Open();
            //                    cmd.Connection = con;
            //                    cmd.CommandType = CommandType.Text;
            //                    cmd.CommandText = "Update tbl_Enrollment set nc_id='" + ddclass1.SelectedValue + "',nsc_id='" + ddsec1.SelectedValue + "',nfee_id='" + newfeeid + "',nsch_id='" + Session["nschoolid"] + "',strStudentNum='" + Newstnum + "' where ne_id='" + neid + "' and bisDeleted=0";
            //                    cmd.ExecuteNonQuery();
            //                    con.Close();


            //                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Students Promoted SuccessFully.');", true);


            //                }
            //            }
            //        }
            //    }
            //    else
            //        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Select Final Or All Trems Result');", true);

            //}
            //catch (Exception ex)
            //{
            //    Response.Redirect("Error.aspx?msg=AdminExaminationResult.aspx");
            //}
            //if (InsertFlag)
            //    Response.Redirect("AdminExaminationResult.aspx");

        }
        string GenrerateStudentNumber(string classid, string secid)
        {
            //try
            //{
            //    con.Open();
            //    cmd.Connection = con;
            //    cmd.CommandType = CommandType.Text;
            //    cmd.CommandText = "select strStudentNum from  tbl_Enrollment where ne_id=(select Max(ne_id) as Id from tbl_Enrollment where  nsc_id='" + secid + "' and nc_id='" + classid + "' and bisDeleted=0) and bisDeleted='False'";
            //    //  cmd.CommandText = "select strStudentNum from  tbl_StudentNumber where ne_id=(select Max(ne_id) as Id from tbl_StudentNumber where  nsc_id=(select nsc_id from tbl_Section where strSection='" + ddsec.Text + "' and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted='False')and bisDeleted='False') and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted='False') and bisDeleted='False')";
            //    //cmd.Parameters.AddWithValue("@reg1", tb.Text);
            //    dr = cmd.ExecuteReader();
            //    if (dr.HasRows)
            //    {
            //        dr.Read();
            //        string stnum = dr["strStudentNum"].ToString();
            //        //stnum = "10B-100";
            //        int dashe = stnum.IndexOf('-');
            //        string rollnumber = stnum.Substring(dashe + 1, stnum.Length - (dashe + 1));
            //        string classSection = stnum.Substring(0, dashe);
            //        int rollnumber2 = Convert.ToInt32(rollnumber);
            //        rollnumber2++;

            //        string NewSTNUM = classSection + "-" + rollnumber2.ToString();
            //        con.Close();
            //        return NewSTNUM;
            //        //txtstnum.Text = NewSTNUM;
            //        //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('The Student Verification Number already exist.');", true);
            //    }
            //    else
            //    {
            //        string stnum = ddcl.Text + ddsec.Text + "-" + "1";
            //        con.Close();
            //        return stnum;
            //        //txtstnum.Text = stnum;
            //    }
            //}
            //catch (Exception ex)
            //{
            //    Response.Redirect("Error.aspx");
            //}
            //finally
            //{
            //    if (con.State == ConnectionState.Open)
            //    {
            //        con.Close();
            //    }
            //}
            //string stnu = ddcl.Text + ddsec.Text + "-" + "1";

            //return stnu;
            return "";

        }
        protected void ddcl_SelectedIndexChanged(object sender, EventArgs e)
        {
            gv_detail_list.DataSource = null;
            gv_detail_list.DataBind();
            if (ddcl.SelectedIndex != 0)
                Bind_ddlSection();
        }

        protected void ddsec_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (ddsec.SelectedIndex != 0)
                BindGrid();
        }

        protected void btnback_Click(object sender, EventArgs e)
        {
            mvstlist.ActiveViewIndex = 0;
        }
        /// <summary>
        /// ////////////////////////////ENCRPTING/////////////////////////////
        /// </summary>
        /// <param name="clearText"></param>
        /// <returns></returns>
        private string Encrypt(string clearText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            byte[] clearBytes = System.Text.Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }
        protected void btnViewFullResult_Click(object sender, EventArgs e)
        {
            //GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            ////TextBox tb = (TextBox)gvr.FindControl("txtroll");
            //string neid = HttpUtility.UrlEncode(Encrypt(gvr.Cells[1].Text.Trim()));// 
            //string clas = HttpUtility.UrlEncode(Encrypt(gvr.Cells[2].Text.Trim()));//  //gvr.Cells[2].Text;
            //string sec = HttpUtility.UrlEncode(Encrypt(gvr.Cells[3].Text.Trim()));// 

            /////Response.Redirect(string.Format("~/CS2.aspx?name={0}&technology={1}", name, technology));
            //Response.Redirect(string.Format("AdminFullResultReport.aspx?eid={0}&cid={1}&scid={2}", neid, clas, sec));
        }

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            gv_detail_list.DataSource = null;
            gv_detail_list.DataBind();
        }
    }
}