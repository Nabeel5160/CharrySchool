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
    public partial class Admin : System.Web.UI.MasterPage
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlConnection con2 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlCommand cmd2 = new SqlCommand();
        SqlDataReader dr;
        SqlDataReader dr2;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_level"].ToString() == "1010010")
            {
                showsuperadmin.Visible = true;
            }
            else
            {
                showsuperadmin.Visible = false;
            }
            if (Session["_level"] != null)
            {
                if (Session["_level"].ToString() == "1" || Session["_level"].ToString() == "1010010")
                {

                }
                else
                    Response.Redirect("Default.aspx");
            }
            else
                Response.Redirect("Default.aspx");

            Boolean _allowflag = false;
            string p = this.Page.Request.FilePath.ToString();
            string pname = p.Substring(p.IndexOf('/') + 1, p.IndexOf('.') - 1);
            try
            {
                

                if (Session["name"] == null)
                {
                    Response.Redirect("Default.aspx");
                }
                else

                    lblnm.Text = Session["name"].ToString();

                if (GetAuthorization(pname))
                {
                    _allowflag = true;
                }
                try
                {
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select Count(nevent_id) as sum from tbl_Event where bisActive=1 and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        //txtEventNotify.Text = dr["sum"].ToString();
                        //txtEventNotify2.Text = dr["sum"].ToString();
                    }

                    con.Close();
                }
                catch (Exception)
                {
                    Response.Redirect("Error.aspx");
                }
            }
            catch (Exception ex)
            {
                Session.Clear();
                Response.Redirect("Default.aspx");
            }
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select Count(*) as sum from tbl_Message where nU_rcv_id='" + Session["uid"] + "' and  bisRead=0 and bisDeleted=0";
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    txtMsgCount.Text = dr["sum"].ToString();
                    txtMsgCount1.Text = dr["sum"].ToString();
                }

                con.Close();
            }
            catch (Exception)
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

            if (_allowflag == false)
            {
                Server.Transfer("NotAllowed.aspx");

                //Response.Redirect("NotAllowed.aspx");
            }
           
            //lblnm.Text = Session["name"].ToString();
        }
        /// <summary>
        /// ////////////////////////////FUNC WHICH ACTUALLY AUTHORIZIES THE PAHES TO USERS//////////////
        /// ////////////////////////////With respect to their Group/////////////////////////////////////
        /// </summary>
        /// <param name="ggid"></param>
        public Boolean GetAuthorization(string pname)
        {

            string group_id = Session["_Groupid_"].ToString();
            bool flag1 = false;
            Boolean _allowflag = false;

            try
            {
                string sql = "Select nPid from [dbo].[tbl_PageGroup] where nGid='" + group_id + "'";
                con.Open();
                cmd.Connection = con;
                cmd.CommandText = sql;
                dr = cmd.ExecuteReader();


                int c = 0;
                int pid;
                if (dr.HasRows)
                {

                    while (dr.Read())
                    {


                        try
                        {
                            pid = Convert.ToInt32(dr["nPid"].ToString());
                            //MessageBox.Show(sdr["nGridFK"].ToString());
                            string sql1 = "Select * from [dbo].[tbl_Page] where nPid='" + pid + "'";

                            con2.Open();
                            cmd2.Connection = con2;
                            cmd2.CommandText = sql1;
                            dr2 = cmd2.ExecuteReader();
                            if (dr2.HasRows)
                            {
                                flag1 = true;


                            }
                            else 
                            {
                                // MessageBox.Show("No Page Accessable ");
                                con.Close();
                                con2.Close();
                                return false;
                                //flag1 = false;
                            }
                            if (flag1 == true)
                            {
                                if (dr2.Read())
                                {
                                    if (dr2["strPname"].ToString() == pname)
                                    {
                                        _allowflag = true;
                                    }
                                }
                                //   MessageBox.Show(reader2["strGname"].ToString());
                                ////////////////////STORE//////////////////////////////////




                            }

                            con2.Close();


                        }
                        catch (Exception er)
                        {
                            //MessageBox.Show("Page data " + er.Message);
                        }
                        c++;
                    }
                    con.Close();


                }
                else
                {
                    con.Close();
                    return false;
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

            if ("AdminDashBoard" == pname || "AdminChangePassword" == pname)
                _allowflag = true;
            return _allowflag;
            //if (_allowflag==false)
            //{
            //    Response.Redirect("NotAllowed.aspx");
            //}
            /////////////////////////
        }

    }
}