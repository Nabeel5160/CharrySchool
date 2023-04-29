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
    public partial class AdminClassFeeReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          //  list();
            BindGrid();
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;

        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select f.strLeaveFee,f.nfee_id,f.strTutionFee,f.strAdmsFee,c.strClass,f.strRegFee,f.strFolderFee,f.strGeneratorFee,f.strBookFee,f.strStationaryFee,f.strAnnualExamFee from tbl_Fee f inner join tbl_Class c on f.nc_id=c.nc_id where f.bisDeleted='False' and f.nsch_id= '" + Session["nschoolid"] + "'";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            return objDs.Tables[0];


        }
        private void BindGrid()
        {
            try
            {
                DataTable dt = GetRecords();
                if (dt.Rows.Count > 0)
                {
                    gvfee.DataSource = dt;
                    gvfee.DataBind();
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

        //public void list()
        //{
        //    try
        //    {
        //    string query = "select c.strClass,f.strAdmsFee,f.strTutionFee from tbl_Fee f inner join tbl_Class c on f.nc_id=c.nc_id where f.bisDeleted='False' and f.nsch_id='" + Session["nschoolid"] + "'";
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
        //                c.classnm = dr["strClass"].ToString();
        //                c.fee = dr["strAdmsFee"].ToString();
        //                c.stnum = dr["strTutionFee"].ToString();
                        
        //                tempList.Add(c);
        //            }
        //            tempList.TrimExcess();
        //            con.Close();
        //            foreach (var c in tempList)
        //            {
        //                lblcn.Text = c.classnm;
        //                lblaf.Text = c.fee;
        //                lbltf.Text = c.stnum;

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