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
    public partial class ParentsMarkLeave : System.Web.UI.Page
    {
        List<string> subid = new List<string>();
        List<string> res = new List<string>();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                studentinfo();
                studentsubid();
            }
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
        private void studentsubid()
        {
            con.Close();
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.Clear();
            cmd.CommandText = "select s.nsbj_id as Subject from tbl_Subject s inner join tbl_Class c on c.nc_id=s.nc_id where c.nc_id=@cid and c.nsch_id=@csh and s.nsch_id=@csh and c.bisDeleted=@fbit and s.bisDeleted=@fbit";
            cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
            cmd.Parameters.AddWithValue("@cid", Session["clsid"].ToString());
            cmd.Parameters.AddWithValue("@csh", Session["nschoolid"].ToString());
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                subid.Add(dr["Subject"].ToString());
            }
        }
        private void studentinfo()
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.Clear();
            cmd.CommandText = "select nc_id,nsc_id from tbl_Enrollment where bisDeleted=@fbit and ne_id=@userid";
            cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
            cmd.Parameters.AddWithValue("@userid", Session["stdid"].ToString());
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                Session["clsid"] = dr["nc_id"].ToString();
                Session["secid"] = dr["nsc_id"].ToString();
            }
        }

        protected void btnaddLeave_Click(object sender, EventArgs e)
        {
            try
            {
                con.Close();
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
                    foreach (string sunjestid in subid)
                    {
                        con.Close();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.Clear();
                        cmd.CommandText = "insert into tbl_Leave(ne_id,nc_id,nsc_id,nsbj_id,nLevel,strFrom,strTo,bPanding,strReason,nsch_id,nG_id,dtAddDate,bisDeleted) values (@stid,@cid,@sid,@s,4,@from,@to,'Panding',@rea,@sch,@userid,@dformat,@fbit)";
                        cmd.Parameters.AddWithValue("@rea", txtreason.Value.Trim());
                        cmd.Parameters.AddWithValue("@to", txtto.Text.Trim());
                        cmd.Parameters.AddWithValue("@from", txtfrom.Text.Trim());
                        cmd.Parameters.AddWithValue("@s", sunjestid);
                        cmd.Parameters.AddWithValue("@sch", Session["nschoolid"].ToString());
                        cmd.Parameters.AddWithValue("@userid", Session["uid"].ToString());
                        cmd.Parameters.AddWithValue("@stid", Session["stdid"].ToString());
                        cmd.Parameters.AddWithValue("@dformat", DATE_FORMAT.format());
                        cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                        cmd.Parameters.AddWithValue("@cid", Session["clsid"].ToString());
                        cmd.Parameters.AddWithValue("@sid", Session["secid"].ToString());
                        cmd.ExecuteNonQuery();
                    }
                    Session["clsid"] = null;
                    Session["secid"] = null;
                    Session["stdid"] = null;
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
                    txtfrom.Text = "";
                    txtto.Text = "";
                    cmd.Parameters.Clear();
                }
            }
        }
    }
}