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

namespace SchoolPRO
{
    public partial class StudentRateTeacher : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            SAltotal();
        }
        private void SAltotal()
        {
            try
            {
                DataTable dt = new DataTable();
                DataRow datarow = null;
                int sz = 0;
                List<string> sizes = new List<string>();
                dt.Columns.Add(new DataColumn("Rating Element", typeof(string)));
                dt.Columns.Add(new DataColumn("Check", typeof(string)));
                List<string> lis1 = new List<string>();

                for (int k = 1; k < 19; k++)
                {
                    if (k == 1)
                    {
                        lis1.Add("Creates a classroom climate that is warm and inviting. Promotes the development of positive self concept for all students. ");
                    }
                    else if (k == 2)
                    {
                        lis1.Add("Involves students at all instructional levels in each lesson and encourages and receives inquiries, ideas and opinions that relate to those lessons from the students. ");
                    }
                    else if (k == 3)
                    {
                        lis1.Add("Presents lessons in such a way as to encourage students to employ higher order critical thinking skills.");
                    }
                    else if (k == 4)
                    {
                        lis1.Add("Demonstrates fairness and consistency in the handling of student discipline.");
                    }
                    else if (k == 5)
                    {
                        lis1.Add("Demonstrates knowledge of subject matter and transmits that knowledge in an interesting manner using a variety of techniques and/or materials to accomplish the objectives of instruction. ");
                    }
                    else if (k == 6)
                    {
                        lis1.Add("Maximizes the use of time for instructional purposes, with all students being involved in meaningful learning activities. ");
                    }
                    else if (k == 7)
                    {
                        lis1.Add("Uses a wide range of assessment information (including but not limited to observa-tions by the teacher, CRT. etc.) to regularly adjust student instruction. ");
                    }
                    else if (k == 8)
                    {
                        lis1.Add("Makes clear the purpose and/or practical importance of the lesson and how the content of the homework assignment relates to that lesson. ");
                    }
                    else if (k == 9)
                    {
                        lis1.Add("Provides prompt and appropriate feedback on work completed by students. ");
                    }
                    else if (k == 10)
                    {
                        lis1.Add("Demonstrates a keen understanding of the needs, concerns, abilities and interest of each student in such a manner that leads to the delivery of needed instructional or other resources. ");
                    }
                    else if (k == 11)
                    {
                        lis1.Add("Performs so that there is observable satisfactory growth in children. ");
                    }
                    else if (k == 12)
                    {
                        lis1.Add("Uses current curricular and instructional practices which relate to effective education. ");
                    }
                    else if (k == 13)
                    {
                        lis1.Add("Actively participates in program improvement activities.");
                    }
                   else if (k == 14)
                    {
                        lis1.Add("Demonstrates accuracy in record keeping and promptness in meeting deadlines. ");
                    }
                    else if (k == 15)
                    {
                        lis1.Add("Demonstrates punctuality at post of duty. ");
                    }
                    else if (k == 16)
                    {
                        lis1.Add("Follows established school policies and procedures. ");
                    }
                    else if (k == 17)
                    {
                        lis1.Add("Demonstrates effective oral and written communication ");
                    }
                   
                    else
                    {
                        lis1.Add("Relates without difficulty to staff members and parents. ");
                    }
                }
                
                foreach (string aaa in lis1)
                {
                    datarow = dt.NewRow();
                    datarow["Rating Element"] = aaa;
                    datarow["Check"] = string.Empty;
                    dt.Rows.Add(datarow);
                }
                ViewState["CurrentTable"] = dt;
                ratgrid.DataSource = dt;
                ratgrid.DataBind();
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