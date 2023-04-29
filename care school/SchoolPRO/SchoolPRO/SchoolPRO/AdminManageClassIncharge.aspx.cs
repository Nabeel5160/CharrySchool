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
    public partial class AdminManageClassIncharge : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {

                    BindGrid();

                }
                txtcc.Focus();
            }
            catch (Exception ex) { }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Select i.nclt_id,c.strClass,s.strSection,t.strfname,t.strfname+' '+t.strlname as name from tbl_ClassIncharge i inner join tbl_Class c on i.nc_id=c.nc_id inner join tbl_Section s on i.nsc_id=s.nsc_id inner join tbl_Users t on i.nu_id=t.nu_id where i.bisDeleted='False' and i.nsch_id='" + Session["nschoolid"] + "' and t.bisDeleted='False' and t.nsch_id='" + Session["nschoolid"] + "'";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            return objDs.Tables[0];

        }
        private void BindGrid()
        {
            try
            {
                DataTable dt = GetRecords();
                if (dt.Rows.Count > 0)
                {
                    gvsearchclass.DataSource = dt;
                    gvsearchclass.DataBind();
                }
            }
            catch (Exception ex) { }
        }

        protected void txtcc_TextChanged(object sender, EventArgs e)
        {
            SearchText();
        }
        private void SearchText()
        {
            try
            {
                DataTable dt = GetRecords();
                DataView dv = new DataView(dt);
                string SearchExpression = null;
                if (!String.IsNullOrEmpty(txtcc.Text))
                {
                    SearchExpression = string.Format("{0} '%{1}%'",
                    gvsearchclass.SortExpression, txtcc.Text);

                }
                else
                {
                    Response.Redirect("AdminManageClassIncharge.aspx");
                }
                dv.RowFilter = "name like" + SearchExpression;
                gvsearchclass.DataSource = dv;
                gvsearchclass.DataBind();
            }
            catch (Exception ex) { }

        }

        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvsearchclass.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvsearchclass.HeaderRow.FindControl("txtcc");

                if (txtExample.Text != null)
                {
                    string strSearch = txtExample.Text;
                    Regex RegExp = new Regex(strSearch.Replace(" ", "|").Trim(), RegexOptions.IgnoreCase);
                    return RegExp.Replace(InputTxt, new MatchEvaluator(ReplaceKeyWords));
                    RegExp = null;
                }
                else
                    return InputTxt;
            }
            else
            {
                return InputTxt;
            }
        }

        public string ReplaceKeyWords(Match m)
        {
            return "<span class='highlight'>" + m.Value + "</span>";
        }

        private void PopulateData()
        {
            try
            {

            DataTable table = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {

                string sql = "Select i.nclt_id,c.strClass,s.strSection,t.strfname,t.strfname+' '+t.strlname as name from tbl_ClassIncharge i inner join tbl_Class c on i.nc_id=c.nc_id inner join tbl_Section s on i.nsc_id=s.nsc_id inner join tbl_Users t on i.nu_id=t.nu_id where i.bisDeleted='False' and i.nsch_id='" + Session["nschoolid"] + "' and t.bisDeleted='False' and t.nsch_id='" + Session["nschoolid"] + "'";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvsearchclass.DataSource = table;

            gvsearchclass.DataBind();
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

        
        protected void btnshow_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            string del = gvr.Cells[1].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_ClassIncharge set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nclt_id='" + del+ "'";
            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvt.ActiveViewIndex = 0;
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

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 1;
        }

        

        protected void btngoback_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 0;
            PopulateData();
        }

        protected void btnadd_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select nc_id from tbl_ClassIncharge where nc_id=(@cnm1) and nsc_id='" + ddsec.Text + "'  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                cmd.Parameters.AddWithValue("@cnm1", ddcl.SelectedValue);
                dr=cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('ClassIncharge already exist.');", true);
                }
                else
                {
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select nc_id from tbl_ClassIncharge where nu_id=@tchr and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    cmd.Parameters.AddWithValue("@tchr", ddtchr.SelectedValue);
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('The Teacher is Already a ClassIncharge .');", true);
                    }
                    else
                    {
                        con.Close();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_ClassIncharge(nu_id,nc_id,nsc_id,nsch_id,dtAddDate,bisDeleted)values(@umn,@cnm,'" + ddsec.SelectedValue + "','" + Session["nschoolid"] + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                        cmd.Parameters.AddWithValue("@umn", ddtchr.SelectedValue);
                        cmd.Parameters.AddWithValue("@cnm", ddcl.Text);
                        cmd.Parameters.AddWithValue("@snm", ddsec.Text);

                        cmd.ExecuteNonQuery();
                        con.Close();
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Incharge Added Successfully .'); window.location = 'AdminManageClassIncharge.aspx';", true);
                        PopulateData();
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
                }
            }
        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 2;
            Bind_ddlTeacher1();
        }

        protected void btnChangeIncharge_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Select nclt_id from tbl_ClassIncharge where nc_id=(Select nc_id from tbl_Class where strClass='" + txtclassnm.Text + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "') AND nsc_id=(Select nsc_id from tbl_Section where strSection='" + txtsecnm.Text + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "' and nc_id=(Select nc_id from tbl_Class where strClass='" + txtclassnm.Text + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "')) AND nu_id='" + ddltch.SelectedValue + "' AND bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";


                dr = cmd.ExecuteReader();
                dr.Read();
                string FirstInchargeid = dr["nclt_id"].ToString();
                con.Close();

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Select nclt_id from tbl_ClassIncharge where nc_id=(Select nc_id from tbl_Class where strClass='" + txtclassnm2.Text + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "') AND nsc_id=(Select nsc_id from tbl_Section where strSection='" + txtsecnm2.Text + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "' and nc_id=(Select nc_id from tbl_Class where strClass='" + txtclassnm2.Text + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "')) AND nu_id='" + ddltch2.SelectedValue + "' AND bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";


                dr = cmd.ExecuteReader();
                dr.Read();
                string SecInchargeid = dr["nclt_id"].ToString();
                con.Close();

                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "Update tbl_ClassIncharge set nu_id='" + ddltch2.SelectedValue + "' where nclt_id='" + FirstInchargeid + "' and bisDeleted='False' ";
                    

                    cmd.ExecuteNonQuery();
                    con.Close();

                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "Update tbl_ClassIncharge set nu_id='" + ddltch.SelectedValue + "' where nclt_id='" + SecInchargeid + "' and bisDeleted='False' ";


                    cmd.ExecuteNonQuery();
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Incharge InterChanged Successfully .'); window.location = 'AdminManageClassIncharge.aspx';", true);
                    mvt.ActiveViewIndex = 0;
                    PopulateData();
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
        public void Bind_ddlTeacher1()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT tbl_Users.nu_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS name FROM tbl_Users INNER JOIN tbl_ClassIncharge ON tbl_Users.nu_id = tbl_ClassIncharge.nu_id WHERE (tbl_Users.bisDeleted = 0) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = '" + Session["nschoolid"] + "') AND (tbl_ClassIncharge.bisDeleted = 'False')", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddltch.DataSource = dr;
                ddltch.Items.Clear();
                ddltch.Items.Add("--Please Select Teacher--");
                ddltch.DataTextField = "name";
                ddltch.DataValueField = "nu_id";
                ddltch.DataBind();
                con.Close();
            }
            catch (Exception) { }
        }
        public void Bind_ddlTeacher2()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT tbl_Users.nu_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS name FROM tbl_Users INNER JOIN tbl_ClassIncharge ON tbl_Users.nu_id = tbl_ClassIncharge.nu_id WHERE (tbl_Users.bisDeleted = 0) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = '" + Session["nschoolid"] + "') and tbl_Users.nu_id <>'" + ddltch.SelectedValue + "' AND (tbl_ClassIncharge.bisDeleted = 'False')", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddltch2.DataSource = dr;
                ddltch2.Items.Clear();
                ddltch2.Items.Add("--Please Select Teacher--");
                ddltch2.DataTextField = "name";
                ddltch2.DataValueField = "nu_id";
                ddltch2.DataBind();
                con.Close();
            }
            catch (Exception) { }
        }
        public void Bind_ddlTeacher3()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT tbl_Users.nu_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS name FROM tbl_Users INNER JOIN tbl_ClassIncharge ON tbl_Users.nu_id = tbl_ClassIncharge.nu_id WHERE (tbl_Users.bisDeleted = 0) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = '" + Session["nschoolid"] + "') AND (tbl_ClassIncharge.bisDeleted = 'False')", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddltch3.DataSource = dr;
                ddltch3.Items.Clear();
                ddltch3.Items.Add("--Please Select Teacher--");
                ddltch3.DataTextField = "name";
                ddltch3.DataValueField = "nu_id";
                ddltch3.DataBind();
                con.Close();
            }
            catch (Exception ex) { }
        }
        public void Bind_ddlTeacher4()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT  tbl_Users.nu_id, tbl_Users.strfname + '  ' + tbl_Users.strlname AS name FROM tbl_Users LEFT OUTER JOIN   tbl_ClassIncharge ON tbl_Users.nu_id = tbl_ClassIncharge.nu_id WHERE (tbl_Users.bisDeleted = 0) AND (tbl_ClassIncharge.nu_id IS NULL)AND (tbl_Users.nLevel = 2) AND (tbl_Users.nu_id<>'" + ddltch3.SelectedValue + "') AND (tbl_Users.nsch_id='" + Session["nschoolid"] + "')", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddltch4.DataSource = dr;
                ddltch4.Items.Clear();
                ddltch4.Items.Add("--Please Select Teacher--");
                ddltch4.DataTextField = "name";
                ddltch4.DataValueField = "nu_id";
                ddltch4.DataBind();
                con.Close();
            }
            catch (Exception ex) { }
        }
       

        protected void ddltch2_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT tbl_Class.strClass,tbl_Class.nc_id, tbl_Section.strSection FROM  tbl_ClassIncharge INNER JOIN   tbl_Class ON tbl_ClassIncharge.nc_id = tbl_Class.nc_id INNER JOIN    tbl_Section ON tbl_ClassIncharge.nsc_id = tbl_Section.nsc_id WHERE (tbl_ClassIncharge.nu_id='" + ddltch2.SelectedValue + "') AND (tbl_ClassIncharge.bisDeleted = 'False') and tbl_ClassIncharge.nsch_id='" + Session["nschoolid"] + "'";


            dr = cmd.ExecuteReader();
            dr.Read();
            txtclassnm2.Text = dr["strClass"].ToString();
            txtsecnm2.Text = dr["strSection"].ToString();
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

        protected void ddltch_SelectedIndexChanged1(object sender, EventArgs e)
        {
            try
            {
            Bind_ddlTeacher2();
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT tbl_Class.strClass, tbl_Section.strSection FROM  tbl_ClassIncharge INNER JOIN   tbl_Class ON tbl_ClassIncharge.nc_id = tbl_Class.nc_id INNER JOIN    tbl_Section ON tbl_ClassIncharge.nsc_id = tbl_Section.nsc_id WHERE (tbl_ClassIncharge.nu_id='" + ddltch.SelectedValue + "')AND (tbl_ClassIncharge.bisDeleted = 'False') and tbl_ClassIncharge.nsch_id='" + Session["nschoolid"] + "'";


            dr = cmd.ExecuteReader();
            dr.Read();
            txtclassnm.Text = dr["strClass"].ToString();
            txtsecnm.Text = dr["strSection"].ToString();
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

        protected void btnRemoveaandChangeIncharge_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Select nclt_id from tbl_ClassIncharge where nc_id=(Select nc_id from tbl_Class where strClass='" + txtclassnm3.Text + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "') AND nsc_id=(Select nsc_id from tbl_Section where strSection='" + txtsecnm3.Text + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "' and nc_id=(Select nc_id from tbl_Class where strClass='" + txtclassnm3.Text + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "')) AND nu_id='" + ddltch3.SelectedValue + "' AND bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";


                dr = cmd.ExecuteReader();
                dr.Read();
                string FirstInchargeid = dr["nclt_id"].ToString();
                con.Close();

                

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Update tbl_ClassIncharge set nu_id='" + ddltch4.SelectedValue + "' where nclt_id='" + FirstInchargeid + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "' ";


                cmd.ExecuteNonQuery();
                con.Close();


                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Incharge Changed  Successfully .'); window.location = 'AdminManageClassIncharge.aspx';", true);
                mvt.ActiveViewIndex = 0;
                PopulateData();
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

        protected void ddltch3_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
            Bind_ddlTeacher4();
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT tbl_Class.strClass, tbl_Section.strSection FROM  tbl_ClassIncharge INNER JOIN   tbl_Class ON tbl_ClassIncharge.nc_id = tbl_Class.nc_id INNER JOIN    tbl_Section ON tbl_ClassIncharge.nsc_id = tbl_Section.nsc_id WHERE (tbl_ClassIncharge.nu_id='" + ddltch3.SelectedValue + "')AND (tbl_ClassIncharge.bisDeleted = 'False') and tbl_ClassIncharge.nsch_id='" + Session["nschoolid"] + "'";


            dr = cmd.ExecuteReader();
            dr.Read();
            txtclassnm3.Text = dr["strClass"].ToString();
            txtsecnm3.Text = dr["strSection"].ToString();
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

        protected void btnRemoveAndAssign_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 3;
            Bind_ddlTeacher3();
        }

        protected void ddltch4_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
    }
}