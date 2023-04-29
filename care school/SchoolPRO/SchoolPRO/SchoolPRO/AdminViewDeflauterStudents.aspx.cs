using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminViewDeflauterStudents : System.Web.UI.Page
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
        protected void btngobck_Click(object sender, EventArgs e)
        {
            mvatnd.ActiveViewIndex = 0;
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
                query = "select e.strFname+' '+e.strLname as name, e.bRegisteredNum,f.nFine,f.strTutionFee,rf.strFeeAmount,rf.strFeeAmountReceived,rf.strFeeConcession,rf.strMonths,rf.strFeeMonth,rf.dtAddDate from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Fee f on e.nc_id=f.nc_id where rf.bisPaid='False' and rf.nc_id='" + nc_id + "'  and rf.nsc_id='" + nsc_id + "' And (SUBSTRING(rf.dtAddDate,4,2) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2)) AND (SUBSTRING(rf.dtAddDate,7,10) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10))  and rf.nsch_id=" + nschid + " group by e.strFname,e.strLname,e.bRegisteredNum,f.nFine,f.strTutionFee,rf.strFeeAmount,rf.strFeeAmountReceived,rf.strFeeMonth,rf.strFeeConcession,rf.dtAddDate,rf.strMonths";
            }
            else
            {
                //query = "select e.strFname+' '+e.strLname as name, e.bRegisteredNum,f.nFine,f.strTutionFee,rf.strFeeAmount,rf.strFeeAmountReceived,rf.strFeeConcession from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Fee f on e.nc_id=f.nc_id where rf.bisPaid='False' and rf.nc_id='1'  and rf.nsc_id='1' And (SUBSTRING(rf.dtAddDate,4,2) = SUBSTRING(CONVERT(VARCHAR(10), '" + txtadmsndate.Text + "', 105 ) ,4,2)) AND (SUBSTRING(rf.dtAddDate,7,10) = SUBSTRING(CONVERT(VARCHAR(10), '" + txtadmsndate.Text + "', 105 ) ,7,10))  and rf.nsch_id=" + nschid + ";";
                query = "select e.strFname+' '+e.strLname as name, e.bRegisteredNum,f.nFine,f.strTutionFee,rf.strFeeAmount,rf.strFeeAmountReceived,rf.strFeeConcession,rf.strMonths,rf.strFeeMonth,rf.dtAddDate from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Fee f on e.nc_id=f.nc_id where rf.bisPaid='False' and rf.nc_id='" + nc_id + "'  and rf.nsc_id='" + nsc_id + "' And rf.dtAddDate>='" + txtfrm.Text + "' and rf.dtAddDate<='" + txtto.Text + "'  and rf.nsch_id=" + nschid + " group by e.strFname,e.strLname,e.bRegisteredNum,f.nFine,f.strTutionFee,rf.strFeeAmount,rf.strFeeAmountReceived,rf.strFeeMonth,rf.strFeeConcession,rf.dtAddDate,rf.strMonths";
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
        private DataTable BindGridView()
        {
            string query = "";
            int nschid = Convert.ToInt32(Session["nschoolid"]);
            int nc_id = Convert.ToInt32(Session["cid"]);
            int nsc_id = Convert.ToInt32(Session["__scid"]);
            DataTable dtGrid = new DataTable();
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString);
            if (txtto.Text == "")
            {
                query = "select e.strFname+' '+e.strLname as name, e.bRegisteredNum,f.nFine,f.strTutionFee,rf.strFeeAmount,rf.strFeeAmountReceived,rf.strFeeConcession,rf.strMonths,rf.strFeeMonth,rf.dtAddDate from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Fee f on e.nc_id=f.nc_id where rf.bisPaid='False' and rf.nc_id='" + nc_id + "'  and rf.nsc_id='" + nsc_id + "' And (SUBSTRING(rf.dtAddDate,4,2) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2)) AND (SUBSTRING(rf.dtAddDate,7,10) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10))  and rf.nsch_id=" + nschid + " group by e.strFname,e.strLname,e.bRegisteredNum,f.nFine,f.strTutionFee,rf.strFeeAmount,rf.strFeeAmountReceived,rf.strFeeMonth,rf.strFeeConcession,rf.dtAddDate,rf.strMonths";
            }
            else
            {
                //query = "select e.strFname+' '+e.strLname as name, e.bRegisteredNum,f.nFine,f.strTutionFee,rf.strFeeAmount,rf.strFeeAmountReceived,rf.strFeeConcession from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Fee f on e.nc_id=f.nc_id where rf.bisPaid='False' and rf.nc_id='1'  and rf.nsc_id='1' And (SUBSTRING(rf.dtAddDate,4,2) = SUBSTRING(CONVERT(VARCHAR(10), '" + txtadmsndate.Text + "', 105 ) ,4,2)) AND (SUBSTRING(rf.dtAddDate,7,10) = SUBSTRING(CONVERT(VARCHAR(10), '" + txtadmsndate.Text + "', 105 ) ,7,10))  and rf.nsch_id=" + nschid + ";";
                query = "select e.strFname+' '+e.strLname as name, e.bRegisteredNum,f.nFine,f.strTutionFee,rf.strFeeAmount,rf.strFeeAmountReceived,rf.strFeeConcession,rf.strMonths,rf.strFeeMonth,rf.dtAddDate from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Fee f on e.nc_id=f.nc_id where rf.bisPaid='False' and rf.nc_id='" + nc_id + "'  and rf.nsc_id='" + nsc_id + "' And rf.dtAddDate>='" + txtfrm.Text + "' and rf.dtAddDate<='" + txtto.Text + "'  and rf.nsch_id=" + nschid + " group by e.strFname,e.strLname,e.bRegisteredNum,f.nFine,f.strTutionFee,rf.strFeeAmount,rf.strFeeAmountReceived,rf.strFeeMonth,rf.strFeeConcession,rf.dtAddDate,rf.strMonths";
            }
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
            dAdapter.Fill(dtGrid);
            return dtGrid;
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
        int totalpending = 0;
        int totalamountrcvd = 0;
        int arears_diff = 0;
        protected void gvsearchclass_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblpending = (Label)e.Row.FindControl("lblpbddt");
                totalpending = totalpending + Convert.ToInt32(lblpending.Text);

                Label lblamntrcvd = (Label)e.Row.FindControl("lblamntrcvd");
                totalamountrcvd = totalamountrcvd + Convert.ToInt32(lblamntrcvd.Text);

                Label lblarears = (Label)e.Row.FindControl("lblarears");
                if (Convert.ToInt32(lblpending.Text) > Convert.ToInt32(e.Row.Cells[4].Text))
                {
                    arears_diff = Convert.ToInt32(lblpending.Text) - Convert.ToInt32(e.Row.Cells[4].Text);
                }
                lblarears.Text = arears_diff.ToString();
                arears_diff=0;
                fine = Convert.ToInt32(e.Row.Cells[3].Text);

                Label lblpafter = (Label)e.Row.FindControl("lblpaddt");
                totalpayableafter = fine + Convert.ToInt32(lblpending.Text);
                lblpafter.Text = totalpayableafter.ToString();

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lblpendingamnt = (Label)e.Row.FindControl("lbltotalfeepending");
                lblpendingamnt.Text = "Total Pendings: " + totalpending.ToString();

                Label lblrecvd = (Label)e.Row.FindControl("lbltrcvd");
                lblrecvd.Text = "Total Received: " + totalamountrcvd.ToString();
            }
        }

        protected void gvsearchclass_DataBound(object sender, EventArgs e)
        {
            for (int i = gvsearchclass.Rows.Count - 1; i > 0; i--)
            {
                GridViewRow row = gvsearchclass.Rows[i];
                GridViewRow previousRow = gvsearchclass.Rows[i - 1];
                for (int j = 0; j < row.Cells.Count; j++)
                {
                    if (row.Cells[1].Text == previousRow.Cells[1].Text)
                    {
                        if (previousRow.Cells[1].RowSpan == 0)
                        {
                            if (row.Cells[1].RowSpan == 0)
                            {
                                previousRow.Cells[1].RowSpan += 2;
                            }
                            else
                            {
                                previousRow.Cells[1].RowSpan = row.Cells[1].RowSpan + 1;
                            }
                            row.Cells[1].Visible = false;
                        }
                    }
                    if (row.Cells[2].Text == previousRow.Cells[2].Text)
                    {
                        if (previousRow.Cells[2].RowSpan == 0)
                        {
                            if (row.Cells[2].RowSpan == 0)
                            {
                                previousRow.Cells[2].RowSpan += 2;
                            }
                            else
                            {
                                previousRow.Cells[2].RowSpan = row.Cells[2].RowSpan + 1;
                            }
                            row.Cells[2].Visible = false;
                        }
                    }
                    if (row.Cells[4].Text == previousRow.Cells[4].Text)
                    {
                        if (previousRow.Cells[4].RowSpan == 0)
                        {
                            if (row.Cells[4].RowSpan == 0)
                            {
                                previousRow.Cells[4].RowSpan += 2;
                            }
                            else
                            {
                                previousRow.Cells[4].RowSpan = row.Cells[4].RowSpan + 1;
                            }
                            row.Cells[4].Visible = false;
                        }
                    }
                    if (row.Cells[3].Text == previousRow.Cells[3].Text)
                    {
                        if (previousRow.Cells[3].RowSpan == 0)
                        {
                            if (row.Cells[3].RowSpan == 0)
                            {
                                previousRow.Cells[3].RowSpan += 2;
                            }
                            else
                            {
                                previousRow.Cells[3].RowSpan = row.Cells[3].RowSpan + 1;
                            }
                            row.Cells[3].Visible = false;
                        }
                    }
                    
                }
            }
        }

        protected void gvsearchclass_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortingDirection = string.Empty;
            if (dir == SortDirection.Ascending)
            {
                dir = SortDirection.Descending;
                sortingDirection = "Desc";
            }
            else
            {
                dir = SortDirection.Ascending;
                sortingDirection = "Asc";
            }

            DataView sortedView = new DataView(BindGridView());
            sortedView.Sort = e.SortExpression + " " + sortingDirection;
            gvsearchclass.DataSource = sortedView;
            gvsearchclass.DataBind();
        }
        public SortDirection dir
        {
            get
            {
                if (ViewState["dirState"] == null)
                {
                    ViewState["dirState"] = SortDirection.Ascending;
                }
                return (SortDirection)ViewState["dirState"];
            }
            set
            {
                ViewState["dirState"] = value;
            }
        }
    }
}