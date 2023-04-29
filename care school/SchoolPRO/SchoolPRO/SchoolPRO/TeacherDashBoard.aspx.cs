using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class TeacherDashBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindRepeaterData();
            }
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btnsend_Click(object sender, EventArgs e)
        {
            //con.Open();
            //cmd.Connection = con;
            //cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "insert into tbl_Conversation (nu_id,strMessage,dtAddDate,bisDeleted) values('" + Session["uid"] + "',@msg,@postedDate,'False')";
            //cmd.Parameters.AddWithValue("@msg", txtmsg.Text);
            //cmd.Parameters.AddWithValue("@postedDate", DateTime.Now);
            //cmd.ExecuteNonQuery();
            //con.Close();
            //txtmsg.Text = "";
            //BindRepeaterData();
        }
        protected void BindRepeaterData()
        {
            //con.Open();
            //SqlCommand cmd1 = new SqlCommand("select u.strImage,u.strfname,c.strMessage,c.dtAddDate from tbl_Conversation c inner join tbl_Users u on c.nu_id=u.nu_id Order By c.dtAddDate DESC", con);
            //DataSet ds = new DataSet();
            //SqlDataAdapter da = new SqlDataAdapter(cmd1);
            //da.Fill(ds);
            //RepDetails.DataSource = ds;
            //RepDetails.DataBind();
            //con.Close();
        }
    }
}