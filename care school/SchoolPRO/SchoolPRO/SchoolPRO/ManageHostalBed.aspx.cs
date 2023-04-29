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

namespace SchoolPRO
{
    public partial class ManageHostalBed : System.Web.UI.Page
    {
        private List<TextBox> textboxes;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            PreRender += new EventHandler(_Default_PreRender);
            textboxes = new List<TextBox>();
           
            if (IsPostBack)
            {
                //recreate Textboxes
                int count = Int32.Parse(ViewState["tbCount"].ToString());
               

                for (int i = 0; i < count; i++)
                {
                    TextBox tb = new TextBox();
                    Label lab = new Label();
                    tb.CssClass = "form-control";
                    //tb.ID = "tb" + textboxes.Count;
                    tb.Text = "BAD #" + textboxes.Count;
                    tb.ID = "tb" + i;

                    prow.Controls.Add(tb);
                    textboxes.Add(tb);
                    tb.Text = Request.Form[tb.ClientID];
                }
            }
        }
        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            mvdep.ActiveViewIndex = 1;
        }
        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddhstl.SelectedIndex == 0 && ddcl.SelectedIndex == 0 && ddlflor.SelectedIndex == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Select The Dropdownlist.');", true);
                }
                else
                {
                List<TextBox> textlst = new List<TextBox>();
                int cnt =Convert.ToInt32(ViewState["tbCount"]);
                for(int i=0; i<cnt ;i++)
                {
                    TextBox tb = (TextBox)(prow.FindControl("tb" + i));
                    textlst.Add(tb);
                }
                con.Close();
                con.Open();
                cmd.Connection = con;
                foreach (TextBox txbx in textlst)
                {
                    cmd.Parameters.Clear();
                    string bedn =Convert.ToString(txbx.Text);
                    cmd.CommandType = CommandType.Text;
                    Int64 blockid = Convert.ToInt64(ddcl.SelectedValue);
                    Int64 hostl = Convert.ToInt64(ddhstl.SelectedValue);
                    Int64 flor = Convert.ToInt64(ddlflor.SelectedValue);
                    Int64 room = Convert.ToInt64(ddlrom.SelectedValue);
                    cmd.CommandText = "insert into tbl_ManageHostalBed(nHrom_id,nBed,nHos_id,nHflor_id,nsch_id,nu_id,nHBlock_id,dtAddDate,bisDeleted) values(@rom,@bed,@hst,@flor,@sch,@uid,@blk,@date,@fbit)";
                    cmd.Parameters.AddWithValue("@bed", bedn);
                    cmd.Parameters.AddWithValue("@rom", room);
                    cmd.Parameters.AddWithValue("@blk", blockid);
                    cmd.Parameters.AddWithValue("@hst", hostl);
                    cmd.Parameters.AddWithValue("@flor", flor);
                    cmd.Parameters.AddWithValue("@sch", Session["nschoolid"].ToString());
                    cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                    cmd.Parameters.AddWithValue("@date", DATE_FORMAT.format());
                    cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                    cmd.ExecuteNonQuery();
                    mvdep.ActiveViewIndex = 0;
                    gvdep.DataBind();
                        }
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
                ddcl.SelectedIndex = 0;
                ddlflor.SelectedIndex = 0;
                ddhstl.SelectedIndex = 0;
                ddlrom.SelectedIndex = 0;
            }
        }
        protected void ddhstl_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddcl.Items.Clear();
            ddcl.Items.Add(new ListItem("--Select Block--", "0"));
            ddcl.DataBind();

        }

        protected void btnadrow_Click(object sender, EventArgs e)
        {
            //int rowCount = 0;
            //rowCount = Convert.ToInt32(Session["clicks"]);
            //rowCount++;
            //Session["clicks"] = rowCount;
            //for (int i = 0; i < rowCount; i++)
            //{

            //    TextBox TxtBoxU = new TextBox();
            //    TxtBoxU.CssClass = "form-control block input-icon input-icon-right"; 
            //    TxtBoxU.ID = "TextBoxU" + i.ToString();
            //    Panel2.Controls.Add(TxtBoxU);

            TextBox tb = new TextBox();
            Label lab = new Label();
            tb.ID = "tb" + textboxes.Count;
            tb.CssClass = "form-control";
            tb.Text = "BAD #" + textboxes.Count;
            prow.Controls.Add(tb);

        textboxes.Add(tb);

            }
        void _Default_PreRender(object sender, EventArgs e)
        {
            //remember how many textboxes we had
            ViewState["tbCount"] = textboxes.Count;
        }

        protected void ddcl_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlflor.Items.Clear();
            ddlflor.Items.Add(new ListItem("--Select Floor--", "0"));
            ddlflor.DataBind();
        }

        protected void ddlflor_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlrom.Items.Clear();
            ddlrom.Items.Add(new ListItem("--Select Room--", "0"));
            ddlrom.DataBind();
        }
    }
}