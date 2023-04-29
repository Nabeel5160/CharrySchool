using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminBankReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //list();
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        //public void list()
        //{
        //    try
        //    {
        //    string query = "select strBname,strBrname,strBcode,strAccTitle,strAccNum,strAmount from tbl_Bank where bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
        //    cmd.Connection = con;
        //    con.Open();
        //    cmd.CommandType = System.Data.CommandType.Text;
        //    cmd.CommandText = query;
        //    List<enrollment> tempList = null;

        //    using (con)
        //    {
        //        dr = cmd.ExecuteReader();
        //        if (dr.HasRows)
        //        {
        //            tempList = new List<enrollment>();
        //            while (dr.Read())
        //            {
        //                enrollment c = new enrollment();
        //                c.bnkname = dr["strBname"].ToString();
        //                c.brname = dr["strBrname"].ToString();
        //                c.bcode = dr["strBcode"].ToString();
        //                c.acctitle = dr["strAccTitle"].ToString();
        //                c.accnum = dr["strAccNum"].ToString();
        //                c.amount = dr["strAmount"].ToString();
        //                tempList.Add(c);
        //            }
        //            tempList.TrimExcess();
        //            con.Close();
        //            foreach (var c in tempList)
        //            {
        //                lblbn.Text = c.bnkname;
        //                lblbrnm.Text = c.brname;
        //                lblbc.Text = c.bcode;
        //                lblac.Text = c.accnum;
        //                lblat.Text = c.acctitle;
        //                lblamnt.Text = c.amount;
        //            }
        //        }
        //    }
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
    }
}