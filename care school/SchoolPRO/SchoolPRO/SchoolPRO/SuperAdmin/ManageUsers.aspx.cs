using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.IO;

namespace SchoolPRO.SuperAdmin
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                BindGrid();

            }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btntreg_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlgroup.SelectedItem.ToString() != "--Select Group--" && ddlschool.SelectedItem.ToString() != "--Select School--" && ddsex.SelectedItem.ToString() != "--Select Gender--")
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
                        cmd.CommandText = "select nu_id from tbl_Users where strEmail='" + txtem.Text + "' and bisDeleted='False' ";
                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Teacher Email already exist.');", true);
                            con.Close();
                        }
                        else
                        {
                            con.Close();
                            string img = "";
                            //if (chqacpt.Checked == true)
                            //{


                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "insert into tbl_Users(nGid,userid,strGender,strNIC,strFname,strLname,strDOB,strEducation,strSalary,strAddress,strCity,strState,strCountry,strPincode,strPhone,strCell,strEmail,strPassword,nLevel,nsch_id,dtAddDate,bisDeleted,strImage) values ('" + ddlgroup.SelectedValue + "',@uid,'" + ddsex.SelectedValue + "',@nic,@fn,@ln,@dob,@edu,@sal,@adrs,@city,@st,@cntry,@pin,@phn,@cell,@em,@psd,'1','" + ddlschool.SelectedValue + "',convert(date,SYSDATETIME()),'False',@img)";
                            cmd.Parameters.AddWithValue("@fn", txtfn.Text.Trim());
                            cmd.Parameters.AddWithValue("@nic", txttchrnic.Text.Trim());

                            //cmd.Parameters.AddWithValue("@mn", txtml.Text);
                            cmd.Parameters.AddWithValue("@ln", txtln.Text.Trim());
                            cmd.Parameters.AddWithValue("@dob", "");//txtdob.Text.Trim());
                            cmd.Parameters.AddWithValue("@edu", "");//txtedu.Text.Trim());
                            cmd.Parameters.AddWithValue("@sal", "");//txtsal.Text.Trim());
                            cmd.Parameters.AddWithValue("@adrs", "");//txtadrs.Text.Trim());
                            cmd.Parameters.AddWithValue("@city", "");//txtcity.Text.Trim());
                            cmd.Parameters.AddWithValue("@st", "");//txtstate.Text.Trim());
                            cmd.Parameters.AddWithValue("@cntry", "");// txtcntry.Text.Trim());
                            cmd.Parameters.AddWithValue("@pin", "");//txtpcode.Text.Trim());
                            cmd.Parameters.AddWithValue("@phn", txtmobile.Text.Trim());//txtphn.Text.Trim());
                            cmd.Parameters.AddWithValue("@cell", txtmobile.Text.Trim());
                            cmd.Parameters.AddWithValue("@em", txtem.Text.Trim());
                            cmd.Parameters.AddWithValue("@psd", txtpwd.Text.Trim());
                            cmd.Parameters.AddWithValue("@img", img);
                            cmd.Parameters.AddWithValue("@uid", Session["uid"]);
                            cmd.ExecuteNonQuery();
                            con.Close();
                            txtfn.Text = "";
                            //txtml.Text = "";
                            txtln.Text = "";
                            //txtdob.Text = "";
                            //txtedu.Text = "";
                            //txtsal.Text = "";
                            //txtadrs.Text = "";
                            //txtcity.Text = "";
                            //txtstate.Text = "";
                            //txtcntry.Text = "";
                            //txtpcode.Text = "";
                            //txtphn.Text = "";
                            txtmobile.Text = "";
                            txtem.Text = "";
                            txtpwd.Text = "";
                            //Response.Redirect("AdminAddTeacher.aspx");        
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('User has been registered successfully.'); window.location = 'ManageUsers.aspx';", true);
                            // PopulateData();
                            // mvt.ActiveViewIndex = 0;


                            // }
                            //else
                            //{
                            //    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Accept the Agreement.');", true);
                            //}
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ex.ToString();
            }



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
                //GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                //Session["email"] = gvr.Cells[4].Text.Trim();
                //Session["edit"] = gvr.Cells[1].Text.Trim();
                //txtupemail.Text = gvr.Cells[4].Text.Trim();
                //txted.Text = gvr.Cells[5].Text.Trim();
                //txtsl.Text = gvr.Cells[6].Text.Trim();
                //txtmb.Text = gvr.Cells[7].Text.Trim();
                //txtct.Text = gvr.Cells[9].Text.Trim();
                //txtctry.Text = gvr.Cells[10].Text.Trim();
                //txtlnm.Text = gvr.Cells[3].Text.Trim();
                //txtfnm.Text = gvr.Cells[15].Text.Trim();

                //txtnic.Text = gvr.Cells[13].Text.Trim();
                //txtdobb.Text = gvr.Cells[14].Text.Trim();
                //txtadr.Text = gvr.Cells[11].Text.Trim();

                //txts.Text = gvr.Cells[12].Text.Trim();
                //mvt.ActiveViewIndex = 2;

            }
            catch (Exception ex)
            {
                ex.ToString();
            }
        }



        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select nu_id,strfname+' '+strlname as name,strlname,strfname,strEmail,strEducation,strSalary,strPhone,strCity,strCountry,strAddress,strState,strNIC,strDOB from tbl_Users where bisDeleted='False' and nLevel='1'";
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
                Response.Redirect("Error.aspx");
            }
        }
        protected void txtcc_TextChanged(object sender, EventArgs e)
        {
            SearchText();
        }
        private void SearchText()
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
                Response.Redirect("ManageUsers.aspx");
            }
            dv.RowFilter = "name like" + SearchExpression;
            gvsearchclass.DataSource = dv;
            gvsearchclass.DataBind();

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

            DataTable table = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {

                string sql = "Select nu_id,strfname+' '+strlname as name,strlname,strfname,strEmail,strEducation,strSalary,strPhone,strCity,strCountry,strAddress,strState,strNIC,strDOB from tbl_Users where bisDeleted='False' and nLevel='1'";

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

        protected void btnuedit_Click(object sender, EventArgs e)
        {
            //lbladr.Text

            //lblcit.Text lblst.Text  lblcnt.Text
            //txtadr.Text = lbladr.Text;
            //txtct.Text = lblcit.Text;
            //txtctry.Text = lblcnt.Text;
            mvt.ActiveViewIndex = 3;
        }

        protected void btndelete_Click(object sender, EventArgs e)
        {
            //con.Open();
            //cmd.Connection = con;
            //cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "Select nu_id from tbl_ClassIncharge where nu_id='" + Session["edit"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";

            //dr = cmd.ExecuteReader();

            //if (dr.HasRows)
            //{
            //    con.Close();
            //    ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "alert('This Teacher is a Class Teacher (Remove him as a class Teacher) ');", true);
            //}
            //else
            //{
            //    con.Close();
            //    //con.Open();
            //    //cmd.Connection = con;
            //    //cmd.CommandType = CommandType.Text;
            //    //cmd.CommandText = "Select nu_id from tbl_ClassIncharge where nu_id='" + Session["edit"] + "' and bisDeleted='False'";

            //    //dr = cmd.ExecuteReader();
            //    //con.Close();
            //    //if (dr.HasRows)
            //    //{
            //    //    ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "alert('This Teacher is a Class Teacher (Remove him as a class Teacher) ');", true);
            //    //}
            //    //else
            //    //{

            //    con.Open();
            //    cmd.Connection = con;
            //    cmd.CommandType = CommandType.Text;
            //    cmd.CommandText = "update tbl_Users set bisDeleted='True', dtDeleteDate=convert(date, SYSDATETIME()) where nu_id='" + Session["edit"] + "' and nsch_id='" + Session["nschoolid"] + "'";

            //    cmd.ExecuteNonQuery();
            //    con.Close();
            //    PopulateData();
            //    mvt.ActiveViewIndex = 0;
                //}
            //}
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            try
            {
                //Boolean EmailFlag = false;
                //con.Open();
                //cmd.Connection = con;
                //cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "select nu_id from tbl_Users where strEmail='" + txtupemail.Text.Trim() + "' and bisDeleted='False' and nlevel='2' and nsch_id='" + Session["nschoolid"] + "'";
                //dr = cmd.ExecuteReader();
                //if (dr.HasRows)
                //{
                //    EmailFlag = true;
                //    // ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Teacher Email already exist.');", true);
                //}
                //con.Close();

                //Boolean NICFlag = false;
                //con.Open();
                //cmd.Connection = con;
                //cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "select nu_id from tbl_Users where strNIC='" + txtnic.Text.Trim() + "'   and bisDeleted='False' and nlevel='2' and nsch_id='" + Session["nschoolid"] + "'";
                //dr = cmd.ExecuteReader();
                //if (dr.HasRows)
                //{
                //    NICFlag = true;
                //}

                //con.Close();

                //con.Open();
                //cmd.Connection = con;
                //cmd.CommandType = CommandType.Text;


                //if (EmailFlag == false)
                //{
                //    if (NICFlag == false)
                //        cmd.CommandText = "update tbl_Users set strEmail='" + txtupemail.Text + "',strNIC='" + txtnic.Text + "',strDOB='" + txtdobb.Text + "',strPhone='" + txtmb.Text + "',strfname='" + txtfnm.Text + "',strlname='" + txtlnm.Text + "',strEducation=@edu,strSalary=@sal,strAddress=@adrs,strCity=@city,strState=@st,strCountry=@cntry,strCell=@cell, dtAddDate=convert(date, SYSDATETIME()) where nu_id='" + Session["edit"] + "' and nsch_id='" + Session["nschoolid"] + "'";
                //    else
                //        cmd.CommandText = "update tbl_Users set strEmail='" + txtupemail.Text + "',strDOB='" + txtdobb.Text + "',strPhone='" + txtmb.Text + "',strfname='" + txtfnm.Text + "',strlname='" + txtlnm.Text + "',strEducation=@edu,strSalary=@sal,strAddress=@adrs,strCity=@city,strState=@st,strCountry=@cntry,strCell=@cell, dtAddDate=convert(date, SYSDATETIME()) where nu_id='" + Session["edit"] + "' and nsch_id='" + Session["nschoolid"] + "'";
                //}
                //else
                //{
                //    if (NICFlag == false)
                //        cmd.CommandText = "update tbl_Users set strNIC='" + txtnic.Text + "',strDOB='" + txtdobb.Text + "',strPhone='" + txtmb.Text + "',strfname='" + txtfnm.Text + "',strlname='" + txtlnm.Text + "',strEducation=@edu,strSalary=@sal,strAddress=@adrs,strCity=@city,strState=@st,strCountry=@cntry,strCell=@cell, dtAddDate=convert(date, SYSDATETIME()) where nu_id='" + Session["edit"] + "' and nsch_id='" + Session["nschoolid"] + "'";
                //    else
                //        cmd.CommandText = "update tbl_Users set strDOB='" + txtdobb.Text + "',strPhone='" + txtmb.Text + "',strfname='" + txtfnm.Text + "',strlname='" + txtlnm.Text + "',strEducation=@edu,strSalary=@sal,strAddress=@adrs,strCity=@city,strState=@st,strCountry=@cntry,strCell=@cell, dtAddDate=convert(date, SYSDATETIME()) where nu_id='" + Session["edit"] + "' and nsch_id='" + Session["nschoolid"] + "'";

                //}
                //cmd.Parameters.AddWithValue("@edu", txted.Text);
                //cmd.Parameters.AddWithValue("@sal", txtsl.Text);
                //cmd.Parameters.AddWithValue("@adrs", txtadr.Text);
                //cmd.Parameters.AddWithValue("@city", txtct.Text);
                //cmd.Parameters.AddWithValue("@st", txts.Text);
                //cmd.Parameters.AddWithValue("@cntry", txtctry.Text);
                //cmd.Parameters.AddWithValue("@cell", txtmb.Text);


                //cmd.ExecuteNonQuery();
                //con.Close();

            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            //PopulateData();
            //mvt.ActiveViewIndex = 0;
        }

        protected void btnclinch_Click(object sender, EventArgs e)
        {
            //Response.Redirect("AdminManageClassIncharge.aspx");
        }

        protected void btntsbj_Click(object sender, EventArgs e)
        {
           // Response.Redirect("AdminManageTeacherSubject.aspx");
        }

        protected void btngoback_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 0;
        }

        protected void gvsearchclass_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvsearchclass.PageIndex = e.NewPageIndex;
            PopulateData();
        }

        protected void txttchrnic_TextChanged(object sender, EventArgs e)
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
                    cmd.CommandText = "select nu_id from tbl_Users where strNIC='" + txttchrnic.Text + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
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

        protected void txtphn_TextChanged(object sender, EventArgs e)
        {
            //Boolean flag = true;
            //for (int i = 0; i < txtphn.Text.Length; i++)
            //{
            //    if (txtphn.Text != "")
            //    {
            //        if (txtphn.Text[i] >= 'a' && txtphn.Text[i] <= 'z' || txtphn.Text[i] >= 'A' && txtphn.Text[i] <= 'Z' || txtphn.Text[i] == '!' || txtphn.Text[i] == '@' || txtphn.Text[i] == '#' || txtphn.Text[i] == '$' || txtphn.Text[i] == '`' || txtphn.Text[i] == '~' || txtphn.Text[i] == '%' || txtphn.Text[i] == '^' || txtphn.Text[i] == '&' || txtphn.Text[i] == '*' || txtphn.Text[i] == '(' || txtphn.Text[i] == ')' || txtphn.Text[i] == '-' || txtphn.Text[i] == '+' || txtphn.Text[i] == '_' || txtphn.Text[i] == '=' || txtphn.Text[i] == ',' || txtphn.Text[i] == '.' || txtphn.Text[i] == '/' || txtphn.Text[i] == '?' || txtphn.Text[i] == ';' || txtphn.Text[i] == ':' || txtphn.Text[i] == '\'' || txtphn.Text[i] == '\"' || txtphn.Text[i] == '|' || txtphn.Text[i] == '\\' || txtphn.Text[i] == '/' || txtphn.Text[i] == '[' || txtphn.Text[i] == ']' || txtphn.Text[i] == '{' || txtphn.Text[i] == '}')
            //        {

            //            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalide Entry.');", true);
            //            txtphn.Text = "";
            //            txtphn.Focus();
            //            flag = false;
            //            break;
            //        }
            //    }
            //}
            //if (txtphn.Text != "" && flag)
            //{
            //    if (txtphn.Text.Length <= 11 && txtphn.Text.Length >= 9)
            //    {
            //        txtmobile.Focus();
            //    }
            //    else
            //    {
            //        txtphn.Text = "";
            //        txtphn.Focus();
            //        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Enter 11  or 9 Digit Number.');", true);
            //    }
            //}


        }

        protected void txtmobile_TextChanged(object sender, EventArgs e)
        {
            Boolean flag = true;
            for (int i = 0; i < txtmobile.Text.Length; i++)
            {
                if (txtmobile.Text != "")
                {
                    if (txtmobile.Text[i] >= 'a' && txtmobile.Text[i] <= 'z' || txtmobile.Text[i] >= 'A' && txtmobile.Text[i] <= 'Z' || txtmobile.Text[i] == '!' || txtmobile.Text[i] == '@' || txtmobile.Text[i] == '#' || txtmobile.Text[i] == '$' || txtmobile.Text[i] == '`' || txtmobile.Text[i] == '~' || txtmobile.Text[i] == '%' || txtmobile.Text[i] == '^' || txtmobile.Text[i] == '&' || txtmobile.Text[i] == '*' || txtmobile.Text[i] == '(' || txtmobile.Text[i] == ')' || txtmobile.Text[i] == '-' || txtmobile.Text[i] == '+' || txtmobile.Text[i] == '_' || txtmobile.Text[i] == '=' || txtmobile.Text[i] == ',' || txtmobile.Text[i] == '.' || txtmobile.Text[i] == '/' || txtmobile.Text[i] == '?' || txtmobile.Text[i] == ';' || txtmobile.Text[i] == ':' || txtmobile.Text[i] == '\'' || txtmobile.Text[i] == '\"' || txtmobile.Text[i] == '|' || txtmobile.Text[i] == '\\' || txtmobile.Text[i] == '/' || txtmobile.Text[i] == '[' || txtmobile.Text[i] == ']' || txtmobile.Text[i] == '{' || txtmobile.Text[i] == '}')
                    {

                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalide Entry.');", true);
                        txtmobile.Text = "";
                        txtmobile.Focus();
                        flag = false;
                        break;
                    }
                }
            }
            if (txtmobile.Text != "" && flag)
            {
                if (txtmobile.Text.Length == 11)
                {
                    txtem.Focus();
                }
                else
                {
                    txtmobile.Text = "";
                    txtmobile.Focus();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Enter 11 Digit Number.');", true);
                }
            }

        }
    }
}