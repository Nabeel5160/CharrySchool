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
using System.Net;
using System.Collections;

namespace SchoolPRO
{
    public partial class TeacherStudentTask : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try{
            if (!IsPostBack)
            {

                BindGrid();

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
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            mvquiz.ActiveViewIndex = 1;
        }
        String topic;
        protected void btnedit_Click(object sender, EventArgs e)
        {try
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["neditid"] = gvr.Cells[1].Text;
            txtecl.Text = gvr.Cells[3].Text;
            txtesec.Text=gvr.Cells[4].Text;
            Label subname = (Label)gvr.FindControl("lblcname");
            txtesub.Text = subname.Text;
            
            txtetsk.Text = gvr.Cells[6].Text;
            txtedsc.Text = gvr.Cells[7].Text;
            txtedt.Text = gvr.Cells[8].Text;
            txtetim.Text = gvr.Cells[9].Text;

         

            mvquiz.ActiveViewIndex = 2;
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

        protected void btndel_Click(object sender, EventArgs e)
        {try
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["ndelid"] = gvr.Cells[1].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Notification set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nntf_id='" + Session["ndelid"] + "'";
            cmd.ExecuteNonQuery();
            con.Close();
            PopulateData();
            mvquiz.ActiveViewIndex = 0;
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

        protected void btnaddQuiz_Click(object sender, EventArgs e)
        {
            try
            {
            string doc = "";
            if (fudoc.HasFile)
            {
                 doc = @"~\Uploaded-Files\" + Path.GetFileName(fudoc.PostedFile.FileName);
                fudoc.SaveAs(Server.MapPath(doc));
            }
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tbl_Notification(nsch_id,nu_id,nc_id,nsc_id,nsbj_id,strTime,dtDate,strTitle,strDesc,strDoc,dtAddDate,bisDeleted)values(@schid,@uid,@cid,@scid,@subid,@time,@date,@title,@desc,@doc,@dt,@fbit)";
            cmd.Parameters.AddWithValue("@cid", ddcl.SelectedValue);
            cmd.Parameters.AddWithValue("@scid",ddsec.SelectedValue);
            cmd.Parameters.AddWithValue("@subid",ddsub.SelectedValue);
            cmd.Parameters.AddWithValue("@schid",Session["nschoolid"].ToString());
            cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                cmd.Parameters.AddWithValue("@time", txttime.Text);
            cmd.Parameters.AddWithValue("@date", txtdate.Text);
            cmd.Parameters.AddWithValue("@title", txttitle.Text);
            cmd.Parameters.AddWithValue("@desc", txtQuizTopic.Text);
            cmd.Parameters.AddWithValue("@doc", doc);
            cmd.Parameters.AddWithValue("@fbit",BIT_T_F.FalseBit());
            cmd.Parameters.AddWithValue("@dt",DATE_FORMAT.format());
            cmd.ExecuteNonQuery();
            con.Close();
            txtQuizTopic.Text = "";
            PopulateData();
            sendalert();
            
            mvquiz.ActiveViewIndex = 0;
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

        protected void sendalert()
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select strMobile from tbl_Enrollment where nc_id='"+ddcl.SelectedValue+"' and nsc_id='"+ddsec.SelectedValue+"' and strStatus='Confirm' and bisDeleted='False'";
            dr = cmd.ExecuteReader();
            ArrayList numberarray = new ArrayList();
            while (dr.Read())
            {
                numberarray.Add(dr["strMobile"].ToString());
            }
            ////send sms code...
            foreach (string num in numberarray)
            {

                string number = num;
                string message = "Dairy"+Environment.NewLine+"Sbj:"+ddsub.SelectedItem+""+Environment.NewLine+"Topic:" + txtQuizTopic.Text + "'";
                ////////////////////////////////////////////////////////////////////////////////////////////

                string ozSURL = "http://127.0.0.1"; //where Ozeki NG SMS Gateway is running
                string ozSPort = "9501"; //port number where Ozeki NG SMS Gateway is listening
                string ozUser = HttpUtility.UrlEncode("admin"); //username for successful login
                string ozPassw = HttpUtility.UrlEncode("admin"); //user's password
                string ozMessageType = "SMS:TEXT"; //type of message
                string ozRecipients = HttpUtility.UrlEncode(number); //who will get the message
                string ozMessageData = HttpUtility.UrlEncode(message); //body of message

                string createdURL = ozSURL + ":" + ozSPort + "/httpapi" +
                    "?action=sendMessage" +
                    "&username=" + ozUser +
                    "&password=" + ozPassw +
                    "&messageType=" + ozMessageType +
                    "&recipient=" + ozRecipients +
                    "&messageData=" + ozMessageData;


                //Create the request and send data to Ozeki NG SMS Gateway Server by HTTP connection
                HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(createdURL);

                //Get response from Ozeki NG SMS Gateway Server and read the answer
                HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();
                System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
                string responseString = respStreamReader.ReadToEnd();
                respStreamReader.Close();
                myResp.Close();
            }
            con.Close();
            txtQuizTopic.Text = "";
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Verified Successfully.');", true);
        }

       protected void btnupdateQuiz_Click(object sender, EventArgs e)
        {
            try
            {
                string edoc = "";
                lbltopic.Text = topic;
               
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_Notification set strTime=@etime,dtDate=@edt,strTitle=@etitle,strDesc=@msgedit where nntf_id='" + Session["neditid"] + "'";
                cmd.Parameters.AddWithValue("@etime", txtetim.Text);
                cmd.Parameters.AddWithValue("@etitle", txtetsk.Text);
                cmd.Parameters.AddWithValue("@msgedit", txtedsc.Text);
                cmd.Parameters.AddWithValue("@edt", txtedt.Text);

                cmd.ExecuteNonQuery();
                con.Close();
                PopulateData();
                mvquiz.ActiveViewIndex = 0;
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

        protected void gvsearchsub_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
            System.Threading.Thread.Sleep(2000);
            if (e.CommandName == "Search")
            {
                TextBox txtGrid = (TextBox)gvsearchsub.HeaderRow.FindControl("txtcc");
                SearchText(txtGrid.Text);
            }
            }
            catch (Exception ex)
            {
               
            }
            finally
            {
               
            }
        }
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select n.nntf_id,c.strClass,sc.strSection,s.strSubject,n.strDesc,n.strTitle,n.dtDate,n.dtAddDate as dt,n.strTime from tbl_Notification n inner join tbl_Section sc on n.nsc_id=sc.nsc_id inner join tbl_Subject s on n.nsbj_id=s.nsbj_id inner join tbl_Class c on n.nc_id=c.nc_id inner join tbl_Users u on n.nu_id=u.nu_id  where u.nlevel='2' and u.nu_id='" + Session["uid"] + "' And n.bisDeleted='False' And n.nsch_id='" + Session["nschoolid"] + "'";
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
                gvsearchsub.DataSource = dt;
                gvsearchsub.DataBind();
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

        private void SearchText(string strSearchText)
        {
            try
            {
            DataTable dt = GetRecords();
            DataView dv = new DataView(dt);
            string SearchExpression = null;
            if (!String.IsNullOrEmpty(strSearchText))
            {
                SearchExpression =
                string.Format("{0} '%{1}%'", gvsearchsub.SortExpression, strSearchText);

            }
                else
                Response.Redirect("TeacherStudentTask.aspx");

            dv.RowFilter = "strSubject like" + SearchExpression;
            gvsearchsub.DataSource = dv;
            gvsearchsub.DataBind();
            }
            catch (Exception ex)
            {
                
            }
            finally
            {
               
            }
        }

        public string Highlight(string InputTxt)
        {
            GridViewRow gvr = gvsearchsub.HeaderRow;
            if (gvr != null)
            {
                TextBox txtExample = (TextBox)gvsearchsub.HeaderRow.FindControl("txtcc");

                if (txtExample.Text != null)
                {
                    string strSearch = txtExample.Text;
                    Regex RegExp = new Regex(strSearch.Replace(" ", "|").Trim(), RegexOptions.IgnoreCase);
                    return RegExp.Replace(InputTxt, new MatchEvaluator(ReplaceKeyWords));
                    RegExp = null;
                }
                else
                    return InputTxt;
            }
            else
            {
                return InputTxt;
            }
        }

        public string ReplaceKeyWords(Match m)
        {
            return "<span class='highlight'>" + m.Value + "</span>";
        }
        private void PopulateData()
        {
            try
            {
            DataTable table = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
            {

                string sql = "select n.nntf_id,c.strClass,sc.strSection,s.strSubject,n.strDesc,n.strTitle,n.dtDate,n.dtAddDate as dt,n.strTime from tbl_Notification n inner join tbl_Section sc on n.nsc_id=sc.nsc_id inner join tbl_Subject s on n.nsbj_id=s.nsbj_id inner join tbl_Class c on n.nc_id=c.nc_id inner join tbl_Users u on n.nu_id=u.nu_id  where u.nlevel='2' and u.nu_id='" + Session["uid"] + "' And n.bisDeleted='False' And n.nsch_id='" + Session["nschoolid"] + "'";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {

                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {

                        ad.Fill(table);

                    }

                }

            }

            gvsearchsub.DataSource = table;

            gvsearchsub.DataBind();
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