using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

using System.Drawing;
using System.Drawing.Imaging;

namespace SchoolPRO
{
    public partial class ParentViewChildren : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();

        SqlDataReader dr;
        BarcodeLib.Barcode b = new BarcodeLib.Barcode();
        public void printbarcode()
        {
            if (Session["uid"] != null)
            {
                //lblsize.Text = Session["size"].ToString();
                getCodetxt.Text = Session["SKU"].ToString();
                int W = Convert.ToInt32("130");
                int H = Convert.ToInt32("40");

                b.IncludeLabel = true;
                BarcodeLib.TYPE type = BarcodeLib.TYPE.CODE128C;

                Bitmap btmap = (Bitmap)b.Encode(type, getCodetxt.Text.Trim(), System.Drawing.Color.Black, System.Drawing.Color.White, W, H);
                btmap.Save(AppDomain.CurrentDomain.BaseDirectory + "/Attachments/BarCodes/" + getCodetxt.Text + ".jpeg", ImageFormat.Jpeg);
                img.ImageUrl = "~/Attachments/BarCodes/" + getCodetxt.Text + ".jpeg";
                img1.ImageUrl = "~/Attachments/BarCodes/" + getCodetxt.Text + ".jpeg";
                img2.ImageUrl = "~/Attachments/BarCodes/" + getCodetxt.Text + ".jpeg";
                Session["URL"] = "~/Attachments/BarCodes/" + getCodetxt.Text + ".jpeg";
                Session["imageUrl"] = Session["URL"].ToString();
                //Session["Number"] = Session["val"];
                //Response.Redirect("~/Barcode.aspx");
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }
        string dtdate = DATE_FORMAT.format();
        protected void Page_Load(object sender, EventArgs e)
        {
            //lbluval.Text = Session["uid"].ToString();
            //lbluemail.Text = Session["userval"].ToString();

            if (!this.IsPostBack)
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Select strSchName+'  '+strAddress as school from  tbl_School where nsch_id= '" + Session["nschoolid"] + "' and bisDeleted='False'";
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                   // txtSchool.Text = dr["school"].ToString();
                    txtschool3.Text = dr["school"].ToString();
                    txtschool1.Text = dr["school"].ToString();
                    txtschool2.Text = dr["school"].ToString();
                }
                else
                {

                }
                con.Close();
               
            }
        }
        protected void btnviewatndnc_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["id"] = gvr.Cells[1].Text;
                //Session["courscode"] = gvr.Cells[2].Text;
                mvt.ActiveViewIndex = 1;

            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
           
        }

        protected void btnuedit_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 0;
        }
        private void INVNUMBER()
        {
            int addinv = 0;
            // SqlConnection con = c1.connect_to_db();
            bool RNflag = true;
            int result = 0;
            if (RNflag)
            {
                //////////////////////////////////////////////////////////
                con.Open();
                SqlCommand cmd22;
                cmd = new SqlCommand("SELECT  receipt_number FROM tbl_Invoice where bisDeleted=1", con);
                SqlDataReader sdr33 = cmd.ExecuteReader();
                if (sdr33.HasRows)
                {
                    sdr33.Read();
                    result = Convert.ToInt32(sdr33["receipt_number"]);

                    if (result != 0)
                    {
                        addinv = result;
                        //////////////////////////// sid.Text = addinv.ToString();
                        RNflag = false;
                        cmd.Dispose();
                        sdr33.Close();
                        // con.Close();
                        //con.Open();
                        cmd22 = new SqlCommand("Update tbl_Invoice set bisDeleted=0 where receipt_number='" + addinv + "'", con);
                        if (cmd22.ExecuteNonQuery() != -1)
                        {

                        }
                        // con.Open();

                    }
                }
                cmd.Dispose();
                con.Close();

            }
            //////////////////////////////////////////////////////////
            if (RNflag)
            {
                con.Open();
                SqlCommand cmd;
                cmd = new SqlCommand("SELECT  MAX(CAST(receipt_number AS Int)) FROM tbl_Invoice where bisDeleted=0", con);
                result = (Int32)cmd.ExecuteScalar();
                if (result != 0 || result == 0)
                {
                    addinv = result + 1;
                }
                //sid.Text = addinv.ToString();
                cmd.Dispose();
                con.Close();
                /////////////////////////////////////////////////////////

                con.Open();
                result = 0;
                //SqlCommand cmd;
                cmd = new SqlCommand("insert into tbl_Invoice (receipt_number,nu_id,dtAddDate,bisDeleted) Values('" + addinv + "','0',convert(date, SYSDATETIME()),0)", con);
                if (cmd.ExecuteNonQuery() != -1)
                { }
                else { }
                //MessageBox.Show("Invoice Not Inserted");
                cmd.Dispose();
                con.Close();
            }
        }

        public void getfeeandduedateofstdent(string neid,string stdnum ,string regno)
        {
            string regfee = "", genfee = "", flderfee = "", examfee = "", bookfee = "", statfee = "";
            txtfee.Text = "0";
            txtFine.Text = "0";
            txtfeecons.Text = "0";
            txtRcvfee.Text = "0";
            txtTotfee.Text = "0";
            try
            {

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;

                txtstnum.Text = stdnum+"-"+regno;
                cmd.CommandText = "select e.strLname,c.strClass,s.strSection,f.strTutionFee,f.dtDueDate,f.nFine,f.strRegFee,f.strFolderFee,f.strGeneratorFee,f.strBookFee,f.strStationaryFee,f.strAnnualExamFee from tbl_Enrollment e inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Section s on e.nsc_id=s.nsc_id inner join tbl_Fee f on e.nfee_id=f.nfee_id where e.ne_id='" + neid + "' and e.bisDeleted='False' and e.nsch_id='" + Session["nschoolid"] + "'";
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtnm.Text = dr["strLname"].ToString();
                    txtDueDate.Text = dr["dtDueDate"].ToString();

                    // genfee = dr["strGeneratorFee"].ToString();
                    // flderfee = dr["strFolderFee"].ToString();

                    // statfee = dr["strStationaryFee"].ToString();

                    if (txtDueDate.Text != "")
                    {
                        if (Convert.ToInt32(DateTime.Now.Day.ToString()) > Convert.ToInt32(txtDueDate.Text))
                        {
                            int today = Convert.ToInt32(DateTime.Now.Day.ToString());
                            int dueday = Convert.ToInt32(txtDueDate.Text);
                            int numofdays = today - dueday;
                            Int64 totfine = numofdays * Convert.ToInt64(dr["nFine"].ToString());
                            txtFine.Text = totfine.ToString();
                        }
                        else
                            txtFine.Text = "0";
                    }
                    else
                        txtFine.Text = "0";
                    //txtFine.Text = dr["nFine"].ToString();
                    if (txtDueDate.Text != "")
                        txtDueDate.Text += "/" + DateTime.Now.Month.ToString() + "/" + DateTime.Now.Year.ToString();
                    else
                        txtDueDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                    txtfee.Text = dr["strTutionFee"].ToString();
                    //txtgenfee.Text = genfee;
                    //txtstatfee.Text = statfee;
                    //txtflderfee.Text = flderfee;

                }
                else
                {

                }
                con.Close();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Select strFeeAmountRemaining from tbl_RecieveFee where nfr_id=(select Max(nfr_id) from tbl_RecieveFee where strRecieveType='Class' and ne_id='" + neid + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "')and strRecieveType='Class' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        if (dr["strFeeAmountRemaining"].ToString() != "")
                        {
                            txtRemnfee.Text = dr["strFeeAmountRemaining"].ToString();
                            Int64 totAmount = Convert.ToInt64(txtRemnfee.Text) + Convert.ToInt64(txtfee.Text);
                            txtTotfee.Text = totAmount.ToString();
                        }
                        else
                        {
                            txtRemnfee.Text = "0";
                            Int64 totAmount = Convert.ToInt64(txtRemnfee.Text) + Convert.ToInt64(txtfee.Text);
                            txtTotfee.Text = totAmount.ToString();
                        }
                    }
                    else
                    {

                    }
                }
                else
                {
                    txtRemnfee.Text = "0";
                    if (txtfee.Text == "")
                        txtfee.Text = "0";

                }
                con.Close();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Select conc.nConcPer from tbl_ConcessionStudent concstd inner join tbl_Concession conc on concstd.nConc_id=conc.nConc_id where concstd.nStd_id=@neeid and concstd.bisDeleted=0 and concstd.nsch_id='" + Session["nschoolid"] + "'";
                cmd.Parameters.AddWithValue("@neeid", neid);
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    string per = dr["nConcPer"].ToString();
                    Int32 concessionamount = (Convert.ToInt32(txtfee.Text) * Convert.ToInt32(per)) / 100;
                    Int32 totfeee = Convert.ToInt32(txtfee.Text) - concessionamount;

                    //chkfeecons.Checked = true;
                    txtfeecons.Text = concessionamount.ToString();
                    txtfee.Text = totfeee.ToString();

                }
                con.Close();
                Int64 totfeeofmonths = 0;
                int mmcounter = 0;
                Boolean flagmm = false;
           
                {
                    if (txtflderfee.Text == "") txtflderfee.Text = "0";
                    if (txtstatfee.Text == "") txtstatfee.Text = "0";
                    // if (txt == "") txtstatfee.Text = "0";
                    Int64 tot1Amount = Convert.ToInt64(txtRemnfee.Text) + Convert.ToInt64(txtfee.Text) + Convert.ToInt64(txtFine.Text);
                    txtTotfee.Text = tot1Amount.ToString();
                    txtRcvfee.Text = txtTotfee.Text;

                }
            }
            catch (Exception)
            {
                Response.Redirect("Error.aspx");
            }
           // txtRcvfee.Focus();
        }
        public void getchallanform(string neid,string cid ,string scid ,string feeid,string stdnum,string regno,string stname,string stclass,string stsec)
        {
            Boolean addfla = true;
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select ne_id from tbl_RecieveFee where   ne_id='" + neid + "' and SUBSTRING(strFeeMonth ,4,2)=SUBSTRING(@date3,4,2) and SUBSTRING(strFeeMonth ,7,10)=SUBSTRING(@date3 ,7,10)  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "' and bisPaid='True'";
                cmd.Parameters.AddWithValue("@date3", dtdate);
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This Month Fee Has been Paid....');", true);

                    return;
                    
                }
                con.Close();
            }
            catch
            { }




            try
            {
                /////////////////FOr ONE MOTHN

                string mm = DateTime.Now.Month.ToString();
                string yy = DateTime.Now.Year.ToString();
                string dd = DateTime.Now.ToString("dd");
                string mid = "0";

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;

                cmd.CommandText = "select strMonthNo,nMonth_id from [tbl_FeeMonth] where strMonthNo=@mmm and bisDeleted=0";
                cmd.Parameters.AddWithValue("@mmm", mm);
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    mid = dr["nMonth_id"].ToString();


                }
                con.Close();
                /////////////////////////////////////////////////////////////////
                cmd.Parameters.Clear();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                try
                {
                    cmd.CommandText = "select ne_id from tbl_RecieveFee where   ne_id='" + neid + "' and SUBSTRING(strFeeMonth ,4,2)=SUBSTRING(@date3,4,2) and SUBSTRING(strFeeMonth ,7,10)=SUBSTRING(@date3 ,7,10)  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                    cmd.Parameters.AddWithValue("@date3", dtdate);
                    dr = cmd.ExecuteReader();
                }
                catch (Exception e)
                { 
                
                }
                if (dr.HasRows)
                {
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Challan already generated.');", true);

                    addfla = false;
                }
               // else
                {
                    con.Close();

                    ///////////////////////////////Get Fee Details of student///////////////////////////////////////////////////

                    getfeeandduedateofstdent(neid, stdnum,regno);
                    int inv = 0;
                    ///////////////////////////////Get Fee Details of student///////////////////////////////////////////////////
                    if (addfla)
                    {


                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "Select Max(nChallanNum) as num from tbl_RecieveFee";
                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            if (dr.Read())
                            {
                                inv = Convert.ToInt32(dr["num"].ToString()) + 1;
                            }
                        }
                        else
                        {
                            inv = 1;
                        }

                        con.Close();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        if (txtfeecons.Text == "")
                            txtfeecons.Text = "0";
                        string mmm2 = DateTime.Now.ToString("MMM");
                        //cmd.CommandText = "insert into tbl_RecieveFee(ne_id,nu_id,nsch_id,strFeeAmount,strFeeAmountReceived,strFeeAmountRemaining,strFeeConcession,strRecieveType,dtAddDate,bisDeleted) values ((select ne_id from tbl_Enrollment where strStudentNum='" + txtstnum.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted=0),'" + Session["uid"] + "','" + Session["nschoolid"] + "',@famnt,'" + txtRcvfee.Text + "' ,'" + txtRemnfee.Text + "','" + txtfeecons.Text + "','Class',convert(date,SYSDATETIME()),'False')";
                        //last change cmd.CommandText = "insert into tbl_RecieveFee(bisPaid,nc_id,nsc_id,ne_id,nu_id,nsch_id,strFeeAmount,strFeeAmountReceived,strFeeAmountRemaining,strFeeConcession,strRecieveType,dtAddDate,bisDeleted) values (0,'" + ddcl.SelectedValue + "','" + ddsec.SelectedValue + "','" + neid + "','" + Session["uid"] + "','" + Session["nschoolid"] + "',@famnt,'" + txtRcvfee.Text + "' ,'" + txtRemnfee.Text + "','" + txtfeecons.Text + "','Class',convert(date,SYSDATETIME()),'False')";
                        //last change cmd.Parameters.AddWithValue("@famnt", txtfee.Text);
                        cmd.CommandText = "insert into tbl_RecieveFee(strMonths,nChallanNum,nMonth_id,strFeeMonth,bisPaid,nc_id,nsc_id,ne_id,nu_id,nsch_id,strFeeAmount,strFeeAmountReceived,strFeeAmountRemaining,strFeeConcession,strRecieveType,dtAddDate,bisDeleted) values (@mm,@inv1,@mid,@date4,0,'" + cid + "','" + scid + "','" + neid + "','" + Session["uid"] + "','" + Session["nschoolid"] + "',@famnt,'" + txtRcvfee.Text + "' ,'" + txtRemnfee.Text + "','" + txtfeecons.Text + "','Class',@date4,'False')";
                        cmd.Parameters.AddWithValue("@famnt", txtfee.Text);
                        cmd.Parameters.AddWithValue("@mm", mmm2);
                        cmd.Parameters.AddWithValue("@mid", mid);
                        cmd.Parameters.AddWithValue("@inv1", inv);

                        cmd.Parameters.AddWithValue("@date4", dtdate);
                        cmd.ExecuteNonQuery();
                        con.Close();
                        int amount = 0;
                        int total = 0;


                        //////////////////////////UPDATE WHEN PAID/////////////////////////////
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "select strAmount from tbl_Bank where strAccNum='" + AdminVariables.getFeeAccNumber() + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
                        dr = cmd.ExecuteReader();
                        if (dr.Read())
                        {
                            amount = Convert.ToInt32(dr["strAmount"].ToString());
                        }
                        /// total = amount + Convert.ToInt32(txtfee.Text) + Convert.ToInt32(txtFine.Text) - Convert.ToInt32(txtRemnfee.Text);
                        total = amount + Convert.ToInt32(txtTotfee.Text) - Convert.ToInt32(txtRemnfee.Text);
                        con.Close();
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "update tbl_Bank set strAmount=@amnt where strAccNum='" + AdminVariables.getFeeAccNumber() + "'  and nsch_id='" + Session["nschoolid"] + "'";
                        cmd.Parameters.AddWithValue("@amnt", total);
                        cmd.ExecuteNonQuery();
                        con.Close();

                        AdminFunctions add = new AdminFunctions();
                        add.challanTransferRecordWith_False_Bit(inv.ToString(), ddacnum.SelectedValue, amount.ToString(), total.ToString(), (Convert.ToInt32(txtTotfee.Text) - Convert.ToInt32(txtRemnfee.Text)).ToString(), neid, Session["uid"].ToString(), Session["nschoolid"].ToString());
                        //////////////////////////////////////////
                    }
                    else
                    {
                        try
                        {
                            con.Open();
                            cmd.Parameters.Clear();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "Select nChallanNum as num from tbl_RecieveFee where ne_id=@neid and strRecieveType='Class' and bisPaid='False' and SUBSTRING(strFeeMonth ,4,2)=SUBSTRING(@date3,4,2) and SUBSTRING(strFeeMonth ,7,10)=SUBSTRING(@date3 ,7,10)  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";

                            cmd.Parameters.AddWithValue("@neid", neid);
                            cmd.Parameters.AddWithValue("@date3", dtdate);
                            dr = cmd.ExecuteReader();
                            if (dr.HasRows)
                            {
                                if (dr.Read())
                                {
                                    inv = Convert.ToInt32(dr["num"].ToString());
                                }
                            }
                            else
                            {
                                inv = 1;
                            }

                            con.Close();
                        }
                        catch(Exception e)
                        
                        {
                            Response.Write(e.Message);
                        }
                    }
                    // tststInvc.Text = inv.ToString();
                    txtinv1.Text = inv.ToString();
                    txtinv2.Text = inv.ToString();
                    txtinv3.Text = inv.ToString();

                    /// date.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                    txtdate1.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                    txtdate2.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                    txtdate3.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

                    //duedate.Text = txtDueDate.Text;
                    txtduedate1.Text = txtDueDate.Text;
                    txtduedate2.Text = txtDueDate.Text;
                    txtduedate3.Text = txtDueDate.Text;

                    // txtstName.Text = ddst.SelectedItem.ToString();
                    txtname1.Text = stname;
                    txtname2.Text = stname;
                    txtname3.Text = stname;

                    // txtstClass.Text = ddcl.SelectedItem.ToString();
                    txtcls1.Text = stclass;
                    txtcls2.Text = stclass;
                    txtcls3.Text = stclass;

                    // txtstSec.Text = ddsec.SelectedItem.ToString();
                    txtsec1.Text = stsec;
                    txtsec2.Text = stsec;
                    txtsec3.Text = stsec;

                    // txtstRoll.Text = txtstnum.Text;
                    txtreg1.Text = txtstnum.Text;
                    txtreg2.Text = txtstnum.Text;
                    txtreg3.Text = txtstnum.Text;

                    //  txtstFee.Text = txtfee.Text;
                    txtstFee1.Text = txtfee.Text;
                    txtstFee2.Text = txtfee.Text;
                    txtstFee3.Text = txtfee.Text;
                    ////////////////////////////MONTH///
                    //txtmonths.Text += DateTime.Now.Month.ToString( + ",";
                    ////////////////////////////MONTH///
                    //  txtmonths.Text = DateTime.Now.ToString("MMM");
                    txtmonths1.Text = DateTime.Now.ToString("MMM");
                    txtmonths2.Text = DateTime.Now.ToString("MMM");
                    txtmonths3.Text = DateTime.Now.ToString("MMM");

                    // txtstFine.Text = txtFine.Text;
                    txtstFine1.Text = txtFine.Text;
                    txtstFine3.Text = txtFine.Text;
                    txtstFine2.Text = txtFine.Text;
                    //if (flagfiner)
                    //{
                    //    
                    //    flagfiner = false;
                    //    txtRemnfee.Text = "0";
                    //}
                    // txtstRemainingFee.Text = txtRemnfee.Text;
                    txtstRemainingFee1.Text = txtRemnfee.Text;
                    txtstRemainingFee2.Text = txtRemnfee.Text;
                    txtstRemainingFee3.Text = txtRemnfee.Text;

                    // txtstConc.Text = txtfeecons.Text;
                    txtstConc1.Text = txtfeecons.Text;
                    txtstConc2.Text = txtfeecons.Text;
                    txtstConc3.Text = txtfeecons.Text;

                    //  txtstRcvFee.Text = txtRcvfee.Text;
                    txtstRcvFee1.Text = txtRcvfee.Text;
                    txtstRcvFee2.Text = txtRcvfee.Text;
                    txtstRcvFee3.Text = txtRcvfee.Text;

                    //  txtstTOTFee.Text = txtTotfee.Text;
                    txtstTOTFee1.Text = txtTotfee.Text;
                    txtstTOTFee2.Text = txtTotfee.Text;
                    txtstTOTFee3.Text = txtTotfee.Text;

                    int totrcvfee = Convert.ToInt32(txtRcvfee.Text);// + Convert.ToInt32(txtFine.Text);



                    // txtstTOTRcvfee.Text = txtRcvfee.Text;
                    txtstTOTRcvfee1.Text = txtRcvfee.Text;
                    txtstTOTRcvfee2.Text = txtRcvfee.Text;
                    txtstTOTRcvfee3.Text = txtRcvfee.Text;

                    Session["SKU"] = txtinv1.Text;

                    printbarcode();

                    Session.Remove("SKU");

                    mvt.ActiveViewIndex = 3;
                 
                }
            }
            catch(Exception e)
            {
              //  int dada = 0;
            }
        }
        protected void btnprintfee_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            string neid=gvr.Cells[1].Text.Trim();
            string stdnum = gvr.Cells[2].Text.Trim();
            string stname = gvr.Cells[3].Text.Trim();
            string stclass = gvr.Cells[4].Text.Trim();
            string stsec = gvr.Cells[5].Text.Trim();
           
           

            string cid=gvr.Cells[7].Text.Trim();
            string scid=gvr.Cells[8].Text.Trim();
            string feeid=gvr.Cells[9].Text.Trim();
            string regno=gvr.Cells[10].Text.Trim();
            //////////////////////////////////////

           
            getchallanform(neid, cid, scid, feeid, stdnum,regno,stname,stclass,stsec);

            ///////////////////////////////////////
            
        }

        protected void linkforAdmission_ServerClick(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 4;
        }

        protected void linkConfirm_ServerClick(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 0;
        }

        protected void btnprintREG_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;

            Session["rgno"] = gvr.Cells[1].Text.Trim();

            Response.Redirect("ParentsRegistrationNumber.aspx");
        }

       
        //protected void btnprint_Click(object sender, EventArgs e)
        //{
        //    GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
        //    Session["eid"] = gvr.Cells[0].Text;
        //    mvt.ActiveViewIndex = 2;
        //}

    }
}