using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
namespace SchoolPRO.SuperAdmin
{
    public partial class ManageGroups : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            gid.Text = gvr.Cells[1].Text;
            
            //DS.SelectParameters["@gid"].DefaultValue = gvr.Cells[1].Text;
            //DS.DataBind();
            MultiView1.ActiveViewIndex = 3;
            
        }

        protected void btndel_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string gid = gvr.Cells[1].Text;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Update tbl_Group set bisDeleted='True' where nGid='" + gid + "'";

                cmd.ExecuteNonQuery();

                con.Close();
                
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Delete tbl_PageGroup  where nGid='" + gid + "'";

                cmd.ExecuteNonQuery();

                con.Close();
                
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            Response.Redirect("ManageGroups.aspx");
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Boolean Addflag = true;
            try
            {

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from tbl_Group where nGcode='" + txtGroupcode.Text + "' and bisDeleted='False'";
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Group Code already exist.');", true);
                }
                else
                {
                    con.Close();
                    dr.Dispose();
                    string groupid = "";
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_Group(strGname,nGcode,dtAddDate,bisDeleted) values(@cname,@nos,convert(date,SYSDATETIME()),'False')";

                    cmd.Parameters.AddWithValue("@cname", txtGroupname.Text);
                    cmd.Parameters.AddWithValue("@nos", txtGroupcode.Text);
                    if (cmd.ExecuteNonQuery() == -1)
                        Addflag = false;
                    con.Close();

                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "Select Max(nGid) as id from tbl_Group where bisDeleted='False'";
                    dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        groupid = dr["id"].ToString();
                    }
                    con.Close();
                    //Response.Redirect("ManageGroups.aspx");
                    //MultiView1.ActiveViewIndex = 0;

                    int i=0;
                    foreach (GridViewRow row in gvpagess.Rows)
                    {
                        if (row.RowType == DataControlRowType.DataRow)
                        {
                            CheckBox chkRow = (row.Cells[1].FindControl("chkRow") as CheckBox);
                            if (chkRow.Checked)
                            {
                                string pid = row.Cells[0].Text;
                                try
                                {
                                    con.Open();
                                    cmd.Connection = con;
                                    cmd.CommandType = CommandType.Text;
                                    cmd.CommandText = "insert into tbl_PageGroup(nPid,nGid) values(@pid"+i.ToString()+",@gid"+i.ToString()+")";
                                    cmd.Parameters.Add("@pid"+i.ToString(), SqlDbType.Int);
                                    cmd.Parameters["@pid" + i.ToString()].Value = Convert.ToInt32(pid);
                                    cmd.Parameters.Add("@gid" + i.ToString(), SqlDbType.Int);
                                    cmd.Parameters["@gid" + i.ToString()].Value = Convert.ToInt32(groupid);
                                    if (cmd.ExecuteNonQuery() == -1)
                                        Addflag = false;
                                    con.Close();
                                    i++;
                                }
                                catch (Exception ex)
                                {
                                   // Response.Redirect("~/Error.aspx");

                                }
                                finally
                                {
                                    if (con.State == ConnectionState.Open)
                                    {
                                        con.Close();
                                    }
                                }

                                //string country = (row.Cells[2].FindControl("lblCountry") as Label).Text;

                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Error.aspx");

            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            if (Addflag)
                Response.Redirect("ManageGroups.aspx");
        }

        protected void btnupdatepage_Click(object sender, EventArgs e)
        {

        }

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 1;
        }

        protected void chkHeader_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkselectall = (CheckBox)gvpagess.HeaderRow.FindControl("chkHeader");
            foreach (GridViewRow row in gvpagess.Rows)
            {
                CheckBox chkchecked = (CheckBox)row.FindControl("chkRow");
                if (chkselectall.Checked)
                {
                    chkchecked.Checked = true;
                }
                else
                {
                    chkchecked.Checked = false;
                }
            }
        }
    }
}