using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminManageClassTimeTable : System.Web.UI.Page
    {
        string per = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
            if (!IsPostBack)
            {

                BindGrid();
               
            }
            if (IsPostBack)
            {




             

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
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        private DataTable GetRecords()
        {
            string mm = DateTime.Now.Month.ToString();
            string dd = DateTime.Now.Day.ToString();
            string shdul = "";
            string shdulid = "";
          
            string id = "";
            try
            {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.CommandText = "SELECT nshd_id,bisDeleted from tbl_Schedule where bisActive=1 and  nsch_id = '" + Session["nschoolid"] + "'";


            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                id = dr["nshd_id"].ToString();
                ddlTimetable.SelectedValue = id;
            }
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
            }
            finally
            {
                con.Close();
            }
            shdulid = id;
            
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select p.strPeriod,t.strDay,t.nt_id,c.strClass,sc.strSection,s.strSubject,u.strfname,u.strfname+' '+u.strlname as name,p.strStartTime,p.strEndTime,t.strShift,shdl.strStartDate,shdl.strEndDate,shdl.strtimetable from tbl_TimeTable t inner join tbl_Class c on t.nc_id=c.nc_id inner join tbl_Subject s on t.nsbj_id=s.nsbj_id inner join tbl_Users u on t.nu_id=u.nu_id inner join tbl_Section sc on t.nsc_id=sc.nsc_id inner join tbl_Schedule shdl on t.nshdule_id=shdl.nshd_id inner join tbl_Period p on t.np_id=p.np_id where t.bisDeleted='False' and c.bisDeleted='False' and s.bisDeleted='False' and u.bisDeleted='False' and sc.bisDeleted='False' and p.bisDeleted='False' and t.nsch_id='" + Session["nschoolid"] + "' and strType='Class' and t.nshdule_id='" + shdulid + "' Order by strClass,strSection";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            return objDs.Tables[0];

        }
        private void BindGrid()
        {try
        {
            DataTable dt = GetRecords();
            if (dt.Rows.Count > 0)
            {
                gvttable.DataSource = dt;
                gvttable.DataBind();
            }
        }
        catch (Exception ex)
        {
          //  Response.Redirect("Error.aspx");
        }
       
        }

        private void SearchText(string strSearchText)
        {
            try{
            DataTable dt = GetRecords();
            DataView dv = new DataView(dt);
            string SearchExpression = null;
            if (!String.IsNullOrEmpty(strSearchText))
            {
                SearchExpression =
                string.Format("{0} '%{1}%'", gvttable.SortExpression, strSearchText);

            }
            else
                Response.Redirect("AdminManageClassTimeTable.aspx");

            dv.RowFilter = "name like" + SearchExpression;
            gvttable.DataSource = dv;
            gvttable.DataBind();
            }
            catch (Exception ex)
            {
                //  Response.Redirect("Error.aspx");
            }
        }



        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvttable.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvttable.HeaderRow.FindControl("txtcc");

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
            if (ddlTimetable.SelectedItem.ToString() != "---Select Time Table---")
            {

                DataTable table = new DataTable();

                using (SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
                {

                    string sql = "select p.strPeriod,t.strDay,t.nt_id,c.strClass,sc.strSection,s.strSubject,u.strfname,u.strfname+' '+u.strlname as name,p.strStartTime,p.strEndTime,t.strShift,shdl.strStartDate,shdl.strEndDate,shdl.strtimetable from tbl_TimeTable t inner join tbl_Class c on t.nc_id=c.nc_id inner join tbl_Subject s on t.nsbj_id=s.nsbj_id inner join tbl_Users u on t.nu_id=u.nu_id inner join tbl_Section sc on t.nsc_id=sc.nsc_id inner join tbl_Schedule shdl on t.nshdule_id=shdl.nshd_id inner join tbl_Period p on t.np_id=p.np_id where t.bisDeleted='False' and c.bisDeleted='False' and s.bisDeleted='False' and u.bisDeleted='False' and sc.bisDeleted='False' and p.bisDeleted='False' and t.nsch_id='" + Session["nschoolid"] + "' and strType='Class' and t.nshdule_id='" + ddlTimetable.SelectedValue + "' Order by strClass,strSection";

                    using (SqlCommand cmd1 = new SqlCommand(sql, con1))
                    {

                        using (SqlDataAdapter ad = new SqlDataAdapter(cmd1))
                        {

                            ad.Fill(table);

                        }

                    }

                }

                gvttable.DataSource = table;

                gvttable.DataBind();
            }
            }
            catch (Exception ex)
            {
                  Response.Redirect("Error.aspx");
            }

        }
        /// <summary>
        /// ////////////////////////ADD TIME TABLE///////////////////////////
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnttable_Click(object sender, EventArgs e)
        {
            try
            {

                if (ddcl.Text == "" || txtsdt.Text == "" || ddltimetable11.SelectedItem.ToString() == "---Select Time Table---" || ddlDay.SelectedItem.ToString() == "---Select Day---" || ddlperiod.SelectedIndex == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('All Feilds Required..');", true);
                }
                else
                {
                    Boolean INSERTFLAG = false, ClassFlag = true, SecFlag = true, TchrFlag = true, DayFlag = true, SttimeFlag = true, EndFlag = true, StDateFlag = true, endDatFlag = true;
                    //////////////ALL VARIABLES///////////////////////////
                    string day = ddlDay.Text;
                    string class1 = ddcl.SelectedValue;
                    string sec1 = ddsec.SelectedValue;
                    string subject = ddsub.SelectedValue;
                    string tchr = ddtchr.SelectedValue;
                    string sttym = ddlperiod.SelectedValue;
                    string edtym = txtenddt.Text;
                    string stDate = txttdt.Text;
                    string edDate = txtedt.Text;
                    
                    //////////////ALL VARIABLES///////////////////////////
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    string shduleid = ddltimetable11.SelectedValue;
                    
                    cmd.CommandText = "select * from tbl_TimeTable where (bisDeleted='False') and nshdule_id='"+shduleid+"' and nsch_id='"+Session["nschoolid"]+"'";
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            if (ddltimetable11.SelectedItem.ToString() == "Winter")
                            {
                                if (class1 == dr["nc_id"].ToString() && sec1 == dr["nsc_id"].ToString() && tchr == dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym == dr["strPeriod"].ToString() && subject == dr["nsbj_id"].ToString())
                                {
                                    INSERTFLAG = false;
                                    break;
                                }
                                if (class1 == dr["nc_id"].ToString() && sec1 == dr["nsc_id"].ToString() && tchr == dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym == dr["strPeriod"].ToString() && subject != dr["nsbj_id"].ToString())
                                {
                                    INSERTFLAG = false;
                                    break;
                                }
                               
                                else if (class1 == dr["nc_id"].ToString() && sec1 == dr["nsc_id"].ToString() && tchr != dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym == dr["strPeriod"].ToString() && subject != dr["nsbj_id"].ToString())
                                {
                                    INSERTFLAG = false;
                                    break;
                                }
                                else if (class1 == dr["nc_id"].ToString() && sec1 == dr["nsc_id"].ToString() && tchr != dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym != dr["strPeriod"].ToString() && subject == dr["nsbj_id"].ToString())
                                {
                                    INSERTFLAG = false;
                                    break;
                                }
                                else if (class1 == dr["nc_id"].ToString() && sec1 == dr["nsc_id"].ToString() && tchr != dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym == dr["strPeriod"].ToString() && subject == dr["nsbj_id"].ToString())
                                {
                                    INSERTFLAG = false;
                                    break;
                                }
                                else if (class1 != dr["nc_id"].ToString() && sec1 != dr["nsc_id"].ToString() && tchr == dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym == dr["strPeriod"].ToString() && subject == dr["nsbj_id"].ToString())
                                {
                                    INSERTFLAG = false;
                                    break;
                                }
                                else if (class1 != dr["nc_id"].ToString() && sec1 != dr["nsc_id"].ToString() && tchr == dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym == dr["strPeriod"].ToString() && subject != dr["nsbj_id"].ToString())
                                {
                                    INSERTFLAG = false;
                                    break;
                                }
                                //else if (class1 == dr["nc_id"].ToString() && sec1 == dr["nsc_id"].ToString() && tchr == dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym != dr["strPeriod"].ToString() && subject == dr["nsbj_id"].ToString())
                                //{
                                //    INSERTFLAG = false;
                                //    break;
                                //}

                                else
                                    INSERTFLAG = true;
                            }
                            else if (ddltimetable11.SelectedItem.ToString() == "Summer")
                            {
                                if (class1 == dr["nc_id"].ToString() && sec1 == dr["nsc_id"].ToString() && tchr == dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym == dr["strPeriod"].ToString() && subject == dr["nsbj_id"].ToString())
                                {
                                    INSERTFLAG = false;
                                    break;
                                }
                                if (class1 == dr["nc_id"].ToString() && sec1 == dr["nsc_id"].ToString() && tchr == dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym == dr["strPeriod"].ToString() && subject != dr["nsbj_id"].ToString())
                                {
                                    INSERTFLAG = false;
                                    break;
                                }

                                else if (class1 == dr["nc_id"].ToString() && sec1 == dr["nsc_id"].ToString() && tchr != dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym == dr["strPeriod"].ToString() && subject != dr["nsbj_id"].ToString())
                                {
                                    INSERTFLAG = false;
                                    break;
                                }
                                else if (class1 == dr["nc_id"].ToString() && sec1 == dr["nsc_id"].ToString() && tchr != dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym != dr["strPeriod"].ToString() && subject == dr["nsbj_id"].ToString())
                                {
                                    INSERTFLAG = false;
                                    break;
                                }
                                else if (class1 == dr["nc_id"].ToString() && sec1 == dr["nsc_id"].ToString() && tchr != dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym == dr["strPeriod"].ToString() && subject == dr["nsbj_id"].ToString())
                                {
                                    INSERTFLAG = false;
                                    break;
                                }
                                else if (class1 != dr["nc_id"].ToString() && sec1 != dr["nsc_id"].ToString() && tchr == dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym == dr["strPeriod"].ToString() && subject == dr["nsbj_id"].ToString())
                                {
                                    INSERTFLAG = false;
                                    break;
                                }
                                else if (class1 != dr["nc_id"].ToString() && sec1 != dr["nsc_id"].ToString() && tchr == dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym == dr["strPeriod"].ToString() && subject != dr["nsbj_id"].ToString())
                                {
                                    INSERTFLAG = false;
                                    break;
                                }
                                //else if (class1 == dr["nc_id"].ToString() && sec1 == dr["nsc_id"].ToString() && tchr == dr["nu_id"].ToString() && day == dr["strDay"].ToString() && sttym != dr["strPeriod"].ToString() && subject == dr["nsbj_id"].ToString())
                                //{
                                //    INSERTFLAG = false;
                                //    break;
                                //}
                                else
                                    INSERTFLAG = true;
                            }
                        }
                    }
                            
                            else
                            {
                                INSERTFLAG = true;
                            }
                            con.Close();
                            if (INSERTFLAG == false)
                            {
                                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Time has already Exist.');", true);
                            }
                            if (INSERTFLAG == true)
                            {
                                con.Open();
                                cmd.Connection = con;
                                cmd.CommandType = CommandType.Text;
                                cmd.CommandText = "select * from tbl_TimeTable where (nu_id='" + ddtchr.SelectedValue + "' and strStartTime='" + txtsdt.Text + "' and strEndTime='" + txtenddt.Text + "' and nc_id='" + ddcl.SelectedValue + "' and nsbj_id='" + ddsub.SelectedValue + "' and nsc_id='" + ddsec.SelectedValue + "' AND strDay='" + ddlDay.SelectedValue + "'  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "' )";
                                dr = cmd.ExecuteReader();
                                if (dr.Read())
                                {
                                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Time has already been declare.');", true);

                                }
                                else
                                {
                                    con.Close();
                                    con.Open();
                                    cmd.Connection = con;
                                    cmd.CommandType = CommandType.Text;
                                    cmd.CommandText = "insert into tbl_TimeTable(np_id,strPeriod,nshdule_id,nc_id,nsc_id,nsbj_id,nu_id,strStartTime,strEndTime,strShift,strStartDate,strEndDate,strType,nsch_id,dtAddDate,bisDeleted,strDay)values(@pid,@period,@shdid,@cid ,'" + ddsec.SelectedValue + "' ,@sid ,@uid,@stime,@etime,@shft,@sdt,@edt,'Class','" + Session["nschoolid"] + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False',@day)";
                                    cmd.Parameters.AddWithValue("@cid", ddcl.SelectedValue);
                                    cmd.Parameters.AddWithValue("@sid", ddsub.SelectedValue);
                                    cmd.Parameters.AddWithValue("@uid", ddtchr.SelectedValue);
                                    cmd.Parameters.AddWithValue("@stime", txtsdt.Text);
                                    cmd.Parameters.AddWithValue("@etime", txtenddt.Text);
                                    cmd.Parameters.AddWithValue("@shft", ddshft.Text);
                                    cmd.Parameters.AddWithValue("@sdt", txttdt.Text);
                                    cmd.Parameters.AddWithValue("@edt", txtedt.Text);
                                    cmd.Parameters.AddWithValue("@day", ddlDay.Text);

                                    cmd.Parameters.AddWithValue("@period",ddlperiod.SelectedItem.ToString());
                                    cmd.Parameters.AddWithValue("@pid", ddlperiod.SelectedValue);

                                    cmd.Parameters.AddWithValue("@shdid", ddltimetable11.SelectedValue);

                                    if (cmd.ExecuteNonQuery() != -1)
                                    {
                                        con.Close();
                                        con.Open();
                                        cmd.Connection = con;
                                        cmd.CommandType = CommandType.Text;
                                        cmd.CommandText = "select * from tbl_TeacherSubject where nu_id=@umn1  and nc_id=@cnm1  and nsbj_id=@snm1  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                                        cmd.Parameters.AddWithValue("@umn1", ddtchr.SelectedValue);
                                        cmd.Parameters.AddWithValue("@cnm1", ddcl.SelectedValue);
                                        cmd.Parameters.AddWithValue("@snm1", ddsub.SelectedValue);
                                        dr = cmd.ExecuteReader();
                                        if (dr.HasRows)
                                        {
                                            //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This Teacher  already exist In the Class For this SubJect.');", true);
                                        }
                                        else
                                        {
                                            con.Close();
                                            con.Open();
                                            cmd.Connection = con;
                                            cmd.CommandType = CommandType.Text;
                                            cmd.CommandText = "select * from tbl_TeacherSubject where nc_id=@cnm3  and nsbj_id=@snm3  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";

                                            cmd.Parameters.AddWithValue("@cnm3", ddcl.SelectedValue);
                                            cmd.Parameters.AddWithValue("@snm3", ddsub.SelectedValue);
                                            dr = cmd.ExecuteReader();
                                            if (dr.HasRows)
                                            {
                                                //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This Subject  already exist In the Class.');", true);
                                            }
                                            else
                                            {
                                                con.Close();


                                                con.Open();
                                                cmd.Connection = con;
                                                cmd.CommandType = CommandType.Text;
                                                cmd.CommandText = "insert into tbl_TeacherSubject(nsch_id,nu_id,nc_id,nsbj_id,dtAddDate,bisDeleted)values('" + Session["nschoolid"] + "',@umn ,@cnm,@snm,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                                                cmd.Parameters.AddWithValue("@umn", ddtchr.SelectedValue);
                                                cmd.Parameters.AddWithValue("@cnm", ddcl.SelectedValue);
                                                cmd.Parameters.AddWithValue("@snm", ddsub.SelectedValue);

                                                cmd.ExecuteNonQuery();
                                                con.Close();
                                                // ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This Teacher  is added Successfully.');", true);


                                            }
                                        }
                                    }
                                }
                            }
                            PopulateData();
                            mvtime.ActiveViewIndex = 0;
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

        protected void ddcl_SelectedIndexChanged(object sender, System.EventArgs e)
        {

        }

        protected void gvttable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                System.Threading.Thread.Sleep(2000);
                if (e.CommandName == "Search")
                {
                    TextBox txtGrid = (TextBox)gvttable.HeaderRow.FindControl("txtcc");
                    SearchText(txtGrid.Text);
                }
            }
            
            catch (Exception ex)
            {
                //Response.Redirect("Error.aspx");
            }
            
        }

        protected void btndel_Click(object sender, System.EventArgs e)
        {
            try
            {
                //  Bind_ddlTeacher1();
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string del = gvr.Cells[1].Text;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_TimeTable set dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ), bisDeleted='True' where nt_id='" + del + "' and nsch_id='" + Session["nschoolid"] + "'";
                cmd.ExecuteNonQuery();
                con.Close();
                PopulateData();
                mvtime.ActiveViewIndex = 0;
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

        protected void btnedit_Click(object sender, System.EventArgs e)
        {
            mvtime.ActiveViewIndex = 2;
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Label tname = (Label)gvr.FindControl("lblcname");
                //
                Session["tid"] = gvr.Cells[1].Text;
                txtst.Text = gvr.Cells[7].Text;
                txtet.Text = gvr.Cells[8].Text;
                //ddcl1.Text = gvr.Cells[4].Text;
                ddcl1.Items.Add(gvr.Cells[4].Text);
                ddsec1.Items.Add(gvr.Cells[5].Text);
                txttdt2.Text = gvr.Cells[10].Text;
                txtedt2.Text = gvr.Cells[11].Text;
                ddsb.Items.Add(gvr.Cells[6].Text);
                ddumna.Items.Add( tname.Text);
                ddsh.Text = gvr.Cells[9].Text;
                ddcl1.Enabled = false;
                ddsec1.Enabled = false;
                ddumna.Enabled = false;
                ddsb.Enabled = false;
                txttdt2.Enabled = false;
                txtedt2.Enabled = false;
                //mvtime.ActiveViewIndex = 2;
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

        protected void btnAdd_Click(object sender, System.EventArgs e)
        {
            mvtime.ActiveViewIndex = 1;
        }

        protected void btnupdate_Click(object sender, System.EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "update tbl_TimeTable set nsc_id='" + ddsec1.SelectedValue + "' , nc_id=@cid,nsbj_id=@sid,nu_id=@uid ,strStartTime=@stime,strEndTime=@etime,strShift=@shft,strStartDate=@sd,strEndDate=@ed,dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nt_id='" + Session["tid"] + "'";
            cmd.CommandText = "update tbl_TimeTable set strStartTime=@stime,strEndTime=@etime where nt_id='" + Session["tid"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
           // cmd.Parameters.AddWithValue("@cid", ddcl1.SelectedValue);
           /// cmd.Parameters.AddWithValue("@sid", ddsb.SelectedValue);
          //  cmd.Parameters.AddWithValue("@uid", ddumna.SelectedValue);
            cmd.Parameters.AddWithValue("@stime", txtst.Text);
            cmd.Parameters.AddWithValue("@etime", txtet.Text);
          //  cmd.Parameters.AddWithValue("@shft", ddsh.Text);
          ///  cmd.Parameters.AddWithValue("@sd", txttdt2.Text);
          //  cmd.Parameters.AddWithValue("@ed", txtedt2.Text);

            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvtime.ActiveViewIndex = 0;
             
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

        protected void gvttable_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvttable.PageIndex = e.NewPageIndex;
            PopulateData();
        }

        protected void winter_CheckedChanged(object sender, EventArgs e)
        {
            //con.Open();
            //cmd.Connection = con;
            //cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "Select * from tbl_Schedule where nshd_id=@id and nsch_id = '" + Session["nschoolid"] + "'";
            //if (winter.Checked)
            //{
            //    string id = "1";
            //    cmd.Parameters.AddWithValue("@id", id);
            //}
            //if (Summer.Checked)
            //{
            //    string id = "2";
            //    cmd.Parameters.AddWithValue("@id", id);
            //}
            //dr = cmd.ExecuteReader();
            //if (dr.Read())
            //{
            //    if (Summer.Checked)
            //    {
            //        string stdate = dr["strStartDate"].ToString();
            //        stdate += "-" + DateTime.Now.Year.ToString();
            //        txttdt.Text = stdate;

            //        string eddate = dr["strEndDate"].ToString();
            //        eddate += "-" + DateTime.Now.Year.ToString();
            //        txtedt.Text = eddate;
            //    }
            //    if (winter.Checked)
            //    {
            //        string stdate = dr["strStartDate"].ToString();
            //        stdate += "-" + DateTime.Now.Year.ToString();
            //        txttdt.Text = stdate;

            //        string eddate = dr["strEndDate"].ToString();
            //        int yyy = Convert.ToInt32(DateTime.Now.Year.ToString());
            //        yyy += 1;
            //        eddate += "-" + yyy.ToString();
            //        txtedt.Text = eddate;
            //    }
            //}
            //con.Close();

        }

        protected void Summer_CheckedChanged(object sender, EventArgs e)
        {
            //con.Open();
            //cmd.Connection = con;
            //cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "Select * from tbl_Schedule where nshd_id=@id and nsch_id = '" + Session["nschoolid"] + "'";
            //if (winter.Checked)
            //{
            //    string id = "1";
            //    cmd.Parameters.AddWithValue("@id", id);
            //}
            //if (Summer.Checked)
            //{
            //    string id = "2";
            //    cmd.Parameters.AddWithValue("@id", id);
            //}
            //dr = cmd.ExecuteReader();
            //if (dr.Read())
            //{
            //    if (Summer.Checked)
            //    {
            //        string stdate = dr["strStartDate"].ToString();
            //        stdate += "-" + DateTime.Now.Year.ToString();
            //        txttdt.Text = stdate;

            //        string eddate = dr["strEndDate"].ToString();
            //        eddate += "-" + DateTime.Now.Year.ToString();
            //        txtedt.Text = eddate;
            //    }
            //    if (winter.Checked)
            //    {
            //        string stdate = dr["strStartDate"].ToString();
            //        stdate += "-" + DateTime.Now.Year.ToString();
            //        txttdt.Text = stdate;

            //        string eddate = dr["strEndDate"].ToString();
            //        int yyy = Convert.ToInt32(DateTime.Now.Year.ToString());
            //        yyy += 1;
            //        eddate += "-" + yyy.ToString();
            //        txtedt.Text = eddate;
            //    }
            //}
            //con.Close();

        }

        protected void ddlTimetable_SelectedIndexChanged(object sender, EventArgs e)
        {

                PopulateData();
        }

        protected void ddlperiod_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (winter.Checked)
            //{
            //    if (ddlperiod.SelectedValue == "1")
            //    {
            //        txtsdt.Text = "7:50";
            //        txtenddt.Text = "8:25";
            //    }
            //    else if (ddlperiod.Text == "7")
            //    {
            //        txtsdt.Text = "11:20";
            //        txtenddt.Text = "11:55";
            //    }
            //   else if (ddlperiod.SelectedValue == "2")
            //    {
            //        txtsdt.Text = "8:25";
            //        txtenddt.Text = "9:00";
            //    }
            //    else if (ddlperiod.SelectedValue == "3")
            //    {
            //        txtsdt.Text = "9:00";
            //        txtenddt.Text = "9:35";
            //    }
            //    else if (ddlperiod.SelectedValue == "4")
            //    {
            //        txtsdt.Text = "9:35";
            //        txtenddt.Text = "10:10";
            //    }
            //    else if (ddlperiod.SelectedValue == "5")
            //    {
            //        txtsdt.Text = "10:10";
            //        txtenddt.Text = "10:45";
            //    }
            //    else if (ddlperiod.Text == "6")
            //    {
            //        txtsdt.Text = "10:45";
            //        txtenddt.Text = "11:20";
            //    }
                
            //    else if (ddlperiod.Text == "8")
            //    {
            //        txtsdt.Text = "11:55";
            //        txtenddt.Text = "12:30";
            //    }
            //}
            //if (Summer.Checked)
            //{

            //    if (ddlperiod.SelectedValue == "1")
            //    {
            //        txtsdt.Text = "7:50";
            //        txtenddt.Text = "8:25";
            //    }
            //    else if (ddlperiod.SelectedValue == "2")
            //    {
            //        txtsdt.Text = "8:25";
            //        txtenddt.Text = "9:00";
            //    }
            //    else if (ddlperiod.SelectedValue == "3")
            //    {
            //        txtsdt.Text = "9:00";
            //        txtenddt.Text = "9:35";
            //    }
            //    else if (ddlperiod.SelectedValue == "4")
            //    {
            //        txtsdt.Text = "9:35";
            //        txtenddt.Text = "10:10";
            //    }
            //    else if (ddlperiod.SelectedValue == "5")
            //    {
            //        txtsdt.Text = "10:10";
            //        txtenddt.Text = "10:45";
            //    }
            //    else if (ddlperiod.SelectedValue == "6")
            //    {
            //        txtsdt.Text = "10:45";
            //        txtenddt.Text = "11:20";
            //    }
            //    else if (ddlperiod.SelectedValue == "7")
            //    {
            //        txtsdt.Text = "11:20";
            //        txtenddt.Text = "11:55";
            //    }
            //    else if (ddlperiod.SelectedValue == "8")
            //    {
            //        txtsdt.Text = "11:55";
            //        txtenddt.Text = "12:30";
            //    }
            //}

        }

        protected void btnChangeIncharge_Click(object sender, EventArgs e)
        {
            try
            {
                //con.Open();
                //cmd.Connection = con;
                //cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "Select nclt_id from tbl_ClassIncharge where nc_id=(Select nc_id from tbl_Class where strClass='" + txtclassnm.Text + "' and bisDeleted=0) AND nsc_id=(Select nsc_id from tbl_Section where strSection='" + txtsecnm.Text + "' and bisDeleted=0 and nc_id=(Select nc_id from tbl_Class where strClass='" + txtclassnm.Text + "' and bisDeleted=0)) AND nu_id='" + ddltch.SelectedValue + "' AND bisDeleted='False'";


                //dr = cmd.ExecuteReader();
                //dr.Read();
                //string FirstInchargeid = dr["nclt_id"].ToString();
                //con.Close();

                //con.Open();
                //cmd.Connection = con;
                //cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "Select nclt_id from tbl_ClassIncharge where nc_id=(Select nc_id from tbl_Class where strClass='" + txtclassnm2.Text + "' and bisDeleted=0) AND nsc_id=(Select nsc_id from tbl_Section where strSection='" + txtsecnm2.Text + "' and bisDeleted=0 and nc_id=(Select nc_id from tbl_Class where strClass='" + txtclassnm2.Text + "' and bisDeleted=0)) AND nu_id='" + ddltch2.SelectedValue + "' AND bisDeleted='False'";


                //dr = cmd.ExecuteReader();
                //dr.Read();
                //string SecInchargeid = dr["nclt_id"].ToString();
                //con.Close();
        
                 if (ddltch.SelectedIndex <= 0 || ddltch2.SelectedIndex <= 0 || ddltimetable1.SelectedIndex <= 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('All Feilds Are Required');", true);
            }
            else
            {
                

                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "Update tbl_TimeTable set nu_id='" + nuid2.Text + "' where nt_id='" + ddltch.SelectedValue + "' and bisDeleted='False' AND nshdule_id ='" + ddltimetable1.SelectedValue + "' and nsch_id='" + Session["nschoolid"] + "'";


                    cmd.ExecuteNonQuery();
                    con.Close();

                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "Update tbl_TimeTable set nu_id='" + nuid1.Text + "' where nt_id='" + ddltch2.SelectedValue + "' and bisDeleted='False' AND nshdule_id ='" + ddltimetable1.SelectedValue + "' and nsch_id='" + Session["nschoolid"] + "'";


                    cmd.ExecuteNonQuery();
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Teacher class Inter changed Successfully .');", true);
                    mvtime.ActiveViewIndex = 0;
                    PopulateData();
                    
                }
              //  else
              //      ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please Select Teacher .');", true);
              ////  Response.Redirect("AdminManageClassTimeTable.aspx");
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
        public void Bind_ddlTeacher1()
        {
            con.Open();
            try
            {
                if (ddltimetable1.SelectedItem.ToString() != ">---Select Time Table---")
                {
                    SqlCommand cmd = new SqlCommand("SELECT tbl_Users.strfname + ' ' + tbl_Users.strlname +' '+tbl_Class.strClass+'-'+tbl_Section.strSection+' '+tbl_Subject.strSubject AS name, tbl_TimeTable.nt_id, tbl_Class.strClass, tbl_Section.strSection, tbl_Subject.strSubject, tbl_Schedule.strtimetable, tbl_TimeTable.strPeriod FROM tbl_Users INNER JOIN tbl_TimeTable ON tbl_Users.nu_id = tbl_TimeTable.nu_id INNER JOIN tbl_Section ON tbl_TimeTable.nsc_id = tbl_Section.nsc_id INNER JOIN tbl_Subject ON tbl_TimeTable.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Class ON tbl_TimeTable.nc_id = tbl_Class.nc_id INNER JOIN tbl_Schedule ON tbl_TimeTable.nshdule_id = tbl_Schedule.nshd_id WHERE (tbl_Users.bisDeleted = 0) AND (tbl_Section.bisDeleted = 0) AND (tbl_Subject.bisDeleted = 0) AND (tbl_Class.bisDeleted = 0) AND (tbl_Schedule.bisDeleted = 0) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = '" + Session["nschoolid"] + "') AND (tbl_TimeTable.bisDeleted = 0) AND (tbl_TimeTable.nshdule_id ='" + ddltimetable1.SelectedValue + "' ) and tbl_TimeTable.nsch_id='" + Session["nschoolid"] + "'", con);

                    SqlDataReader dr = cmd.ExecuteReader();
                    ddltch.DataSource = dr;
                    ddltch.Items.Clear();
                    ddltch.Items.Add("--Please Select Teacher--");
                    ddltch.DataTextField = "name";
                    ddltch.DataValueField = "nt_id";
                    ddltch.DataBind();
                    //con.Close();
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
        public void Bind_ddlTeacher2()
        {
            try
            {
                con.Open();
                if (ddltch.SelectedItem.ToString() != "--Please Select Teacher--")
                {
                    SqlCommand cmd = new SqlCommand("SELECT tbl_Users.strfname + ' ' + tbl_Users.strlname +' '+tbl_Class.strClass+'-'+tbl_Section.strSection+' '+tbl_Subject.strSubject AS name, tbl_TimeTable.nt_id, tbl_Class.strClass, tbl_Section.strSection, tbl_Subject.strSubject, tbl_Schedule.strtimetable, tbl_TimeTable.strPeriod FROM tbl_Users INNER JOIN tbl_TimeTable ON tbl_Users.nu_id = tbl_TimeTable.nu_id INNER JOIN tbl_Section ON tbl_TimeTable.nsc_id = tbl_Section.nsc_id INNER JOIN tbl_Subject ON tbl_TimeTable.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Class ON tbl_TimeTable.nc_id = tbl_Class.nc_id INNER JOIN tbl_Schedule ON tbl_TimeTable.nshdule_id = tbl_Schedule.nshd_id WHERE (tbl_Users.bisDeleted = 0) AND (tbl_Section.bisDeleted = 0) AND (tbl_Subject.bisDeleted = 0) AND (tbl_Class.bisDeleted = 0) AND (tbl_Schedule.bisDeleted = 0) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = '" + Session["nschoolid"] + "') AND (tbl_TimeTable.bisDeleted = 0) AND (tbl_TimeTable.nshdule_id ='" + ddltimetable1.SelectedValue + "' ) AND (tbl_TimeTable.nt_id <>'" + ddltch.SelectedValue + "' ) and tbl_TimeTable.nsch_id='" + Session["nschoolid"] + "'", con);

                    SqlDataReader dr = cmd.ExecuteReader();
                    ddltch2.DataSource = dr;
                    ddltch2.Items.Clear();
                    ddltch2.Items.Add("--Please Select Teacher--");
                    ddltch2.DataTextField = "name";
                    ddltch2.DataValueField = "nt_id";
                    ddltch2.DataBind();
                    con.Close();
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

        protected void btnInterchangeTeacher_Click(object sender, EventArgs e)
        {
            
            mvtime.ActiveViewIndex = 3;
        }

        protected void ddltimetable1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bind_ddlTeacher1();
        }

        protected void ddltch2_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
            con.Open();
            if (ddltch2.SelectedItem.ToString() != "--Please Select Teacher--")
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT strDay,strPeriod,nu_id from tbl_TimeTable where nt_id='" + ddltch2.SelectedValue + "'and bisDeleted = 'False' and nsch_id = '" + Session["nschoolid"] + "'";


                dr = cmd.ExecuteReader();
                dr.Read();
                txtDay2.Text = dr["strDay"].ToString();
                txtPeriod2.Text = dr["strPeriod"].ToString();
                nuid2.Text = dr["nu_id"].ToString();
            }
            //con.Close();
           }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }

        }

        protected void ddltch_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
            Bind_ddlTeacher2();
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT strDay,strPeriod,nu_id from tbl_TimeTable where nt_id='" + ddltch.SelectedValue + "'and bisDeleted = 'False' and nsch_id = '" + Session["nschoolid"] + "'";


            dr = cmd.ExecuteReader();
            dr.Read();
            txtDay.Text = dr["strDay"].ToString();
            txtPeriod.Text = dr["strPeriod"].ToString();
            nuid1.Text = dr["nu_id"].ToString();
            //con.Close();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }

        protected void btnChangeTeacherTime_Click(object sender, EventArgs e)
        {
            mvtime.ActiveViewIndex = 4;
        }

        protected void ddltch3_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
            Bind_ddlTeacher4();
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT strDay,strPeriod,nu_id from tbl_TimeTable where nt_id='" + ddltch3.SelectedValue + "'and bisDeleted = 'False' and nsch_id = '" + Session["nschoolid"] + "'";


            dr = cmd.ExecuteReader();
            dr.Read();
            txtDay3.Text = dr["strDay"].ToString();
            txtPeriod3.Text = dr["strPeriod"].ToString();
            nuid3.Text = dr["nu_id"].ToString();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }

        protected void btnRemoveaandChangeIncharge_Click(object sender, EventArgs e)
        {
            try
            {
            if (ddltch3.SelectedIndex <= 0 || ddltch4.SelectedIndex <= 0 || ddlTimetable3.SelectedIndex <= 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('All Feilds Are Required');", true);
            }
            else
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Update tbl_TimeTable set nu_id='" + ddltch4.SelectedValue + "' where nt_id='" + ddltch3.SelectedValue + "' and bisDeleted='False' and nshdule_id='" + ddlTimetable3.SelectedValue + "' and nsch_id = '" + Session["nschoolid"] + "' ";


                //cmd.ExecuteNonQuery();
                if (cmd.ExecuteNonQuery() == -1)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Failed To change  .');", true);
                }
                else
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Changed  Successfully.'); window.location='AdminManageClassTimeTable.aspx';", true);
                con.Close();


                //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Incharge Changed  Successfully .');", true);
                //mvt.ActiveViewIndex = 0;
                //mvtime.ActiveViewIndex = 0;
                //PopulateData();

               // Response.Redirect("AdminManageClassTimeTable.aspx");
            }
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
           
        }
        public void Bind_ddlTeacher3()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT tbl_Users.strfname + ' ' + tbl_Users.strlname +' '+tbl_Class.strClass+'-'+tbl_Section.strSection+' '+tbl_Subject.strSubject AS name, tbl_TimeTable.nt_id, tbl_Class.strClass, tbl_Section.strSection, tbl_Subject.strSubject, tbl_Schedule.strtimetable, tbl_TimeTable.strPeriod FROM tbl_Users INNER JOIN tbl_TimeTable ON tbl_Users.nu_id = tbl_TimeTable.nu_id INNER JOIN tbl_Section ON tbl_TimeTable.nsc_id = tbl_Section.nsc_id INNER JOIN tbl_Subject ON tbl_TimeTable.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Class ON tbl_TimeTable.nc_id = tbl_Class.nc_id INNER JOIN tbl_Schedule ON tbl_TimeTable.nshdule_id = tbl_Schedule.nshd_id WHERE (tbl_Users.bisDeleted = 0) AND (tbl_Section.bisDeleted = 0) AND (tbl_Subject.bisDeleted = 0) AND (tbl_Class.bisDeleted = 0) AND (tbl_Schedule.bisDeleted = 0) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = '" + Session["nschoolid"] + "') AND (tbl_TimeTable.bisDeleted = 0) AND (tbl_TimeTable.nshdule_id ='" + ddlTimetable3.SelectedValue + "' ) and tbl_TimeTable.nsch_id = '" + Session["nschoolid"] + "'", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddltch3.DataSource = dr;
                ddltch3.Items.Clear();
                ddltch3.Items.Add("--Please Select Teacher--");
                ddltch3.DataTextField = "name";
                ddltch3.DataValueField = "nt_id";
                ddltch3.DataBind();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }
        public void Bind_ddlTeacher4()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT tbl_TimeTable.nt_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS name, tbl_Users.nu_id FROM tbl_Users LEFT OUTER JOIN tbl_TimeTable ON tbl_Users.nu_id = tbl_TimeTable.nu_id AND tbl_TimeTable.bisDeleted='False' WHERE (tbl_Users.bisDeleted = 0) AND (tbl_TimeTable.nu_id IS NULL) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = '" + Session["nschoolid"] + "')", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddltch4.DataSource = dr;
                ddltch4.Items.Clear();
                ddltch4.Items.Add("--Please Select Teacher--");
                ddltch4.DataTextField = "name";
                ddltch4.DataValueField = "nu_id";
                ddltch4.DataBind();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }
        protected void ddlTimetable3_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bind_ddlTeacher3();
        }

        protected void ddltch4_SelectedIndexChanged(object sender, EventArgs e)
        {
            //con.Open();
            //cmd.Connection = con;
            //cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "SELECT strDay,strPeriod,nu_id from tbl_TimeTable where nt_id='" + ddltch3.SelectedValue + "'and bisDeleted = 'False'";


            //dr = cmd.ExecuteReader();
            //dr.Read();
           
            //nuid3.Text = dr["nu_id"].ToString();
            //con.Close();
        }

        protected void btnChangeAllTeacherClasses_Click(object sender, EventArgs e)
        {

        }
        public void Bind_ddlTeacher5()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT DISTINCT(tbl_Users.nu_id), tbl_Users.strfname + ' ' + tbl_Users.strlname AS name FROM tbl_Users INNER JOIN tbl_TimeTable ON tbl_Users.nu_id = tbl_TimeTable.nu_id INNER JOIN tbl_Section ON tbl_TimeTable.nsc_id = tbl_Section.nsc_id INNER JOIN tbl_Subject ON tbl_TimeTable.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Class ON tbl_TimeTable.nc_id = tbl_Class.nc_id INNER JOIN tbl_Schedule ON tbl_TimeTable.nshdule_id = tbl_Schedule.nshd_id WHERE (tbl_Users.bisDeleted = 0) AND (tbl_Section.bisDeleted = 0) AND (tbl_Subject.bisDeleted = 0) AND (tbl_Class.bisDeleted = 0) AND (tbl_Schedule.bisDeleted = 0) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = '" + Session["nschoolid"] + "') AND (tbl_TimeTable.bisDeleted = 0) AND (tbl_TimeTable.nshdule_id ='" + ddltimetable4.SelectedValue + "' ) and tbl_TimeTable.nsch_id = '" + Session["nschoolid"] + "'", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddltch5.DataSource = dr;
                ddltch5.Items.Clear();
                ddltch5.Items.Add("--Please Select Teacher--");
                ddltch5.DataTextField = "name";
                ddltch5.DataValueField = "nu_id";
                ddltch5.DataBind();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }
        public void Bind_ddlTeacher6()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT tbl_TimeTable.nt_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS name, tbl_Users.nu_id FROM tbl_Users LEFT OUTER JOIN tbl_TimeTable ON tbl_Users.nu_id = tbl_TimeTable.nu_id AND tbl_TimeTable.bisDeleted='False' WHERE (tbl_Users.bisDeleted = 0) AND (tbl_TimeTable.nu_id IS NULL) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = '" + Session["nschoolid"] + "')", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddltch6.DataSource = dr;
                ddltch6.Items.Clear();
                ddltch6.Items.Add("--Please Select Teacher--");
                ddltch6.DataTextField = "name";
                ddltch6.DataValueField = "nu_id";
                ddltch6.DataBind();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }
        protected void ddltimetable4_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bind_ddlTeacher5();
        }

        protected void ddltch5_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bind_ddlTeacher6();
            //con.Open();
            //cmd.Connection = con;
            //cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "SELECT strDay,strPeriod,nu_id from tbl_TimeTable where nt_id='" + ddltch5.SelectedValue + "'and bisDeleted = 'False'";


            //dr = cmd.ExecuteReader();
            //dr.Read();
            //ddlDay5.SelectedValue = dr["strDay"].ToString();
            ////txtDay5.Text = dr["strDay"].ToString();
            //txtPeriod5.Text = dr["strPeriod"].ToString();
            //nuid5.Text = dr["nu_id"].ToString();
            //con.Close();
        }

        protected void ddltch6_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnChangeAllDayTime_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddltch6.SelectedIndex <= 0 || ddltch5.SelectedIndex <= 0 || ddltimetable4.SelectedIndex <= 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('All Feilds Are Required');", true);
                }
                else
                {
                    try
                    {
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "Update tbl_TimeTable set nu_id='" + ddltch6.SelectedValue + "' where nu_id='" + ddltch5.SelectedValue + "' and bisDeleted='False' and nshdule_id='" + ddltimetable4.SelectedValue + "' and nsch_id = '" + Session["nschoolid"] + "'";

                        if (cmd.ExecuteNonQuery() == -1)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Failed To change  .');", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Changed  Successfully.'); window.location='AdminManageClassTimeTable.aspx';", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
                    }
                    finally
                    {
                        if (con.State == ConnectionState.Open)
                            con.Close();
                    }


                    //  ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Incharge Changed  Successfully .');", true);
                    //mvt.ActiveViewIndex = 0;
                    //  mvtime.ActiveViewIndex = 0;
                    // PopulateData();
                   // Response.Redirect("AdminManageClassTimeTable.aspx");
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
            
        }

        protected void btnChangeAllDaystime_Click(object sender, EventArgs e)
        {
            mvtime.ActiveViewIndex = 5;
        }
        public void Bind_ddlTeacher7()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT DISTINCT(tbl_Users.nu_id), tbl_Users.strfname + ' ' + tbl_Users.strlname AS name FROM tbl_Users INNER JOIN tbl_TimeTable ON tbl_Users.nu_id = tbl_TimeTable.nu_id  INNER JOIN tbl_Section ON tbl_TimeTable.nsc_id = tbl_Section.nsc_id INNER JOIN tbl_Subject ON tbl_TimeTable.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Class ON tbl_TimeTable.nc_id = tbl_Class.nc_id INNER JOIN tbl_Schedule ON tbl_TimeTable.nshdule_id = tbl_Schedule.nshd_id WHERE (tbl_Users.bisDeleted = 0) AND (tbl_Section.bisDeleted = 0) AND (tbl_Subject.bisDeleted = 0) AND (tbl_Class.bisDeleted = 0) AND (tbl_Schedule.bisDeleted = 0) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = '" + Session["nschoolid"] + "') AND (tbl_TimeTable.bisDeleted = 0) AND (tbl_TimeTable.nshdule_id ='" + ddltimetable5.SelectedValue + "' ) and tbl_TimeTable.nsch_id = '" + Session["nschoolid"] + "'", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddltch55.DataSource = dr;
                ddltch55.Items.Clear();
                ddltch55.Items.Add("--Please Select Teacher--");
                ddltch55.DataTextField = "name";
                ddltch55.DataValueField = "nu_id";
                ddltch55.DataBind();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }
        public void Bind_ddlTeacher8()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT tbl_TimeTable.nt_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS name, tbl_Users.nu_id FROM tbl_Users LEFT OUTER JOIN tbl_TimeTable ON tbl_Users.nu_id = tbl_TimeTable.nu_id AND tbl_TimeTable.bisDeleted='False' WHERE (tbl_Users.bisDeleted = 0) AND (tbl_TimeTable.nu_id IS NULL) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = '" + Session["nschoolid"] + "')", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddltch66.DataSource = dr;
                ddltch66.Items.Clear();
                ddltch66.Items.Add("--Please Select Teacher--");
                ddltch66.DataTextField = "name";
                ddltch66.DataValueField = "nu_id";
                ddltch66.DataBind();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }
        
        protected void ddltimetable5_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bind_ddlTeacher7();
        }

        protected void ddltch55_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bind_ddlTeacher8();
        }

        protected void btnChangeBySelectDay_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddltch66.SelectedIndex <= 0 || ddltch55.SelectedIndex <= 0 || ddltimetable5.SelectedIndex <= 0 || ddlDay5.SelectedIndex <= 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('All Feilds Are Required');", true);
                }
                else
                {
                    try
                    {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "Update tbl_TimeTable set nu_id='" + ddltch66.SelectedValue + "' where nu_id='" + ddltch55.SelectedValue + "' and strDay='" + ddlDay5.SelectedValue + "'  and bisDeleted='False'  and nshdule_id='" + ddltimetable5.SelectedValue + "' and nsch_id = '" + Session["nschoolid"] + "' ";


                    if (cmd.ExecuteNonQuery() == -1)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Failed To change  .');", true);
                    }
                    else
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Changed  Successfully.'); window.location='AdminManageClassTimeTable.aspx';", true);
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
                    }
                    finally
                    {
                        if (con.State == ConnectionState.Open)
                            con.Close();
                    }


                    //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Changed  Successfully .');", true);
                    //mvt.ActiveViewIndex = 0;
                    // mvtime.ActiveViewIndex = 0;
                    // PopulateData();
                    //Response.Redirect("AdminManageClassTimeTable.aspx");
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
          
        }
        

        protected void btnChangeByDay_Click(object sender, EventArgs e)
        {
            mvtime.ActiveViewIndex = 6;
        }

        protected void ddltimetable11_SelectedIndexChanged(object sender, EventArgs e)
        {
           
            if (ddltimetable11.SelectedItem.ToString() != "---Select Time Table---")
            {
                try
                {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Select * from tbl_Schedule where nshd_id=@id and nsch_id = '" + Session["nschoolid"] + "'";

                cmd.Parameters.AddWithValue("@id", ddltimetable11.SelectedValue);



                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    if (dr["strtimetable"].ToString() == "Summer")
                    {
                        string stdate = dr["strStartDate"].ToString();
                        stdate += "-" + DateTime.Now.Year.ToString();
                        txttdt.Text = stdate;

                        string eddate = dr["strEndDate"].ToString();
                        eddate += "-" + DateTime.Now.Year.ToString();
                        txtedt.Text = eddate;
                    }
                    if (dr["strtimetable"].ToString() == "Winter")
                    {
                        string stdate = dr["strStartDate"].ToString();
                        stdate += "-" + DateTime.Now.Year.ToString();
                        txttdt.Text = stdate;

                        string eddate = dr["strEndDate"].ToString();
                        int yyy = Convert.ToInt32(DateTime.Now.Year.ToString());
                        yyy += 1;
                        eddate += "-" + yyy.ToString();
                        txtedt.Text = eddate;
                    }
                }


              
                }
                catch (Exception ex)
                {
                    Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
                }
                finally
                {
                    if (con.State == ConnectionState.Open)
                        con.Close();
                }


                Bind_ddlPeriods();
            }
           
           
        }

        protected void btnViewTimeTable_Click(object sender, EventArgs e)
        {
            Session["nshduleid"] = "";
            dddlTimetable.DataBind();
            //dddlTimeTable2.DataBind();
            //dddlTimeTable3.DataBind();
            //dddlTimeTable4.DataBind();
            //dddlTimeTable5.DataBind();
            string id = "";
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "SELECT nshd_id,bisDeleted from tbl_Schedule where bisActive=1 and nsch_id = '" + Session["nschoolid"] + "'";


                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    id = dr["nshd_id"].ToString();

                    dddlTimetable.SelectedValue = id;
                    Session["nshduleid"] = id;
                    //dddlTimeTable2.SelectedValue = id;
                    //dddlTimeTable3.SelectedValue = id;
                    //dddlTimeTable4.SelectedValue = id;
                    //dddlTimeTable5.SelectedValue = id;
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }

            mvtime.ActiveViewIndex = 7;
        }
        protected void dddlcl_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                dddlsec.Items.Clear();
                // dddlsec.Items.Add("--Select Class Section--");
                //dddlsecDS.DataBind();
                // dddlsec.DataSource = dddlsecDS.DataSourceMode;
                dddlsec.DataBind();
            }
            catch (Exception) { }

        }

        protected void btn_BACK1_Click(object sender, EventArgs e)
        {
            //dddlTimetable.Items.Clear();
            //dddlTimetable.DataBind();
            //dddlTimeTable2.Items.Clear();
            //dddlTimeTable2.DataBind();

            //dddlTimeTable3.Items.Clear();
            //dddlTimeTable3.DataBind();
            //dddlTimeTable4.Items.Clear();
            //dddlTimeTable4.DataBind();
            //dddlTimeTable5.Items.Clear();
            //dddlTimeTable5.DataBind();
            mvtime.ActiveViewIndex = 0;
        }

        protected void btn_Tchbyday_Click(object sender, EventArgs e)
        {
           
            mvtime.ActiveViewIndex = 8;
            //dddlTimetable.DataBind();
          //  dddlTimeTable2.DataBind();
            // dddlTimeTable3.DataBind();
            // dddlTimeTable4.DataBind();
            //  dddlTimeTable5.DataBind();
           
        }

        protected void btn_Day_Click(object sender, EventArgs e)
        {
            
            mvtime.ActiveViewIndex = 10;

            //dddlTimetable.DataBind();
            // dddlTimeTable2.DataBind();
            // dddlTimeTable3.DataBind();
            // dddlTimeTable4.DataBind();
            //  dddlTimeTable5.DataBind();
         
        }

        protected void btn_TchDayClass_Click(object sender, EventArgs e)
        {
            mvtime.ActiveViewIndex = 9;
            //dddlTimetable.DataBind();
            // dddlTimeTable2.DataBind();
            // dddlTimeTable3.DataBind();
            // dddlTimeTable4.DataBind();
            //  dddlTimeTable5.DataBind();
         
        }

        protected void btnPeriod_and_Day_Click(object sender, EventArgs e)
        {
            mvtime.ActiveViewIndex = 11;
            //dddlTimetable.DataBind();
            // dddlTimeTable2.DataBind();
            // dddlTimeTable3.DataBind();
            // dddlTimeTable4.DataBind();
            //  dddlTimeTable5.DataBind();
         
        }
        public void Bind_ddlPeriods()
        {
            try
            {
                con.Open();
                string bit = "False";
                SqlCommand cmd = new SqlCommand("Select p.np_id,p.strPeriod as name from tbl_Period p inner join tbl_Schedule shdl on p.nshdul_id=shdl.nshd_id  where p.bisDeleted=@bit and p.nsch_id=@schid and p.nshdul_id=@shdid", con);
                cmd.Parameters.AddWithValue("@bit", bit);
                cmd.Parameters.AddWithValue("@shdid",ddltimetable11.SelectedValue);
                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
                SqlDataReader dr = cmd.ExecuteReader();
                ddlperiod.DataSource = dr;
                ddlperiod.Items.Clear();
                ddlperiod.Items.Add("--Please Select Period--");
                ddlperiod.DataTextField = "name";
                ddlperiod.DataValueField = "np_id";
                ddlperiod.DataBind();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManage.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }
        public void Bind_ddlPeriods5()
        {
           
        }

        protected void dddlTimeTable5_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                dddlperiod5.Items.Clear();
                con.Open();
                string bit = "False";
                SqlCommand cmd = new SqlCommand("Select p.np_id,p.strPeriod as name from tbl_Period p inner join tbl_Schedule shdl on p.nshdul_id=shdl.nshd_id  where p.bisDeleted=@bit and p.nsch_id=@schid and p.nshdul_id=@shdid", con);
                cmd.Parameters.AddWithValue("@bit", bit);
                cmd.Parameters.AddWithValue("@shdid", dddlTimeTable5.SelectedValue);
                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
                SqlDataReader dr = cmd.ExecuteReader();
                dddlperiod5.Items.Add(new ListItem("--Please Select Period--", "0"));
                dddlperiod5.DataSource = dr;
                dddlperiod5.DataTextField = "name";
                dddlperiod5.DataValueField = "np_id";
                dddlperiod5.DataBind();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageClassTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }

        protected void ddlperiod_SelectedIndexChanged1(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                string bit = "";
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    string shduleid = ddltimetable11.SelectedValue;

                    cmd.CommandText = "select strStartTime,strEndTime from tbl_Period where (bisDeleted=@bit) and nshdul_id=@shd and nsch_id=@schid and np_id=@pid";
                    cmd.Parameters.AddWithValue("@bit", bit);
                    cmd.Parameters.AddWithValue("@shd", ddltimetable11.SelectedValue);
                    cmd.Parameters.AddWithValue("@pid", ddlperiod.SelectedValue);
                    cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());    
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            txtsdt.Text = dr["strStartTime"].ToString();
                            txtenddt.Text = dr["strEndTime"].ToString();
                            break;
                        }
                    }
                    con.Close();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=AdminManageClassTimeTable.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }

        protected void btnday_Click(object sender, EventArgs e)
        {
            PopulateData1();
        }
        private void PopulateData1()
        {

            try
            {
                if (ddlTimetable.SelectedItem.ToString() != "---Select Time Table---")
                {

                    DataTable table = new DataTable();

                    using (SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
                    {

                        string sql = "select p.strPeriod,t.strDay,t.nt_id,c.strClass,sc.strSection,s.strSubject,u.strfname,u.strfname+' '+u.strlname as name,p.strStartTime,p.strEndTime,t.strShift,shdl.strStartDate,shdl.strEndDate,shdl.strtimetable from tbl_TimeTable t inner join tbl_Class c on t.nc_id=c.nc_id inner join tbl_Subject s on t.nsbj_id=s.nsbj_id inner join tbl_Users u on t.nu_id=u.nu_id inner join tbl_Section sc on t.nsc_id=sc.nsc_id inner join tbl_Schedule shdl on t.nshdule_id=shdl.nshd_id inner join tbl_Period p on t.np_id=p.np_id where t.bisDeleted='False' and c.bisDeleted='False' and s.bisDeleted='False' and u.bisDeleted='False' and sc.bisDeleted='False' and p.bisDeleted='False' and t.nsch_id='" + Session["nschoolid"] + "' and strType='Class' and t.nshdule_id='" + ddlTimetable.SelectedValue + "' Order by p.strPeriod";

                        using (SqlCommand cmd1 = new SqlCommand(sql, con1))
                        {

                            using (SqlDataAdapter ad = new SqlDataAdapter(cmd1))
                            {

                                ad.Fill(table);

                            }

                        }

                    }

                    gvttable.DataSource = table;

                    gvttable.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }

        }
        private void PopulateData2()
        {

            try
            {
                if (ddlTimetable.SelectedItem.ToString() != "---Select Time Table---")
                {

                    DataTable table = new DataTable();

                    using (SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
                    {

                        string sql = "select p.strPeriod,t.strDay,t.nt_id,c.strClass,sc.strSection,s.strSubject,u.strfname,u.strfname+' '+u.strlname as name,p.strStartTime,p.strEndTime,t.strShift,shdl.strStartDate,shdl.strEndDate,shdl.strtimetable from tbl_TimeTable t inner join tbl_Class c on t.nc_id=c.nc_id inner join tbl_Subject s on t.nsbj_id=s.nsbj_id inner join tbl_Users u on t.nu_id=u.nu_id inner join tbl_Section sc on t.nsc_id=sc.nsc_id inner join tbl_Schedule shdl on t.nshdule_id=shdl.nshd_id inner join tbl_Period p on t.np_id=p.np_id where t.bisDeleted='False' and c.bisDeleted='False' and s.bisDeleted='False' and u.bisDeleted='False' and sc.bisDeleted='False' and p.bisDeleted='False' and t.nsch_id='" + Session["nschoolid"] + "' and strType='Class' and t.nshdule_id='" + ddlTimetable.SelectedValue + "' Order by t.strDay";

                        using (SqlCommand cmd1 = new SqlCommand(sql, con1))
                        {

                            using (SqlDataAdapter ad = new SqlDataAdapter(cmd1))
                            {

                                ad.Fill(table);

                            }

                        }

                    }

                    gvttable.DataSource = table;

                    gvttable.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }

        }
        protected void btnseccls_Click(object sender, EventArgs e)
        {
            PopulateData2();
        }
    }
}