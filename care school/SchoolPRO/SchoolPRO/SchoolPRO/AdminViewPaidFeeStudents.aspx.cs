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
    public partial class AdminViewPaidFeeStudents : System.Web.UI.Page
    {
        int total = 0;
        Label lbltotal;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnvful_Click(object sender, EventArgs e)
        {

            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["cid"] = gvr.Cells[1].Text;
            Session["secs"] = gvr.Cells[3].Text;
            Session["__scid"] = gvr.Cells[5].Text;

            lblclnsec.Text = "Class: " + gvr.Cells[2].Text + " & Section: " + gvr.Cells[3].Text;
            if (txtto.Text == "")
            {
                lbldt.Text = "Date: " + DateTime.Now.ToString("dd-MM-yyyy");
            }
            else
            {
                lbldt.Text = "From Date: " + txtfrm.Text + " & To Date:" + txtto.Text;
            }

            bindData();
            mvatnd.ActiveViewIndex = 1;

        }
        private void bindData()
        {
            string query = "";
            DataSet ds = new DataSet();
            int nschid = Convert.ToInt32(Session["nschoolid"]);
            int nc_id = Convert.ToInt32(Session["cid"]);
            int nsc_id = Convert.ToInt32(Session["__scid"]);
            if (txtto.Text == "")
            {
                query = "select e.strFname+' '+e.strLname as name, e.bRegisteredNum,f.nFine,f.strTutionFee,rf.strFeeAmount,rf.strFeeAmountReceived,rf.strFeeConcession from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Fee f on e.nc_id=f.nc_id where rf.bisPaid='True' and rf.nc_id='" + nc_id + "'  and rf.nsc_id='" + nsc_id + "' And (SUBSTRING(rf.dtAddDate,4,2) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2)) AND (SUBSTRING(rf.dtAddDate,7,10) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10))  and rf.nsch_id=" + nschid + "";
            }
            else
            {
                //query = "select e.strFname+' '+e.strLname as name, e.bRegisteredNum,f.nFine,f.strTutionFee,rf.strFeeAmount,rf.strFeeAmountReceived,rf.strFeeConcession from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Fee f on e.nc_id=f.nc_id where rf.bisPaid='True' and rf.nc_id='1'  and rf.nsc_id='1' And (SUBSTRING(rf.dtAddDate,4,2) = SUBSTRING(CONVERT(VARCHAR(10), '"+txtadmsndate.Text+"', 105 ) ,4,2)) AND (SUBSTRING(rf.dtAddDate,7,10) = SUBSTRING(CONVERT(VARCHAR(10), '"+txtadmsndate.Text+"', 105 ) ,7,10))  and rf.nsch_id=" + nschid + ";";
                query = "select e.strFname+' '+e.strLname as name, e.bRegisteredNum,f.nFine,f.strTutionFee,rf.strFeeAmount,rf.strFeeAmountReceived,rf.strFeeConcession from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Fee f on e.nc_id=f.nc_id where rf.bisPaid='True' and rf.nc_id='" + nc_id + "'  and rf.nsc_id='" + nsc_id + "' And rf.dtAddDate>='" + txtfrm.Text + "' and rf.dtAddDate<='" + txtto.Text + "'  and rf.nsch_id=" + nschid + "";
            }


            string cs = WebConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                con.Open();
                da.Fill(ds, "student");
                gvsearchclass.DataSource = ds.Tables["student"];
                gvsearchclass.DataBind();
                con.Close();

            }
        }

        protected void btngobck_Click(object sender, EventArgs e)
        {
            mvatnd.ActiveViewIndex = 0;
        }

        protected void txtadmsndate_TextChanged(object sender, EventArgs e)
        {
            bindData();
            if (txtto.Text == "")
            {
                lbldt.Text = "Date: " + DateTime.Now.ToString("dd-MM-yyyy");
            }
            else
            {
                lbldt.Text = "From Date: " + txtfrm.Text + " & To Date:" + txtto.Text;
            }
        }
        int paddt = 0, fine = 0, feeissue = 0;
        int totalpayableafter = 0;
        int totalamountrcvd = 0;
        int arears_diff = 0;
        protected void gvsearchclass_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblamntrcvd = (Label)e.Row.FindControl("lblamntrcvd");
                totalamountrcvd = totalamountrcvd + Convert.ToInt32(lblamntrcvd.Text);

                Label lblarears = (Label)e.Row.FindControl("lblarears");
                if (Convert.ToInt32(lblamntrcvd.Text) > Convert.ToInt32(e.Row.Cells[6].Text))
                {
                    arears_diff = Convert.ToInt32(lblamntrcvd.Text) - Convert.ToInt32(e.Row.Cells[6].Text);
                }
                lblarears.Text = arears_diff.ToString();
                fine = Convert.ToInt32(e.Row.Cells[4].Text);
                feeissue = Convert.ToInt32(e.Row.Cells[7].Text);
                Label lblpafter = (Label)e.Row.FindControl("lblpaddt");
                totalpayableafter = fine + feeissue;
                lblpafter.Text = totalpayableafter.ToString();

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lbltrcvd = (Label)e.Row.FindControl("lbltrcvd");
                lbltrcvd.Text = "Total Received: " + totalamountrcvd.ToString();
            }
        }
    }
}