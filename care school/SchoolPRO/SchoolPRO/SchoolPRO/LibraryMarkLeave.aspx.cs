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
using System.Globalization;

namespace SchoolPRO
{
    public partial class LibraryMarkLeave : System.Web.UI.Page
    {
        List<string> res = new List<string>();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private void GetRange()
        {
            //List<string> res = new List<string>();
            DateTime tm = DateTime.ParseExact(txtfrom.Text, "dd-MM-yyyy", System.Globalization.CultureInfo.InvariantCulture);
            DateTime tm1 = DateTime.ParseExact(txtto.Text, "dd-MM-yyyy", System.Globalization.CultureInfo.InvariantCulture);
            var start = tm;
            var end = tm1;
            for (var date = start; date <= end; date = date.AddDays(1))
            {
                DateTime dt = Convert.ToDateTime(date);
                string newString = dt.ToString("dd-MM-yyyy");
                res.Add(newString);
            }
        }

        protected void btnaddLeave_Click(object sender, EventArgs e)
        {
           try
            {
                GetRange();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.CommandText = "select bPanding from tbl_Leave where bisDeleted=@fbit and bPanding=@fbit and nu_id=@userid";
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@userid", Session["uid"].ToString());
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Leave Request Panding....!')", true);
                }
                else
                {
                    con.Close();
                    foreach (string add in res)
                    {
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.Clear();
                        cmd.CommandText = "insert into tbl_Leave(nLevel,bAccept,bCancel,Date,strReason,nsch_id,nu_id,dtAddDate,bisDeleted,bPanding) values (1,@tbit,@fbit,@dat,@rea,@sch,@userid,@dformat,@fbit,@fbit)";
                        cmd.Parameters.AddWithValue("@rea", txtreason.Value.Trim());
                        cmd.Parameters.AddWithValue("@dat", add);
                        cmd.Parameters.AddWithValue("@sch", Session["nschoolid"].ToString());
                        cmd.Parameters.AddWithValue("@userid", Session["uid"].ToString());
                        cmd.Parameters.AddWithValue("@dformat", DATE_FORMAT.format());
                        cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                        cmd.Parameters.AddWithValue("@tbit", BIT_T_F.TrueBit());
                        cmd.ExecuteNonQuery();
                        con.Close();
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
                    cmd.Parameters.Clear();
                }
            }
        }
    }
}