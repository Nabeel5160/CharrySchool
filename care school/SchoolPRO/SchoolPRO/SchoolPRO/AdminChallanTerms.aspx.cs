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
using System.Drawing;
using System.Drawing.Imaging;

namespace SchoolPRO
{
    public partial class AdminChallanTerms : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindGrid();
            }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();

        SqlDataReader dr;
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            //
            cmd.CommandText = "Select * from tbl_ChallanTerms where bisDeleted='False'";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            return objDs.Tables[0];

        }
        private void bindGrid()
        {
            try
            {
                DataTable dt = GetRecords();
                if (dt.Rows.Count > 0)
                {
                    gvsearchclass.DataSource = dt;
                    gvsearchclass.DataBind();
                    gvsearchclass.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
            }
            catch (Exception) { }
        }

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 2;
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            lblid.Text=gvr.Cells[1].Text;
            txtetnc.Text = gvr.Cells[2].Text;
            MultiView1.ActiveViewIndex = 1;
        }

        protected void btndel_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            string id = gvr.Cells[1].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_ChallanTerms set bisDeleted='True' where nct_id='"+id+"'";
            cmd.ExecuteNonQuery();
            con.Close();
            bindGrid();
        }

        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tbl_ChallanTerms(strChallanTerms,bisDeleted,dtAddDate)values(@ct,'False',convert(date,SYSDATETIME()))";
            cmd.Parameters.AddWithValue("@ct", txtctncnd.Text);
            cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
            con.Close();
            txtctncnd.Text = "";
            bindGrid();
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_ChallanTerms set strChallanTerms=@ect where nct_id='" + lblid.Text + "'";
            cmd.Parameters.AddWithValue("@ect", txtetnc.Text);
            cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
            con.Close();
            txtetnc.Text = "";
            lblid.Text = "";
            bindGrid();
            MultiView1.ActiveViewIndex = 0;
        }
    }
}