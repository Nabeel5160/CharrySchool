using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace SchoolPRO
{
    public partial class AdminViewClassStudents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                    BindGrid();
                {
                    // editImagefile.HasFile = true;

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
        protected void btngobck_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminViewStudentDetail.aspx");
        }

        protected void btnviewfull_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["id"] = gvr.Cells[1].Text;
                mvt.ActiveViewIndex = 1;
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

        protected void btnuedit_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 0;
        }

        protected void btnupdatestudent_Click(object sender, EventArgs e)
        {
            try
            {
                //Session["newadmno"] = labadmno.Text;
                //string newid  = Session["newrollno"].ToString();
                //string oldid = Session["admno"].ToString();
                //if (Session["newadmno"].ToString() == Session["admno"].ToString())
                //{
                string neid = Session["id"].ToString();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "Update tbl_Enrollment Set strAdmissionNumber='" + Session["newrollno"] + "',  dtUpdate=CONVERT(VARCHAR(10), GETDATE(), 105 ),nUpdateByu_id='" + Session["uid"] + "',strDOB='" + lbldob.Text + "' , strBirthPlace='" + lblbp.Text + "',strNationality='" + lblntn.Text + "' ,strMotherlang='" + lblmlng.Text + "',strReligion='" + lblrelg.Text + "',strPhAddress='" + lbladr.Text + "',strCity='" + lblcit.Text + "',strState='" + lblst.Text + "',strCountry='" + lblcnt.Text + "',strPhone='" + lblph.Text + "',strMobile='" + lblph.Text + "',strFname='" + txtfname.Text + "',strLname='" + txtlname.Text + "'  where  ne_id='" + neid + "' ";
               


                    cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();
                    con.Close();

                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "Update tbl_Users Set strfname='" + txtgfnm.Text + "',strlname='" + txtglnm.Text + "',strNIC='" + txtgdnic.Text + "' where nu_id=(select nu_id from tbl_Enrollment where ne_id='" + neid + "')";



                    cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();
                    con.Close();
                    ShowEDITbtnandDisableFeilds();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Student Detail Updated SuccessFully.');", true);
                //}
                //else
                //{
                //    con.Open();
                //    cmd.Connection = con;
                //    cmd.CommandType = CommandType.Text;
                //    cmd.CommandText = "select strStudentNum from tbl_Enrollment where strStudentNum=@scode and bisDeleted='False'";
                //    cmd.Parameters.AddWithValue("@scode", Session["newrollno"].ToString());
                //    dr = cmd.ExecuteReader();
                //    if (dr.HasRows)
                //    {
                //        con.Close();
                //        cmd.Dispose();
                //        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Admission Number Already  Exists Enter Another Admission Number.');", true);
                //    }
                //    else
                //    {
                //        cmd.Parameters.Clear();
                //        con.Close();

                //        con.Open();
                //        cmd.Connection = con;
                //        cmd.CommandType = CommandType.Text;
                //        cmd.CommandText = "Update tbl_Enrollment Set strAdmissionNumber='" + Session["newadmno"] + "',  dtUpdate=CONVERT(VARCHAR(10), GETDATE(), 105 ),nUpdateByu_id='" + Session["uid"] + "',strDOB='" + lbldob.Text + "' , strBirthPlace='" + lblbp.Text + "',strNationality='" + lblntn.Text + "' ,strMotherlang='" + lblmlng.Text + "',strReligion='" + lblrelg.Text + "',strPhAddress='" + lbladr.Text + "',strCity='" + lblcit.Text + "',strState='" + lblst.Text + "',strCountry='" + lblcnt.Text + "',strPhone='" + lblph.Text + "',strMobile='" + lblph.Text + "'  where  ne_id='" + Session["id"] + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";



                //        cmd.ExecuteNonQuery();
                //        con.Close();
                //        ShowEDITbtnandDisableFeilds();
                //        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Student Detail Updated SuccessFully.');", true);
                //    }
                
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

        protected void btnimageupdate_Click(object sender, EventArgs e)
        {
            // mvt.ActiveViewIndex = 2;

            Response.Redirect("AdminEditStudentPic.aspx");
        }

        protected void btnTransfer_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["__eid"] = gvr.Cells[1].Text;

                //mvt.ActiveViewIndex = 1;
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            Response.Redirect("AdminStudentTransfer.aspx");
        }

        protected void btnMessagesend_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["stdid"] = gvr.Cells[1].Text;
            mvt.ActiveViewIndex = 2;
        }

        protected void btnsend_Click(object sender, EventArgs e)
        {
            try
            {
                
                if (chkstd.Checked)
                {
                    Int32 stdid = Convert.ToInt32(Session["stdid"].ToString());
                    Int32 uid = Convert.ToInt32(Session["uid"].ToString());
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_Message(strMsgTitle,strMsgDesc,nE_rcv_id,nU_rcv_id,nU_sndr_id,nsch_id,dtAddDate,bisDeleted) values (@txttitle,@txtDiscreption,@stdid,(select nu_id from tbl_Enrollment where ne_id=" + stdid + " and bisDeleted='False'),@uid,(select nsc_id from tbl_Enrollment where ne_id=" + stdid + " and bisDeleted='False'),CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                    cmd.Parameters.AddWithValue("@txttitle", txttitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@txtDiscreption", txtDiscreption.Text.Trim());
                    cmd.Parameters.AddWithValue("@uid", uid);
                    cmd.Parameters.AddWithValue("@stdid", stdid);
                    //cmd.Parameters.AddWithValue("@parenrid", parenrid);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    mvt.ActiveViewIndex = 0;
                }
                else
                {
                    Int32 stdid = Convert.ToInt32(Session["stdid"].ToString());
                    Int32 uid = Convert.ToInt32(Session["uid"].ToString());
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_Message(strMsgTitle,strMsgDesc,nU_rcv_id,nU_sndr_id,nsch_id,dtAddDate,bisDeleted) values (@txttitle,@txtDiscreption,(select nu_id from tbl_Enrollment where ne_id=" + stdid + " and bisDeleted='False'),@uid,(select nsc_id from tbl_Enrollment where ne_id=" + stdid + " and bisDeleted='False'),CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                    cmd.Parameters.AddWithValue("@txttitle", txttitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@txtDiscreption", txtDiscreption.Text.Trim());
                    cmd.Parameters.AddWithValue("@uid", uid);
                    //cmd.Parameters.AddWithValue("@stdid", stdid);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    mvt.ActiveViewIndex = 0;
                }
            }
            catch (Exception ex)
            {
            }
        }

        public void ShowEDITbtnandDisableFeilds()
        {
            lbldob.ReadOnly = true;
            lblbp.ReadOnly = true;
            lblntn.ReadOnly = true;
            lblmlng.ReadOnly = true;
            lblrelg.ReadOnly = true;
            lbladr.ReadOnly = true;
            lblcit.ReadOnly = true;
            lblst.ReadOnly = true;
            lblcnt.ReadOnly = true;
            lblph.ReadOnly = true;
            txtglnm.ReadOnly = true;
            txtgfnm.ReadOnly = true;
            txtfname.ReadOnly = true;
            txtlname.ReadOnly = true;
            btnupdatestudent.Visible = false;
            btnEdit.Visible = true;
            //labadmno.ReadOnly = true;
        }
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            txtgfnm.ReadOnly = false;
            txtglnm.ReadOnly = false;
            txtgdnic.ReadOnly = false;
            txtfname.ReadOnly = false;
            txtlname.ReadOnly = false;
            lbldob.ReadOnly = false;
            lblbp.ReadOnly = false;
            lblntn.ReadOnly = false;
            lblmlng.ReadOnly = false;
            lblrelg.ReadOnly = false;
            lbladr.ReadOnly = false;
            lblcit.ReadOnly = false;
            lblst.ReadOnly = false;
            lblcnt.ReadOnly = false;
            lblph.ReadOnly = false;
            btnupdatestudent.Visible = true;
            
            btnEdit.Visible = false;
            labrollno.ReadOnly = true;
            Session["rollno"] = Request.Form[labrollno.UniqueID];

        }

        //protected void txtsrch_TextChanged(object sender, EventArgs e)
        //{
        //    SearchText();
        //}
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT [ne_id],[strStudentNum], [strFname], [strLname] FROM [tbl_Enrollment] WHERE ([nc_id] = '" + Session["cid"] + "') and nsc_id='" + Session["__scid"] + "' and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();

            dAdapter.Fill(objDs);
            con.Close();
            return objDs.Tables[0];
        }
        private void BindGrid()
        {
            try
            {
                DataTable dt = GetRecords();
                if (dt.Rows.Count > 0)
                {
                    gvbystnum.DataSource = dt;
                    gvbystnum.DataBind();
                }
            }
            catch (Exception) { }
        }

        protected void gvbystnum_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        //private void SearchText()
        //{
        //    try
        //    {
        //        DataTable dt = GetRecords();
        //        DataView dv = new DataView(dt);
        //        string SearchExpression = null;
        //        if (!String.IsNullOrEmpty(txtsrch.Text))
        //        {
        //            SearchExpression = string.Format("{0} '%{1}%'",
        //            gvbystnum.SortExpression, txtsrch.Text);

        //        }
        //        else
        //        {
        //            Response.Redirect("AdminViewClassStudents.aspx");
        //        }
        //        dv.RowFilter = "Convert(strfname,'System.String') like" + SearchExpression;
        //        gvbystnum.DataSource = dv;
        //        gvbystnum.DataBind();

        //    }
        //    catch (Exception ex)
        //    {
        //    }
        //}
    }
}

       
        

   