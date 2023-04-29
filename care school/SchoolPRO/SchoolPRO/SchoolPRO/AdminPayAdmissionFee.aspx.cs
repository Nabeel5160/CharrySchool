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

namespace SchoolPRO
{
    public partial class AdminPayAdmissionFee : System.Web.UI.Page
    {
        string fbit = BIT_T_F.FalseBit();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                BindGrid();
               
            }
            PaidDisable();

        }
        private void PaidDisable()
        {
            try
            {

                foreach (GridViewRow gvr in gvfee.Rows)
                {
                    if (gvr.Cells[10].Text == "Paid")
                    {
                        Button b = (Button)gvr.FindControl("Paid");
                        b.Enabled = false;
                    }
                }
            }
            catch { }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();

        SqlDataReader dr;
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select rf.nfr_id,Cast(rf.nChallanNum as varchar(100)) nChallanNum,rf.strFeeAmount,e.ne_id,e.strFname+' '+e.strLname as strname,c.strClass,s.strSection,rf.dtAddDate,IIF ( rf.bisPaid = 1, 'Paid', 'Not Paid' ) as paid from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Section s on e.nsc_id=s.nsc_id where rf.strRecieveType='Admission' and rf.bisDeleted='False'  and rf.nsch_id='" + Session["nschoolid"] + "'";
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
                    gvfee.DataSource = dt;
                    gvfee.DataBind();
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
        private void PopulateData()
        {
            try
            {
                DataTable table = new DataTable();

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
                {

                    string sql = "select rf.nfr_id,Cast(rf.nChallanNum as varchar(100)) nChallanNum,rf.strFeeAmount,e.ne_id,e.strFname+' '+e.strLname as strname,c.strClass,s.strSection,rf.dtAddDate,IIF ( rf.bisPaid = 1, 'Paid', 'Not Paid' ) as paid from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Section s on e.nsc_id=s.nsc_id where rf.strRecieveType='Admission' and rf.bisDeleted='False' and rf.nsch_id='" + Session["nschoolid"] + "'";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {

                        using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                        {

                            ad.Fill(table);

                        }

                    }

                }

                gvfee.DataSource = table;

                gvfee.DataBind();
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
        protected void gvfee_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvfee.PageIndex = e.NewPageIndex;
                PopulateData();
            }
            catch (Exception ex)
            {
                //Response.Redirect("Error.aspx");
            }

        }
        /// <summary>
        /// ///////////////
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        /// 
        string cls = "", sec = "";
        string GenrerateStudentNumber(string neid)
        {
            string student_number = "";
            string cid="0",scid="0";
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select c.nc_id,c.strClass,sc.nsc_id,sc.strSection from  tbl_Enrollment e inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Section sc on e.nsc_id=sc.nsc_id  where e.ne_id=@eid and e.bisDeleted=@tbit and e.nsch_id=@schid1";
                //  cmd.CommandText = "select strStudentNum from  tbl_StudentNumber where ne_id=(select Max(ne_id) as Id from tbl_StudentNumber where  nsc_id=(select nsc_id from tbl_Section where strSection='" + ddsec.Text + "' and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted='False')and bisDeleted='False') and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted='False') and bisDeleted='False')";
                cmd.Parameters.AddWithValue("@eid", neid);
                cmd.Parameters.AddWithValue("@tbit", BIT_T_F.TrueBit());


                cmd.Parameters.AddWithValue("@schid1", Session["nschoolid"].ToString());
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    cls = dr["strClass"].ToString();
                    sec = dr["strSection"].ToString();
                    cid = dr["nc_id"].ToString();
                    scid = dr["nsc_id"].ToString();
                }
                con.Close();




                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select strStudentNum from  tbl_Enrollment where ne_id=(select Max(ne_id) as Id from tbl_Enrollment where  nsc_id=@scid and nc_id=@cid and bisDeleted=@bit and nsch_id= @schid)";
                //  cmd.CommandText = "select strStudentNum from  tbl_StudentNumber where ne_id=(select Max(ne_id) as Id from tbl_StudentNumber where  nsc_id=(select nsc_id from tbl_Section where strSection='" + ddsec.Text + "' and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted='False')and bisDeleted='False') and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted='False') and bisDeleted='False')";
                cmd.Parameters.AddWithValue("@scid", scid);
                cmd.Parameters.AddWithValue("@cid", cid);
                cmd.Parameters.AddWithValue("@bit", fbit);


                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
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

                    student_number = NewSTNUM;
                    //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('The Student Verification Number already exist.');", true);
                }
                else
                {
                    string stnum = cls + sec + "-" + "1";
                    student_number = stnum;
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
            return student_number;

        }


        protected void Paid_Click(object sender, EventArgs e)
        {
            try
            {
                
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                // Label nfr_id=(Label)gvr.FindControl()
                string del = gvr.Cells[1].Text;
                string neid = gvr.Cells[2].Text;

                Label ch = (Label)gvr.FindControl("lblcname");
                string chno = ch.Text;
                if (gvr.Cells[10].Text != "Paid")
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    //cmd.CommandText = "update tbl_RecieveFee set bisPaid=1 where nfr_id='" + del + "'  and nsch_id='" + Session["nschoolid"] + "'";
                    cmd.CommandText = "update tbl_RecieveFee set bisPaid=1,dtPaidDate=@dt,tmPaidTime=@tm,nPaidby=@uid where nfr_id='" + del + "'  and nsch_id='" + Session["nschoolid"] + "' and bisPaid=0";
                    cmd.Parameters.AddWithValue("@dt", DATE_FORMAT.format());
                    cmd.Parameters.AddWithValue("@tm", DATE_FORMAT.time());
                    cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                    if (cmd.ExecuteNonQuery() == -1)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Fee Not Paid.... Sorry.....');", true);
                    }
                    else
                    {
                        AdminFunctions add = new AdminFunctions();
                        add.Paid_True_Bit(chno);
                        PopulateData();

                    }

                    string stnumb = GenrerateStudentNumber(neid);
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "update tbl_Enrollment set bisDeleted='False',strStatus='Confirm',strStudentNum=@stnumb,dtAdmissionConfirmDate=@dt,nAdmissionConfirmBy=@uid where ne_id='" + neid + "'  and nsch_id='" + Session["nschoolid"] + "'";
                    cmd.Parameters.AddWithValue("@stnumb", stnumb);
                    cmd.Parameters.AddWithValue("@dt", DATE_FORMAT.format());
                    cmd.Parameters.AddWithValue("@uid",Session["uid"].ToString());
                    cmd.ExecuteNonQuery();
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
        protected void gvsearchclass_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                System.Threading.Thread.Sleep(2000);
                if (e.CommandName == "Search")
                {
                    TextBox txtGrid = (TextBox)gvfee.HeaderRow.FindControl("txtcc");
                    SearchText(txtGrid.Text);
                }
            }
            catch (Exception) { }
        }
        private void SearchText(string strSearchText)
        {
            try
            {
                DataTable dt = GetRecords();
                DataView dv = new DataView(dt);
                string SearchExpression = null;
                if (!String.IsNullOrEmpty(strSearchText))
                {
                    SearchExpression =
                    string.Format("{0} '%{1}%'", gvfee.SortExpression, strSearchText);

                }
                else
                    Response.Redirect("#");
                dv.RowFilter = "nChallanNum like" + SearchExpression;
                gvfee.DataSource = dv;
                gvfee.DataBind();

                PaidDisable();
            }
            catch (Exception) { }
        }
        //public string Highlight(string InputTxt)
        //{
        //    GridViewRow gvr = gvfee.HeaderRow;
        //    if (gvr != null)
        //    {
        //        TextBox txtExample = (TextBox)gvfee.HeaderRow.FindControl("txtcc");

        //        if (txtExample.Text != null)
        //        {
        //            string strSearch = txtExample.Text;
        //            Regex RegExp = new Regex(strSearch.Replace(" ", "|").Trim(), RegexOptions.IgnoreCase);
        //            return RegExp.Replace(InputTxt, new MatchEvaluator(ReplaceKeyWords));
        //            RegExp = null;
        //        }
        //        else
        //            return InputTxt;
        //    }
        //    else
        //    {
        //        return InputTxt;
        //    }
        //}

        protected void gvfee_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void txtcc_TextChanged(object sender, EventArgs e)
        {

        }
    }
}