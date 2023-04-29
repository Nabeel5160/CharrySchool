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
    public partial class AdminViewProfitLossReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Profit_Loss();
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr,dr2;

        public void Profit_Loss()
        {
            try

            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = " select sum(Cast(f.strTutionFee AS INT)) from tbl_Enrollment e inner join tbl_Fee f on e.nfee_id=f.nfee_id where e.bisDeleted='False' and e.nsch_id='" + Session["nschoolid"] + "'";
            int result = Convert.ToInt32(cmd.ExecuteScalar());
            lbltfee.Text = result.ToString();
            con.Close();
            
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select sum(Cast(strFeeAmount AS INT)) from tbl_RecieveFee where nsch_id='" + Session["nschoolid"] + "'";
            int recieve_fee = Convert.ToInt32(cmd.ExecuteScalar());
            lbltfeercvd.Text = recieve_fee.ToString();
            con.Close();
            int pending = result - recieve_fee;
            lbltfeepnd.Text = pending.ToString();

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "";
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
            //con.Open();
            //cmd.Connection = con;
            //cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "";
            //con.Close();
        }

    }
}