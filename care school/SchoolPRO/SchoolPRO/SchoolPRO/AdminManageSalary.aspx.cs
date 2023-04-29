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
    public partial class AdminManageSalary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
            if (!IsPostBack)
            {

                BindGrid();
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

            }
            if (chkbn.Checked)
            {
                txtbns.Visible = true;
            }
            else
            {
                txtbns.Visible = false;
            }
            if (IsPostBack)
            {
                //if(ddenm.SelectedIndex != -1)
                //status();
            }
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
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminManageLoans.aspx");
            
        }

        protected void btnAddexp_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from tbl_Salary where nu_id='" + ddenm.SelectedValue + "' and SUBSTRING(dtAddDate ,4,2)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2) and SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) and bisDeleted='False' and nsch_id=@schid6";
                cmd.Parameters.AddWithValue("@schid6", Session["nschoolid"]);
                dr=cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Salary  already exist For this Month.');", true);
                    txtfine.Text = "";
                    txtsalary.Text = "";
                    txtbns.Text = "";
                    ddenm.Focus();
                }
                else
                {
                

                    int t_amount = 0;
                    int actual_amount = 0;
                    Boolean ValidAmountflag = true;
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select strAmount from tbl_Bank where strAccNum='" + ddacnum.Text + "' and bisDeleted='False' and nsch_id='"+Session["nschoolid"]+"'";
                    dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        t_amount = Convert.ToInt32(dr["strAmount"]);
                    }

                    

                    if (chkbn.Checked == true)
                    {
                        if (t_amount >= (Convert.ToInt32(txtsalary.Text) + Convert.ToInt32(txtbns.Text)))
                        {
                            actual_amount = t_amount - (Convert.ToInt32(txtsalary.Text) + Convert.ToInt32(txtbns.Text));
                        }
                        else
                            ValidAmountflag = false;
                    }
                    else
                    {
                        if (t_amount >= Convert.ToInt32(txtsalary.Text))
                        {
                            actual_amount = t_amount - Convert.ToInt32(txtsalary.Text);
                        }

                        else
                            ValidAmountflag = false;
                        
                    }

                    con.Close();

                    if (ValidAmountflag)
                    {
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "update tbl_Bank set strAmount=@am where strAccNum='" + ddacnum.Text + "' and bisDeleted='False' and nsch_id=@schid8";
                        cmd.Parameters.AddWithValue("@schid8", Session["nschoolid"]);
                        cmd.Parameters.AddWithValue("@am", actual_amount);
                        cmd.ExecuteNonQuery();
                        con.Close();
                        
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "Select MAX(nPayslip)+1 as d from tbl_Salary ";//"select IIF(nPayslip is Not Null, MAX(nPayslip)+1,'10') as d from tbl_Salary Group by nPayslip";

                        dr = cmd.ExecuteReader();
                        string payslip = "";
                       // if (dr.HasRows)
                        {
                            dr.Read();
                           
                            payslip = dr["d"].ToString();

                            if (payslip == "")
                                payslip = "10";
                        }
                        con.Close();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_Salary(nPayslip,userid,nu_id,strSalary,strFine,strBonus,dtAddDate,bisDeleted,nsch_id) values(@payslip,'"+Session["uid"]+"','" + ddenm.SelectedValue + "',@sal,'" + txtfine.Text + "',@bns,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False','" + Session["nschoolid"]+"')";
                        
                        // cmd.Parameters.AddWithValue("@nm", ddenm.Text);
                        cmd.Parameters.AddWithValue("@sal", txtsalary.Text);
                        cmd.Parameters.AddWithValue("@payslip", payslip);
                        if (chkbn.Checked == true)
                        {
                            cmd.Parameters.AddWithValue("@bns", txtbns.Text);
                        }
                        else
                        {
                            txtbns.Text = "0";
                            cmd.Parameters.AddWithValue("@bns", txtbns.Text);
                        }
                        cmd.ExecuteNonQuery();
                        con.Close();
                        //con.Close();
                        //con.Open();
                        //cmd.Connection = con;
                        //cmd.CommandType = CommandType.Text;
                        //cmd.CommandText = "Select Max(nsal_id) from tbl_Salary where bisDeleted='False'";

                       // int inv = Convert.ToInt32(cmd.ExecuteScalar());
                        int inv = Convert.ToInt32(payslip);

                       /// con.Close();

                        PopulateData();
                        ////////////////////////////////////////////
                        txtempInvc.Text = inv.ToString();
                        date.Text = DateTime.Now.Date.ToString();
                        txtempName.Text = ddenm.SelectedItem.ToString();
                        txtemptotsal.Text = txtsalary.Text;
                        txtempsal.Text = txtamnt.Text;
                        txtempAbsnt.Text = lbla.Text;
                        txtempprsnt.Text = lblp.Text;
                        txtempfulleaves.Text = lblfullv.Text;
                        txtemphalfleaves.Text = lblhalflv.Text;
                        txtempBonus.Text = txtbns.Text;
                        txtempfine.Text = txtfine.Text;

                        mvsal.ActiveViewIndex = 2;

                        txtbns.Text = "";
                        txtamnt.Text = "";
                    }
                    else
                        ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "alert('Your School  Account Does Not Have Amount To Pay Salary For This Employee');", true);
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

        protected void lblgoback_Click(object sender, EventArgs e)
        {
            mvsal.ActiveViewIndex = 0;
        }
        protected void gvvend_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            System.Threading.Thread.Sleep(2000);
            if (e.CommandName == "Search")
            {
                TextBox txtGrid = (TextBox)gvsal.HeaderRow.FindControl("txtcc");
                SearchText(txtGrid.Text);
            }
        }

        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select s.nsal_id,u.strfname+' '+u.strlname as name,s.strSalary,s.strBonus,s.dtAddDate from tbl_Salary s inner join tbl_Users u on s.nu_id=u.nu_id where u.bisDeleted='False' and u.nsch_id=@schid and s.bisDeleted='False' and s.nsch_id=@schid  and u.nLevel=@tch_emp";
            cmd.Parameters.AddWithValue("@tch_emp", UsersLevel.getTchLevel());
            cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
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
                gvsal.DataSource = dt;
                gvsal.DataBind();

            }
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                
            }
            
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
                string.Format("{0} '%{1}%'", gvsal.SortExpression, strSearchText);

            }
                else
                Response.Redirect("AdminManageSalary.aspx");

            dv.RowFilter = "name like" + SearchExpression;
            gvsal.DataSource = dv;
            gvsal.DataBind();
            }
            catch (Exception ex)
            {
               // Response.Redirect("Error.aspx");
            }
            finally
            {
                
            }
        }

        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvsal.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvsal.HeaderRow.FindControl("txtcc");

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

                    string sql = "Select s.nsal_id,u.strfname+' '+u.strlname as name,s.strSalary,s.strBonus,s.dtAddDate from tbl_Salary s inner join tbl_Users u on s.nu_id=u.nu_id where u.bisDeleted='False' and u.nsch_id=@schid and s.bisDeleted='False' and s.nsch_id=@schid and u.nLevel=@tch_emp";
                    

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@tch_emp", UsersLevel.getTchLevel());
                        cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);
                        using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                        {

                            ad.Fill(table);

                        }

                    }

                }

                gvsal.DataSource = table;

                gvsal.DataBind();
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
        public void status()
        {
            if (ddenm.SelectedItem.ToString() != "--Select Employee--")
            {
                try
                {
                    SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());

                    con1.Open();
                    cmd.Connection = con1;
                    cmd.CommandType = CommandType.Text;
                    //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Present' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                    cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where dtAddDate>='"+txtfrm.Text+"' and dtAddDate<='"+txtto.Text+"' and strStatus='Present' and nu_id='" + Convert.ToInt32(ddenm.Text) + "' and SUBSTRING(dtAddDate ,4,2)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2) and SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) and bisDeleted='False' and nsch_id=@schid";
                    cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);
                    int present = Convert.ToInt32(cmd.ExecuteScalar());
                    //if (present > 0)
                    //{
                    lblp.Text = present.ToString();
                    //}
                    con1.Close();
                    con1.Open();
                    cmd.Connection = con1;
                    cmd.CommandType = CommandType.Text;
                    //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Abscent' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                    cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where dtAddDate>='" + txtfrm.Text + "' and dtAddDate<='" + txtto.Text + "' and strStatus='Absent' and nu_id='" + Convert.ToInt32(ddenm.SelectedValue) + "' and SUBSTRING(dtAddDate ,4,2)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2) and SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) and bisDeleted='False' and nsch_id=@schid1";
                    cmd.Parameters.AddWithValue("@schid1", Session["nschoolid"]);
                    int Abscent = Convert.ToInt32(cmd.ExecuteScalar());
                    //if (Abscent > 0)
                    //{
                    lbla.Text = Abscent.ToString();
                    //}
                    con1.Close();
                    con1.Open();
                    cmd.Connection = con1;
                    cmd.CommandType = CommandType.Text;
                    //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Half Leave Application' OR strStatus='Full Leave Application' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                    cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where nu_id='" + Convert.ToInt32(ddenm.SelectedValue) + "' and strStatus='Half Leave Application' and SUBSTRING(dtAddDate ,4,2)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2) and SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) and bisDeleted='False' and nsch_id=@schid2";
                    cmd.Parameters.AddWithValue("@schid2", Session["nschoolid"]);
                    int Leave = Convert.ToInt32(cmd.ExecuteScalar());
                    //if (Leave > 0)
                    //{
                    lblhalflv.Text = Leave.ToString();
                    //}
                    con1.Close();
                    con1.Open();
                    cmd.Connection = con1;
                    cmd.CommandType = CommandType.Text;
                    //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Half Leave Application' OR strStatus='Full Leave Application' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                    cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where nu_id='" + Convert.ToInt32(ddenm.SelectedValue) + "' and strStatus='Full Leave Application' and SUBSTRING(dtAddDate ,4,2)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2) and SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) and bisDeleted='False' and nsch_id=@schid3";
                    cmd.Parameters.AddWithValue("@schid3", Session["nschoolid"]);
                    int fulLeave = Convert.ToInt32(cmd.ExecuteScalar());
                    //if (Leave > 0)
                    //{
                    lblfullv.Text = fulLeave.ToString();
                    //}
                    con1.Close();
                    con1.Open();
                    cmd.Connection = con1;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Late' and nu_id='" + Convert.ToInt32(ddenm.SelectedValue) + "' and SUBSTRING(dtAddDate ,4,2)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2) and SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) and bisDeleted='False' and nsch_id=@schid4";
                    cmd.Parameters.AddWithValue("@schid4", Session["nschoolid"]);
                    int Late = Convert.ToInt32(cmd.ExecuteScalar());
                    //if (Late > 0)
                    //{
                    lbllate.Text = Late.ToString();
                    //}

                    con1.Close();


                    con1.Open();
                    cmd.Connection = con1;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select strRetAmount from tbl_Loan where nu_id='" + Convert.ToInt32(ddenm.SelectedValue) + "' and nsch_id='"+Session["nschoolid"]+"'";
                    dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        loan = Convert.ToInt32(dr["strRetAmount"]);
                        total_loan = loan + total_loan;
                    }
                    con1.Close();
                    string incrsal = "";
                    int salperctng =0;
                    con1.Open();
                    cmd.Connection = con1;
                    cmd.CommandType = CommandType.Text;
                    //cmd.CommandText = "select strSalary from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4";
                    cmd.CommandText = "select strSalary,nIcrSal_id from tbl_Users where nu_id='" + Convert.ToInt32(ddenm.SelectedValue) + "'and bisDeleted='False' and nsch_id=@schid5";
                    cmd.Parameters.AddWithValue("@schid5", Session["nschoolid"]);
                    dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        sal = Convert.ToInt32(dr["strSalary"].ToString());
                        incrsal = dr["nIcrSal_id"].ToString();
                    }
                    total_sal = sal;//((sal / 30) * present) - total_loan;
                    //txtamnt.Text = total_sal.ToString();
                    con1.Close();
                    con1.Open();
                    cmd.Connection = con1;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select strIncSal from tbl_IncrementSalaryRecord where nSal_id='"+incrsal+"'";
                    dr = cmd.ExecuteReader();
                    if(dr.Read())
                    {
                        salperctng = Convert.ToInt32( dr["strIncSal"].ToString());
                    }
                    int profit = Convert.ToInt32(sal) * salperctng/100 ;
                    int totalsal = profit + Convert.ToInt32(sal);
                    int finalsal = ((totalsal / 30) * present)-total_loan;

                    txtamnt.Text = finalsal.ToString();
                    con1.Close();
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
        }
        int total_loan = 0;
        int sal = 0;
        int total_sal = 0;
        int loan = 0;

        //protected void ddenm_SelectedIndexChanged(object sender, EventArgs e)
        //{

        //}

        protected void txtfine_TextChanged(object sender, EventArgs e)
        {
            try
            {
            Boolean flag = true;
            for (int i = 0; i < txtfine.Text.Length; i++)
            {
                if (txtfine.Text != "")
                {
                    if (txtfine.Text[i] >= 'a' && txtfine.Text[i] <= 'z' || txtfine.Text[i] >= 'A' && txtfine.Text[i] <= 'Z' || txtfine.Text[i] == '!' || txtfine.Text[i] == '@' || txtfine.Text[i] == '#' || txtfine.Text[i] == '$' || txtfine.Text[i] == '`' || txtfine.Text[i] == '~' || txtfine.Text[i] == '%' || txtfine.Text[i] == '^' || txtfine.Text[i] == '&' || txtfine.Text[i] == '*' || txtfine.Text[i] == '(' || txtfine.Text[i] == ')' || txtfine.Text[i] == '-' || txtfine.Text[i] == '+' || txtfine.Text[i] == '_' || txtfine.Text[i] == '=' || txtfine.Text[i] == ',' || txtfine.Text[i] == '.' || txtfine.Text[i] == '/' || txtfine.Text[i] == '?' || txtfine.Text[i] == ';' || txtfine.Text[i] == ':' || txtfine.Text[i] == '\'' || txtfine.Text[i] == '\"' || txtfine.Text[i] == '|' || txtfine.Text[i] == '\\' || txtfine.Text[i] == '/' || txtfine.Text[i] == '[' || txtfine.Text[i] == ']' || txtfine.Text[i] == '{' || txtfine.Text[i] == '}')
                    {

                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalide Entry.');", true);
                        txtfine.Text = "";
                        txtfine.Focus();
                        flag = false;
                        break;
                    }
                }
            }
            if (flag)
            {
                int amount = Convert.ToInt32(txtamnt.Text);
                int fine = Convert.ToInt32(txtfine.Text);
                int total = 0;
                total = amount - fine;
                txtamnt.Text = total.ToString();
                txtsalary.Focus();
            }
            }
            catch (Exception ex)
            {
               // Response.Redirect("Error.aspx");
            }
            finally
            {
               
            }
        }

        protected void btnLoan_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminManageLoans.aspx");
        }

        protected void btnsal_Click(object sender, EventArgs e)
        {
            mvsal.ActiveViewIndex = 1;
        }

        protected void btBack_Click(object sender, EventArgs e)
        {
            mvsal.ActiveViewIndex = 0;
        }

        protected void ddenm_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (ddenm.SelectedIndex != 0)
            //    status();
        }

        protected void txtto_TextChanged(object sender, EventArgs e)
        {
            status();

        }
    }
}