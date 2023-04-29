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
    public partial class AdminManageSchoolLeaving : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            S_No();
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        public void S_No()
        {
            try
            {
                int inc = 0;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select count(nS_No) from tbl_SchoolLeaving where bisDeleted='False'";
                int val = Convert.ToInt32(cmd.ExecuteScalar());
                if (val == 0)
                {
                    inc = inc + 1;
                    lblsno.Text = inc.ToString();
                }
                else
                {
                    lblsno.Text = val.ToString();
                }

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
        //public static string NumberToWords(DateTime number)
        //{
        //    if (number == 0)
        //    {
        //        return "Zero";
        //    }
        //    if (number < 0)

        //        return "Minus" + NumberToWords(Math.Abs(number)) + " ";
        //    string words = "";

        //    if ((number / 100000000) > 0)
        //    {
        //        words += NumberToWords(number / 10000000) + " " + "Crore" + " ";
        //        number %= 10000000;
        //    }
        //    if ((number / 1000000) > 0)
        //    {
        //        words += NumberToWords(number / 100000) + " " + "Lakh" + " ";
        //        number %= 100000;
        //    }
        //    if ((number / 1000) > 0)
        //    {
        //        words += NumberToWords(number / 1000) + " " + "Thousand" + " ";
        //        number %= 1000;
        //    }
        //    if ((number / 100) > 0)
        //    {
        //        words += NumberToWords(number / 100) + " " + "Hundred" + " ";
        //        number %= 100;
        //    }
        //    if (number > 0)
        //    {
        //        if (words != "")

        //            words += "and" + " ";
        //        var unitW = new[] { "Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Tweleve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen" };
        //        var tenW = new[] { "Zero", "Ten", "Twenty", "Thirty", "Forty", "Fivety", "Sixty", "Seventy", "Eighty", "Ninety" };


        //        if (number < 20)

        //            words += unitW[number];
        //        else
        //        {
        //            words += tenW[number / 10];
        //            if ((number % 10) > 0)
        //            {
        //                words += " " + unitW[number % 10];
        //            }
        //        }
        //    }
        //    return words;
        //}
        protected void txtstnum_TextChanged(object sender, EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select e.strFname,e.strLname,e.strDOB,u.strfname,u.strlname,c.strClass,e.dtEn_Date from tbl_Enrollment e inner join tbl_Users u on e.nu_id=u.nu_id inner join tbl_Class c on e.nc_id=c.nc_id where e.strStudentNum='" + txtstnum.Text + "' and e.nsch_id= '" + Session["nschoolid"] + "' and e.bisDeleted='False'";
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                txtfn.Text = dr["strFname"].ToString();
                txtln.Text = dr["strLname"].ToString();
                txtpfn.Text = dr["strfname"].ToString();
                txtpln.Text = dr["strlname"].ToString();
                txtecl.Text = dr["strClass"].ToString();
                //lblcl.Text = dr["strClass"].ToString();
                //lblstnum.Text = dr["strStudentNum"].ToString();
                txtdtfg.Text = dr["strDOB"].ToString();
                txtsdt.Text = dr["dtEn_Date"].ToString();
                //lbldtwd.Text = NumberToWords(Convert.ToInt64(dr["strDOB"]));
                
            }
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

        protected void btngo_Click(object sender, EventArgs e)
        {
            mvsub.ActiveViewIndex = 1;
        }

        protected void btnsub_Click(object sender, EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tbl_SchoolLeaving(nsch_id,ne_id,nc_id,nS_No,strStartDate,strEndDate,strTotalMarks,strObtMarks,strDesc,dtAddDate,bisDeleted) values ('" + Session["nschoolid"] + "',(select ne_id from tbl_Enrollment where strStudentNum='" + txtstnum.Text + "' and nsch_id='" + Session["nschoolid"] + "'),(select nc_id from tbl_Enrollment where strStudentNum='" + txtstnum.Text + "' and nsch_id='" + Session["nschoolid"] + "'),@sno,@stdt,@edt,@tm,@om,@dsc,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
            cmd.Parameters.AddWithValue("@sno", lblsno.Text);
            cmd.Parameters.AddWithValue("@stdt",txtsdt.Text);
            cmd.Parameters.AddWithValue("@edt", txtedt.Text);
            cmd.Parameters.AddWithValue("@tm", txttmarks.Text);
            cmd.Parameters.AddWithValue("@om", txtobtmarks.Text);
            cmd.Parameters.AddWithValue("@dsc", txtdesc.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Enrollment set bisDeleted='True' where strStudentNum='" + txtstnum.Text + "' and nsch_id='" + Session["nschoolid"] + "'";
            cmd.ExecuteNonQuery();
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
    }
}