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
namespace SchoolPRO
{
    public partial class AdminUpgradeTeacherDesignation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            if (ddltch.SelectedIndex != 0 && ddldesg.SelectedIndex != 0)
                try
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select nDesg_id from tbl_RecordDesignation where nTch_id='" + ddltch.SelectedValue + "' and nDesg_id='" + ddldesg.SelectedValue + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Designation already exist.');", true);
                    }
                    else
                    {
                        con.Close();
                        dr.Dispose();

                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "Select nDesg_id from tbl_Users where nu_id=@tchid and nsch_id=@schid";
                        cmd.Parameters.AddWithValue("@tchid", ddltch.SelectedValue);
                        cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);

                        dr = cmd.ExecuteReader();
                        string desgid = "";
                        if (dr.Read())
                        {
                            desgid = dr["nDesg_id"].ToString();
                        }
                        con.Close();
                        /////////////////////////////////////////////
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "Select nIcrSal_id from tbl_Users where nu_id=@tchid0 and nsch_id=@schid0";
                        cmd.Parameters.AddWithValue("@tchid0", ddltch.SelectedValue);
                        cmd.Parameters.AddWithValue("@schid0", Session["nschoolid"]);

                        dr = cmd.ExecuteReader();
                        string salid = "";
                        if (dr.Read())
                        {
                            salid = dr["nIcrSal_id"].ToString();
                        }
                        con.Close();

                        dr.Dispose();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_RecordDesignation(nTch_id,nDesg_id,nsch_id,nu_id,dtAddDate,bisDeleted,strStatus) values(@tchid1,@desgid1,@schid1,@uid1,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False','Previous')";
                        cmd.Parameters.AddWithValue("@tchid1", ddltch.SelectedValue);
                        cmd.Parameters.AddWithValue("@desgid1", desgid);
                        cmd.Parameters.AddWithValue("@uid1", Session["uid"]);
                        cmd.Parameters.AddWithValue("@schid1", Session["nschoolid"]);
                        cmd.ExecuteNonQuery();
                        con.Close();

                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "update tbl_Users set nDesg_id=@desg2 where nu_id=@tchid2";
                        cmd.Parameters.AddWithValue("@tchid2", ddltch.SelectedValue);
                        cmd.Parameters.AddWithValue("@desg2", ddldesg.SelectedValue);
                        cmd.ExecuteNonQuery();

                        con.Close();
                        //if (txtsal.Text != "")
                        //{
                            //////////////////////////////////////////////////////////////////////
                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "insert into tbl_IncrementSalaryRecord(nTch_id,strIncSal,nsch_id,nu_id,dtAddDate,bisDeleted,strStatus) values(@tchid4,@salper4,@schid4,@uid4,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False','True')";
                            cmd.Parameters.AddWithValue("@tchid4", ddltch.SelectedValue);
                            cmd.Parameters.AddWithValue("@salper4", txtsal.Text);
                            cmd.Parameters.AddWithValue("@uid4", Session["uid"]);
                            cmd.Parameters.AddWithValue("@schid4", Session["nschoolid"]);
                            cmd.ExecuteNonQuery();
                            con.Close();

                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "Select MAX(nSal_id) as id from tbl_IncrementSalaryRecord where nTch_id=@tchid8 and nsch_id=@schid8";
                            cmd.Parameters.AddWithValue("@tchid8", ddltch.SelectedValue);
                            cmd.Parameters.AddWithValue("@schid8", Session["nschoolid"]);

                            dr = cmd.ExecuteReader();
                            string salid8 = "";
                            if (dr.Read())
                            {
                                salid8 = dr["id"].ToString();
                            }
                            con.Close();
                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "update tbl_Users set nIcrSal_id=@salid5 where nu_id=@tchid5";
                            cmd.Parameters.AddWithValue("@tchid5", ddltch.SelectedValue);
                            cmd.Parameters.AddWithValue("@salid5", salid8);
                            cmd.ExecuteNonQuery();

                            con.Close();
                            ////////////////////////////////////////////////
                        //}
                        //txtaddDesig.Text = "";
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Designation has been successfully Upgrades.'); window.location='AdminAddTeacher.aspx'; ", true);
                        //PopulateData();
                        //MultiView1.ActiveViewIndex = 0;
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


        public void Bind_ddlTeacher()
        {
            if (ddldpt.SelectedIndex != 0)
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand("SELECT tbl_Users.nu_id, tbl_Users.strfname + ' ' + tbl_Users.strlname + ' ' + tbl_Designation.strDesgName AS name, tbl_Users.nsch_id FROM tbl_Users LEFT OUTER JOIN tbl_Designation ON tbl_Users.nDesg_id = tbl_Designation.nDesg_id WHERE (tbl_Users.nLevel = '2') AND (tbl_Users.bisDeleted = 'False') AND (tbl_Users.nsch_id = @schid) AND (tbl_Users.nDpt_id = @dptid)", con);
                    cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);
                    cmd.Parameters.AddWithValue("@dptid", ddldpt.SelectedValue);
                    SqlDataReader dr = cmd.ExecuteReader();
                    ddltch.DataSource = dr;
                    ddltch.Items.Clear();
                    ddltch.Items.Add("--Please Select Teacher--");
                    ddltch.DataTextField = "name";
                    ddltch.DataValueField = "nu_id";
                    ddltch.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Redirect("Error.aspx");
                }
                finally
                {
                    if (con.State == ConnectionState.Open)
                        con.Close();
                }
            }
            else
            {
                ddltch.Items.Clear();
                ddldesg.Items.Clear();
            }
        }

        protected void ddldpt_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bind_ddlTeacher();
        }
        public void Bind_ddlDesg()
        {
            if (ddltch.SelectedIndex != 0)
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand("SELECT nDesg_id, strDesgName + ' ' + strDesgCode AS name FROM tbl_Designation AS desg WHERE (bisDeleted = 'False') AND (nsch_id = @schid) AND (nDesg_id <> (SELECT nDesg_id FROM tbl_Users WHERE (nu_id = @tchid) AND (bisDeleted = 'False')))", con);
                    cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);
                    cmd.Parameters.AddWithValue("@tchid", ddltch.SelectedValue);
                    SqlDataReader dr = cmd.ExecuteReader();
                   ddldesg.DataSource = dr;
                   ddldesg.Items.Clear();
                   ddldesg.Items.Add("--Please Select Designation--");
                   ddldesg.DataTextField = "name";
                   ddldesg.DataValueField = "nDesg_id";
                   ddldesg.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Redirect("Error.aspx");
                }
                finally
                {
                    if (con.State == ConnectionState.Open)
                        con.Close();
                }
            }
            else
                ddldesg.Items.Clear();
        }

        protected void ddltch_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bind_ddlDesg();
        }

        protected void txtsal_TextChanged(object sender, EventArgs e)
        {
            Boolean flag = true;
            for (int i = 0; i < txtsal.Text.Length; i++)
            {
                if (txtsal.Text != "")
                {
                    if (txtsal.Text[i] >= 'a' && txtsal.Text[i] <= 'z' || txtsal.Text[i] >= 'A' && txtsal.Text[i] <= 'Z' || txtsal.Text[i] == '!' || txtsal.Text[i] == '@' || txtsal.Text[i] == '#' || txtsal.Text[i] == '$' || txtsal.Text[i] == '`' || txtsal.Text[i] == '~' || txtsal.Text[i] == '%' || txtsal.Text[i] == '^' || txtsal.Text[i] == '&' || txtsal.Text[i] == '*' || txtsal.Text[i] == '(' || txtsal.Text[i] == ')' || txtsal.Text[i] == '-' || txtsal.Text[i] == '+' || txtsal.Text[i] == '_' || txtsal.Text[i] == '=' || txtsal.Text[i] == ',' || txtsal.Text[i] == '.' || txtsal.Text[i] == '/' || txtsal.Text[i] == '?' || txtsal.Text[i] == ';' || txtsal.Text[i] == ':' || txtsal.Text[i] == '\'' || txtsal.Text[i] == '\"' || txtsal.Text[i] == '|' || txtsal.Text[i] == '\\' || txtsal.Text[i] == '/' || txtsal.Text[i] == '[' || txtsal.Text[i] == ']' || txtsal.Text[i] == '{' || txtsal.Text[i] == '}')
                    {

                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalid Entry.');", true);
                        txtsal.Text = "";
                        txtsal.Focus();
                        flag = false;
                        break;
                    }
                }
            }
            if (flag)
            {
                Int32 sal = Convert.ToInt32(txtsal.Text);
                if (sal <= 100 && sal > 0)
                {

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Invalid Entry.');", true);
                    txtsal.Text = "";
                    txtsal.Focus();
                }
            }
        }
    }
}