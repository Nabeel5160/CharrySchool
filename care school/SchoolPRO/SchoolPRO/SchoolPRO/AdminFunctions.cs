using System;
using System.Collections.Generic;

using System.Web;


using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace SchoolPRO
{
    public class AdminFunctions
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();

        SqlDataReader dr;
        public void challanTransferRecordWith_False_Bit(string challan, string accnum, string oldamt, string newamt, string tranamt, string neid, string uid, string schid)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into tbl_Bank_Challan_Transfer (naccid,straccnum,strchallannum,stroldamount,strnewamount,strtransferamount,neid,bisDeleted,bPaid,tmAddTime,dtAddDate,nu_id,nsch_id) Values((Select  nbnk_id from tbl_Bank where strAccNum = @accnum and bisDeleted=@fbit and nsch_id=@schid),@accnum,@challno,@oldamt,@newamt,@tranamt,@neid,@fbit,@fbit,@tm,@dt,@uid,@schid)";
                cmd.Parameters.AddWithValue("@accnum", accnum);
                cmd.Parameters.AddWithValue("@challno", challan);
                cmd.Parameters.AddWithValue("@oldamt", oldamt);
                cmd.Parameters.AddWithValue("@newamt", newamt);
                cmd.Parameters.AddWithValue("@tranamt", tranamt);
                cmd.Parameters.AddWithValue("@neid", neid);
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@tm", DATE_FORMAT.time());
                cmd.Parameters.AddWithValue("@dt", DATE_FORMAT.format());
                cmd.Parameters.AddWithValue("@uid", uid);
                cmd.Parameters.AddWithValue("@schid", schid);
                cmd.ExecuteNonQuery();

                con.Close();
            }
            catch (Exception ex)
            {
                //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Error')", true);
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


        public void challanTransferRecordWith_True_Bit(string challan, string accnum, string oldamt, string newamt, string tranamt, string neid, string uid, string schid)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into tbl_Bank_Challan_Transfer (naccid,straccnum,strchallannum,stroldamount,strnewamount,strtransferamount,neid,bisDeleted,bPaid,tmAddTime,dtAddDate,nu_id,nsch_id) Values((Select  nbnk_id from tbl_Bank where strAccNum = @accnum and bisDeleted=@fbit and nsch_id=@schid),@accnum,@challno,@oldamt,@newamt,@tranamt,@neid,@fbit,@fbit,@tm,@dt,@uid,@schid)";
                cmd.Parameters.AddWithValue("@accnum", accnum);
                cmd.Parameters.AddWithValue("@challno", challan);
                cmd.Parameters.AddWithValue("@oldamt", oldamt);
                cmd.Parameters.AddWithValue("@newamt", newamt);
                cmd.Parameters.AddWithValue("@tranamt", tranamt);
                cmd.Parameters.AddWithValue("@neid", neid);
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@tm", DATE_FORMAT.time());
                cmd.Parameters.AddWithValue("@dt", DATE_FORMAT.format());
                cmd.Parameters.AddWithValue("@uid", uid);
                cmd.Parameters.AddWithValue("@schid", schid);
                cmd.ExecuteNonQuery();

                con.Close();
            }
            catch (Exception ex)
            {
                //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Error')", true);
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

        public void Paid_True_Bit(string challan)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Update tbl_Bank_Challan_Transfer set bPaid=@tbit where [strchallannum] = @challnm and bPaid=@fbit";

                cmd.Parameters.AddWithValue("@tbit", BIT_T_F.TrueBit());
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@challnm", challan);

                cmd.ExecuteNonQuery();

                con.Close();
            }
            catch (Exception ex)
            {
                //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Error')", true);
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                    cmd.Parameters.Clear();
                    //cmd.Dispose();
                }
            }
        }

        public string eid { get; set; }
        public string pid { get; set; }
        public string DiaryDetail { get; set; }
        public string sch_class { get; set; }
        public string sch_school { get; set; }
        public string diaryDate { get; set; }
        public string sch_parentnum { get; set; }
        public string type { get; set; }
        public string status { get; set; }
    }
}