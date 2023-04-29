using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace SchoolPRO
{
    public partial class AdminStudentAttendance : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    string day = "";

                    day = DateTime.Now.DayOfWeek.ToString();
                    txtattdt.Text = DATE_FORMAT.format();


                    BindGrid();

                }
            }
            catch (Exception) { }
        }

        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            //
            cmd.CommandText = "SELECT tbl_Class.nc_id, tbl_Class.strClass, tbl_Section.strSection,tbl_Section.nsc_id FROM tbl_Class INNER JOIN tbl_Section ON tbl_Class.nc_id = tbl_Section.nc_id WHERE (tbl_Class.bisDeleted = 'False') and (tbl_Section.bisDeleted = 'False') and tbl_Class.nsch_id='" + Session["nschoolid"] + "'";
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
                DataTable dt = GetRecords();
                if (dt.Rows.Count > 0)
                {
                    gvbyclass.DataSource = dt;
                    gvbyclass.DataBind();
                    gvbyclass.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
            }
            catch (Exception) { }
        }
        //public void Bind_ddSubjects()
        //{
        //    try
        //    {
        //        con.Close();
        //        con.Open();
        //        SqlCommand cmd = new SqlCommand("select strSubject, nsbj_id from tbl_Subject where nc_id = '" + cid + "' and nsch_id = '" + Session["nschoolid"] + "'", con);
        //        SqlDataReader dr = cmd.ExecuteReader();

        //        ddlsubjects.Items.Clear();
        //        ddlsubjects.Items.Add("--Select Subject--");
        //        ddlsubjects.DataSource = dr;
        //        ddlsubjects.DataTextField = "strSubject";
        //        ddlsubjects.DataValueField = "nsbj_id";
        //        ddlsubjects.DataBind();
        //        con.Close();
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
        private DataTable GetRecords_Attend()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            //
            cmd.CommandText = "SELECT e.ne_id, e.bRegisteredNum, e.strFname+' '+e.strLname as StdName, u.strfname+' '+u.strlname as fname FROM tbl_Enrollment e inner join tbl_Users u on e.nu_id=u.nu_id WHERE (e.nc_id = '" + cid + "') and e.nsc_id='" + scid + "' AND (e.bRegisteredNum IS NOT NULL) AND (e.nsch_id = '" + Session["nschoolid"] + "') AND (e.bisDeleted = 'False')";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            con.Close();
            return objDs.Tables[0];

        }
        private void BindGrid_Attend()
        {
            try
            {
                DataTable dt = GetRecords_Attend();
                if (dt.Rows.Count > 0)
                {
                    gvattnd.DataSource = dt;
                    gvattnd.DataBind();
                    gvattnd.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
            }
            catch (Exception) { }
        }

        public void Bind_ddTemplate()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT nstmp_id, strSMSTitle FROM [tbl_SMStemplate] WHERE ([bisDeleted] = 0) and nsch_id='" + Session["nschoolid"] + "' ", con);
                SqlDataReader dr = cmd.ExecuteReader();

                ddsmstemp.Items.Clear();
                ddsmstemp.Items.Add("--Select SMS Title--");
                ddsmstemp.DataSource = dr;
                ddsmstemp.DataTextField = "strSMSTitle";
                ddsmstemp.DataValueField = "nstmp_id";
                ddsmstemp.DataBind();
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
            cmd.Parameters.AddWithValue("@cdate", Currentdate);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                stdid.Add(dr["nG_id"].ToString());
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlaccept = (e.Row.FindControl("ddst") as DropDownList);
                foreach (string idd in stdid)
                {
                    if (e.Row.Cells[1].Text == idd)
                    {
                        //ddlaccept.Enabled = false;
                        ddlaccept.SelectedIndex = 2;
                    }
                }
            }
        }

        string cid = "0", scid = "0";
        protected void btnvful_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            cid = gvr.Cells[1].Text;
            scid = gvr.Cells[5].Text;
            lblcid.Text = cid;
            lblscid.Text = scid;
            BindGrid_Attend();
            //Bind_ddSubjects();
            mvt.ActiveViewIndex = 1;
        }
        private string SendSMSToURL(string getUri)
        {

            string SentResult = String.Empty;
            string StatusCode = String.Empty;

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(getUri);

            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            StreamReader responseReader = new StreamReader(response.GetResponseStream());

            String resultmsg = responseReader.ReadToEnd();
            responseReader.Close();

            int StartIndex = 0;
            int LastIndex = resultmsg.Length;

            if (LastIndex > 0)
                SentResult = resultmsg.Substring(StartIndex, LastIndex);

            HttpStatusCode objHSC = response.StatusCode;

            StatusCode = objHSC.GetHashCode().ToString();

            responseReader.Dispose();

            return SentResult;

        }
        protected void btnsubmitattend_Click(object sender, EventArgs e)
        {
            Boolean ADDFLAG = true;
            string url = "";
            string number = "", message = txtmsg.Text, username = "", password = "", to = "", from = "",eid="";
            try
            {
                if (ADDFLAG)
                {
                    //string date = "";
                    //string m_date = "";
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    //cmd.CommandText = "select dtAddDate from tbl_Attendance where dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) and nsbj_id=(select nsbj_id from tbl_Subject where strCourseCode='" + Session["courscode"] + "') and nsc_id=(select nsc_id from tbl_Section where nc_id='" + Session["cid"] + "') and bisDeleted='False'";
                    cmd.CommandText = "select count(na_id) from tbl_Attendance where dtAddDate=CONVERT(VARCHAR(10), '" + txtattdt.Text + "', 105 ) and nsc_id='" + lblscid.Text + "' and nc_id='" + lblcid.Text + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    int result = Convert.ToInt32(cmd.ExecuteScalar());

                    con.Close();
                    if (result != 0)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Attendance has already been marked.');", true);
                    }
                    else
                    {

                        foreach (GridViewRow row in gvattnd.Rows)
                        {
                            if (row.RowType == DataControlRowType.DataRow)
                            {
                                string status = ((DropDownList)row.FindControl("ddst")).Text;
                                string remarks = ((TextBox)row.FindControl("txtrem")).Text;
                                eid = row.Cells[1].Text;
                                //txtre.Text=gvr.Cells[4].Text;
                                con.Open();
                                cmd.Connection = con;
                                cmd.CommandType = CommandType.Text;
                                cmd.CommandText = "insert into tbl_Attendance(nsch_id,nc_id,nsc_id,nsbj_id,ne_id,nu_id,strStatus,strRemarks,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "','" + lblcid.Text + "','" + lblscid.Text + "','" + 0 + "','" + eid + "','" + Session["uid"] + "',@st,@rem,CONVERT(VARCHAR(10), '" + txtattdt.Text + "', 105 ),'False')";

                                cmd.Parameters.AddWithValue("@st", status);
                                cmd.Parameters.AddWithValue("@rem", remarks);
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();
                                con.Close();
                                if (chkabs.Checked == true)
                                {
                                    if (status == "Absent")
                                    {
                                        System.Threading.Thread.Sleep(1000);
                                        con.Open();
                                        cmd.Connection = con;
                                        cmd.CommandType = CommandType.Text;
                                        cmd.CommandText = "select * from tbl_Enrollment where ne_id='" + eid + "'";
                                        dr = cmd.ExecuteReader();
                                        if (dr.Read())
                                        {
                                            number = dr["strPhone"].ToString();
                                            username = "rising.sagheer";
                                            password = "56978";
                                            from = "SMS Alert";
                                            con.Close();
                                            System.Threading.Thread.Sleep(1000);
                                            url = "http://Lifetimesms.com/api.php?username=" + username + "&password=" + password + "&to=" + number + "&from=" + from + "&message=" + message + "";

                                            SendSMSToURL(url);

                                            con.Open();
                                            cmd.Connection = con;
                                            cmd.CommandType = CommandType.Text;
                                            cmd.CommandText = "insert into tbl_Notification(ne_id,nc_id,nsc_id,nu_id,strDesc,strSMS,bisStatus,dtAddDate,nsch_id)values(@eid,@cid,@scid,@uid,@desc,'SMS','1',CONVERT(DATE,SYSDATETIME()),@schid)";
                                            cmd.Parameters.AddWithValue("@eid", eid);
                                            cmd.Parameters.AddWithValue("@cid", lblcid.Text);
                                            cmd.Parameters.AddWithValue("@scid", lblscid.Text);
                                            cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                                            cmd.Parameters.AddWithValue("@desc", txtmsg.Text);
                                            cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
                                            cmd.ExecuteNonQuery();
                                            cmd.Parameters.Clear();
                                            con.Close();
                                            con.Open();
                                            cmd.Connection = con;
                                            cmd.CommandType = CommandType.Text;
                                            cmd.CommandText = "insert into tbl_SendSMS(nUserId,nParentId,strNumber,strMessage,bisSent,dtSendDate,nsch_id)values(@uid,(select nu_id from tbl_Enrollment where ne_id=@pid),@numb,@msg,'1',CONVERT(DATE,SYSDATETIME()),@schid)";
                                            cmd.Parameters.AddWithValue("@uid", Session["uid"]);
                                            cmd.Parameters.AddWithValue("@pid", eid);
                                            cmd.Parameters.AddWithValue("@numb", number);
                                            cmd.Parameters.AddWithValue("@msg", txtmsg.Text);
                                            cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
                                            cmd.ExecuteNonQuery();
                                            cmd.Parameters.Clear();
                                            con.Close();
                                        }

                                        con.Close();

                                    }
                                }
                            }
                        }


                    }
                    mpok.Show();
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

        }

        protected void lbok_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 0;
        }

        protected void chkabs_CheckedChanged(object sender, EventArgs e)
        {
            Bind_ddTemplate();
            ddsmstemp.Visible = true;
        }

        protected void ddsmstemp_SelectedIndexChanged(object sender, EventArgs e)
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select strSMStemp from tbl_SMStemplate where nstmp_id='" + ddsmstemp.SelectedItem.Value + "'";
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                txtmsg.Text = dr["strSMStemp"].ToString();
            }
            con.Close();
            txtmsg.Visible = true;
        }





    }
}