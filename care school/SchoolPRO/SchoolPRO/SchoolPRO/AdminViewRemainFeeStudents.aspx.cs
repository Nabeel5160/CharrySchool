using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;
namespace SchoolPRO
{
    public partial class AdminViewRemainFeeStudents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
        protected void btnvful_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["cid"] = gvr.Cells[1].Text;
            Session["secs"] = gvr.Cells[3].Text;
            Session["__scid"] = gvr.Cells[5].Text;
            mvatnd.ActiveViewIndex = 1;
            
        }
        void binddata(string date)
        {
            DataSet ds = new DataSet();
            int nschid = Convert.ToInt32(Session["nschoolid"]);
            int nc_id = Convert.ToInt32(Session["cid"]);
            int nsc_id = Convert.ToInt32(Session["__scid"]);
            string cs = WebConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString;
            string query = @"SELECT tbl_RecieveFee.strFeeAmount, tbl_Enrollment.strFname+' '+tbl_Enrollment.strLname as fullname, tbl_Enrollment.strStudentNum, tbl_RecieveFee.strFeeAmountReceived, tbl_RecieveFee.strFeeAmountRemaining, tbl_RecieveFee.dtAddDate FROM tbl_RecieveFee INNER JOIN tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id WHERE tbl_Enrollment.nc_id=" + nc_id + "  and tbl_Enrollment.nsc_id=" + nsc_id + " And (SUBSTRING(tbl_RecieveFee.dtAddDate ,4,2) = SUBSTRING(CONVERT(VARCHAR(10), '" + date + "', 105 ) ,4,2)) AND (tbl_RecieveFee.strFeeAmountRemaining > 0)";
            using(SqlConnection con=new SqlConnection(cs))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                
                da.Fill(ds,"student");
                gvclass.DataSource=ds.Tables["student"];
                gvclass.DataBind();
            }
            query = "select sum(CAST(strFeeAmountRemaining as int)) from tbl_RecieveFee where nc_id=" + nc_id + " and nsc_id=" + nsc_id + " And (SUBSTRING(tbl_RecieveFee.dtAddDate ,4,2) = SUBSTRING(CONVERT(VARCHAR(10), '" + date + "', 105 ) ,4,2)) AND (tbl_RecieveFee.strFeeAmountRemaining > 0)";
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);
                lblremainfee.Text = Convert.ToString(cmd.ExecuteScalar());
            }
            query = "select sum(CAST(strFeeAmountReceived as int)) from tbl_RecieveFee where nc_id=" + nc_id + " and nsc_id=" + nsc_id + " And (SUBSTRING(tbl_RecieveFee.dtAddDate ,4,2) = SUBSTRING(CONVERT(VARCHAR(10), '" + date + "', 105 ) ,4,2)) AND (tbl_RecieveFee.strFeeAmountRemaining > 0)";
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);
                lblrecfee.Text = Convert.ToString(cmd.ExecuteScalar());
            }
            lblTotal.Text = (Convert.ToInt32(lblrecfee.Text) + Convert.ToInt32(lblremainfee.Text)).ToString(); ;
        }
    

        protected void txtadmsndate_TextChanged1(object sender, EventArgs e)
        {
            
            
            string date = txtadmsndate.Text;
            binddata(date);
            
        }

        protected void btngobck_Click(object sender, EventArgs e)
        {
            mvatnd.ActiveViewIndex = 0;
            txtadmsndate.Text = "";
            lblTotal.Text = "";
            lblrecfee.Text = "";
            lblremainfee.Text = "";
        }


    }
}