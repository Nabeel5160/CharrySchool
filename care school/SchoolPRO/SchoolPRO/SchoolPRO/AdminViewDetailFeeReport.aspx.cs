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
    public partial class AdminViewDetailFeeReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btnvful_Click(object sender, EventArgs e)
        {

            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["cid"] = gvr.Cells[1].Text;
            Session["secs"] = gvr.Cells[3].Text;
            Session["__scid"] = gvr.Cells[5].Text;

            lblclnsec.Text = "Class: " + gvr.Cells[2].Text + " & Section: " + gvr.Cells[3].Text;
            
            bindData();
            mvatnd.ActiveViewIndex = 1;

        }
        
        private DataTable GetRecords()
        {
            int nschid = Convert.ToInt32(Session["nschoolid"]);
            int nc_id = Convert.ToInt32(Session["cid"]);
            int nsc_id = Convert.ToInt32(Session["__scid"]);
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            
                //query = "select e.strFname+' '+e.strLname as name, e.bRegisteredNum,f.nFine,f.strTutionFee,rf.strFeeAmount,rf.strFeeAmountReceived,rf.strFeeConcession from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Fee f on e.nc_id=f.nc_id where rf.bisPaid='True' and rf.nc_id='1'  and rf.nsc_id='1' And (SUBSTRING(rf.dtAddDate,4,2) = SUBSTRING(CONVERT(VARCHAR(10), '"+txtadmsndate.Text+"', 105 ) ,4,2)) AND (SUBSTRING(rf.dtAddDate,7,10) = SUBSTRING(CONVERT(VARCHAR(10), '"+txtadmsndate.Text+"', 105 ) ,7,10))  and rf.nsch_id=" + nschid + ";";
            cmd.CommandText = "SELECT strClass,strSection, name,[01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12] FROM (select SUBSTRING(rf.strFeeMonth,4,2) as months,e.strFname+' '+e.strLname as name,rf.strFeeAmountReceived,c.strClass,s.strSection from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Section s on e.nsc_id=s.nsc_id where rf.strRecieveType='Class' and rf.nsch_id=" + nschid + " and rf.nc_id=" + nc_id + " and rf.nsc_id=" + nsc_id + ") p PIVOT(max(strFeeAmountReceived) FOR months IN ([01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12])) AS PVT order by PVT.strClass";
            
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            return objDs.Tables[0];

        }
        private void bindData()
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
        protected void btngobck_Click(object sender, EventArgs e)
        {
            mvatnd.ActiveViewIndex = 0;
        }

        //protected void txtadmsndate_TextChanged(object sender, EventArgs e)
        //{
        //    bindData();
        //    if (txtto.Text == "")
        //    {
        //        lbldt.Text = "Date: " + DateTime.Now.ToString("dd-MM-yyyy");
        //    }
        //    else
        //    {
        //        lbldt.Text = "From Date: " + txtfrm.Text + " & To Date:" + txtto.Text;
        //    }
        //}
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