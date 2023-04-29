using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class TeacherRateStudents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try

            {
            if (!IsPostBack)
            {

                BindGrid();
                //con.Close();
                //string neid = "";

                //if (Request.Cookies["eid"] != null)
                //{
                //    neid = Request.Cookies["eid"].Value;
                //}
                //else
                //    neid = Request.QueryString["eid"].ToString();

                txtrnum.Text = Session["nneeiidd"].ToString();

                
                
                txtrnum_TextChanged();
                //mvquiz.ActiveViewIndex = 1;
            }
            if (Session["nneeiidd"] != null)
                mvquiz.ActiveViewIndex = 1;
            //if (Request.Cookies["eid"] != null)
            //    Response.Write(Request.Cookies["eid"].Value);
            //else
            //     Request.QueryString["eid"].ToString();
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
        protected void txtrnum_TextChanged()
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select strFname+' '+strLname as name from tbl_Enrollment where ne_id='" + Session["nneeiidd"] + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                txtstname.Text = dr["name"].ToString();
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

        protected void btnrate_Click(object sender, EventArgs e)
        {
            try
            {
          
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tbl_Rating(nu_id,ne_id,nsbj_id,strRemarks,strPoints,strOutOf,dtAddDate,bisDeleted,nsch_id)values('" + Session["uid"] + "','" + Session["nneeiidd"] + "','" + ddcc.SelectedValue + "',@remarks,@points,@tpoints,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False','" + Session["nschoolid"] + "')";
            cmd.Parameters.AddWithValue("@remarks", txtremarks.Text);
            cmd.Parameters.AddWithValue("@points", txtrate.Text);
            cmd.Parameters.AddWithValue("@tpoints", txtoutof.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            txtremarks.Text = "";
            txtrate.Text = "";
            txtoutof.Text = "";
            PopulateData();

            mvquiz.ActiveViewIndex = 0;
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

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Rating set nsbj_id='"+ddesub.SelectedValue+"',strRemarks=@erem,strPoints=@epnts,strOutOf=@eout,dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nrtng_id='" + Session["neditid"] + "'";
            cmd.Parameters.AddWithValue("@erem", txterem.Text);
            cmd.Parameters.AddWithValue("@epnts",txterate.Text);
            cmd.Parameters.AddWithValue("@eout",txteout.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvquiz.ActiveViewIndex = 0;
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

        protected void gvsearchsub_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
            System.Threading.Thread.Sleep(2000);
            if (e.CommandName == "Search")
            {
                TextBox txtGrid = (TextBox)gvsearchsub.HeaderRow.FindControl("txtcc");
                SearchText(txtGrid.Text);
            }
            }
            catch (Exception ex)
            {
                
            }
            finally
            {
             
            }
        }
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select r.nrtng_id,e.strFname,e.strLname,e.strFname+' '+e.strLname as name,sb.strSubject,r.strPoints,r.strOutOf,r.strRemarks from tbl_Rating r inner join tbl_Enrollment e on r.ne_id=e.ne_id inner join tbl_Subject sb on r.nsbj_id=sb.nsbj_id inner join tbl_Users u on r.nu_id=u.nu_id where r.nu_id='" + Session["uid"] + "' and r.bisDeleted='False' and r.nsch_id='" + Session["nschoolid"] + "'";
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
                gvsearchsub.DataSource = dt;
                gvsearchsub.DataBind();
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
                string.Format("{0} '%{1}%'", gvsearchsub.SortExpression, strSearchText);

            }
            else
                Response.Redirect("TeacherRateStudents.aspx");

           
                dv.RowFilter = "name like" + SearchExpression;
            
           
                gvsearchsub.DataSource = dv;
            gvsearchsub.DataBind();
            }
            catch (Exception ex)
            {
               
            }
            finally
            {
               
            }
        }

        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvsearchsub.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvsearchsub.HeaderRow.FindControl("txtcc");

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

                string sql = "select r.nrtng_id,r.ne_id,e.strFname,e.strLname,e.strFname+' '+e.strLname as name,sb.strSubject,r.strPoints,r.strOutOf,r.strRemarks from tbl_Rating r inner join tbl_Enrollment e on r.ne_id=e.ne_id inner join tbl_Subject sb on r.nsbj_id=sb.nsbj_id inner join tbl_Users u on r.nu_id=u.nu_id where r.nu_id='" + Session["uid"] + "' and r.bisDeleted='False' and r.nsch_id='" + Session["nschoolid"] + "'";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvsearchsub.DataSource = table;

            gvsearchsub.DataBind();
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

        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
                    GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                    Session["neditid"] = gvr.Cells[1].Text;
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select e.strFname,r.nsbj_id,r.strOutOf,r.strRemarks,r.strPoints from tbl_Enrollment e inner join tbl_Rating r on e.ne_id=r.ne_id where r.nrtng_id='" + Session["neditid"] + "' and r.bisDeleted='False' and r.nsch_id='" + Session["nschoolid"] + "'";
                    dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        txtename.Text = dr["strFname"].ToString();
                        ddesub.SelectedValue = dr["nsbj_id"].ToString();
                        txteout.Text = dr["strOutOf"].ToString();
                        txterate.Text = dr["strPoints"].ToString();
                        txterem.Text = dr["strRemarks"].ToString();
                    }
                    con.Close();
                    mvquiz.ActiveViewIndex = 2;
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

        protected void btndel_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            string delid = gvr.Cells[1].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Rating set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nrtng_id='" + delid + "'";
            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvquiz.ActiveViewIndex = 0;
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

        protected void txtenum_TextChanged(object sender, EventArgs e)
        {
            
        }

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
           // mvquiz.ActiveViewIndex = 1;
        }

        protected void RatingControlChanged(object sender, AjaxControlToolkit.RatingEventArgs e)
        {
            //con.Open();
            //SqlCommand cmd = new SqlCommand("insert into tbl_Rating(strPoints) values(@Rating)" , con);
            //cmd.Parameters.AddWithValue("@Rating", RatingControl.CurrentRating);
            //cmd.ExecuteNonQuery();
            //con.Close();

            try
            {
                string remarks = "";
                if (RatingControl.CurrentRating == 1)
                {
                    remarks = "Poor";
                }
                else if (RatingControl.CurrentRating == 2)
                {
                    remarks = "Average";
                }
                else if (RatingControl.CurrentRating == 3)
                {
                    remarks = "Fair";
                }
                else if (RatingControl.CurrentRating == 4)
                {
                    remarks = "Good";
                }
                else if (RatingControl.CurrentRating == 5)
                {
                    remarks = "Excellent";
                }

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into tbl_Rating(nu_id,ne_id,nsbj_id,strPoints,strOutOf,strRemarks,dtAddDate,bisDeleted,nsch_id)values('" + Session["uid"] + "','" + Session["nneeiidd"] + "','" + ddcc.SelectedValue + "',@points,'5',@rm,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False','" + Session["nschoolid"] + "')";

                cmd.Parameters.AddWithValue("@points", RatingControl.CurrentRating);
                cmd.Parameters.AddWithValue("@rm", remarks);
               
                cmd.ExecuteNonQuery();
                con.Close();
           
                PopulateData();

                mvquiz.ActiveViewIndex = 0;
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
            //BindRatingControl();
        }
        protected void BindRatingControl()
        {
            //int total = 0;
            //DataTable dt = new DataTable();
            //con.Open();
            //SqlCommand cmd = new SqlCommand("select strPoints from tbl_Rating" , con);
            //SqlDataAdapter da = new SqlDataAdapter(cmd);
            //da.Fill(dt);
            //if (dt.Rows.Count > 0)
            //{
            //    for (int i=0; i < dt.Rows.Count; i++)
            //    {
            //        total += Convert.ToInt16(dt.Rows[i][0].ToString());
            //    }
            //    int average = total/(dt.Rows.Count);
            //    RatingControl.CurrentRating = average;

            //}
        }

    }
}