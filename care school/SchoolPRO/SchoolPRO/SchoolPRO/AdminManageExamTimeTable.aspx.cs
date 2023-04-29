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
    public partial class AdminManageExamTimeTable : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
            if (!IsPostBack)
            {

                BindGrid();

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
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select t.nt_id,c.strClass,s.strSubject,t.strStartTime,t.strEndTime,t.strShift,t.strStartDate from tbl_TimeTable t inner join tbl_Class c on t.nc_id=c.nc_id inner join tbl_Subject s on t.nsbj_id=s.nsbj_id where t.bisDeleted='False' and t.nsch_id='" + Session["nschoolid"] + "' and t.strType='Exam'";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            return objDs.Tables[0];

        }
        private void BindGrid()
        {try
        {
            DataTable dt = GetRecords();
            if (dt.Rows.Count > 0)
            {
                gvttable.DataSource = dt;
                gvttable.DataBind();
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

        private void SearchText(string strSearchText)
        {
            try
            {
            DataTable dt = GetRecords();
            DataView dv = new DataView(dt);
            string SearchExpression = null;
            if (!String.IsNullOrEmpty(strSearchText))
            {
                SearchExpression =
                string.Format("{0} '%{1}%'", gvttable.SortExpression, strSearchText);

            }else

                Response.Redirect("AdminManageExamTimeTable.aspx");
            


            dv.RowFilter = "strname like" + SearchExpression;
            gvttable.DataSource = dv;
            gvttable.DataBind();
            }
            catch (Exception ex)
            {
               // Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }



        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvttable.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvttable.HeaderRow.FindControl("txtcc");

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

                string sql = "select t.nt_id,c.strClass,s.strSubject,t.strStartTime,t.strEndTime,t.strShift,t.strStartDate from tbl_TimeTable t inner join tbl_Class c on t.nc_id=c.nc_id inner join tbl_Subject s on t.nsbj_id=s.nsbj_id where t.bisDeleted='False' and t.nsch_id='" + Session["nschoolid"] + "' and t.strType='Exam'";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvttable.DataSource = table;

            gvttable.DataBind();
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
        protected void btnttable_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddcl.Text == "" && txtsdt.Text == "")
                {
                    Response.Write("fill the fields");
                }
                else
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    //cmd.CommandText = "select * from tbl_TimeTable where strClass='" + txtaddclass.Text + "' and bisDeleted='False'";
                    cmd.CommandText = "select * from tbl_TimeTable where strStartTime='" + txtsdt.Text + "' and nsbj_id='" + ddsub.SelectedValue + "' and nc_id='" + ddcl.SelectedValue + "' and strType='Exam' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Class Exam  already exist.');", true);
                    }
                    else
                    {
                        con.Close();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "insert into tbl_TimeTable(nshdule_id,nc_id,nsbj_id,strStartTime,strEndTime,strShift,strStartDate,strType,nsch_id,dtAddDate,bisDeleted)values(@shdlid,@cid,@sid ,@stime,@etime,@shft,@dt,'Exam','" + Session["nschoolid"] + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                        cmd.Parameters.AddWithValue("@shdlid",ddlTimetable.SelectedValue);
                        cmd.Parameters.AddWithValue("@cid", ddcl.SelectedValue);
                        cmd.Parameters.AddWithValue("@sid", ddsub.SelectedValue);
                        cmd.Parameters.AddWithValue("@stime", txtsdt.Text);
                        cmd.Parameters.AddWithValue("@etime", txtenddt.Text);
                        cmd.Parameters.AddWithValue("@shft", ddshft.Text);
                        cmd.Parameters.AddWithValue("@dt", txt2dt.Text);
                        cmd.ExecuteNonQuery();
                        con.Close();
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
            PopulateData();
            mvtime.ActiveViewIndex = 0;
        }

        protected void ddcl_SelectedIndexChanged(object sender, System.EventArgs e)
        {

        }

        protected void gvttable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
            System.Threading.Thread.Sleep(2000);
            if (e.CommandName == "Search")
            {
                TextBox txtGrid = (TextBox)gvttable.HeaderRow.FindControl("txtcc");
                SearchText(txtGrid.Text);
            }
            }
            catch (Exception ex)
            {
               // Response.Redirect("Error.aspx");
            }
            finally
            {
               
            }
        }

        protected void btndel_Click(object sender, System.EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            string del = gvr.Cells[1].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_TimeTable set dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ), bisDeleted='True' where nt_id='" + del + "'";
            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvtime.ActiveViewIndex = 0;
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

        protected void btnedit_Click(object sender, System.EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["tid"] = gvr.Cells[1].Text;
            txtst.Text = gvr.Cells[5].Text;
            txtet.Text = gvr.Cells[6].Text;
            //txtet.Text = gvr.Cells[6].Text;
            mvtime.ActiveViewIndex = 2;
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

        protected void btnAdd_Click(object sender, System.EventArgs e)
        {
            mvtime.ActiveViewIndex = 1;
        }

        protected void btnupdate_Click(object sender, System.EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_TimeTable set nc_id=@cid,nsbj_id=@sid,strStartTime=@stime,strEndTime=@etime,strShift=@shft,strStartDate=@dt,dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nt_id='" + Session["tid"] + "'";
            cmd.Parameters.AddWithValue("@cid", ddcl1.SelectedValue);
            cmd.Parameters.AddWithValue("@sid", ddsb.SelectedValue);
            cmd.Parameters.AddWithValue("@stime", txtst.Text);
            cmd.Parameters.AddWithValue("@etime", txtet.Text);
            cmd.Parameters.AddWithValue("@shft", ddsh.Text);
            cmd.Parameters.AddWithValue("@dt", txt2dt.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvtime.ActiveViewIndex = 0;
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