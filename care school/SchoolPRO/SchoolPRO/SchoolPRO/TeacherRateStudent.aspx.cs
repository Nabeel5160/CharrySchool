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
    public partial class TeacherRateStudent : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            //SAltotal();
        }
        //private void SAltotal()
        //{
        //    try
        //    {
        //        DataTable dt = new DataTable();
        //        DataRow datarow = null;
        //        int sz = 0;
        //        List<string> sizes = new List<string>();
        //        dt.Columns.Add(new DataColumn("Rating Element", typeof(string)));
        //        dt.Columns.Add(new DataColumn("Check", typeof(string)));
        //        List<string> lis1 = new List<string>();

        //        for (int k = 1; k < 5; k++)
        //        {
        //            if (k == 1)
        //            {
        //                lis1.Add("Readin Skill Improved..... ?");
        //            }
        //            else if (k == 2)
        //            {
        //                lis1.Add("Writing Skill Improved..... ?");
        //            }
        //            else if (k == 3)
        //            {
        //                lis1.Add("Particapate in Class..... ?");
        //            }
        //            else
        //            {
        //                lis1.Add("Submit the assignment at time..... ?");
        //            }
        //        }

        //        foreach (string aaa in lis1)
        //        {
        //            datarow = dt.NewRow();
        //            datarow["Rating Element"] = aaa;
        //            datarow["Check"] = string.Empty;
        //            dt.Rows.Add(datarow);
        //        }
        //        ViewState["CurrentTable"] = dt;
        //        ratgrid.DataSource = dt;
        //        ratgrid.DataBind();
        //    }
        //    catch (Exception ex)
        //    {
        //        Response.Redirect("Error.aspx");
        //    }
        //    finally
        //    {
        //        if (con.State == ConnectionState.Open)
        //        {
        //            con.Close();
        //        }
        //    }
        //}

        protected void btnADDForm_Click(object sender, EventArgs e)
        {

            if (RadioButtonList1.SelectedIndex == 0)
            {
                string a = RadioButtonList1.SelectedItem.Text;
            }
            //try
            //{
            //    foreach (GridViewRow item in ratgrid.Rows)
            //    {
            //        string a=item.Cells[0].Text;
            //            //var rdbList = item.FindControl("BTNRAD") as RadioButtonList;
            //        RadioButtonList rbl_responses = (RadioButtonList)item.Cells[2].FindControl("BTNRAD");
            //        if (rbl_responses.SelectedValue != null)
            //            {
            //                if (rbl_responses.SelectedValue == "Satisfactory")
            //                {
            //                }
            //                else if (rbl_responses.SelectedValue == "UnSatisfactory")
            //                {
            //                }
            //            }
            //    }
            //}
            //catch (Exception ex)
            //{
            //    Response.Redirect("Error.aspx");
            //}
            //finally
            //{
            //    if (con.State == ConnectionState.Open)
            //    {
            //        con.Close();
            //    }
            //}
        }
    }
}