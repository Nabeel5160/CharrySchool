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
    public partial class AdminStudentLeavingCert : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
           // if(!IsPostBack)
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select strSchName+'  '+strAddress as school from  tbl_School where nsch_id= '" + Session["nschoolid"] + "' and bisDeleted='False'";
            dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                txtSchool.Text = dr["school"].ToString();
            }
            else
            {

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
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        /// <summary>
        /// ////////////////////////////BIND CLASS DD ////////////////////////////
        /// </summary>
        public void Bind_ddlClass() 
        {
            if (txtyear.Text != "")
            {
                if (txtyear.Text.Length == 4)
                {
            try
            {
                
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT [strClass],[nc_id] FROM [tbl_Class] WHERE ([bisDeleted] = 0) AND nsch_id='" + Session["nschoolid"] + "' AND SUBSTRING(dtAddDate ,7,10)='" + txtyear.Text + "'", con);
                SqlDataReader dr = cmd.ExecuteReader();

                ddcl.Items.Clear();
                ddcl.Items.Add("--Please Select Class--");
                ddcl.DataSource = dr;
                ddcl.DataTextField = "strClass";
                ddcl.DataValueField = "nc_id";
                ddcl.DataBind();
                con.Close();
            }
            catch (Exception) { }
             }
                else
                    ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "alert('Please Enter Year Only ... ThankYou');",true);
            }
            else
                ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "alert('Please Enter Year ... ThankYou');", true);
        
        }

        public void Bind_ddlSection()
        {
             if (txtyear.Text != "")
            {
                if (txtyear.Text.Length == 4)
                {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT [strSection],[nsc_id] FROM [tbl_Section] WHERE (([nc_id] ='" + ddcl.SelectedValue + "') AND SUBSTRING(dtAddDate ,7,10)='" + txtyear.Text + "')", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddsec.DataSource = dr;
                ddsec.Items.Clear();
                ddsec.Items.Add("--Please Select Section--");
                ddsec.DataTextField = "strSection";
                ddsec.DataValueField = "nsc_id";
                ddsec.DataBind();
                con.Close();
            }
            catch (Exception) { }
                }
                else
                    ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "alert('Please Enter Year Only ... ThankYou');", true);
            }
             else
                 ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "alert('Please Enter Year ... ThankYou');", true);
        
        }

        public void Bind_ddlStudent()
        {
            if (txtyear.Text != "")
            {
                if (txtyear.Text.Length == 4)
                {
                    try
                    {
                        try
                        {
                            con.Open();
                            SqlCommand cmd = new SqlCommand("SELECT [strFname], [strStudentNum]+'_'+CAST(ne_id as VARCHAR(50)) as stnum FROM [tbl_Enrollment] WHERE (([nc_id] = '" + ddcl.SelectedValue + "') AND ([nsc_id] ='" + Convert.ToInt32(ddsec.SelectedValue) + "')  AND ([bisDeleted] =0))", con);

                            SqlDataReader dr = cmd.ExecuteReader();

                            ddst.Items.Clear();
                            ddst.Items.Add("--Please Select students--");
                            ddst.DataSource = dr;
                            ddst.DataTextField = "strFname";
                            ddst.DataValueField = "stnum";
                            ddst.DataBind();
                            con.Close();
                        }
                        catch (Exception) { }
                    }
                    catch (Exception) { }
                }
                else
                    ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "alert('Please Enter Year Only ... ThankYou');",true);
            }
            else
                ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "alert('Please Enter Year ... ThankYou');", true);
        }

        protected void ddcl_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bind_ddlSection();
        }

        protected void ddsec_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bind_ddlStudent();
        }

        protected void ddst_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                //txtstnum.Text = ddst.SelectedValue;
                string stnumid = ddst.SelectedValue;
                int dashe = stnumid.IndexOf('_');
                string neid = stnumid.Substring(dashe + 1, stnumid.Length - (dashe + 1));
                string stnumber = stnumid.Substring(0, dashe);

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select e.strStudentNum,e.strFname+' '+e.strLname as Name,e.dtVerifyDate,c.strClass,s.strSection,f.strLeaveFee from tbl_Enrollment e inner join tbl_Fee f on e.nfee_id=f.nfee_id inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Section s on e.nsc_id=s.nsc_id where e.ne_id='" + neid + "' and e.bisDeleted='False' and c.nc_id='" + ddcl.SelectedValue + "' and s.nsc_id='" + ddsec.SelectedValue + "' and e.nsch_id='" + Session["nschoolid"] + "'";
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtstName.Text = dr["Name"].ToString();
                    date.Text = DateTime.Now.Date.ToString();
                    txtdate.Text = dr["dtVerifyDate"].ToString();
                    txtstRoll.Text = dr["strStudentNum"].ToString();
                    txtstClass.Text = dr["strClass"].ToString();
                    txtstSec.Text = dr["strSection"].ToString();
                    txtLvFee.Text = dr["strLeaveFee"].ToString();
                }
                else
                {

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

        protected void txtstnum_TextChanged(object sender, EventArgs e)
        {
            
        }

        protected void txtyear_TextChanged(object sender, EventArgs e)
        {
            try
            {
            if (txtyear.Text != "")
            {
                if (txtyear.Text.Length <= 4)
                {
                    Bind_ddlClass();
                }
                else
                {
                    txtyear.Text = "";
                }
            }
            }
            catch (Exception ex)
            {
             //   Response.Redirect("Error.aspx");
            }
            finally
            {
               
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
             Boolean flag = true;
            try
            {
                string stnumid = ddst.SelectedValue;
                int dashe = stnumid.IndexOf('_');
                string neid = stnumid.Substring(dashe + 1, stnumid.Length - (dashe + 1));
                string stnumber = stnumid.Substring(0, dashe);

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into tbl_RecieveFee (ne_id,nc_id,nsc_id,nu_id,nsch_id,strFeeAmountReceived,strRecieveType,dtAddDate,bisDeleted)values(@neid,'" + ddcl.SelectedValue + "',@nscid,@nuid,@nschid,@stramt,'Leave_Cert',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                cmd.Parameters.AddWithValue("@neid", neid);
               
                cmd.Parameters.AddWithValue("@nscid", ddsec.SelectedValue);
                cmd.Parameters.AddWithValue("@nuid", Session["uid"]);
                cmd.Parameters.AddWithValue("@nschid", Session["nschoolid"]);
                cmd.Parameters.AddWithValue("@stramt", txtLvFee.Text);


                if (cmd.ExecuteNonQuery() == -1)
                    flag = false;
                con.Close();

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into tbl_SchoolLeaving (ne_id,nc_id,nsc_id,nu_id,nsch_id,nS_No,strStartDate,strEndDate,strRemarks,dtAddDate,bisDeleted)values(@neid1,'" + ddcl.SelectedValue + "',@nscid1,@nuid1,@nschid1,(Select MAX(nS_No)+1 from tbl_SchoolLeaving where bisDeleted='False'),@stdate,'" + txtenddate.Text + "','"+txtRemarks.Text+"',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                cmd.Parameters.AddWithValue("@neid1", neid);
           
                cmd.Parameters.AddWithValue("@nscid1", ddsec.SelectedValue);
                cmd.Parameters.AddWithValue("@nuid1", Session["uid"]);
                cmd.Parameters.AddWithValue("@nschid1", Session["nschoolid"]);

                cmd.Parameters.AddWithValue("@stdate", txtdate.Text);
                cmd.Parameters.AddWithValue("@remark",txtRemarks.Text);

                if (cmd.ExecuteNonQuery() == -1)
                    flag = false;
                con.Close();

                

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Update tbl_Enrollment set bisDeleted='True' ,dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where ne_id='"+neid+"' and bisDeleted='False'";
                if (cmd.ExecuteNonQuery() == -1)
                    flag = false;
                con.Close();
                if(flag)
                    ScriptManager.RegisterStartupScript(this, GetType(), "print", "printDiv('printable')", true);
                else
                    Response.Redirect("Error.aspx?msg=AdminStudentLeavingCert.aspx");

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