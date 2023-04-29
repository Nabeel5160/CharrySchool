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
    public partial class ParentDashBoard : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                getAttendance();
               // getFee();
                if (!IsPostBack)
                {
                    BindRepeaterData();
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=ParentDashBoard.aspx");

            }
        }
        
        protected void btnsend_Click(object sender, EventArgs e)
        {
            try{

            con1.Open();
            cmd.Connection = con1;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tbl_Conversation (nu_id,strMessage,dtAddDate,bisDeleted) values('" + Session["uid"] + "',@msg,@postedDate,'False')";
            cmd.Parameters.AddWithValue("@msg", txtmsg.Text);
            cmd.Parameters.AddWithValue("@postedDate", DateTime.Now);
            cmd.ExecuteNonQuery();
            con1.Close();
            txtmsg.Text = "";
            BindRepeaterData();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=" + ex.ToString());

            }
        }
        protected void BindRepeaterData()
        {
            try
            {
            con1.Open();
            SqlCommand cmd1 = new SqlCommand("select u.strImage,u.strfname,c.strMessage,c.dtAddDate from tbl_Conversation c inner join tbl_Users u on c.nu_id=u.nu_id Order By c.dtAddDate DESC ", con1);
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(cmd1);
            da.Fill(ds);
            RepDetails.DataSource = ds;
            RepDetails.DataBind();
            con1.Close();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=" + ex.ToString());

            }
        }
        public void getAttendance()
        {
            try
            {
            string query = "select e.strStudentNum,e.strFname,e.strMname, a.strStatus,a.dtAddDate, c.strClass from tbl_Attendance a inner join tbl_Enrollment e on a.ne_id=e.ne_id inner join tbl_Class c on e.nc_id=c.nc_id where e.nu_id=(select nu_id from tbl_Users where strEmail='" + Session["userval"] + "') and a.dtAddDate=convert(date,SYSDATETIME())";
            cmd.Connection = con;
            con.Open();
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.CommandText = query;
            List<enrollment> tempList = null;
            
            using (con)
            {
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    tempList = new List<enrollment>();
                    while (dr.Read())
                    {
                        enrollment c = new enrollment();
                        c.stnum = dr["strStudentNum"].ToString();
                        c.efname = dr["strFname"].ToString();
                        c.emname = dr["strMname"].ToString();
                        c.status = dr["strStatus"].ToString();
                        c.date = dr["dtAddDate"].ToString();
                        c.classnm = dr["strClass"].ToString();
                        tempList.Add(c);
                    }
                    tempList.TrimExcess();
                    con.Close();
                    foreach (var c in tempList)
                    {
                        lblstnum.Text = c.stnum;
                        lblfnm.Text = c.efname;
                        lblmnm.Text = c.emname;
                        lblst.Text = c.status;
                        lbldt.Text = c.date;
                        lblcl.Text = c.classnm;
                    }
                }
            }
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=" + ex.ToString());

            }
        }
        public void getFee()
        {
            try
            {
                SqlConnection con2 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
                string query = "SELECT tbl_RecieveFee.strFeeAmount, tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS fullname, tbl_Enrollment.strStudentNum, tbl_RecieveFee.strFeeAmountReceived, tbl_RecieveFee.strFeeAmountRemaining, tbl_RecieveFee.dtAddDate, tbl_Enrollment.nu_id FROM tbl_RecieveFee INNER JOIN tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Users ON tbl_Enrollment.nu_id = tbl_Users.nu_id WHERE (tbl_RecieveFee.nsch_id = @nschid) AND (tbl_Enrollment.nu_id = @nuid) and  tbl_RecieveFee.bisPaid = 'True'";
                cmd.Connection = con2;
                con2.Open();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = query;
                cmd.Parameters.AddWithValue("@nschid", Session["nschoolid"]);
                cmd.Parameters.AddWithValue("@nuid", Session["uid"]);
                List<enrollment> tempList = null;

                using (con2)
                {
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                       tempList = new List<enrollment>();
                        while (dr.Read())
                        {
                            enrollment c = new enrollment();
                           c.stnum = dr["strStudentNum"].ToString();
                            c.vnum = dr["fullname"].ToString();
                            c.fee = dr["strFeeAmount"].ToString();
                            c.amount = dr["strFeeAmountReceived"].ToString();
                            
                            c.efee = dr["strFeeAmountRemaining"].ToString();
                            c.date = dr["dtAddDate"].ToString();
                            tempList.Add(c);
                        }
                        tempList.TrimExcess();
                        con2.Close();
                        foreach (var c in tempList)
                        {
                            lblstnum1.Text=c.stnum;
                            lblnm.Text=c.vnum; 
                            lblfee.Text =c.fee;
                            lblRcvFee.Text =c.amount;

                            lblRemnFee.Text=c.efee;
                            lbldate.Text = c.date;
                            
                        
                        }

                        //lblstnum1.Text = dr["strStudentNum"].ToString();
                        //lblnm.Text = dr["fullname"].ToString();
                        //lblfee.Text = dr["strFeeAmount"].ToString();
                        //lblRcvFee.Text = dr["strFeeAmountReceived"].ToString();

                        //lblRemnFee.Text = dr["strFeeAmountRemaining"].ToString();
                        //lbldate.Text = dr["dtAddDate"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=" + ex.ToString());

            }
        }

        protected void gridViewMaster_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try{
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string cname = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "strClass"));
                GridView gridViewNested = (GridView)e.Row.FindControl("nestedGridView");
                SqlDataSource sqlDataSourceNestedGrid = new SqlDataSource();
                sqlDataSourceNestedGrid.ConnectionString = ConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString;
                sqlDataSourceNestedGrid.SelectCommand = "SELECT ss.strSubject, n.strTime,n.dtDate,n.strDesc FROM tbl_Notification n inner join tbl_Subject ss on n.nsbj_id=ss.nsbj_id WHERE n.nc_id = (select nc_id from tbl_Class where strClass='" + cname + "' and bisDeleted=0 and nsch_id='"+Session["nschoolid"]+"') and n.dtAddDate='"+DATE_FORMAT.format()+"'";
                gridViewNested.DataSource = sqlDataSourceNestedGrid;
                gridViewNested.DataBind();
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("Error.aspx");

        }
        }

        protected void sqldd_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void btnViewHistory_Click(object sender, EventArgs e)
        {

        }
    }
}