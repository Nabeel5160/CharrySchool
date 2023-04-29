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
    public partial class TeacherMarkLeave : System.Web.UI.Page
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
            for ( var date = start;  date <= end; date = date.AddDays(1))
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
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.CommandText = "select bPanding from tbl_Leave where bisDeleted=@fbit and bPanding='Panding' and nG_id=@userid";
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
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Clear();
                    cmd.CommandText = "insert into tbl_Leave(nLevel,bPanding,strFrom,strTo,strReason,nsch_id,nG_id,dtAddDate,bisDeleted) values (2,'Panding',@from,@to,@rea,@sch,@userid,@dformat,@fbit)";
                    cmd.Parameters.AddWithValue("@rea", txtreason.Value.Trim());
                    cmd.Parameters.AddWithValue("@from", txtto.Text.Trim());
                    cmd.Parameters.AddWithValue("@to", txtfrom.Text.Trim());
                    cmd.Parameters.AddWithValue("@sch", Session["nschoolid"].ToString());
                    cmd.Parameters.AddWithValue("@userid", Session["uid"].ToString());
                    cmd.Parameters.AddWithValue("@dformat", DATE_FORMAT.format());
                    cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                    cmd.Parameters.AddWithValue("@tbit", BIT_T_F.TrueBit());
                    cmd.ExecuteNonQuery();
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
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Add Successfully....!')", true);
                    con.Close();
                    gvadmin.DataBind();
                    mvquiz.ActiveViewIndex = 0;
                    txtfrom.Text = "";
                    txtto.Text = "";
                    txtreason.Value="";
                    cmd.Parameters.Clear();
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            mvquiz.ActiveViewIndex = 1;
        }
    }
}