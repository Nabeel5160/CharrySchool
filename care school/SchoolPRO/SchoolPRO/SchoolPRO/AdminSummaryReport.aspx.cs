using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;


namespace SchoolPRO
{
    public partial class AdminSummaryReport : System.Web.UI.Page
    {
         SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();

        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GET_FEE_CONCS_Currnt_MON();
                GET_TOT_SAlARY_Currnt_MON();
            }
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Select strSchName+'  '+strAddress as school from  tbl_School where nsch_id= '" + Session["nschoolid"] + "' and bisDeleted='False'";
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    
                    
                    txtschool1.Text = dr["school"].ToString();
                    
                }
                else
                {

                }
                con.Close();
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

            //GET_FEE_TO_BE_PAID_Currnt_MON();
            //GET_FEE_REVC_Currnt_MON();
           
          //  GET_TOT_SAlARY_Currnt_MON();
        }

        public void GET_FEE_TO_BE_PAID_Currnt_MON()
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
              
               // cmd.CommandText = "SELECT SUM(CAST(tbl_Fee.strTutionFee AS bigint)) AS TOT FROM tbl_Enrollment AS ST INNER JOIN tbl_Fee ON ST.nfee_id = tbl_Fee.nfee_id LEFT OUTER JOIN (SELECT DISTINCT tbl_RecieveFee.ne_id AS ID FROM tbl_RecieveFee INNER JOIN tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id WHERE (SUBSTRING(tbl_RecieveFee.dtAddDate, 4, 2) >= SUBSTRING(@fm, 4, 2)) and (SUBSTRING(tbl_RecieveFee.dtAddDate, 4, 2) <= SUBSTRING(@to, 4, 2)) and (SUBSTRING(tbl_RecieveFee.dtAddDate, 7, 4) >= SUBSTRING(@fm, 7, 4)) and (SUBSTRING(tbl_RecieveFee.dtAddDate, 7, 4) <= SUBSTRING(@to, 7, 4)) AND (tbl_RecieveFee.nsch_id = @nschid)) AS Fee ON ST.ne_id = Fee.ID WHERE   (Fee.ID IS NULL) AND (ST.bisDeleted = @fbit) AND (ST.nsch_id = @nschid) AND (tbl_Fee.bisDeleted = @fbit)";

                cmd.CommandText = "SELECT SUM(CAST(tbl_Fee.strTutionFee AS bigint)) AS TOT FROM tbl_Enrollment AS ST INNER JOIN tbl_Fee ON ST.nfee_id = tbl_Fee.nfee_id LEFT OUTER JOIN (SELECT DISTINCT tbl_RecieveFee.ne_id AS ID FROM tbl_RecieveFee INNER JOIN tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id WHERE (dbo.to_date('dd-mm-yyyy', tbl_RecieveFee.dtAddDate) BETWEEN dbo.to_date('dd-mm-yyyy', @fm) AND dbo.to_date('dd-mm-yyyy', @to))) AS Fee ON ST.ne_id = Fee.ID WHERE   (Fee.ID IS NULL) AND (ST.bisDeleted = @fbit) AND (ST.nsch_id = @nschid) AND (tbl_Fee.bisDeleted = @fbit)";
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit() );
                cmd.Parameters.AddWithValue("@nschid",Session["nschoolid"].ToString().Trim());
                cmd.Parameters.AddWithValue("@fm",txtfrom.Text);
                cmd.Parameters.AddWithValue("@to",txtto.Text);
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {


                txttotfeetopay.Text = dr["TOT"].ToString();

                }
                else
                {

                }
                con.Close();
                cmd.Parameters.Clear();

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
        public void GET_FEE_REVC_Currnt_MON()
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "SELECT SUM(CAST(tbl_Fee.strTutionFee AS bigint)) AS TOT FROM tbl_Enrollment AS ST INNER JOIN tbl_Fee ON ST.nfee_id = tbl_Fee.nfee_id LEFT OUTER JOIN (SELECT DISTINCT tbl_RecieveFee.ne_id AS ID FROM            tbl_RecieveFee INNER JOIN tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id WHERE        (SUBSTRING(tbl_RecieveFee.dtAddDate, 4, 2) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105), 4, 2)) AND (tbl_RecieveFee.nsch_id = @nschid)) AS Fee ON ST.ne_id = Fee.ID WHERE   (Fee.ID IS NOT NULL) AND (ST.bisDeleted = @fbit) AND (ST.nsch_id = @nschid) AND (tbl_Fee.bisDeleted = @fbit)";
                /////cmd.CommandText = "SELECT SUM(0+CAST(tbl_Fee.strTutionFee AS bigint)) AS TOT FROM tbl_Enrollment AS ST INNER JOIN tbl_Fee ON ST.nfee_id = tbl_Fee.nfee_id LEFT OUTER JOIN (SELECT DISTINCT tbl_RecieveFee.ne_id AS ID FROM   tbl_RecieveFee INNER JOIN tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id WHERE        (dbo.to_date('dd-mm-yyyy', tbl_RecieveFee.dtAddDate) BETWEEN dbo.to_date('dd-mm-yyyy', @fm) AND dbo.to_date('dd-mm-yyyy', @to)) AND (tbl_RecieveFee.nsch_id = @nschid)) AS Fee ON ST.ne_id = Fee.ID WHERE   (Fee.ID IS NOT NULL) AND (ST.bisDeleted = @fbit) AND (ST.nsch_id = @nschid) AND (tbl_Fee.bisDeleted = @fbit)";
                //Class


                cmd.CommandText = "SELECT  SUM(CAST({ fn IFNULL(tbl_RecieveFee.strFeeAmount, 0) }  AS bigint)) AS TOT FROM tbl_RecieveFee INNER JOIN  tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id WHERE        (tbl_RecieveFee.bisDeleted = @fbit) AND (tbl_Enrollment.bisDeleted = @fbit) AND (tbl_RecieveFee.bisPaid = @tbit) AND (tbl_RecieveFee.nsch_id = @nschid) AND (tbl_Enrollment.nsch_id = @nschid) AND   (dbo.to_date('dd-mm-yyyy', tbl_RecieveFee.dtAddDate) BETWEEN dbo.to_date('dd-mm-yyyy', @fm) AND dbo.to_date('dd-mm-yyyy', @to))";
                
                
                //(SUBSTRING(tbl_RecieveFee.dtAddDate, 4, 2) >= SUBSTRING(@fm, 4, 2)) and (SUBSTRING(tbl_RecieveFee.dtAddDate, 4, 2) <= SUBSTRING(@to, 4, 2)) and (SUBSTRING(tbl_RecieveFee.dtAddDate, 7, 4) >= SUBSTRING(@fm, 7, 4)) and (SUBSTRING(tbl_RecieveFee.dtAddDate, 7, 4) <= SUBSTRING(@to, 7, 4))
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@tbit", BIT_T_F.TrueBit());
                cmd.Parameters.AddWithValue("@nschid", Session["nschoolid"].ToString().Trim());
                cmd.Parameters.AddWithValue("@fm", txtfrom.Text);
                cmd.Parameters.AddWithValue("@to", txtto.Text);



                dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    if (dr.Read())
                    {


                        txttotfeeRecv.Text = dr["TOT"].ToString();

                    }
                    else
                    {

                    }
                }
                else
                {
                    txttotfeeRecv.Text = "0";
                }
                con.Close();
                cmd.Parameters.Clear();
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
        public void GET_FEE_CONCS_Currnt_MON()
        {
            try
            {
               //SELECT SUM(CAST(tbl_Fee.strTutionFee AS bigint) - CAST(tbl_Fee.strTutionFee AS bigint) * CAST(tbl_Concession.nConcPer AS bigint) / 100) AS perFROM            tbl_ConcessionStudent INNER JOIN tbl_Concession ON tbl_ConcessionStudent.nConc_id = tbl_Concession.nConc_id INNER JOIN tbl_Fee ON tbl_ConcessionStudent.nc_id = tbl_Fee.nc_id WHERE        (tbl_Fee.bisDeleted = @fbit) AND (tbl_Concession.bisDeleted = @fbit) AND (tbl_ConcessionStudent.bisDeleted = @fbit) AND (tbl_ConcessionStudent.nsch_id = @schid)
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT SUM(CAST(tbl_Fee.strTutionFee AS bigint) - CAST(tbl_Fee.strTutionFee AS bigint) * CAST(tbl_Concession.nConcPer AS bigint) / 100) AS tot FROM            tbl_ConcessionStudent INNER JOIN tbl_Concession ON tbl_ConcessionStudent.nConc_id = tbl_Concession.nConc_id INNER JOIN tbl_Fee ON tbl_ConcessionStudent.nc_id = tbl_Fee.nc_id WHERE        (tbl_Fee.bisDeleted = @fbit) AND (tbl_Concession.bisDeleted = @fbit) AND (tbl_ConcessionStudent.bisDeleted = @fbit) AND (tbl_ConcessionStudent.nsch_id = @schid)";
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString().Trim());
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {


                    txttotConces.Text= dr["tot"].ToString();

                }
                else
                {

                }
                con.Close();
                cmd.Parameters.Clear();

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
        public void GET_EXPENSE_Currnt_MON()
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT SUM(CAST({ fn IFNULL(tbl_Expense.strAmount, 0) } AS bigint) ) AS tot FROM  tbl_Expense WHERE (tbl_Expense.nsch_id = @schid) AND (tbl_Expense.nsch_id = @schid) AND (tbl_Expense.bisDeleted = @fbit) AND (tbl_Expense.bisDeleted = @fbit) and  ((dbo.to_date('dd-mm-yyyy', tbl_Expense.dtAddDate) BETWEEN dbo.to_date('dd-mm-yyyy', @fm) AND dbo.to_date('dd-mm-yyyy', @to)))";
                cmd.Parameters.AddWithValue("@fm", txtfrom.Text);
                cmd.Parameters.AddWithValue("@to", txtto.Text);
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString().Trim());
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {


                  txttotExpnse.Text= dr["tot"].ToString();

                }
                else
                {

                }
                con.Close();
                cmd.Parameters.Clear();

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
        public void GET_TOT_SAlARY_Currnt_MON()
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT        SUM(CAST({ fn IFNULL(strSalary, 0) } AS bigint)) AS tot FROM  tbl_Users WHERE        (nsch_id = @schid) AND (bisDeleted = @fbit) AND (nLevel = 2 or nLevel = 5 or nLevel = 10 or nLevel = 11 or nLevel = 1)";
                cmd.Parameters.AddWithValue("@fm", txtfrom.Text);
                cmd.Parameters.AddWithValue("@to", txtto.Text);
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString().Trim());
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {


                   txttotSalary.Text = dr["tot"].ToString();

                }
                else
                {

                }
                con.Close();
                cmd.Parameters.Clear();

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

        public void GET_TOT_SAlARY_paid_Currnt_MON()
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT SUM(CAST({ fn IFNULL(tbl_Salary.strSalary, 0) } AS bigint) + CAST({ fn IFNULL(tbl_Salary.strBonus, 0) } AS bigint) - CAST({ fn IFNULL(tbl_Salary.strFine, 0) } AS bigint)) AS tot FROM  tbl_Salary INNER JOIN tbl_Users ON tbl_Salary.nu_id = tbl_Users.nu_id WHERE (tbl_Salary.nsch_id = @schid) AND (tbl_Users.nsch_id = @schid) AND (tbl_Salary.bisDeleted = @fbit) AND (tbl_Users.bisDeleted = @fbit) and (dbo.to_date('dd-mm-yyyy', tbl_Salary.dtAddDate) BETWEEN dbo.to_date('dd-mm-yyyy', @fm) AND dbo.to_date('dd-mm-yyyy', @to))";
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString().Trim());
                cmd.Parameters.AddWithValue("@fm", txtfrom.Text);
                cmd.Parameters.AddWithValue("@to", txtto.Text);
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {


                   txttotSalaryPaid.Text= dr["tot"].ToString();

                }
                else
                {

                }
                con.Close();
                cmd.Parameters.Clear();

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

        public void GET_TOT_SAlARY_payable_Currnt_MON()
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT  SUM(CAST(ST.strSalary AS bigint)) AS TOT FROM tbl_Users AS ST LEFT OUTER JOIN  (SELECT DISTINCT tbl_Salary.nu_id AS ID  FROM tbl_Salary INNER JOIN tbl_Users ON tbl_Salary.nu_id = tbl_Users.nu_id WHERE (dbo.to_date('dd-mm-yyyy', tbl_Salary.dtAddDate) BETWEEN dbo.to_date('dd-mm-yyyy', @fm) AND dbo.to_date('dd-mm-yyyy', @to)) AND (tbl_Salary.nsch_id = @nschid) AND (tbl_Salary.bisDeleted = @fbit) AND (tbl_Users.bisDeleted = @fbit)) AS Fee ON ST.nu_id = Fee.ID WHERE (Fee.ID IS NULL) AND (ST.bisDeleted = @fbit) AND (ST.nsch_id = @nschid) AND (ST.nLevel = 2 or ST.nLevel = 5 or ST.nLevel = 10 or ST.nLevel = 11 or ST.nLevel = 1)";
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@nschid", Session["nschoolid"].ToString().Trim());
                cmd.Parameters.AddWithValue("@fm", txtfrom.Text);
                cmd.Parameters.AddWithValue("@to", txtto.Text);
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {


                   txttotSalaryPaYble.Text= dr["tot"].ToString();

                }
                else
                {

                }
                con.Close();
                cmd.Parameters.Clear();

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

        protected void txtto_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (txtfrom.Text != "" && txtto.Text != "")
                {
                    GET_FEE_TO_BE_PAID_Currnt_MON();
                    GET_FEE_REVC_Currnt_MON();
                  //  GET_FEE_CONCS_Currnt_MON();
                    GET_TOT_SAlARY_paid_Currnt_MON(); 
                    GET_TOT_SAlARY_payable_Currnt_MON();
                    GET_EXPENSE_Currnt_MON();
                   // GET_TOT_SAlARY_Currnt_MON();
                }
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

        protected void txtdob_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (txtfrom.Text != "" && txtto.Text != "")
                {
                    GET_FEE_TO_BE_PAID_Currnt_MON();
                    GET_FEE_REVC_Currnt_MON();
                   // GET_FEE_CONCS_Currnt_MON();
                    GET_TOT_SAlARY_paid_Currnt_MON();
                    GET_TOT_SAlARY_payable_Currnt_MON();
                   // GET_TOT_SAlARY_Currnt_MON();
                    GET_EXPENSE_Currnt_MON();
                }
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
    }
}