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
    public partial class AdminManageNewAdmissionMarks : System.Web.UI.Page
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
                Session["cname"] = gvr.Cells[5].Text;
                Session["section"] = "0";
                Session["courscode"] = gvr.Cells[6].Text;
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

        protected void btnviewMarks_Click(object sender, EventArgs e)
        {

        }

        protected void ddexams_SelectedIndexChanged(object sender, EventArgs e)
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
                            //if (ddexams.Text == "Quiz")
                            //{
                            //    cmd.CommandText = "Select nr_id,strObtMarks,strRemarks,strTotalMarks from tbl_Result Where strType='" + ddexams.Text + "' and ne_id='" + id + "' AND SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) AND SUBSTRING(dtAddDate ,4,2)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2) and nsbj_id='" + Session["courscode"] + "' and bisDeleted=0  and nsch_id='" + Session["nschoolid"] + "'";
                            //}
                            //else
                            cmd.CommandText = "Select nr_id,strObtMarks,strRemarks,strTotalMarks from tbl_Result Where nAdmsn_id='" + ddexams.SelectedValue + "' and ne_id='" + id + "' AND SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) and nsbj_id='" + Session["courscode"] + "'  and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "' ";

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
                                txttmrks.Enabled = false;
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

        protected void btnsubmitattend_Click(object sender, EventArgs e)
        {
            //bool flag = true;

            Boolean CanADDFLAG = false;
            int count = 0;
            //string class_name = null;
            //int percentage = 0;
            bool flag = true;
            foreach (GridViewRow row in GridView2.Rows)
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
                                count++;
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
            //if (count == GridView2.Rows.Count)
            //{
            //    CanADDFLAG = true;
            //}
            //else
            //{
            //    CanADDFLAG = false;
            //}

            if (CanADDFLAG)
            {


                if (ddexams.SelectedIndex != 0 && txttmrks.Text != "")
                {

                    foreach (GridViewRow row in GridView2.Rows)
                    {
                        if (row.RowType == DataControlRowType.DataRow)
                        {
                            //double result = 0;
                            string marks = ((TextBox)row.FindControl("txtmarks")).Text;
                            string remarks = ((TextBox)row.FindControl("txtrem")).Text;

                            if (marks != "")
                            {
                                if (row.Enabled == true)
                                {

                                    string student_num = row.Cells[5].Text;
                                    //txtre.Text=gvr.Cells[4].Text;
                                    con.Open();
                                    cmd.Connection = con;
                                    cmd.CommandType = CommandType.Text;
                                    cmd.CommandText = "insert into tbl_Result(nAdmsn_id,nsch_id,nc_id,nsc_id,nsbj_id,ne_id,nu_id,strTotalMarks,strObtMarks,strRemarks,strType,dtAddDate,bisDeleted) values(@admsnid,'" + Session["nschoolid"] + "','" + Session["cname"] + "','" + Session["section"] + "','" + Session["courscode"] + "','" + student_num + "',(select nu_id from tbl_Users where strEmail='" + Session["userval"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),@obt,@st,@rem,'" + ddexams.SelectedItem.ToString().Trim() + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                                    cmd.Parameters.AddWithValue("@st", marks);
                                    cmd.Parameters.AddWithValue("@obt", txttmrks.Text);
                                    cmd.Parameters.AddWithValue("@rem", remarks);
                                    cmd.Parameters.AddWithValue("@admsnid", ddexams.SelectedValue);
                                    cmd.ExecuteNonQuery();

                                    cmd.Parameters.Clear();
                                    con.Close();
                                    
                                }
                            }
                            else
                            {
                                row.BackColor = System.Drawing.Color.LightPink;
                                flag = false;
                            }

                        }
                    }
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Subject Marks Entered SuccessFully.'); window.location = 'AdminManageNewAdmissionMarks.aspx';", true);

                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('All Feilds Required'); ", true);
            }

        }

        protected void dddlcl_SelectedIndexChanged(object sender, EventArgs e)
        {
            //dddlsec.Items.Clear();
           // dddlsec.Items.Add("----Select Section----");
           /// dddlsec.DataBind();

            GridView1.DataBind();
        }

        protected void dddlsec_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void txttmrks_TextChanged(object sender, EventArgs e)
        {

        }
    }
}