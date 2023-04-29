using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SchoolPRO
{
    public partial class TeacherClassInchargeconformleave : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            checkbit();
        }
        //private DataTable GetRecords()
        //{
        //    con.Open();
        //    cmd.Connection = con;
        //    cmd.CommandType = CommandType.Text;
        //    cmd.CommandText = "Select id.npd_id,id.strCostPrice,id.nTotalQuant,id.nActualQuant,id.bnSKU,id.strBrand,id.strSeason,d.strDepartmentName,c.strCategoryName,sb.strSubCatName, id.nProductCode,id.strSalePrice,v.strVendorName,sz.nSizeCode,clr.nCCode,lg.nLengthCode from tbl_ItemDetail id inner join tbl_Department d on id.nd_id=d.nd_id inner join tbl_Category c on id.nc_id=c.nc_id inner join tbl_SubCategory sb on id.n_sbcat=sb.n_sbcat inner join tbl_Size sz on id.ns_id=sz.ns_id inner join tbl_Color clr on id.nclr_id=clr.nclr_id inner join tbl_Length lg on id.nl_id=lg.nl_id inner join tbl_Vendor v on id.nv_id=v.nv_id where id.bisDeleted='False' ORDER BY id.bnSKU DESC";
        //    SqlDataAdapter dAdapter = new SqlDataAdapter();
        //    dAdapter.SelectCommand = cmd;
        //    con.Close();
        //    DataSet objDs = new DataSet();
        //    dAdapter.Fill(objDs);
        //    return objDs.Tables[0];

        //}
        private void checkbit()
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.Clear();
            cmd.CommandText = "select bisClassTeacher from tbl_AttendenceMarking";
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                string bitfalse = dr["bisClassTeacher"].ToString();
                if (bitfalse == "False")
                {
                    mvt.ActiveViewIndex = 1;
                }
                else if (bitfalse == "True")
                {
                    mvt.ActiveViewIndex = 0;
                }
            }
        }

        protected void btnaccept_Click(object sender, EventArgs e)
        {
            try
            {
                string ids = ((Button)sender).CommandArgument.ToString();
                con.Close();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.CommandText = "update tbl_Leave set bPanding='Accepted',strConformBy=@userid where nLeav_id=@lid ";
                cmd.Parameters.AddWithValue("@sch", Session["nschoolid"].ToString());
                cmd.Parameters.AddWithValue("@userid", Session["uid"].ToString());
                cmd.Parameters.AddWithValue("@dformat", DATE_FORMAT.format());
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@tbit", BIT_T_F.TrueBit());
                cmd.Parameters.AddWithValue("@lid", ids);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    gridtrus.DataBind();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Accept Leave Request Successfully....!')", true);
                    con.Close();
                    cmd.Parameters.Clear();
                }
            }
        }

        protected void btnreject_Click(object sender, EventArgs e)
        {
            try
            {
                string ids = ((Button)sender).CommandArgument.ToString();
                con.Close();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.CommandText = "update tbl_Leave set bPanding='Rejected' where nLeav_id=@lid ";
                cmd.Parameters.AddWithValue("@lid", ids);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    gridtrus.DataBind();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Rejected Leave Request Successfully....!')", true);
                    con.Close();
                    cmd.Parameters.Clear();
                }
            }
        }

        protected void gvteacher_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Button btnaccept = (e.Row.FindControl("btnaccept") as Button);
                Button btnreject = (e.Row.FindControl("btnreject") as Button);
                if (e.Row.Cells[9].Text == "Accepted" || e.Row.Cells[9].Text == "Rejected")
                {
                    btnaccept.Enabled = false;
                    btnreject.Enabled = false;
                }
            }
        }

        protected void gridtrus_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Button btnaccept = (e.Row.FindControl("btnaccept") as Button);
                Button btnreject = (e.Row.FindControl("btnreject") as Button);
                if (e.Row.Cells[9].Text == "Accepted" || e.Row.Cells[9].Text == "Rejected")
                {
                    btnaccept.Enabled = false;
                    btnreject.Enabled = false;
                }
            }
        }
    }
}