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
    public partial class AdminAddExamMarks : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            //
            cmd.CommandText = "Select c.*,s.* from tbl_Section s inner join tbl_Class c on s.nc_id=c.nc_id where c.bisDeleted='False' and s.bisDeleted='False' and c.nsch_id='" + Session["nschoolid"] + "'";
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
                    gvaddmarks.DataSource = dt;
                    gvaddmarks.DataBind();
                    gvaddmarks.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
            }
            catch (Exception) { }
        }

        private DataTable GetRecords_Students()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            //
            cmd.CommandText = "Select e.ne_id, e.strFname+' '+e.strLname as stdname, u.strfname+' '+u.strlname as fname, e.bRegisteredNum from tbl_Enrollment e inner join tbl_Users u on e.nu_id=u.nu_id where e.nc_id='"+lblcid.Text+"' and e.nsc_id='"+lblscid.Text+"' and e.bisDeleted='False' and e.nsch_id='" + Session["nschoolid"] + "'";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            con.Close();
            return objDs.Tables[0];

        }
        private void BindGrid_Students()
        {
            try
            {
                DataTable dt = GetRecords_Students();
                if (dt.Rows.Count > 0)
                {
                    gvstdmarks.DataSource = dt;
                    gvstdmarks.DataBind();
                    gvstdmarks.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
            }
            catch (Exception) { }
        }
        public void Bind_ddExamType()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT nExam_id, strExamName FROM [tbl_ExamType] WHERE ([bisDeleted] = 0) and nsch_id='" + Session["nschoolid"] + "' ", con);
                SqlDataReader dr = cmd.ExecuteReader();

                ddexams.Items.Clear();
                ddexams.Items.Add("--Select Exam Type--");
                ddexams.DataSource = dr;
                ddexams.DataTextField = "strExamName";
                ddexams.DataValueField = "nExam_id";
                ddexams.DataBind();
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

        public void Bind_ddSubjects()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT nsbj_id, strSubject FROM [tbl_Subject] WHERE nc_id='"+lblcid.Text+"' and ([bisDeleted] = 0) and nsch_id='" + Session["nschoolid"] + "' ", con);
                SqlDataReader dr = cmd.ExecuteReader();

                ddsubj.Items.Clear();
                ddsubj.Items.Add("--Select Class Subject--");
                ddsubj.DataSource = dr;
                ddsubj.DataTextField = "strSubject";
                ddsubj.DataValueField = "nsbj_id";
                ddsubj.DataBind();
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
        public void Bind_ddSubjectsshow()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT nsbj_id, strSubject FROM [tbl_Subject] WHERE nc_id='" + lblcid.Text + "' and ([bisDeleted] = 0) and nsch_id='" + Session["nschoolid"] + "' ", con);
                SqlDataReader dr = cmd.ExecuteReader();

                ddsubjshw.Items.Clear();
                ddsubjshw.Items.Add("--Select Class Subject--");
                ddsubjshw.DataSource = dr;
                ddsubjshw.DataTextField = "strSubject";
                ddsubjshw.DataValueField = "nsbj_id";
                ddsubjshw.DataBind();
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
        
        protected void btnAddMarks_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                lblcid.Text = gvr.Cells[5].Text;
                lblscid.Text = gvr.Cells[6].Text;
                Bind_ddExamType();
                Bind_ddSubjects();
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

        public void ddexams_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            int count = 0;
            foreach (GridViewRow row in gvstdmarks.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    if (ddexams.SelectedIndex != 0)
                    {
                        string id = row.Cells[5].Text.ToString();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        //if (ddexams.Text == "Quiz")
                        //{
                        //    cmd.CommandText = "Select nr_id,strObtMarks,strRemarks,strTotalMarks from tbl_Result Where nExam_id='" + ddexams.SelectedValue + "' and ne_id='" + id + "' AND SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) AND SUBSTRING(dtAddDate ,4,2)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2) and nsbj_id='" + Session["courscode"] + "' and bisDeleted=0  and nsch_id='" + Session["nschoolid"] + "'";                    
                        //}
                        //else
                        cmd.CommandText = "Select nr_id,strObtMarks,strRemarks,strTotalMarks from tbl_Result Where nExam_id='" + ddexams.SelectedValue + "' and ne_id='" + id + "' AND SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) and nsbj_id='" + ddsubj.SelectedItem.Value + "'  and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "' ";

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
            if (count == gvstdmarks.Rows.Count)
            {
                btnsubmitattend.Enabled = false;
            }
            // gvstdmarks.Columns[5].Visible = false;
        }

        protected void btnsubmitattend_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean CanADDFLAG = false;
                lblcours.Text = ddsubj.SelectedItem.Text;
                //string class_name = null;
                //int percentage = 0;
                bool flag = true;
                if (ddexams.SelectedIndex != 0 && txttmrks.Text != "")
                {
                    foreach (GridViewRow row in gvstdmarks.Rows)
                    {
                        if (row.RowType == DataControlRowType.DataRow)
                        {
                            //double result = 0;

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
                        foreach (GridViewRow row in gvstdmarks.Rows)
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
                                            cmd.CommandText = "insert into tbl_Result(nsch_id,nc_id,nsc_id,nsbj_id,ne_id,nu_id,strTotalMarks,strObtMarks,strRemarks,strType,nExam_id,dtAddDate,bisDeleted) values('" + Session["nschoolid"] + "','" + lblcid.Text + "','" + lblscid.Text + "','" + ddsubj.SelectedItem.Value + "','" + student_num + "','"+Session["uid"]+"',@obt,@st,@rem,@examname,@examtypeid,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                                            cmd.Parameters.AddWithValue("@st", marks);
                                            cmd.Parameters.AddWithValue("@obt", txttmrks.Text);
                                            cmd.Parameters.AddWithValue("@rem", remarks);
                                            cmd.Parameters.AddWithValue("@examtypeid", ddexams.SelectedValue);
                                            cmd.Parameters.AddWithValue("@examname", ddexams.SelectedItem.ToString());
                                            cmd.ExecuteNonQuery();

                                            cmd.Parameters.Clear();
                                            con.Close();
                                            CanADDFLAG = true;
                                            txtmk.Style["border"] = "2px solid rgb(213, 213, 213)";
                                        }
                                    }
                                    else
                                    {
                                        txtmk.Style["border"] = "2px solid red";


                                        flag = false;
                                        CanADDFLAG = false;
                                        flag = false;
                                    }
                                }
                                else
                                {
                                    txtmk.Style["border"] = "2px solid red";


                                    flag = false;
                                    CanADDFLAG = false;
                                }


                            }
                        }


                    }
                }
                else
                    flag = false;
                if (flag == true)
                {
                    ddexams.SelectedIndex = 0;
                    foreach (GridViewRow row in gvstdmarks.Rows)
                    {
                        ((TextBox)row.FindControl("txtmarks")).Text = "";
                        ((TextBox)row.FindControl("txtrem")).Text = "";
                        txttmrks.Text = "";
                        ((TextBox)row.FindControl("txtmarks")).Style["border"] = "2px solid rgb(213, 213, 213)";
                    }
                    //    refresh();
                    mvmarks.ActiveViewIndex = 1;
                }
                //PopulateData();
            }
            catch (Exception ex)
            {
                mperror.Show();
                //Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                    
                }
            }
            mpok.Show();
        }
        private void PopulateData(string cls, string sec, string sub)
        {
            try
            {

                DataTable table = new DataTable();

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
                {

                    string sql = "SELECT ex.nr_id, e.bRegisteredNum, e.strFname+' '+e.strLname as studentname,u.strfname+' '+u.strlname as fathernm,ex.strTotalMarks, ex.strObtMarks, ex.strRemarks FROM tbl_Enrollment AS e inner join tbl_Users u on e.nu_id=u.nu_id INNER JOIN tbl_Result AS ex ON e.ne_id = ex.ne_id WHERE (ex.nc_id = @cname) AND (ex.nsbj_id = @cc) and (ex.nsc_id=@sce111) and ex.nu_id=@uem AND (ex.bisDeleted = 'False') and ex.nsch_id=@schid2 and ex.nQuiz_id is Null";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@uem", Session["uid"].ToString().Trim());
                        cmd.Parameters.AddWithValue("@sce111", sec.Trim());
                        cmd.Parameters.AddWithValue("@cname", cls.Trim());
                        cmd.Parameters.AddWithValue("@cc", sub.Trim());
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
            catch (Exception)
            {
                Response.Redirect("Error.aspx");
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
        protected void btnviewMarks_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                TextBox tb = (TextBox)gvr.FindControl("txtroll");
                //Session["cname1"] = gvr.Cells[0].Text;
                //Session["coursecode1"] = gvr.Cells[2].Text;
                lblcid.Text = gvr.Cells[5].Text;
                lblscid.Text = gvr.Cells[6].Text;
                Bind_ddSubjectsshow();

                

                mvmarks.ActiveViewIndex = 2;
            }
            catch (Exception)
            {
                Response.Redirect("Error.aspx");
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

        protected void ddsubjshw_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateData(lblcid.Text, lblscid.Text, ddsubjshw.SelectedItem.Value);
        }
        protected void gottoback_Click(object sender, EventArgs e)
        {
            mvmarks.ActiveViewIndex = 0;
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
            catch (Exception)
            {
                Response.Redirect("Error.aspx");
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
                PopulateData(lblcid.Text, lblscid.Text, ddsubjshw.SelectedItem.Text);
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Updated Successfully.');", true);
                mvmarks.ActiveViewIndex = 2;
                
            }
            catch (Exception)
            {
                Response.Redirect("Error.aspx");
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

        protected void ddsubj_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindGrid_Students();
        }

        protected void lbok_Click(object sender, EventArgs e)
        {
            mvmarks.ActiveViewIndex = 0;
        }
    }
}