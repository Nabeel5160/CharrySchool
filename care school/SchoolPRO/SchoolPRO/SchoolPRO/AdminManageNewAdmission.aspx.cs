using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;

namespace SchoolPRO
{
    public partial class AdminManageNewAdmission : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindClass();
                txtgnic.Visible = false;
            }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;

        void GenrerateStudentNumber()
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select strStudentNum from  tbl_Enrollment where ne_id=(select Max(ne_id) as Id from tbl_Enrollment where  nsc_id=(select nsc_id from tbl_Section where strSection='" + ddsec.Text + "' and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted='False' and nsch_id= '" + Session["nschoolid"] + "')and bisDeleted='False' and nsch_id= '" + Session["nschoolid"] + "') and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted='False' and nsch_id= '" + Session["nschoolid"] + "') and bisDeleted='False' and nsch_id= '" + Session["nschoolid"] + "')";
                //  cmd.CommandText = "select strStudentNum from  tbl_StudentNumber where ne_id=(select Max(ne_id) as Id from tbl_StudentNumber where  nsc_id=(select nsc_id from tbl_Section where strSection='" + ddsec.Text + "' and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted='False')and bisDeleted='False') and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted='False') and bisDeleted='False')";
                //cmd.Parameters.AddWithValue("@reg1", tb.Text);
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    string stnum = dr["strStudentNum"].ToString();
                    //stnum = "10B-100";
                    int dashe = stnum.IndexOf('-');
                    string rollnumber = stnum.Substring(dashe + 1, stnum.Length - (dashe + 1));
                    string classSection = stnum.Substring(0, dashe);
                    int rollnumber2 = Convert.ToInt32(rollnumber);
                    rollnumber2++;

                    string NewSTNUM = classSection + "-" + rollnumber2.ToString();

                    txtstnum.Text = NewSTNUM;
                    //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('The Student Verification Number already exist.');", true);
                }
                else
                {
                    string stnum = ddcl.Text + ddsec.Text + "-" + "1";
                    txtstnum.Text = stnum;
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
        protected void btnreset_Click(object sender, EventArgs e)
        {
            //Response.Redirect("AdminDashBo");
        }

        public void bindClass()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT [strClass],[nc_id] FROM [tbl_Class] where bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddcl.Items.Clear();
                ddcl.Items.Add("----- Select Class-----");
                ddcl.DataSource = dr;
                ddcl.DataTextField = "strClass";
                ddcl.DataValueField = "nc_id";

                ddcl.DataBind();
                con.Close();
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

        public void bindSection()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT [nsc_id],[strSection] FROM [tbl_Section] where nc_id=('" + ddcl.SelectedItem.Value + "') and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddsec.Items.Clear();
                ddsec.Items.Add("----- Select Section-----");
                ddsec.DataSource = dr;
                ddsec.DataTextField = "strSection";
                ddsec.DataValueField = "nsc_id";

                ddsec.DataBind();
                con.Close();
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
        public void concession_student()
        {

            // retrieving concession type and ammount
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * from tbl_Concession where strConcTitle='" + txtdisc.Text + "'";
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                con.Close();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;

                cmd.CommandText = "insert into tbl_ConcessionStudent(nStd_id,nConc_id,nc_id,nsc_id,userid,nsch_id,dtAddDate,bisDeleted)values((select max(ne_id) from tbl_Enrollment),(select nConc_id from tbl_Concession where strConcTitle='" + txtdisc.Text + "' and bisDeleted='False'),('" + ddcl.SelectedItem.Value+ "'),('" + ddsec.SelectedItem.Value+ "'),@uid,@schid,convert(date,sysdatetime()),'False')";

                cmd.Parameters.AddWithValue("@uid", Session["uid"]);
                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);
                cmd.ExecuteNonQuery();
                cmd.Parameters.Clear();
                con.Close();
            }
            else
            {
                con.Close();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into tbl_Concession(strConcTitle,strConcCode,nuserid,nConcPer,nsch_id,dtAddDate,bisDeleted)values(@ctitl,@code,@uid,@concamnt,@schid,convert(date,sysdatetime()),'False')";
                cmd.Parameters.AddWithValue("@ctitl", txtdisc.Text);
                cmd.Parameters.AddWithValue("@code", txtdisc.Text);
                cmd.Parameters.AddWithValue("@concamnt", txtdisc.Text);
                cmd.Parameters.AddWithValue("@uid", Session["uid"]);
                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);
                cmd.ExecuteNonQuery();
                cmd.Parameters.Clear();
                con.Close();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;

                cmd.CommandText = "insert into tbl_ConcessionStudent(nStd_id,nConc_id,nc_id,nsc_id,userid,nsch_id,dtAddDate,bisDeleted)values((select max(ne_id) from tbl_Enrollment),(select max(nConc_id) from tbl_Concession),('" + ddcl.SelectedItem.Value+ "'),('" + ddsec.SelectedItem.Value+ "'),@uid,@schid,convert(date,sysdatetime()),'False')";

                cmd.Parameters.AddWithValue("@uid", Session["uid"]);
                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);
                cmd.ExecuteNonQuery();
                cmd.Parameters.Clear();
                con.Close();
            }

        }
        protected void btnreg_Click(object sender, EventArgs e)
        {
            txtstnum.Text = "";
            Boolean addflag = false;
            try
            {
                //con.Open();
                //cmd.Connection = con;
                //cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "select stremail from tbl_Enrollment where strAdmissionNumber='" + txtadmnumber.Text + "'";
                //dr = cmd.ExecuteReader();
                //if (dr.HasRows)
                //{
                //    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Admission Number already exist.');", true);

                //}
                //else
                //{
                //    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select nsc_id from tbl_Enrollment where strStudentNum=@reg1 and nsc_id=(select nsc_id from tbl_Section where strSection='" + lblSection + "' and nc_id=('"+ddcl.SelectedItem.Value+"')and bisDeleted='False' and nsch_id= '" + Session["nschoolid"] + "') and bisDeleted='False' and nsch_id= '" + Session["nschoolid"] + "'";
                    cmd.Parameters.AddWithValue("@reg1", txtstnum.Text);
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Sorry ,Student Roll Number already Exists Please Select Class and Section Again for Re_assigning. Thank You');", true);
                    }
                    else
                    {
                        con.Close();


                        if (txtnic.Text != "")
                        {
                            if (txtnic.Text.Length <= 13)
                            {
                                //con.Open();
                                //cmd.Connection = con;
                                //cmd.CommandType = CommandType.Text;
                                //cmd.CommandText = "select stremail from tbl_Enrollment where stremail='" + txtsemail.Text + "' and bisDeleted='False'";
                                //dr = cmd.ExecuteReader();
                                //if (dr.HasRows)
                                //{
                                //    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Email already exist.');", true);
                                //}
                                //else
                                //{
                                //    con.Close();
                                    con.Open();
                                    cmd.Connection = con;
                                    cmd.CommandType = CommandType.Text;
                                    cmd.CommandText = "select stremail from tbl_Enrollment where strNIC='" + txtstnic.Text + "' and bisDeleted='False'";
                                    //dr = cmd.ExecuteReader();
                                    //if (dr.HasRows)
                                    //{
                                    //    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('NIC already exist.');", true);
                                    //}
                                    //else
                                    //{
                                    con.Close();
                                    int uid = 0;
                                    string s_img = "";

                                    if (fustimg.HasFile)
                                    {
                                        s_img = @"~\Uploaded-Files\" + Path.GetFileName(fustimg.PostedFile.FileName);
                                        fustimg.SaveAs(Server.MapPath(s_img));
                                    }
                                    else
                                    {
                                        if (ddsex.SelectedItem.ToString() == "Male")
                                        {
                                            s_img = @"~\Uploaded-Files\male.jpg";
                                            //fustimg.SaveAs(Server.MapPath(s_img));
                                        }
                                        else if (ddsex.SelectedItem.ToString() == "Female")
                                        {
                                            s_img = @"~\Uploaded-Files\female.jpg";
                                        }
                                    }
                                    con.Open();
                                    cmd.Connection = con;
                                    cmd.CommandType = CommandType.Text;
                                    cmd.CommandText = "select MAX(bRegisteredNum) as regnumber from tbl_Enrollment";
                                    dr = cmd.ExecuteReader();
                                    string regnum = "";
                                    Int64 regnumber = 0;
                                    if (dr.Read())
                                    {
                                        regnum = dr["regnumber"].ToString();
                                    }
                                    if (regnum == "")
                                    {
                                        regnum = "0";
                                        regnumber = Convert.ToInt64(regnum);
                                        regnumber += 1;
                                    }
                                    else
                                    {
                                        regnumber = Convert.ToInt64(regnum);
                                        regnumber += 1;
                                    }
                                    con.Close();
                                    con.Open();
                                    cmd.Connection = con;
                                    cmd.CommandType = CommandType.Text;
                                    cmd.CommandText = "insert into tbl_Enrollment(strStatus,bRegisteredNum,userid,strNIC,dtVerifyDate,nu_id,nfee_id,dtEn_Date,strFname,strLname,nc_id,nsc_id,strShift,strDOB,strBirthPlace,strNationality,strMotherlang,strReligion,strGender,strPhAddress,strPrAddress,strCity,strState,strCountry,nPinCode,strPhone,strMobile,strEmail,strPassword,strImage,nsch_id,dtAddDate,bisDeleted) values ('Pending','" + regnumber + "','" + Session["uid"] + "',@stnic,CONVERT(VARCHAR(10), GETDATE(), 105 ),(select nu_id from tbl_Users where strNIC='" + txtnic.Text + "' and nlevel=3 and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'),(select nfee_id from tbl_Fee where nc_id=('"+ddcl.SelectedItem.Value+"') and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'),CONVERT(VARCHAR(10), GETDATE(), 105 ),@fn,@ln,('"+ddcl.SelectedItem.Value+"'),('" + ddsec.SelectedItem.Value + "'),@shft,@dob,@bplace,@nationality,@mlng,@relg,@gen,@phadrs,@pradrs,@city,@st,@cntry,@pin,@phn,@emphn,@em,@psd,@img,'" + Session["nschoolid"] + "','" + txtadmsndate.Text + "','True')";
                                    cmd.Parameters.AddWithValue("@stnic", txtstnic.Text);
                                    cmd.Parameters.AddWithValue("@fn", txtsfn.Text);
                                    //cmd.Parameters.AddWithValue("@admnum", txtadmnumber.Text);
                                    cmd.Parameters.AddWithValue("@ln", txtsln.Text);
                                    //cmd.Parameters.AddWithValue("@clnm", ddcl.Text);
                                    cmd.Parameters.AddWithValue("@shft", ddshft.Text);
                                    cmd.Parameters.AddWithValue("@dob", txtdob.Text);
                                    cmd.Parameters.AddWithValue("@gen", ddsex.Text);
                                    cmd.Parameters.AddWithValue("@phadrs", txtadrs.Text);
                                    cmd.Parameters.AddWithValue("@pradrs", txtadrs.Text);
                                    cmd.Parameters.AddWithValue("@city", txtcity.Text);
                                    cmd.Parameters.AddWithValue("@st", txtstate.Text);
                                    cmd.Parameters.AddWithValue("@cntry", txtcntry.Text);
                                    cmd.Parameters.AddWithValue("@pin", txtpcode.Text);
                                    cmd.Parameters.AddWithValue("@phn", txtphn.Text);
                                    cmd.Parameters.AddWithValue("@emphn", txtmobile.Text);
                                    cmd.Parameters.AddWithValue("@em", txtsemail.Text);
                                    cmd.Parameters.AddWithValue("@psd", txtspwd.Text);
                                    cmd.Parameters.AddWithValue("@bplace", txtbplace.Text);
                                    cmd.Parameters.AddWithValue("@nationality", txtnt.Text);
                                    cmd.Parameters.AddWithValue("@mlng", txtlng.Text);
                                    cmd.Parameters.AddWithValue("@relg", txtrelg.Text);
                                    cmd.Parameters.AddWithValue("@img", s_img);
                                    cmd.ExecuteNonQuery();
                                    cmd.Parameters.Clear();
                                    con.Close();

                                    //send sms code....


                                    //string number = txtmobile.Text;
                                    //string message = "Congratulations..!! You Child has been enrolled. Student Name:'" + txtsfn.Text + "' '" + txtsln.Text + "' Roll #:'" + txtstnum.Text + "' in Class:'" + ddcl.Text + "' Section:'" + ddsec.Text + "' ";
                                    //////////////////////////////////////////////////////////////////////////////////////////////

                                    //string ozSURL = "http://127.0.0.1"; //where Ozeki NG SMS Gateway is running
                                    //string ozSPort = "9501"; //port number where Ozeki NG SMS Gateway is listening
                                    //string ozUser = HttpUtility.UrlEncode("admin"); //username for successful login
                                    //string ozPassw = HttpUtility.UrlEncode("admin"); //user's password
                                    //string ozMessageType = "SMS:TEXT"; //type of message
                                    //string ozRecipients = HttpUtility.UrlEncode(number); //who will get the message
                                    //string ozMessageData = HttpUtility.UrlEncode(message); //body of message

                                    //string createdURL = ozSURL + ":" + ozSPort + "/httpapi" +
                                    //    "?action=sendMessage" +
                                    //    "&username=" + ozUser +
                                    //    "&password=" + ozPassw +
                                    //    "&messageType=" + ozMessageType +
                                    //    "&recipient=" + ozRecipients +
                                    //    "&messageData=" + ozMessageData;


                                    ////Create the request and send data to Ozeki NG SMS Gateway Server by HTTP connection
                                    //HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(createdURL);

                                    ////Get response from Ozeki NG SMS Gateway Server and read the answer
                                    //HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();
                                    //System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
                                    //string responseString = respStreamReader.ReadToEnd();
                                    //respStreamReader.Close();
                                    //myResp.Close();

                                    // txtgfn.Text = "";
                                    txtstnum.Text = "";
                                    txtsfn.Text = "";
                                    txtsln.Text = "";
                                    //txtml.Text = "";
                                    // txtgln.Text = "";
                                    txtdob.Text = "";
                                    txtmobile.Text = "";
                                    //  txtem.Text = "";
                                    txtpwd.Text = "";
                                    txtsemail.Text = "";
                                    txtspwd.Text = "";

                                    txtstnic.Focus();

                                    txtnic.Visible = true;
                                    addflag = true;
                                    if (txtdisc.Text == "" || txtdisc.Text == "0")
                                    {
                                    }
                                    else
                                    {
                                        concession_student();
                                    }
                                    // Response.Redirect("AdminManageP-C.aspx");
                                    //  Response.Redirect(Request.RawUrl);
                                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Your Child has been enrolled.'); window.location = 'AdminManageNewAdmission.aspx';", true);
                                //}
                            }

                            else
                            {
                                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Enter All Digits Of Your NIC ,If you have?.');", true);

                            }
                        }
                        else
                        {
                            try
                            {

                                //con.Open();
                                //cmd.Connection = con;
                                //cmd.CommandType = CommandType.Text;
                                //cmd.CommandText = "select nu_id from tbl_Users where stremail='" + txtem.Text + "'   and bisDeleted='False'";
                                //dr = cmd.ExecuteReader();
                                //if (dr.HasRows)
                                //{
                                //    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Parent Email  already exist.');", true);
                                //}
                                //else
                                //{
                                //    con.Close();
                                    con.Open();
                                    cmd.Connection = con;
                                    cmd.CommandType = CommandType.Text;
                                    cmd.CommandText = "select nu_id from tbl_Users where strNIC='" + txtgnic.Text + "'   and bisDeleted='False'";
                                    dr = cmd.ExecuteReader();
                                    if (dr.HasRows)
                                    {
                                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('NIC  already exist.');", true);
                                    }
                                    else
                                    {
                                        con.Close();
                                        string d_img = "", s_img = "";
                                        // parent registration

                                        //d_img = @"~\Uploaded-Files\" + Path.GetFileName(fstimg.PostedFile.FileName);
                                        //fstimg.SaveAs(Server.MapPath(d_img));
                                        d_img = @"~\Uploaded-Files\TransParentDayLogo.jpg";

                                        con.Open();
                                        cmd.Connection = con;
                                        cmd.CommandType = CommandType.Text;
                                        cmd.CommandText = "insert into tbl_Users(strGdianNIC,strGdianName,nsch_id,userid,strNIC,strImage,strfname,strlname,strRelation,strAddress,strCity,strState,strPincode,strCountry,strPhone,strCell,strEmail,strPassword,nlevel,dtAddDate,bisDeleted) values (@gardnic,@gardname,'" + Session["nschoolid"] + "','" + Session["uid"] + "','" + txtgnic.Text + "',@dimg,@fn,@ln,@rel,@adrs,@city,@st,@pin,@cntry,@phn,@cell,@em,@psd,'3',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                                        cmd.Parameters.AddWithValue("@fn", txtgfn.Text);
                                        //cmd.Parameters.AddWithValue("@mn", txtml.Text);
                                        cmd.Parameters.AddWithValue("@ln", txtgln.Text);
                                        cmd.Parameters.AddWithValue("@gardname", txtgardname.Text);
                                        cmd.Parameters.AddWithValue("@gardnic", txtgardnic.Text);
                                        cmd.Parameters.AddWithValue("@rel", ddgaurd.Text);
                                        cmd.Parameters.AddWithValue("@adrs", txtadrs.Text);
                                        cmd.Parameters.AddWithValue("@city", txtcity.Text);
                                        cmd.Parameters.AddWithValue("@st", txtstate.Text);
                                        cmd.Parameters.AddWithValue("@pin", txtpcode.Text);
                                        cmd.Parameters.AddWithValue("@cntry", txtcntry.Text);
                                        cmd.Parameters.AddWithValue("@phn", txtphn.Text);
                                        cmd.Parameters.AddWithValue("@cell", txtmobile.Text);
                                        cmd.Parameters.AddWithValue("@em", txtem.Text);
                                        cmd.Parameters.AddWithValue("@psd", txtpwd.Text);
                                        cmd.Parameters.AddWithValue("@dimg", d_img);
                                        cmd.ExecuteNonQuery();
                                        cmd.Parameters.Clear();
                                        con.Close();
                                        // ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Parent Registered Successfully.');", true);

                                        //con.Open();
                                        //cmd.Connection = con;
                                        //cmd.CommandType = CommandType.Text;
                                        //cmd.CommandText = "select ne_id from tbl_Enrollment where stremail='" + txtsemail.Text + "' and bisDeleted='False'";
                                        //dr = cmd.ExecuteReader();
                                        //if (dr.HasRows)
                                        //{
                                        //    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Student Email already exist.');", true);
                                        //}
                                        //else
                                        //{
                                        //    con.Close();
                                        //    con.Close();
                                            con.Open();
                                            cmd.Connection = con;
                                            cmd.CommandType = CommandType.Text;
                                            cmd.CommandText = "select ne_id from tbl_Enrollment where strNIC='" + txtstnic.Text + "' and bisDeleted='False'";
                                            //dr = cmd.ExecuteReader();
                                            //if (dr.HasRows)
                                            //{
                                            //    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('NIC already exist.');", true);
                                            //}
                                            //else
                                            {
                                                con.Close();
                                                //child registration
                                                if (fustimg.HasFile)
                                                {
                                                    s_img = @"~\Uploaded-Files\" + Path.GetFileName(fustimg.PostedFile.FileName);
                                                    fustimg.SaveAs(Server.MapPath(s_img));
                                                }
                                                else
                                                {
                                                    if (ddsex.SelectedItem.ToString() == "Male")
                                                    {
                                                        s_img = @"~\Uploaded-Files\male.jpg";
                                                        //fustimg.SaveAs(Server.MapPath(s_img));
                                                    }
                                                    else if (ddsex.SelectedItem.ToString() == "Female")
                                                    {
                                                        s_img = @"~\Uploaded-Files\female.jpg";
                                                    }
                                                }
                                                con.Open();
                                                cmd.Connection = con;
                                                cmd.CommandType = CommandType.Text;
                                                cmd.CommandText = "select  MAX(bRegisteredNum) as regnumber from tbl_Enrollment ";
                                                dr = cmd.ExecuteReader();
                                                string regnum = "";
                                                Int64 regnumber = 0;
                                                if (dr.Read())
                                                {
                                                    regnum = dr["regnumber"].ToString();
                                                }
                                                if (regnum == "")
                                                {
                                                    regnum = "0";
                                                    regnumber = Convert.ToInt64(regnum);
                                                    regnumber += 1;
                                                }
                                                else
                                                {
                                                    regnumber = Convert.ToInt64(regnum);
                                                    regnumber += 1;
                                                }
                                                con.Close();
                                                con.Open();
                                                cmd.Connection = con;
                                                cmd.CommandType = CommandType.Text;
                                                //cmd.CommandText = "insert into tbl_Enrollment(nu_id,nfee_id,dtEn_Date,strFname,strLname,nc_id,nsc_id,strShift,strDOB,strBirthPlace,strNationality,strMotherlang,strReligion,strGender,strPhAddress,strPrAddress,strCity,strState,strCountry,nPinCode,strPhone,strMobile,strEmail,strPassword,strImage,nsch_id,strStudentNum,dtAddDate,bisDeleted) values ((select max(nu_id) from tbl_Users),(select nfee_id from tbl_Fee where nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted=0)),CONVERT(VARCHAR(10), GETDATE(), 105 ),@fn,@ln,(select nc_id from tbl_Class where strClass=@clnm),(select nsc_id from tbl_Section where strSection='" + lblSection.Text + "' and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "')),@shft,@dob,@bplace,@nationality,@mlng,@relg,@gen,@phadrs,@pradrs,@city,@st,@cntry,@pin,@phn,@emphn,@em,@psd,@img,'" + Session["nschoolid"] + "','" + txtstnum.Text + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                                                // cmd.CommandText = "insert into tbl_Enrollment(nu_id,nfee_id,dtEn_Date,strFname,strLname,nc_id,nsc_id,strShift,strDOB,strBirthPlace,strNationality,strMotherlang,strReligion,strGender,strPhAddress,strPrAddress,strCity,strState,strCountry,nPinCode,strPhone,strMobile,strEmail,strPassword,strImage,nsch_id,strStudentNum,dtAddDate,bisDeleted) values ((select max(nu_id) from tbl_Users),(select nfee_id from tbl_Fee where nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted=0)and bisDeleted=0),CONVERT(VARCHAR(10), GETDATE(), 105 ),@fn,@ln,(select nc_id from tbl_Class where strClass=@clnm and bisDeleted=0),(select nsc_id from tbl_Section where strSection='" + lblSection.Text + "' and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted=0)and bisDeleted=0),@shft,@dob,@bplace,@nationality,@mlng,@relg,@gen,@phadrs,@pradrs,@city,@st,@cntry,@pin,@phn,@emphn,@em,@psd,@img,'" + Session["nschoolid"] + "','" + txtstnum.Text + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                                                //cmd.CommandText = "insert into tbl_Enrollment(userid,dtVerifyDate,nu_id,nfee_id,dtEn_Date,strFname,strLname,nc_id,nsc_id,strShift,strDOB,strBirthPlace,strNationality,strMotherlang,strReligion,strGender,strPhAddress,strPrAddress,strCity,strState,strCountry,nPinCode,strPhone,strMobile,strEmail,strPassword,strImage,nsch_id,strStudentNum,dtAddDate,bisDeleted) values ('" + Session["uid"] + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),(select max(nu_id) from tbl_Users where nlevel=3),(select nfee_id from tbl_Fee where nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted=0)and bisDeleted=0),CONVERT(VARCHAR(10), GETDATE(), 105 ),@fn,@ln,(select nc_id from tbl_Class where strClass=@clnm and bisDeleted=0),(select nsc_id from tbl_Section where strSection='" + lblSection.Text + "' and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted=0)and bisDeleted=0),@shft,@dob,@bplace,@nationality,@mlng,@relg,@gen,@phadrs,@pradrs,@city,@st,@cntry,@pin,@phn,@emphn,@em,@psd,@img,'" + Session["nschoolid"] + "','" + txtstnum.Text + "','" + txtadmsndate.Text + "','False')";
                                                //
                                                //cmd.Parameters.AddWithValue("@mn", txtml.Text);
                                                cmd.CommandText = "insert into tbl_Enrollment(strStatus,bRegisteredNum,userid,strNIC,dtVerifyDate,nu_id,nfee_id,dtEn_Date,strFname,strLname,nc_id,nsc_id,strShift,strDOB,strBirthPlace,strNationality,strMotherlang,strReligion,strGender,strPhAddress,strPrAddress,strCity,strState,strCountry,nPinCode,strPhone,strMobile,strEmail,strPassword,strImage,nsch_id,dtAddDate,bisDeleted) values ('Pending','" + regnumber + "','" + Session["uid"] + "',@stnic,CONVERT(VARCHAR(10), GETDATE(), 105 ),(select max(nu_id) from tbl_Users where nlevel=3 and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'),(select nfee_id from tbl_Fee where nc_id=('"+ddcl.SelectedItem.Value+"') and bisDeleted=0),CONVERT(VARCHAR(10), GETDATE(), 105 ),@fn,@ln,('"+ddcl.SelectedItem.Value+"'),('"+ddsec.SelectedItem.Value+"'),@shft,@dob,@bplace,@nationality,@mlng,@relg,@gen,@phadrs,@pradrs,@city,@st,@cntry,@pin,@phn,@emphn,@em,@psd,@img,'" + Session["nschoolid"] + "','" + txtadmsndate.Text + "','True')";
                                                cmd.Parameters.AddWithValue("@stnic", txtstnic.Text);
                                                //@admnum
                                                //cmd.Parameters.AddWithValue("@admnum", txtadmnumber.Text);
                                                cmd.Parameters.AddWithValue("@fn", txtsfn.Text);
                                                cmd.Parameters.AddWithValue("@ln", txtsln.Text);
                                                cmd.Parameters.AddWithValue("@clnm", ddcl.Text);
                                                cmd.Parameters.AddWithValue("@shft", ddshft.Text);
                                                cmd.Parameters.AddWithValue("@dob", txtdob.Text);
                                                cmd.Parameters.AddWithValue("@gen", ddsex.Text);
                                                cmd.Parameters.AddWithValue("@phadrs", txtadrs.Text);
                                                cmd.Parameters.AddWithValue("@pradrs", txtadrs.Text);
                                                cmd.Parameters.AddWithValue("@city", txtcity.Text);
                                                cmd.Parameters.AddWithValue("@st", txtstate.Text);
                                                cmd.Parameters.AddWithValue("@cntry", txtcntry.Text);
                                                cmd.Parameters.AddWithValue("@pin", txtpcode.Text);
                                                cmd.Parameters.AddWithValue("@phn", txtphn.Text);
                                                cmd.Parameters.AddWithValue("@emphn", txtmobile.Text);
                                                cmd.Parameters.AddWithValue("@em", txtsemail.Text);
                                                cmd.Parameters.AddWithValue("@psd", txtspwd.Text);
                                                cmd.Parameters.AddWithValue("@bplace", txtbplace.Text);
                                                cmd.Parameters.AddWithValue("@nationality", txtnt.Text);
                                                cmd.Parameters.AddWithValue("@mlng", txtlng.Text);
                                                cmd.Parameters.AddWithValue("@relg", txtrelg.Text);
                                                cmd.Parameters.AddWithValue("@img", s_img);
                                                cmd.ExecuteNonQuery();
                                                cmd.Parameters.Clear();
                                                con.Close();
                                                //send sms code....


                                                //string number = txtmobile.Text;
                                                //string message = "Congratulations..!! Your Child has been enrolled. Student Name:'" + txtsfn.Text + "' '" + txtsln.Text + "' Admission #:'" + txtadmnumber.Text + "' in Class:'" + ddcl.Text + "' Section:'" + ddsec.Text + "' ";
                                                //////////////////////////////////////////////////////////////////////////////////////////////

                                                //string ozSURL = "http://127.0.0.1"; //where Ozeki NG SMS Gateway is running
                                                //string ozSPort = "9501"; //port number where Ozeki NG SMS Gateway is listening
                                                //string ozUser = HttpUtility.UrlEncode("admin"); //username for successful login
                                                //string ozPassw = HttpUtility.UrlEncode("admin"); //user's password
                                                //string ozMessageType = "SMS:TEXT"; //type of message
                                                //string ozRecipients = HttpUtility.UrlEncode(number); //who will get the message
                                                //string ozMessageData = HttpUtility.UrlEncode(message); //body of message

                                                //string createdURL = ozSURL + ":" + ozSPort + "/httpapi" +
                                                //    "?action=sendMessage" +
                                                //    "&username=" + ozUser +
                                                //    "&password=" + ozPassw +
                                                //    "&messageType=" + ozMessageType +
                                                //    "&recipient=" + ozRecipients +
                                                //    "&messageData=" + ozMessageData;


                                                ////Create the request and send data to Ozeki NG SMS Gateway Server by HTTP connection
                                                //HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(createdURL);

                                                ////Get response from Ozeki NG SMS Gateway Server and read the answer
                                                //HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();
                                                //System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
                                                //string responseString = respStreamReader.ReadToEnd();
                                                //respStreamReader.Close();
                                                //myResp.Close();
                                                txtgfn.Text = "";
                                                txtstnum.Text = "";
                                                txtsfn.Text = "";
                                                txtsln.Text = "";
                                                //  txtml.Text = "";
                                                txtgln.Text = "";
                                                txtdob.Text = "";
                                                txtmobile.Text = "";
                                                txtem.Text = "";
                                                txtpwd.Text = "";

                                                txtsemail.Text = "";
                                                txtspwd.Text = "";

                                                txtnic.Text = "";

                                                txtstnic.Focus();
                                                addflag = true;
                                                if (txtdisc.Text == "" || txtdisc.Text == "0")
                                                {
                                                }
                                                else
                                                {
                                                    concession_student();
                                                }
                                                // txtnic.Visible = true;
                                                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Parent and Child  has been Registered.'); window.location = 'AdminManageNewAdmission.aspx';", true);
                                                // Response.Redirect("AdminManageP-C.aspx");
                                                // Response.Redirect(Request.RawUrl);
                                            }
                                       // }
                                    }

                                //}

                            }
                            catch (Exception ex)
                            {
                                Response.Redirect("Error.aspx?msg=AdminManageNewAdmission.aspx");
                            }
                        }
                    }
                //}
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
            // if( addflag == true)
            // ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Student Or Parent has been registered successfully.'); window.location = 'AdminManageP-C.aspx';", true);
            //Response.Redirect("AdminManageP-C.aspx?ch=1");
        }

        protected void txtstnum_TextChanged(object sender, EventArgs e)
        {
            //con.Open();
            //    cmd.Connection = con;
            //    cmd.CommandType = CommandType.Text;
            //    cmd.CommandText = "select nsc_id from tbl_Enrollment where strStudentNum=@reg1 and nsc_id=(select nsc_id from tbl_Section where strSection='" + section + "' and nc_id=(select nc_id from tbl_Class where strClass='" + clas + "' and bisDeleted='False')and bisDeleted='False') and bisDeleted='False'";
            //    cmd.Parameters.AddWithValue("@reg1", tb.Text);
            //    dr=cmd.ExecuteReader();
            //    if (dr.HasRows)
            //    {
            //        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('The Student Verification Number already exist.');", true);
            //    }
            //    else
            //    { }
            /////////////////////////////////////////
            // con.Open();
            // cmd.Connection = con;
            // cmd.CommandType = CommandType.Text;
            // //cmd.CommandText = "select strStudentNum from tbl_Enrollment where strStudentNum='" + txtstnum.Text + "' and bisDeleted='False'";
            // cmd.CommandText = "select nsc_id from tbl_Enrollment where strStudentNum=@reg1 and nsc_id=(select nsc_id from tbl_Section where strSection='" + section + "' and nc_id=(select nc_id from tbl_Class where strClass='" + clas + "' and bisDeleted='False')and bisDeleted='False') and bisDeleted='False'";
            // cmd.Parameters.AddWithValue("@reg1", tb.Text);
            // dr = cmd.ExecuteReader();
            // if (dr.Read())
            // {
            //     ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This number has already been assigned.');", true);
            //     txtstnum.Focus();
            //     txtstnum.Text = "";
            // }
            //// txtsfn.Focus();
            // con.Close();
        }

        protected void txtnic_TextChanged(object sender, EventArgs e)
        {
            try
            {
                Boolean flag = true;
                for (int i = 0; i < txtnic.Text.Length; i++)
                {
                    if (txtnic.Text != "")
                    {
                        if (txtnic.Text[i] >= 'a' && txtnic.Text[i] <= 'z' || txtnic.Text[i] >= 'A' && txtnic.Text[i] <= 'Z' || txtnic.Text[i] == '!' || txtnic.Text[i] == '@' || txtnic.Text[i] == '#' || txtnic.Text[i] == '$' || txtnic.Text[i] == '`' || txtnic.Text[i] == '~' || txtnic.Text[i] == '%' || txtnic.Text[i] == '^' || txtnic.Text[i] == '&' || txtnic.Text[i] == '*' || txtnic.Text[i] == '(' || txtnic.Text[i] == ')' || txtnic.Text[i] == '-' || txtnic.Text[i] == '+' || txtnic.Text[i] == '_' || txtnic.Text[i] == '=' || txtnic.Text[i] == ',' || txtnic.Text[i] == '.' || txtnic.Text[i] == '/' || txtnic.Text[i] == '?' || txtnic.Text[i] == ';' || txtnic.Text[i] == ':' || txtnic.Text[i] == '\'' || txtnic.Text[i] == '\"' || txtnic.Text[i] == '|' || txtnic.Text[i] == '\\' || txtnic.Text[i] == '/' || txtnic.Text[i] == '[' || txtnic.Text[i] == ']' || txtnic.Text[i] == '{' || txtnic.Text[i] == '}')
                        {

                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalide Entry.');", true);
                            txtnic.Text = "";
                            txtnic.Focus();
                            flag = false;
                            break;
                        }
                    }
                }
                if (txtnic.Text != "" && flag)
                {
                    if (txtnic.Text.Length <= 13)
                    {
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "select * from tbl_Users where strNIC='" + txtnic.Text + "' and bisDeleted=0";
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
                            txtem.Text = dr["strEmail"].ToString();
                            txtem.Enabled = false;
                            txtpwd.Text = dr["strPassword"].ToString();
                            // txtpwd.Enabled = false;
                            txtrepass.Text = dr["strPassword"].ToString();
                            // txtrepass.Enabled = false;
                            txtgfn.Text = dr["strfname"].ToString();
                            txtgfn.Enabled = false;
                            txtgln.Text = dr["strlname"].ToString();
                            txtgln.Enabled = false;
                            txtgnic.Text = dr["strNIC"].ToString();
                            txtgnic.Enabled = false;
                            txtadrs.Text = dr["strAddress"].ToString();
                            txtcity.Text = dr["strCity"].ToString();
                            txtcntry.Text = dr["strCountry"].ToString();
                            txtstate.Text = dr["strState"].ToString();
                            txtphn.Text = dr["strPhone"].ToString();
                            txtmobile.Text = dr["strCell"].ToString();

                            txtnic.Visible = false;
                            txtgfn.Focus();

                            txtgnic.Visible = true;
                            //txtstnic.Focus();
                            //txtsfn.Focus();
                        }
                        else
                        {
                            txtgfn.Focus();
                            txtgnic.Text = txtnic.Text;
                            txtnic.Text = "";
                            //txtsfn.Focus();

                            txtem.Enabled = true;
                            txtem.Text = "";
                            // txtpwd.Enabled = false;

                            // txtrepass.Enabled = false;

                            txtgfn.Enabled = true;
                            txtgfn.Text = "";
                            txtgln.Enabled = true;
                            txtgln.Text = "";
                            txtgnic.Enabled = true;

                            txtgnic.Visible = true;
                            txtnic.Visible = false;
                            // txtgnic.Text = "";
                            // ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This number has already been assigned.');", true);
                        }
                        con.Close();
                    }
                    else
                    {
                        txtnic.Focus();
                        txtnic.Text = "";
                        txtnic.Visible = true;
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

        protected void sqlclass_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void ddsec_SelectedIndexChanged(object sender, EventArgs e)
        {

            //GenrerateStudentNumber();
            //// ddsecValue =ddsec.SelectedValue;
            //lblSection.Text = ddsec.SelectedValue;
            ////lblSectionn.Visible = true;
            //SelectedSec.Visible = true;
            //SelectedSec.Text = ddsec.SelectedValue;
            //ddsec.Items.Clear();
            //ddsec.Items.Add("Select Section");
        }

        protected void ddsec_TextChanged(object sender, EventArgs e)
        {
            //  GenrerateStudentNumber();
        }

        protected void txtstnic_TextChanged(object sender, EventArgs e)
        {
            try
            {
                Boolean flag = true;
                for (int i = 0; i < txtstnic.Text.Length; i++)
                {
                    if (txtstnic.Text != "")
                    {
                        if (txtstnic.Text[i] >= 'a' && txtstnic.Text[i] <= 'z' || txtstnic.Text[i] >= 'A' && txtstnic.Text[i] <= 'Z' || txtstnic.Text[i] == '!' || txtstnic.Text[i] == '@' || txtstnic.Text[i] == '#' || txtstnic.Text[i] == '$' || txtstnic.Text[i] == '`' || txtstnic.Text[i] == '~' || txtstnic.Text[i] == '%' || txtstnic.Text[i] == '^' || txtstnic.Text[i] == '&' || txtstnic.Text[i] == '*' || txtstnic.Text[i] == '(' || txtstnic.Text[i] == ')' || txtstnic.Text[i] == '-' || txtstnic.Text[i] == '+' || txtstnic.Text[i] == '_' || txtstnic.Text[i] == '=' || txtstnic.Text[i] == ',' || txtstnic.Text[i] == '.' || txtstnic.Text[i] == '/' || txtstnic.Text[i] == '?' || txtstnic.Text[i] == ';' || txtstnic.Text[i] == ':' || txtstnic.Text[i] == '\'' || txtstnic.Text[i] == '\"' || txtstnic.Text[i] == '|' || txtstnic.Text[i] == '\\' || txtstnic.Text[i] == '/' || txtstnic.Text[i] == '[' || txtstnic.Text[i] == ']' || txtstnic.Text[i] == '{' || txtstnic.Text[i] == '}')
                        {

                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalide Entry.');", true);
                            txtstnic.Text = "";
                            txtstnic.Focus();
                            flag = false;
                            break;
                        }
                    }
                }
                if (txtstnic.Text != "" && flag)
                {
                    if (txtstnic.Text.Length <= 13)
                    {
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "select * from tbl_Enrollment where strNIC='" + txtstnic.Text + "' and bisDeleted=0";
                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            txtstnic.Focus();
                            txtstnic.Text = "";

                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Student NIC Already Exists.');", true);
                            //txtsfn.Focus();
                        }
                        else
                        {
                            //txtsfn.Focus();
                            ddshft.Focus();
                            // txtgnic.Text = "";
                            // ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This number has already been assigned.');", true);
                        }
                        con.Close();

                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "select * from tbl_Enrollment where strNIC='" + txtstnic.Text + "' and bisDeleted=1 and strStatus='Pending' and strStudentNum!=''";
                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            txtstnic.Focus();
                            txtstnic.Text = "";

                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Student NIC Already Exists.');", true);
                            //txtsfn.Focus();
                        }
                        else
                        {
                            //txtsfn.Focus();
                            ddshft.Focus();
                            // txtgnic.Text = "";
                            // ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This number has already been assigned.');", true);
                        }
                        con.Close();
                    }
                    else
                    {
                        txtstnic.Focus();
                        txtstnic.Text = "";

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

        protected void txtsfn_TextChanged(object sender, EventArgs e)
        {
            try
            {
                //string em = AutoEmail.GETEMAIL();
                //string name = txtsfn.Text;
                //name = name.Replace(' ', '_');

                //txtsemail.Text = name + em;

                txtsln.Focus();
            }
            catch (Exception ex)
            {
            }
        }

        protected void txtgfn_TextChanged(object sender, EventArgs e)
        {
            try
            {
                //if (txtem.Enabled == true)
                //{
                //    string em = AutoEmail.GETEMAIL();
                //    string name = txtgfn.Text;
                //    name = name.Replace(' ', '_');
                //    txtem.Text = name + em;
                //}
                txtgln.Focus();
            }
            catch (Exception ex)
            {
            }
        }

        protected void txtphn_TextChanged(object sender, EventArgs e)
        {
            try
            {
                Boolean flag = true;
                for (int i = 0; i < txtphn.Text.Length; i++)
                {
                    if (txtphn.Text != "")
                    {
                        if (txtphn.Text[i] >= 'a' && txtphn.Text[i] <= 'z' || txtphn.Text[i] >= 'A' && txtphn.Text[i] <= 'Z' || txtphn.Text[i] == '!' || txtphn.Text[i] == '@' || txtphn.Text[i] == '#' || txtphn.Text[i] == '$' || txtphn.Text[i] == '`' || txtphn.Text[i] == '~' || txtphn.Text[i] == '%' || txtphn.Text[i] == '^' || txtphn.Text[i] == '&' || txtphn.Text[i] == '*' || txtphn.Text[i] == '(' || txtphn.Text[i] == ')' || txtphn.Text[i] == '-' || txtphn.Text[i] == '+' || txtphn.Text[i] == '_' || txtphn.Text[i] == '=' || txtphn.Text[i] == ',' || txtphn.Text[i] == '.' || txtphn.Text[i] == '/' || txtphn.Text[i] == '?' || txtphn.Text[i] == ';' || txtphn.Text[i] == ':' || txtphn.Text[i] == '\'' || txtphn.Text[i] == '\"' || txtphn.Text[i] == '|' || txtphn.Text[i] == '\\' || txtphn.Text[i] == '/' || txtphn.Text[i] == '[' || txtphn.Text[i] == ']' || txtphn.Text[i] == '{' || txtphn.Text[i] == '}')
                        {

                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalide Entry.');", true);
                            txtphn.Text = "";
                            txtphn.Focus();
                            flag = false;
                            break;
                        }
                    }
                }
                if (txtphn.Text != "" && flag)
                {
                    if (txtphn.Text.Length <= 11 && txtphn.Text.Length >= 9)
                    {
                        txtmobile.Focus();
                    }
                    else
                    {
                        txtphn.Text = "";
                        txtphn.Focus();
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Enter 11 or 9 Digit Number.');", true);
                    }
                }
            }
            catch (Exception ex)
            {
            }
        }

        protected void txtmobile_TextChanged(object sender, EventArgs e)
        {
            try
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
                        if (txtem.Enabled)
                            txtem.Focus();
                        else
                        {
                            txtpwd.Focus();
                        }
                    }
                    else
                    {
                        txtmobile.Text = "";
                        txtmobile.Focus();
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Enter 11 Digit Number.');", true);
                    }
                }
            }
            catch (Exception) { }
        }

        protected void ddcl_SelectedIndexChanged(object sender, EventArgs e)
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * from tbl_Fee where nc_id=(@cid) and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
            cmd.Parameters.AddWithValue("@cid", ddcl.SelectedItem.Value);
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                txtclfee.Text = dr["strTutionFee"].ToString();
            }
            con.Close();
            bindSection();
            ddsec.Focus();
        }
    }
}