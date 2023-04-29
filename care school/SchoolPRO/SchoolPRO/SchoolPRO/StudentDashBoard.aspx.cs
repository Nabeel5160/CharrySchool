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
    public partial class StudentDashBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getAttendance();
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        public void getAttendance()
        {
            try
            {
            Boolean HASFLAG = false;
            string query = "select e.strStudentNum,e.strFname,e.strMname, a.strStatus,a.dtAddDate, c.strClass from tbl_Attendance a inner join tbl_Enrollment e on a.ne_id=e.ne_id inner join tbl_Class c on e.nc_id=c.nc_id where e.ne_id='" + Session["eid"] + "' and a.dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) and e.nsch_id='" + Session["nschoolid"] + "'";
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
                    HASFLAG = true;
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

        protected void gridViewMaster_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string cname = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "strClass"));
                GridView gridViewNested = (GridView)e.Row.FindControl("nestedGridView");
                SqlDataSource sqlDataSourceNestedGrid = new SqlDataSource();
                sqlDataSourceNestedGrid.ConnectionString = ConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString;
                sqlDataSourceNestedGrid.SelectCommand = "SELECT ss.strSubject, n.strTime,n.dtDate,n.strDesc FROM tbl_Notification n inner join tbl_Subject ss on n.nsbj_id=ss.nsbj_id WHERE n.nc_id = (select nc_id from tbl_Class where strClass='" + cname + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "') and n.dtAddDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) and n.nsch_id='" + Session["nschoolid"] + "'";
                gridViewNested.DataSource = sqlDataSourceNestedGrid;
                gridViewNested.DataBind();
            }
            }
            catch (Exception ex)
            {
                
            }
            finally
            {
               
            }
        }
    }
}