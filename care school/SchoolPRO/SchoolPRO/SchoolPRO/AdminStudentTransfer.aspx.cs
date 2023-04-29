using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
namespace SchoolPRO
{
    public partial class AdminStudentTransfer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
                
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void ddlschool_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlclass_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        string GenrerateStudentNumber()
        {
            string neid = Session["__eid"].ToString();
            string cid = ddlclass.SelectedValue;
            string scid = ddlsec.SelectedValue;
            string stnumber = "";
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select strStudentNum from  tbl_Enrollment where ne_id=(select Max(ne_id) as Id from tbl_Enrollment where  nsc_id=@scid2 and nc_id=@cid2 and bisDeleted='False' and nsch_id=@nschid2)";
               
                cmd.Parameters.AddWithValue("@cid2", cid);

                cmd.Parameters.AddWithValue("@scid2", scid);
                cmd.Parameters.Add("@nschid2", SqlDbType.Int);
                cmd.Parameters["@nschid2"].Value = Convert.ToInt32(ddlschool.SelectedValue);
                
                
                //  cmd.CommandText = "select strStudentNum from  tbl_StudentNumber where ne_id=(select Max(ne_id) as Id from tbl_StudentNumber where  nsc_id=(select nsc_id from tbl_Section where strSection='" + ddsec.Text + "' and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted='False')and bisDeleted='False') and nc_id=(select nc_id from tbl_Class where strClass='" + ddcl.Text + "' and bisDeleted='False') and bisDeleted='False')";
                //cmd.Parameters.AddWithValue("@reg1", tb.Text);
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    string stnum = dr["strStudentNum"].ToString();
                    if (stnum == "")
                    {
                        stnum = ddlclass.Text + ddlsec.Text + "-" + "1";
                    }
                    //stnum = "10B-100";
                    int dashe = stnum.IndexOf('-');
                    string rollnumber = stnum.Substring(dashe + 1, stnum.Length - (dashe + 1));
                    string classSection = stnum.Substring(0, dashe);
                    int rollnumber2 = Convert.ToInt32(rollnumber);
                    rollnumber2++;

                    string NewSTNUM = classSection + "-" + rollnumber2.ToString();

                  stnum = NewSTNUM;
                    //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('The Student Verification Number already exist.');", true);
                }
                else
                {
                    string stnum = ddlclass.SelectedItem.ToString() + ddlsec.SelectedItem.ToString() + "-" + "1";
                   stnumber= stnum;
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
            return stnumber;

        }
        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try
            {
                string neid = Session["__eid"].ToString();
                string cid = Session["cid"].ToString();
                string scid = Session["__scid"].ToString();
                string stnum=GenrerateStudentNumber();

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into tbl_StudentTransferRecord (strTransferReason,ne_id,nc_id,nsc_id,nfee_id,nfrom_sch_id,nto_sch_id,dtAddDate,bisDeleted,nuserid) Values(@reason,@neid,@ncid,@nscid,(Select nfee_id from tbl_Fee where nc_id=@ncid1 and bisDeleted='False' and nsch_id=@nschid1),@fromnschid,@tonschid,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False',@uid)";
                cmd.Parameters.AddWithValue("@neid",neid);
                cmd.Parameters.AddWithValue("@reason", txtreason.Text);
                cmd.Parameters.AddWithValue("@ncid", cid);
                cmd.Parameters.AddWithValue("@ncid1", cid);
                cmd.Parameters.AddWithValue("@nscid", scid);
                cmd.Parameters.Add("@nschid1", SqlDbType.Int);
                cmd.Parameters["@nschid1"].Value = Convert.ToInt32(Session["nschoolid"].ToString());

                cmd.Parameters.Add("@fromnschid", SqlDbType.Int);
                cmd.Parameters["@fromnschid"].Value = Convert.ToInt32(Session["nschoolid"].ToString());

                cmd.Parameters.Add("@tonschid", SqlDbType.Int);
                cmd.Parameters["@tonschid"].Value = Convert.ToInt32(ddlschool.SelectedValue);
                cmd.Parameters.Add("@uid", SqlDbType.Int);
                cmd.Parameters["@uid"].Value = Convert.ToInt32(Session["uid"].ToString());

                //cmd.CommandText = "Update tbl_Enrollment Set strDOB='" + lbldob.Text + "' , strBirthPlace='" + lblbp.Text + "',strNationality='" + lblntn.Text + "' ,strMotherlang='" + lblmlng.Text + "',strReligion='" + lblrelg.Text + "',strPhAddress='" + lbladr.Text + "',strCity='" + lblcit.Text + "',strState='" + lblst.Text + "',strCountry='" + lblcnt.Text + "',strPhone='" + lblph.Text + "',strMobile='" + lblph.Text + "'  where  ne_id='" + Session["id"] + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";



                cmd.ExecuteNonQuery();
                con.Close();

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Update tbl_Enrollment set nc_id=@cid ,nsc_id=@scid,nsch_id=@schid ,nfee_id=(select nfee_id from tbl_Fee where nc_id=@cid and bisDeleted='False' and nsch_id=@schid),strStudentNum=@stnum where ne_id=@eid and bisDeleted='False'";
                cmd.Parameters.AddWithValue("@eid", neid);
                cmd.Parameters.AddWithValue("@cid", ddlclass.SelectedValue);
                cmd.Parameters.AddWithValue("@scid", ddlsec.SelectedValue);
                cmd.Parameters.AddWithValue("@stnum",stnum);
                cmd.Parameters.Add("@schid", SqlDbType.Int);
                cmd.Parameters["@schid"].Value = Convert.ToInt32(ddlschool.SelectedValue);
                 

                //cmd.CommandText = "Update tbl_Enrollment Set strDOB='" + lbldob.Text + "' , strBirthPlace='" + lblbp.Text + "',strNationality='" + lblntn.Text + "' ,strMotherlang='" + lblmlng.Text + "',strReligion='" + lblrelg.Text + "',strPhAddress='" + lbladr.Text + "',strCity='" + lblcit.Text + "',strState='" + lblst.Text + "',strCountry='" + lblcnt.Text + "',strPhone='" + lblph.Text + "',strMobile='" + lblph.Text + "'  where  ne_id='" + Session["id"] + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";



                cmd.ExecuteNonQuery();
                con.Close();




                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Student Transfer SuccessFully.'); window.location='AdminViewClassStudents.aspx';", true);
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