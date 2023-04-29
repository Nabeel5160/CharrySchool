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
    public partial class AdminPayFee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                BindGrid();
                txtcc.Focus();
              //  PaidDisable();
            }
            else
            {
                txtbcode.Focus();
            }
            //PaidDisable();
            
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
            cmd.CommandText = "select rf.nfr_id,Cast(rf.nChallanNum as varchar(100)) as nChallanNum,rf.strFeeAmount,e.ne_id,e.strFname+' '+e.strLname as strname,c.strClass,s.strSection,rf.dtAddDate,rf.bisPaid as paid from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Section s on e.nsc_id=s.nsc_id where rf.strRecieveType='Class' and rf.bisDeleted='False' and rf.nsch_id='" + Session["nschoolid"] + "' order by nChallanNum DESC";
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

                    string sql = "select rf.nfr_id,Cast(rf.nChallanNum as varchar(100)) nChallanNum,rf.strFeeAmount,e.ne_id,e.strFname+' '+e.strLname as strname,c.strClass,s.strSection,rf.dtAddDate,IIF ( rf.bisPaid = 1, 'Paid', 'Not Paid' ) as paid from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Section s on e.nsc_id=s.nsc_id where rf.strRecieveType='Class' and rf.bisDeleted='False' and rf.nsch_id='" + Session["nschoolid"] + "'";

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
                //PaidDisable();
            }
            catch (Exception ex)
            {
                //Response.Redirect("Error.aspx");
            }

        }
        public void UpdateAccount(string accnum,string totfee ,string remaing)
        {
           try
                {
                    Int32 amount = 0;
                    Int32 total = 0;
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select strAmount from tbl_Bank where strAccNum='" + accnum+ "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
                    dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        amount = Convert.ToInt32(dr["strAmount"].ToString());
                    }
                    // total = amount + Convert.ToInt32(txtfee.Text) + Convert.ToInt32(txtFine.Text) - Convert.ToInt32(txtRemnfee.Text);
                    total = amount + Convert.ToInt32(totfee) - Convert.ToInt32(remaing);
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "update tbl_Bank set strAmount=@amnt where strAccNum='" + accnum + "'  and nsch_id='" + Session["nschoolid"] + "'";
                    cmd.Parameters.AddWithValue("@amnt", total);
                    cmd.ExecuteNonQuery();
                    con.Close();
                 }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Error')", true);
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                    cmd.Parameters.Clear();
                    cmd.Dispose();
                }
            }
        }
        public List<string> GETtotFee(string challanid)
        {
            List<string> amt = new List<string>();
            try
            {
                Int32 amount = 0;
                Int32 total = 0;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select strFeeAmountReceived amt,strFeeAmountRemaining as remanamt from tbl_RecieveFee where nChallanNum=@id and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
                cmd.Parameters.AddWithValue("id", challanid);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    amt.Add(dr["amt"].ToString());
                    amt.Add(dr["remanamt"].ToString());
                   
                }
                // total = amount + Convert.ToInt32(txtfee.Text) + Convert.ToInt32(txtFine.Text) - Convert.ToInt32(txtRemnfee.Text);
               
                con.Close();
               
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Error')", true);
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                    cmd.Parameters.Clear();
                    cmd.Dispose();
                }
            }
            return amt;

        }
        protected void Paid_Click(object sender, EventArgs e)
        {
            try{

                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                // Label nfr_id=(Label)gvr.FindControl()
                string del = gvr.Cells[1].Text;
                string neid = gvr.Cells[2].Text;

                Label ch = (Label)gvr.FindControl("lblcname");
                string chno = ch.Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_RecieveFee set bisPaid=1,dtPaidDate=@dt,tmPaidTime=@tm,nPaidby=@uid where nfr_id='" + del + "'  and nsch_id='" + Session["nschoolid"] + "' and bisPaid=0";
            cmd.Parameters.AddWithValue("@dt", DATE_FORMAT.format());
            cmd.Parameters.AddWithValue("@tm", DATE_FORMAT.time());
            cmd.Parameters.AddWithValue("@uid",Session["uid"].ToString());

                
            if (cmd.ExecuteNonQuery() == -1)
            {
                con.Close();

               

                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Fee Not Paid.... Sorry.....');", true);
            }
            else
            {
                con.Close();
                AdminFunctions add = new AdminFunctions();
                add.Paid_True_Bit(chno);


                PopulateData();
            }
                

            //con.Close();
            
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
                    gvfee.SortExpression, txtcc.Text);

                }
                else
                {
                    Response.Redirect("AdminPayFee.aspx");
                }
                dv.RowFilter = "Convert(nChallanNum,'System.String') like" + SearchExpression;
                gvfee.DataSource = dv;
                gvfee.DataBind();

            }
            catch (Exception ex)
            {
            }
        }
        public string Highlight(string InputTxt)
        {
            string Search_Str = txtcc.Text.ToString();
            // Setup the regular expression and add the Or operator.
            Regex RegExp = new Regex(Search_Str.Replace(" ", "|").Trim(),
            RegexOptions.IgnoreCase);

            // Highlight keywords by calling the 
            //delegate each time a keyword is found.
            return RegExp.Replace(InputTxt,
            new MatchEvaluator(ReplaceKeyWords));

            // Set the RegExp to null.
            RegExp = null;

        }

        public string ReplaceKeyWords(Match m)
        {

            return "<span class='highlight'>" + m.Value + "</span>";

        }

        protected void gvfee_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void btngo_Click(object sender, EventArgs e)
        {
            txtbcode.Focus();
            mvsub.ActiveViewIndex = 1;
        }

        protected void txtbcode_TextChanged(object sender, EventArgs e)
        {
            try{
                List<PrintChallan> challan = new List<PrintChallan>();
                string duedate = "";Int64 totalrecvd=0;
                string eid = "", fr_id = ""; string feeamount = "", newchallan="",oldchallan="",fineamount="0";
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select f.dtDueDate,f.nFine,e.ne_id,r.nfr_id,r.nChallanNum,r.strFeeAmount from tbl_RecieveFee r inner join tbl_Enrollment e on r.ne_id=e.ne_id inner join tbl_Fee f on e.nfee_id=f.nfee_id where r.nChallanNum='" + txtbcode.Text + "' and bisPaid=0";
                dr = cmd.ExecuteReader();
                
                while (dr.Read())
                {
                    PrintChallan pc = new PrintChallan();
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    duedate = dr["dtDueDate"].ToString();
                    eid = dr["ne_id"].ToString();
                    fr_id = dr["nfr_id"].ToString();
                    feeamount = dr["strFeeAmount"].ToString();
                    oldchallan=dr["nChallanNum"].ToString();
                    
                    if (duedate != "")
                    {
                        if (Convert.ToInt32(DateTime.Now.Day.ToString()) > Convert.ToInt32(duedate))
                        {
                            if (oldchallan == newchallan)
                            {
                            }
                            else
                            {
                                newchallan = oldchallan;
                                fineamount = dr["nFine"].ToString();
                                int today = Convert.ToInt32(DateTime.Now.Day.ToString());
                                int dueday = Convert.ToInt32(duedate);
                                //int numofdays = today - dueday;
                                totalrecvd = Convert.ToInt64(feeamount) + (Convert.ToInt64(dr["nFine"].ToString()));
                            }
                        }
                        else
                        {
                            totalrecvd = Convert.ToInt64(feeamount);
                        }
                    }
                    else
                    {
                        totalrecvd = Convert.ToInt64(feeamount);
                    }
                    pc.bcode = oldchallan;
                    pc.invoice = fr_id;
                    pc.studentfine = fineamount;
                    pc.totalrcvfee = totalrecvd.ToString();
                    challan.Add(pc);
                        
                    //con.Open();
                }
                con.Close();
                Int64 amount = 0,total=0;
                challan.TrimExcess();
                foreach (var pc in challan)
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select strAmount from tbl_Bank where strAccNum='" + ddacnum.SelectedItem.Value + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
                    dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        amount = Convert.ToInt32(dr["strAmount"].ToString());
                    }
                    // total = amount + Convert.ToInt32(txtfee.Text) + Convert.ToInt32(txtFine.Text) - Convert.ToInt32(txtRemnfee.Text);
                    total = amount + Convert.ToInt32(pc.totalrcvfee);
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "update tbl_Bank set strAmount=@amnt where strAccNum='" + ddacnum.SelectedItem.Value + "'  and nsch_id='" + Session["nschoolid"] + "'";
                    cmd.Parameters.AddWithValue("@amnt", total);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "update tbl_RecieveFee set strFeeAmountReceived=@feercvd, bisPaid='1', dtPaidDate=@dt, tmPaidTime=@tm, nPaidby=@uid where nChallanNum='" + pc.bcode + "' and nfr_id='" + pc.invoice + "'  and nsch_id='" + Session["nschoolid"] + "' and bisPaid=0";
                    cmd.Parameters.AddWithValue("@dt", DATE_FORMAT.format());
                    cmd.Parameters.AddWithValue("@tm", DATE_FORMAT.time());
                    cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                    cmd.Parameters.AddWithValue("@feercvd", pc.totalrcvfee);
                    cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();
                    con.Close();
                    AdminFunctions add1 = new AdminFunctions();
                    add1.challanTransferRecordWith_True_Bit(pc.bcode.ToString(), ddacnum.SelectedValue, amount.ToString(), total.ToString(), pc.totalrcvfee.ToString(), eid, Session["uid"].ToString(), Session["nschoolid"].ToString());
                    lblnotify.ForeColor = System.Drawing.Color.Green;
                    lblnotify.Text = "Fee Received Successfully...";
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('" + lblnotify.Text + "');", true);
                }
                

                AdminFunctions add = new AdminFunctions();
                add.Paid_True_Bit(txtbcode.Text);
                    
                PopulateData();
                txtbcode.Text = "";
            //con.Close();
            
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

        protected void btngobck_Click(object sender, EventArgs e)
        {
            mvsub.ActiveViewIndex = 0;
        }
    }
}