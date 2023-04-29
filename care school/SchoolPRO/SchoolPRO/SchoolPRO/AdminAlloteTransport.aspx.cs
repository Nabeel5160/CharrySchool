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
    public partial class AdminAlloteTransport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                BindGrid();

            }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void gvsearchclass_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
            System.Threading.Thread.Sleep(2000);
            if (e.CommandName == "Search")
            {
                TextBox txtGrid = (TextBox)gvsearchclass.HeaderRow.FindControl("txtcc");
                SearchText(txtGrid.Text);
            }
            }
            catch (Exception ex)
            {
               // Response.Redirect("Error.aspx");
            }
          
        }
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select a.nalt_id, e.strStudentNum,v.strBusNumber,r.strRouteName,r.strAmount,v.strCapacity from tbl_Allotment a inner join tbl_Enrollment e on a.ne_id=e.ne_id inner join tbl_Vehicle v on a.nvh_id=v.nvh_id inner join tbl_Route r on a.nrt_id=r.nrt_id where a.bisDeleted='False' and a.nsch_id='"+Session["nschoolid"]+"'";
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

        private void SearchText(string strSearchText)
        {try
        {
            DataTable dt = GetRecords();
            DataView dv = new DataView(dt);
            string SearchExpression = null;
            if (!String.IsNullOrEmpty(strSearchText))
            {
                SearchExpression =
                string.Format("{0} '%{1}%'", gvsearchclass.SortExpression, strSearchText);

            }
            else
                Response.Redirect("AdminAlloteTransport.aspx");

            dv.RowFilter = "strRouteName like" + SearchExpression;
            gvsearchclass.DataSource = dv;
            gvsearchclass.DataBind();
        }
        catch (Exception ex)
        {
           // Response.Redirect("Error.aspx");
        }
        
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

        protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            gvsearchclass.DataBind();
        }

        protected void gvsearchclass_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string s = "hello";
                Response.Write(s);

            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                
            }
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["vid"] = gvr.Cells[1].Text;
                txtestnm.Text = gvr.Cells[3].Text;

                txtebn.Text = gvr.Cells[5].Text;
                txtecap.Text = gvr.Cells[6].Text;
                txtepr.Text = gvr.Cells[7].Text;

                MultiView1.ActiveViewIndex = 1;
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
            string date = DATE_FORMAT.format();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Allotment set ne_id=(select ne_id from tbl_Enrollment where strStudentNum='" + txtestnm.Text + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'), nrt_id='" + ddert.Text + "', nvh_id=(select nvh_id from tbl_Vehicle where strBusNumber='" + txtebn.Text + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),dtUpDate=@date,nUpDatedBy=@uid where nalt_id='" + Session["vid"] + "'";
            cmd.Parameters.AddWithValue("@date", date);
            cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            MultiView1.ActiveViewIndex = 0;
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
            MultiView1.ActiveViewIndex = 2;
        }

        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try{

                string date = DATE_FORMAT.format();
                string bit = "False";
            string transport = "Transport";
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tbl_Allotment(ne_id,nsch_id,nu_id,nrt_id,nvh_id,strType,dtAddDate,bisDeleted) values((select ne_id from tbl_Enrollment where strStudentNum=@stnum and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "' ),'" + Session["nschoolid"] + "','" + Session["uid"] + "','" + ddrt.Text + "',(select nvh_id from tbl_Vehicle where strBusNumber='" + txtbn.Text + "'and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'),@type,@date,@bit)";
            cmd.Parameters.AddWithValue("@stnum", txtstnum.Text);
            cmd.Parameters.AddWithValue("@type", transport);
            cmd.Parameters.AddWithValue("@bit", bit);
            cmd.Parameters.AddWithValue("@date", date);
            cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
            cmd.ExecuteNonQuery();
            con.Close();
            ///// capacity decrement ..
            int capacity = 0, total = 0 ;
            //con.Open();
            //cmd.Connection = con;
            //cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "select strCapacity from tbl_Vehicle where strBusNumber='" + txtbn.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
            //dr = cmd.ExecuteReader();
            //if (dr.Read())
            //{
            //    capacity = Convert.ToInt32(dr["strCapacity"].ToString());
            //}
            //total = capacity - 1;
            //con.Close();
            total = Convert.ToInt32(txtcap.Text) - 1;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Vehicle set strCapacity='" + total + "', dtUpDate=@date2,nUpDatedBy=@uid2 where strBusNumber='" + txtbn.Text + "' and nsch_id=@schid2  and bisDeleted='False'";
            cmd.Parameters.AddWithValue("@date2", date);
            cmd.Parameters.AddWithValue("@uid2", Session["uid"].ToString());
            cmd.Parameters.AddWithValue("@schid2", Session["nschoolid"].ToString());
                cmd.ExecuteNonQuery();
            con.Close();
            ////// bank amount updated
            int amount = 0, total_amount = 0;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select strAmount from tbl_Bank where strAccNum='" + ddacnum.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                amount = Convert.ToInt32(dr["strAmount"].ToString());
            }
            total_amount = amount + Convert.ToInt32(txtpr.Text);
            con.Close();
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Bank set strAmount='" + total_amount + "',dtUpDate=@date3,nUpDatedBy=@uid3 where strAccNum='" + ddacnum.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
            cmd.Parameters.AddWithValue("@date3", date);
            cmd.Parameters.AddWithValue("@uid3", Session["uid"].ToString());
                cmd.ExecuteNonQuery();
            con.Close();
            ////// recieve fee table inserting with type transport fee
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tbl_RecieveFee(ne_id,nsch_id,nu_id,strFeeAmount,strRecieveType,dtAddDate,bisDeleted) values((select ne_id from tbl_Enrollment where strStudentNum=@stnum and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'),'" + Session["nschoolid"] + "','" + Session["uid"] + "',@amnt1,@typ1,@date4,@bit4)";
            cmd.Parameters.AddWithValue("@amnt1", txtpr.Text);
            cmd.Parameters.AddWithValue("@typ1", transport);
            cmd.Parameters.AddWithValue("@bit4", bit);
            cmd.Parameters.AddWithValue("@date4", date);
            cmd.ExecuteNonQuery();
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
            

            txtbn.Text = "";
            txtrt.Text = "";
            txtcap.Text = "";
            txtpr.Text = "";
            PopulateData();
            MultiView1.ActiveViewIndex = 0;
        }

        protected void PopulateData()
        {
            try
            {

            DataTable table = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {

                string sql = "select a.nalt_id, e.strStudentNum,v.strBusNumber,r.strRouteName,r.strAmount,v.strCapacity from tbl_Allotment a inner join tbl_Enrollment e on a.ne_id=e.ne_id inner join tbl_Vehicle v on a.nvh_id=v.nvh_id inner join tbl_Route r on a.nrt_id=r.nrt_id where a.bisDeleted='False' and a.nsch_id='" + Session["nschoolid"] + "'";

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
           

        }

        protected void btndel_Click(object sender, EventArgs e)
        {
            string date = DATE_FORMAT.format();
            try
            {

                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string del = gvr.Cells[1].Text;
              
                string bit = "True";
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_Allotment set bisDeleted=@bit,dtDeleteDate=@date where nalt_id='" + del + "'";
                cmd.Parameters.AddWithValue("@bit", bit);
                cmd.Parameters.AddWithValue("@date", date);
                cmd.ExecuteNonQuery();
                con.Close();
                PopulateData();
                MultiView1.ActiveViewIndex = 0;
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

        protected void btngoback_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void txtstnum_TextChanged(object sender, EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select strFname,strLname from tbl_Enrollment where strStudentNum='" + txtstnum.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                txtfn.Text = dr["strFname"].ToString();
                txtln.Text = dr["strLname"].ToString();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Student Number does not exist.');", true);
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

        protected void txtestnm_TextChanged(object sender, EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select strFname,strLname from tbl_Enrollment where strStudentNum='" + txtestnm.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted='False'";
            dr = cmd.ExecuteReader();
                
            if (dr.Read())
            {
                txtefn.Text = dr["strFname"].ToString();
                txteln.Text = dr["strLname"].ToString();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Student Number does not exist.');", true);
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

        protected void ddrt_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select  v.strCapacity,v.strBusNumber,v.strRegNumber,r.strAmount,r.strRouteNumber from tbl_Vehicle v inner join tbl_Route r on v.nrt_id=r.nrt_id where r.nrt_id='" + ddrt.Text + "' and v.nsch_id='" + Session["nschoolid"] + "' and v.bisDeleted='False' and r.bisDeleted='False'";
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtbn.Text = dr["strBusNumber"].ToString();
                    txtrt.Text = dr["strRegNumber"].ToString();
                    txtpr.Text = dr["strAmount"].ToString();
                    txtcap.Text = dr["strCapacity"].ToString();
                    txtcap.ReadOnly = true;
                    txtrt.ReadOnly = true;
                    txtbn.ReadOnly = true;
                    txtpr.ReadOnly = true;
                }
                else
                {
                    txtbn.Text = "";
                    txtrt.Text = "";
                    txtpr.Text = "";
                    txtcap.Text = "";
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Route info is not available.');", true);
                }
               // con.Close();
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