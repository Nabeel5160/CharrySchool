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
    public partial class HostalStudentApply1 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 1;
        }

        protected void txtregno_TextChanged(object sender, EventArgs e)
        {
            stdinfo();
        }
        private void stdinfo()
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select ne_id,nu_id,nsc_id,strShift,strNIC,strFname,strLname,strDOB,strAdmissionNumber,strPrAddress,strCity,strCountry,strPhone,strEmail from tbl_Enrollment where bRegisteredNum=@reg and bisDeleted=@fbit";
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@reg", txtregno.Text);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    txtfn.Text = dr["strFname"].ToString();
                    txtln.Text = dr["strLname"].ToString();
                    txtdob.Text = dr["strDOB"].ToString();
                    txtad.Text = dr["strAdmissionNumber"].ToString();
                    txtadrs.Text = dr["strPrAddress"].ToString();
                    txtcity.Text = dr["strCity"].ToString();
                    txtcntry.Text = dr["strCountry"].ToString();
                    txtphn.Text = dr["strPhone"].ToString();
                    txtem.Text = dr["strEmail"].ToString();
                    txtnic.Text = dr["strNIC"].ToString();
                    txtshft.Text = dr["strShift"].ToString();
                    Session["nschoolid1"] = dr["nsc_id"].ToString();
                    Session["nuid"] = dr["nu_id"].ToString();
                    Session["estdid"] = dr["ne_id"].ToString();
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

        protected void btntreg_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.CommandText = "select * from tbl_ManageHostalStudent where bRegisteredNum=@sreg and bisDeleted=@fbit and ne_id=@seid and strAdmissionNumber=@sad";
                cmd.Parameters.AddWithValue("@sreg", txtregno.Text);
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@seid", Session["estdid"].ToString());
                cmd.Parameters.AddWithValue("@sad", txtad.Text);
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Student Already Exists.');", true);
                }
                else
                {
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_ManageHostalStudent( ne_id,bRegisteredNum,strShift,strNIC,strFname,strLname,strDOB,strAdmissionNumber,strPrAddress,strCity,strCountry,strPhone,strEmail,nsc_id,nu_id,dtAddDate,bisDeleted) values(@seid,@sreg,@sshft,@snic,@fnam,@lnam,@sdob,@sad,@sadd,@scit,@scntry,@sphn,@sem,@sch,@uid,@date,@fbit)";
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@sch", Session["nschoolid1"].ToString());
                    cmd.Parameters.AddWithValue("@uid", Session["nuid"].ToString());
                    cmd.Parameters.AddWithValue("@seid", Session["estdid"].ToString());
                    cmd.Parameters.AddWithValue("@date", DATE_FORMAT.format());
                    cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());

                    cmd.Parameters.AddWithValue("@fnam", txtfn.Text);
                    cmd.Parameters.AddWithValue("@lnam", txtln.Text);
                    cmd.Parameters.AddWithValue("@sreg", txtregno.Text);
                    cmd.Parameters.AddWithValue("@sdob", txtdob.Text);
                    cmd.Parameters.AddWithValue("@sad", txtad.Text);
                    cmd.Parameters.AddWithValue("@sadd", txtadrs.Text);
                    cmd.Parameters.AddWithValue("@scit", txtcity.Text);
                    cmd.Parameters.AddWithValue("@scntry", txtcntry.Text);
                    cmd.Parameters.AddWithValue("@sphn", txtphn.Text);
                    cmd.Parameters.AddWithValue("@sem", txtem.Text);
                    cmd.Parameters.AddWithValue("@snic", txtnic.Text);
                    cmd.Parameters.AddWithValue("@sshft", txtshft.Text);
                    cmd.ExecuteNonQuery();
                    mvt.ActiveViewIndex = 0;
                    gvdep.DataBind();
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
                txtfn.Text = "";
                txtln.Text = "";
                txtdob.Text = "";
                txtad.Text = "";
                txtadrs.Text = "";
                txtcity.Text = "";
                txtcntry.Text = "";
                txtphn.Text = "";
                txtem.Text = "";

                txtnic.Text = "";
                txtshft.Text = "";
            }
        }
        
    }
}