using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.IO;
using System.Text;
using System.Web.UI.DataVisualization.Charting;
using System.Drawing;

namespace SchoolPRO
{
    public partial class AdminDashBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                if (!IsPostBack)
                {
                    if (Request.QueryString.Count > 0)
                        Session["nschoolid"] = Request.QueryString["utf"].ToString();
                    BindData_Month_chart();
                    strength_student();
                }
            }
            catch (Exception ex) { }
            status();
        }

        private void BindData_Month_chart()
        {
            DateTime now = DateTime.Now;
            string month = now.ToString("MMM");
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString))
            {
                string CmdString = "select count(*) as Unpaid, c.strClass as Class from tbl_RecieveFee rf inner join tbl_Class  c on rf.nc_id=c.nc_id where rf.bisPaid='0' and rf.bisDeleted='0' and substring(strMonths,0,4)='" + month + "' and rf.nsch_id='" + Session["nschoolid"]+ "' group by c.strClass";
                SqlDataAdapter sda = new SqlDataAdapter(CmdString, con);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                DataTable dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    Chart1.DataSource = ds;
                    Chart1.Series["Series1"].XValueMember = "Class";
                    Chart1.Series["Series1"].YValueMembers = "Unpaid";
                    Chart1.DataBind();
                }
                else
                {
                    Chart1.DataSource = null;
                    Chart1.DataBind();
                }
            }
        }
        private void strength_student()
        {   
            DataSet ds = new DataSet();
        
        con.Open();
        string cmdstr = "select count(*) as Male, strGender as Gender from tbl_Enrollment where strgender='Male' and bisDeleted='0' and nsch_id='" + Session["nschoolid"] + "' group by strGender union select count(*) as feMale, strGender as Gender from tbl_Enrollment where strgender='FeMale' and bisDeleted='0' and nsch_id='" + Session["nschoolid"] + "' group by strGender";
        SqlDataAdapter sda = new SqlDataAdapter(cmdstr, con);
       
        sda.Fill(ds);
        DataTable dt = ds.Tables[0];
        string[] XPointMember = new string[dt.Rows.Count];
        int[] YPointMember = new int[dt.Rows.Count];

        for (int count = 0; count < dt.Rows.Count; count++)
        {
            //storing Values for X axis  
            XPointMember[count] = dt.Rows[count]["Gender"].ToString();
            //storing values for Y Axis  
            YPointMember[count] = Convert.ToInt32(dt.Rows[count]["Male"]);

        }
        //binding chart control  
        Chart2.Series[0].Points.DataBindXY(XPointMember, YPointMember);

        //Setting width of line  
        Chart2.Series[0].BorderWidth = 10;
        //setting Chart type   
        Chart2.Series[0].ChartType = SeriesChartType.Pie;


        foreach (Series charts in Chart2.Series)
        {
            foreach (DataPoint point in charts.Points)
            {
                switch (point.AxisLabel)
                {
                    case "Q1": point.Color = Color.RoyalBlue; break;
                    case "Q2": point.Color = Color.SaddleBrown; break;
                    //case "Q3": point.Color = Color.SpringGreen; break;
                }
                point.Label = string.Format("{0:0} - {1}", point.YValues[0], point.AxisLabel);

            }
        }


        //Enabled 3D  
        //  Chart1.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;  
        con.Close();  
        }
        
        
        private string Decrypt(string cipherText)
        {

            string EncryptionKey = "MAKV2SPBNI99212";
            cipherText = cipherText.Replace(" ", "+");
            try
            {
                byte[] cipherBytes = Convert.FromBase64String(cipherText);
                using (Aes encryptor = Aes.Create())
                {
                    Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                        {
                            cs.Write(cipherBytes, 0, cipherBytes.Length);
                            cs.Close();
                        }
                        cipherText = Encoding.Unicode.GetString(ms.ToArray());
                    }
                }
            }
            catch (Exception ex)
            {
                // Response.Redirect("Error.aspx");
            }

            return cipherText;

        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        public void status()
        {
            SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
            try
            {


                //con1.Open();
                //cmd.Connection = con1;
                //cmd.CommandType = CommandType.Text;
                ////cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Present' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                ////-------cmd.CommandText = "SELECT  COUNT(*) AS Expr1 FROM (SELECT ne_id FROM  tbl_Attendance  WHERE (strStatus = 'Present') AND (DATEPART(d, dtAddDate) = DATEPART(d, CONVERT(VARCHAR(10), GETDATE(), 105 ))) AND (DATEPART(m, dtAddDate) = DATEPART(m,CONVERT(VARCHAR(10), GETDATE(), 105 ))) AND (bisDeleted = 'False') AND (nsch_id = '" + Session["nschoolid"] + "') GROUP BY ne_id) AS tbl1";
                //cmd.CommandText = "SELECT  COUNT(*) AS Expr1 FROM (SELECT ne_id FROM  tbl_Attendance  WHERE (strStatus = 'Present') AND ( dtAddDate = CONVERT(VARCHAR(10), GETDATE(), 105 ))  AND (bisDeleted = 'False') AND (nsch_id = '" + Session["nschoolid"] + "') GROUP BY ne_id) AS tbl1";

                //int present = Convert.ToInt32(cmd.ExecuteScalar());
                ////if (present > 0)
                ////{
                //txttotprsnts.Text = present.ToString();
                ////}
                //con1.Close();
                //con1.Open();
                //cmd.Connection = con1;
                //cmd.CommandType = CommandType.Text;
                ////cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Abscent' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                ////cmd.CommandText = "select count(strStatus) from tbl_Attendance where strStatus='Absent' and DATEPART(d,dtAddDate)=DATEPART(d,CONVERT(VARCHAR(10), GETDATE(), 105 )) AND (DATEPART(m, tbl_Attendance.dtAddDate) = DATEPART(m, CONVERT (date, SYSDATETIME()))) and bisDeleted='False'";
                ////-------cmd.CommandText = "SELECT  COUNT(*) AS Expr1 FROM (SELECT ne_id FROM  tbl_Attendance  WHERE (strStatus = 'Absent') AND (DATEPART(d, dtAddDate) = DATEPART(d, CONVERT(VARCHAR(10), GETDATE(), 105 ))) AND (DATEPART(m, dtAddDate) = DATEPART(m,CONVERT(VARCHAR(10), GETDATE(), 105 ))) AND (bisDeleted = 'False') AND (nsch_id = '" + Session["nschoolid"] + "') GROUP BY ne_id) AS tbl1";
                //cmd.CommandText = "SELECT  COUNT(*) AS Expr1 FROM (SELECT ne_id FROM  tbl_Attendance  WHERE (strStatus = 'Absent') AND (dtAddDate =  CONVERT(VARCHAR(10), GETDATE(), 105 ))  AND (bisDeleted = 'False') AND (nsch_id = '" + Session["nschoolid"] + "') GROUP BY ne_id) AS tbl1";

                //int Abscent = Convert.ToInt32(cmd.ExecuteScalar());
                ////if (Abscent > 0)
                ////{
                //txttotabsnt.Text = Abscent.ToString();
                ////}
                //con1.Close();
                //con1.Open();
                //cmd.Connection = con1;
                //cmd.CommandType = CommandType.Text;
                ////cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Half Leave Application' OR strStatus='Full Leave Application' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where nu_id='" + Convert.ToInt32(ddenm.SelectedValue) + "' and strStatus='Half Leave Application' and DATEPART(m,dtAddDate)=DATEPART(m,CONVERT(VARCHAR(10), GETDATE(), 105 )) and bisDeleted='False'";
                //int Leave = Convert.ToInt32(cmd.ExecuteScalar());
                ////if (Leave > 0)
                ////{
                //lblhalflv.Text = Leave.ToString();
                ////}
                //con1.Close();
                //con1.Open();
                //cmd.Connection = con1;
                //cmd.CommandType = CommandType.Text;
                ////cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Half Leave Application' OR strStatus='Full Leave Application' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where nu_id='" + Convert.ToInt32(ddenm.SelectedValue) + "' and strStatus='Full Leave Application' and DATEPART(m,dtAddDate)=DATEPART(m,CONVERT(VARCHAR(10), GETDATE(), 105 )) and bisDeleted='False'";
                //int fulLeave = Convert.ToInt32(cmd.ExecuteScalar());
                ////if (Leave > 0)
                ////{
                //lblfullv.Text = fulLeave.ToString();
                ////}
                //con1.Close();
                //con1.Open();
                //cmd.Connection = con1;
                //cmd.CommandType = CommandType.Text;
                //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Late' and nu_id='" + Convert.ToInt32(ddenm.SelectedValue) + "' and DATEPART(m,dtAddDate)=DATEPART(m,CONVERT(VARCHAR(10), GETDATE(), 105 )) and bisDeleted='False'";
                //int Late = Convert.ToInt32(cmd.ExecuteScalar());
                ////if (Late > 0)
                ////{
                //lbllate.Text = Late.ToString();
                ////}

                //con1.Close();


            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx?msg=Default.aspx");
            }
            finally
            {
                if (con1.State == System.Data.ConnectionState.Open)
                {
                    con1.Close();
                }
            }
        }



        
    }

}
