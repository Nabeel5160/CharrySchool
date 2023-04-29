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
    public partial class ParentViewTeacher : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            //string schiddd = Session["nschoolid"].ToString();
        }

        protected void btnviewteacher_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string eid = gvr.Cells[1].Text;
                Session["stdid"]=eid;
                string cid = gvr.Cells[2].Text;
                string scid = gvr.Cells[3].Text;

                teacherDs.SelectParameters["cid"].DefaultValue = cid;
                teacherDs.SelectParameters["scid"].DefaultValue = scid;

                mvt.ActiveViewIndex = 1;
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 0;
        }

        protected void btnSndMsgteacher_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string uid = gvr.Cells[1].Text;
                mvt.ActiveViewIndex = 2;
                ddladduser.Focus();
                teachrDS.SelectParameters["nu_id"].DefaultValue = uid;
            }
            
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            
            }
        }

        protected void btnaddMessage_Click(object sender, EventArgs e)
        {
            try
            {
                string query = "insert into tbl_Message (nsch_id,strMsgTitle,strMsgDesc,nU_rcv_id,nU_sndr_id,bisRead,bisDeleted,dtAddDate) Values ('" + Session["nschoolid"] + "','" + txtaddMessagetitle.Text + "','" + txtaddMessagedesc.Text + "','" + ddladduser.SelectedValue + "','" + Session["uid"] + "','False','False',CONVERT(VARCHAR(10), GETDATE(), 105 ))";
                cmd.Connection = con;
                con.Open();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = query;
                cmd.ExecuteNonQuery();


                con.Close();

                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Message Send successfully.');", true);
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }

        protected void btnviewatndnc_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["teacherid"] = gvr.Cells[1].Text;
            Response.Redirect("ParentRateTeacher.aspx");
        }

        protected void btnleave_Click(object sender, EventArgs e)
        {
            Response.Redirect("ParentsMarkLeave.aspx");
        }
    }
}