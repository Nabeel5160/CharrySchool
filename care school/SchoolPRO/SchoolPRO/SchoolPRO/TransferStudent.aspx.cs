using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class TransferStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                bindClassData();
            disableAll();
        }
        void disableAll()
        {
            btnPromote.Enabled = false;
        }
        void bindClassData()
        {
            DataSet ds = new DataSet();
            string CS = WebConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("select * from tbl_class where bisDeleted='false'", con);
                con.Open();
                da.Fill(ds, "class");
                ddcl.DataSource = ds;
                ddcl.DataTextField = "strClass";
                ddcl.DataValueField = "nc_id";
                ddcl.DataBind();

            }

        }

        protected void ddcl_SelectedIndexChanged(object sender, EventArgs e)
        {
            //bind from section
            ListItem select = new ListItem("<---Select Section--->", "-1");
            ddsec.Items.Clear();
            ddltosection.Items.Clear();
            ddsec.Items.Add(select);
            ddltosection.Items.Add(select);
            int classId = Convert.ToInt32(ddcl.SelectedItem.Value);
            DataSet ds = new DataSet();
            string CS = WebConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("select * from tbl_section where bisDeleted='false' and nc_id=" + classId, con);
                con.Open();
                da.Fill(ds, "section");
                ddsec.DataSource = ds;
                ddsec.DataTextField = "strSection";
                ddsec.DataValueField = "nsc_id";
                ddsec.DataBind();
            }
            gv_students.DataSource = null;
            gv_students.DataBind();
            disableAll();
        }
        protected void ddsec_SelectedIndexChanged(object sender, EventArgs e)
        {
            int classId = Convert.ToInt32(ddcl.SelectedItem.Value);
            int sectionId = Convert.ToInt32(ddsec.SelectedItem.Value);
            DataSet ds = new DataSet();
            string CS = WebConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString;
            string query = "select * from tbl_Enrollment where bisDeleted='false' and nc_id=" + classId + " And nsc_id=" + sectionId;
            ViewState["query"] = query;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                con.Open();
                da.Fill(ds, "students");
                gv_students.DataSource = ds;
                gv_students.DataBind();
            }
            ListItem select = new ListItem("<---Select Section--->", "-1");
            ddltosection.Items.Clear(); 
            ddltosection.Items.Add(select);
      
            query = "select * from tbl_Section where bisDeleted='false' and nc_id=" + classId + " And nsc_id!=" + sectionId;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                con.Open();
                da.Fill(ds, "section");
                ddltosection.DataSource = ds.Tables["section"];
                ddltosection.DataTextField = "strSection";
                ddltosection.DataValueField = "nsc_id";
                ddltosection.DataBind();
            }
            ViewState["ds"] = ds;
            btnPromote.Enabled = false;
        }

        protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
        {
            GridViewRow row = gv_students.HeaderRow;
            CheckBox chk2 = (CheckBox)row.FindControl("CheckBox2");
            if (chk2.Checked)
            {
                foreach (GridViewRow drow in gv_students.Rows)
                {
                    if (drow.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chk1 = (CheckBox)drow.FindControl("CheckBox1");

                        chk1.Checked = true;
                    }
                }
            }
            else
            {
                foreach (GridViewRow drow in gv_students.Rows)
                {
                    if (drow.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chk1 = (CheckBox)drow.FindControl("CheckBox1");

                        chk1.Checked = false;
                    }
                }
            }
            if (ddltosection.SelectedValue != "0")
                btnPromote.Enabled = true;

        }

        protected void btnPromote_Click(object sender, EventArgs e)
        {
            promote();
            update();
            gv_students.DataSource = null;
            gv_students.DataBind();
            ddsec.SelectedValue = "-1";
        }
        private void promote()
        {
            DataSet ds = ViewState["ds"] as DataSet;
            int i = 0;
            foreach (GridViewRow drow in gv_students.Rows)
            {
                DataRow dr = ds.Tables["students"].Rows[i++];
                if (drow.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chk1 = (CheckBox)drow.FindControl("CheckBox1");
                    if (chk1.Checked)
                    {
                        int nc_id = Convert.ToInt32(dr["nc_id"]);
                        int nsc_id = Convert.ToInt32(ddltosection.SelectedValue);
                        dr["nsc_id"] = nsc_id;
                        dr["strStudentNum"] = getstudentNum(nc_id, nsc_id);
                    }
                }

            }
            ViewState["ds"] = ds;
        }
        string getstudentNum(int nc_id, int nsc_id)
        {
            return getClassName(nc_id) + " " + getSectionName(nsc_id) + "-" + getIdNo(nc_id, nsc_id);
        }
        private string getClassName(int nc_id)
        {
            string strClass;
            string CS = WebConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select strClass from tbl_Class where nc_id=" + nc_id, con);
                strClass = cmd.ExecuteScalar().ToString();
            }
            return strClass;
        }
        private string getSectionName(int nsc_id)
        {
            string strSection;
            string CS = WebConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select strSection from tbl_Section where nsc_id=" + nsc_id, con);
                strSection = cmd.ExecuteScalar().ToString();
            }
            return strSection;
        }
        private int getIdNo(int nc_id, int nsc_id)
        {
            DataSet ds = ViewState["ds"] as DataSet;
            int id, id_prev;
            string CS = WebConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select count(*) from tbl_Enrollment where nc_id=" + nc_id + "and nsc_id =" + nsc_id, con);
                id_prev = Convert.ToInt32(cmd.ExecuteScalar());
            }
            DataTable tbl = ds.Tables["students"];
            DataRow[] row = tbl.Select("nc_id=" + nc_id + "and nsc_id=" + nsc_id);
            id = row.Length;
            return id + id_prev;
        }

        void update()
        {
            string CS = WebConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString;
            string query = ViewState["query"].ToString();
            DataSet ds = ViewState["ds"] as DataSet;
            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                SqlCommandBuilder builder = new SqlCommandBuilder(da);
                int rowsupdated = da.Update(ds, "students");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + rowsupdated + " Student(s) has been Transferred to Another Section')", true);
            }

        }
       


        protected void ddltosection_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddltosection.SelectedValue != "0")
                btnPromote.Enabled = true;
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (ddltosection.SelectedValue != "0")
                btnPromote.Enabled = true;
        }
    }
}