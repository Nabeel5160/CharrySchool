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
    public partial class AdminManageEmployees : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {

                    BindGrid();

                }
                txtcc.Focus();
            }
            catch (Exception) { }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btntreg_Click(object sender, EventArgs e)
        {
            try
            {

                if (ddlgroup.SelectedIndex == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('No Group Selected .');", true);
                }
                else
                {
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select nu_id from tbl_Users where strNIC='" + txttchrnic.Text + "'   and bisDeleted='False' ";
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('NIC  already exist.');", true);
                        con.Close();
                    }
                    else
                    {
                        con.Close();

                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "select * from tbl_Users where stremail='" + txtem.Text + "'  and bisDeleted='False'";
                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Email  already exist.');", true);
                        }
                        else
                        {
                            con.Close();
                            // if (chqacpt.Checked == true)
                            // {
                            string img = "";
                            if (fimg.HasFile)
                            {
                                img = @"~\Uploaded-Files\" + Path.GetFileName(fimg.PostedFile.FileName);
                                fimg.SaveAs(Server.MapPath(img));
                            }
                            else
                                img = @"~\Uploaded-Files\Employee.jpg";
                            Int32 empnum = 10;
                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "select MAX(nEmployeeNumber) as num from tbl_Users";
                            dr = cmd.ExecuteReader();
                            if (dr.HasRows)
                            {
                                dr.Read();
                                string empno = dr["num"].ToString();
                                if (empno != "")
                                    empnum = Convert.ToInt32(empno) + 1;


                            }
                            else
                            {
                                empnum = 10;
                            }

                            con.Close();
                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "insert into tbl_Users(nGid,strNIC,strFname,strMname,strLname,strDOB,strEducation,strSalary,strAddress,strCity,strState,strCountry,strPincode,strPhone,strCell,strEmail,strPassword,nLevel,nsch_id,dtAddDate,bisDeleted,strImage,userid,nEmployeeNumber) values (@gid,@nic,@fn,@mn,@ln,@dob,@edu,@sal,@adrs,@city,@st,@cntry,@pin,@phn,@cell,@em,@psd,'1','" + Session["nschoolid"] + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False',@img,'" + Session["uid"] + "',@empnum)";
                            cmd.Parameters.AddWithValue("@gid", ddlgroup.SelectedValue);
                            cmd.Parameters.AddWithValue("@empnum", empnum.ToString());
                            cmd.Parameters.AddWithValue("@nic", txttchrnic.Text);
                            cmd.Parameters.AddWithValue("@fn", txtfn.Text);
                            cmd.Parameters.AddWithValue("@mn", txtml.Text);
                            cmd.Parameters.AddWithValue("@ln", txtln.Text);
                            cmd.Parameters.AddWithValue("@dob", txtdob.Text);
                            cmd.Parameters.AddWithValue("@edu", txtedu.Text);
                            cmd.Parameters.AddWithValue("@sal", txtsal.Text);
                            cmd.Parameters.AddWithValue("@adrs", txtadrs.Text);
                            cmd.Parameters.AddWithValue("@city", txtcity.Text);
                            cmd.Parameters.AddWithValue("@st", txtstate.Text);
                            cmd.Parameters.AddWithValue("@cntry", txtcntry.Text);
                            cmd.Parameters.AddWithValue("@pin", txtpcode.Text);
                            cmd.Parameters.AddWithValue("@phn", txtphn.Text);
                            cmd.Parameters.AddWithValue("@cell", txtmobile.Text);
                            cmd.Parameters.AddWithValue("@em", txtem.Text);
                            cmd.Parameters.AddWithValue("@psd", txtpwd.Text);
                            cmd.Parameters.AddWithValue("@img", img);
                            cmd.ExecuteNonQuery();
                            con.Close();
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Employee Added SuccessFully.'); window.location ='AdminManageEmployees.aspx';", true);


                            //}
                            //else
                            //{
                            //    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('please accept the user agreement.');", true);
                            //}
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
           // PopulateData();
           // mvt.ActiveViewIndex = 0;
        }

        protected void ddcl_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 1;
            txttchrnic.Focus();
        }

        protected void btnshow_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["email"] = gvr.Cells[4].Text;
                Session["edit"] = gvr.Cells[1].Text;
                txted.Text = gvr.Cells[5].Text;
                txtsl.Text = gvr.Cells[6].Text;
               
                mvt.ActiveViewIndex = 2;
                txtupemail.Text = gvr.Cells[4].Text;
                txtmb.Text = gvr.Cells[7].Text.Trim();
                txtct.Text = gvr.Cells[9].Text.Trim();
                txtctry.Text = gvr.Cells[10].Text.Trim();
                txtlnm.Text = gvr.Cells[3].Text.Trim();
                txtfnm.Text = gvr.Cells[15].Text.Trim();

                txtnic.Text = gvr.Cells[13].Text.Trim();
                txtdobb.Text = gvr.Cells[14].Text.Trim();
                txtadr.Text = gvr.Cells[11].Text.Trim();

                txts.Text = gvr.Cells[12].Text.Trim();

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

        

        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select nu_id,strfname+' '+strlname as name,strlname,strfname,strEmail,strEducation,strSalary,strPhone,strCity,strCountry,strAddress,strState,strNIC,strDOB from tbl_Users where  (nLevel=1 or nLevel=2) and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False' ";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            return objDs.Tables[0];

        }
        private void BindGrid()
        {
            try
            {
            DataTable dt = GetRecords();
            if (dt.Rows.Count > 0)
            {
                gvsearchclass.DataSource = dt;
                gvsearchclass.DataBind();
            }
            }
            catch (Exception ex)
            {
              //  Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        protected void txtcc_TextChanged(object sender, EventArgs e)
        {
            SearchText();
        }
        private void SearchText()
        {
            try
            {
            DataTable dt = GetRecords();
            DataView dv = new DataView(dt);
            string SearchExpression = null;
            if (!String.IsNullOrEmpty(txtcc.Text))
            {
                SearchExpression = string.Format("{0} '%{1}%'",
                gvsearchclass.SortExpression, txtcc.Text);

            }
            else
            {
                Response.Redirect("AdminManageEmployees.aspx");
            }
            dv.RowFilter = "name like" + SearchExpression;
            gvsearchclass.DataSource = dv;
            gvsearchclass.DataBind();
            }
            catch (Exception ex)
            {
               // Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

        }

        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvsearchclass.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvsearchclass.HeaderRow.FindControl("txtcc");

                if (txtExample.Text != null)
                {
                    string strSearch = txtExample.Text;
                    Regex RegExp = new Regex(strSearch.Replace(" ", "|").Trim(), RegexOptions.IgnoreCase);
                    return RegExp.Replace(InputTxt, new MatchEvaluator(ReplaceKeyWords));
                    RegExp = null;
                }
                else
                    return InputTxt;
            }
            else
            {
                return InputTxt;
            }
        }

        public string ReplaceKeyWords(Match m)
        {
            return "<span class='highlight'>" + m.Value + "</span>";
        }

        private void PopulateData()
        {
            try
            {
            DataTable table = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {

                string sql = "Select nu_id,strfname+' '+strlname as name,strlname,strfname,strEmail,strEducation,strSalary,strPhone,strCity,strCountry,strAddress,strState,strNIC,strDOB from tbl_Users where  (nLevel=1 or nLevel=2) and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False' ";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvsearchclass.DataSource = table;

            gvsearchclass.DataBind();
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

        protected void btnuedit_Click(object sender, EventArgs e)
        {

            mvt.ActiveViewIndex = 3;
        }

        protected void btndelete_Click(object sender, EventArgs e)
        {
            try
            {
            //GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            string del = Session["edit"].ToString();//gvr.Cells[0].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Users set bisDeleted='True', dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nu_id='" + del + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";

            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvt.ActiveViewIndex = 0;
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Employee Deleted SuccessFully.');", true);
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
                Boolean EmailFlag = false;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select nu_id from tbl_Users where strEmail='" + txtupemail.Text.Trim() + "' and bisDeleted='False'";
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    EmailFlag = true;
                    // ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Teacher Email already exist.');", true);
                }
                con.Close();

                Boolean NICFlag = false;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select nu_id from tbl_Users where strNIC='" + txtnic.Text.Trim() + "'   and bisDeleted='False'";
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    NICFlag = true;
                }

                con.Close();

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "update tbl_Users set strEducation=@edu,strSalary=@sal,strAddress=@adrs,strCity=@city,strState=@st,strCountry=@cntry,strCell=@cell, dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nu_id='" + Session["edit"] + "' and nsch_id='" + Session["nschoolid"] + "'  and bisDeleted='False'";
                if (EmailFlag == false)
                {
                    if (NICFlag == false)
                        cmd.CommandText = "update tbl_Users set strEmail='" + txtupemail.Text + "',strNIC='" + txtnic.Text + "',strDOB='" + txtdobb.Text + "',strPhone='" + txtmb.Text + "',strfname='" + txtfnm.Text + "',strlname='" + txtlnm.Text + "',strEducation=@edu,strSalary=@sal,strAddress=@adrs,strCity=@city,strState=@st,strCountry=@cntry,strCell=@cell, dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nu_id='" + Session["edit"] + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
                    else
                        cmd.CommandText = "update tbl_Users set strEmail='" + txtupemail.Text + "',strDOB='" + txtdobb.Text + "',strPhone='" + txtmb.Text + "',strfname='" + txtfnm.Text + "',strlname='" + txtlnm.Text + "',strEducation=@edu,strSalary=@sal,strAddress=@adrs,strCity=@city,strState=@st,strCountry=@cntry,strCell=@cell, dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nu_id='" + Session["edit"] + "' and nsch_id='" + Session["nschoolid"] + "'";
                }
                else
                {
                    if (NICFlag == false)
                        cmd.CommandText = "update tbl_Users set strNIC='" + txtnic.Text + "',strDOB='" + txtdobb.Text + "',strPhone='" + txtmb.Text + "',strfname='" + txtfnm.Text + "',strlname='" + txtlnm.Text + "',strEducation=@edu,strSalary=@sal,strAddress=@adrs,strCity=@city,strState=@st,strCountry=@cntry,strCell=@cell, dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nu_id='" + Session["edit"] + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
                    else
                        cmd.CommandText = "update tbl_Users set strDOB='" + txtdobb.Text + "',strPhone='" + txtmb.Text + "',strfname='" + txtfnm.Text + "',strlname='" + txtlnm.Text + "',strEducation=@edu,strSalary=@sal,strAddress=@adrs,strCity=@city,strState=@st,strCountry=@cntry,strCell=@cell, dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nu_id='" + Session["edit"] + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";

                }
                
                cmd.Parameters.AddWithValue("@edu", txted.Text);
                cmd.Parameters.AddWithValue("@sal", txtsl.Text);
                cmd.Parameters.AddWithValue("@adrs", txtadr.Text);
                cmd.Parameters.AddWithValue("@city", txtct.Text);
                cmd.Parameters.AddWithValue("@st", txts.Text);
                cmd.Parameters.AddWithValue("@cntry", txtctry.Text);
                cmd.Parameters.AddWithValue("@cell", txtmb.Text);

                cmd.ExecuteNonQuery();
                
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Updation SuccessFull.');", true);
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
            PopulateData();
            mvt.ActiveViewIndex = 0;
        }

        protected void btngoback_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 0;
        }
        protected void txttchrnic_TextChanged(object sender, EventArgs e)
        {
            try
            {
                Boolean flag = true;
                for (int i = 0; i < txttchrnic.Text.Length; i++)
                {
                    if (txttchrnic.Text != "")
                    {
                        if (txttchrnic.Text[i] >= 'a' && txttchrnic.Text[i] <= 'z' || txttchrnic.Text[i] >= 'A' && txttchrnic.Text[i] <= 'Z' || txttchrnic.Text[i] == '!' || txttchrnic.Text[i] == '@' || txttchrnic.Text[i] == '#' || txttchrnic.Text[i] == '$' || txttchrnic.Text[i] == '`' || txttchrnic.Text[i] == '~' || txttchrnic.Text[i] == '%' || txttchrnic.Text[i] == '^' || txttchrnic.Text[i] == '&' || txttchrnic.Text[i] == '*' || txttchrnic.Text[i] == '(' || txttchrnic.Text[i] == ')' || txttchrnic.Text[i] == '-' || txttchrnic.Text[i] == '+' || txttchrnic.Text[i] == '_' || txttchrnic.Text[i] == '=' || txttchrnic.Text[i] == ',' || txttchrnic.Text[i] == '.' || txttchrnic.Text[i] == '/' || txttchrnic.Text[i] == '?' || txttchrnic.Text[i] == ';' || txttchrnic.Text[i] == ':' || txttchrnic.Text[i] == '\'' || txttchrnic.Text[i] == '\"' || txttchrnic.Text[i] == '|' || txttchrnic.Text[i] == '\\' || txttchrnic.Text[i] == '/' || txttchrnic.Text[i] == '[' || txttchrnic.Text[i] == ']' || txttchrnic.Text[i] == '{' || txttchrnic.Text[i] == '}')
                        {

                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalide Entry.');", true);
                            txttchrnic.Text = "";
                            txttchrnic.Focus();
                            flag = false;
                            break;
                        }
                    }
                }
                if (txttchrnic.Text != "" && flag)
                {
                    if (txttchrnic.Text.Length == 13)
                    {
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "select nu_id from tbl_Users where strNIC='" + txttchrnic.Text + "' and bisDeleted=0";
                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            dr.Read();
                            // txtgfn.Text = dr["strfname"].ToString();
                            //txtgln.Text = dr["strlname"].ToString();
                            //txtem.Visible = false;
                            //txtpwd.Visible = false;
                            //txtrepass.Visible = false;
                            //txtgfn.Visible = false;
                            //txtgln.Visible = false;
                            //txtgnic.Visible = false;
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('NIC Already Exists.');", true);
                            txttchrnic.Focus();
                            txttchrnic.Text = "";
                            ////////////////// //txtstnic.Focus();
                            //txtsfn.Focus();
                        }
                        else
                        {
                            txtfn.Focus();
                            // txtgnic.Text = "";
                            // ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This number has already been assigned.');", true);
                        }
                        con.Close();
                    }
                    else
                    {
                        txttchrnic.Focus();
                        txttchrnic.Text = "";
                        txttchrnic.Visible = true;
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Enter 13 Digit NIC Number.');", true);
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

        protected void gvsearchclass_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvsearchclass.PageIndex = e.NewPageIndex;
                PopulateData();
            }
            catch (Exception) { }
        }
        //////////////////////////////////

    }
}