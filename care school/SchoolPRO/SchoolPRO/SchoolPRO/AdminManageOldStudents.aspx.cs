using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminManageOldStudents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btnsreg_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from tbl_OldStudents where strAddmissionNum='" + txtaddmissionnum.Text + "' and bisDeleted='False'";
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Addmission already exist.');", true);
                }
                else
                {
                    con.Close();
                    
                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "insert into tbl_OldStudents(nu_id,strclass,nsch_id,strName,strFname,strDOB,strGender,strAddress,strAddmissionNum,dtVerifyDate,dtStart_Date,dtEnd_Date,dtAddDate,bisDeleted) Values('"+Session["uid"]+"','"+ddcl.SelectedValue+"','"+Session["nschoolid"]+"','"+txtstn.Text+"','"+txtfn.Text+"','"+txtdob.Text+"','"+ddsex.Text+"','"+txtaddrs.Text+"','"+txtaddmissionnum.Text+"','"+txtstartdate.Text+"','"+txtstartdate.Text+"','"+txtenddate.Text+"',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                            
                            cmd.ExecuteNonQuery();
                            con.Close();
                            txtfn.Text = "";
                            //txtml.Text = "";
                            txtaddrs.Text="";
                    txtstn.Text="";
                    txtfn.Text="";

                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Student has been enrolled.');", true);
                        }
            
                

            }
            catch (Exception ex)
            {
                Response.Redirect("Error.asx");
            }
        }

        
    }
}