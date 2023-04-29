﻿using System;
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
    public partial class AdminRecievingFee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {

                    BindGrid();
                    Bind_ddlClass();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "Select strSchName,strAddress from  tbl_School where nsch_id= '" + Session["nschoolid"] + "' and bisDeleted='False'";
                    dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        txtSchool.Text = dr["strSchName"].ToString();
                        lblsch2.Text = dr["strSchName"].ToString();
                        lblsch1.Text = dr["strSchName"].ToString();
                        lblsch3.Text = dr["strSchName"].ToString();
                        lbladrs1.Text = dr["strAddress"].ToString();
                        lbladrs2.Text = dr["strAddress"].ToString();
                        lbladrs3.Text = dr["strAddress"].ToString();
                    }
                    else
                    {

                    }
                    con.Close();

                }
                if (IsPostBack)
                {
                    //if(ddst.Text!="")
                    //txtstnum.Text = ddst.SelectedValue.ToString();
                }
            }
            catch (Exception ex)
            {
                // Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

            // mvsub.ActiveViewIndex = 3;
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();

        SqlDataReader dr;

        BarcodeLib.Barcode b = new BarcodeLib.Barcode();
      public  void printbarcode()
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
                Image2.ImageUrl = "~/Attachments/BarCodes/" + getCodetxt.Text + ".jpeg";
                img1.ImageUrl = "~/Attachments/BarCodes/" + getCodetxt.Text + ".jpeg";
                Image3.ImageUrl = "~/Attachments/BarCodes/" + getCodetxt.Text + ".jpeg";
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

        public void challanTransferRecordWith_False_Bit(string challan, string accnum, string oldamt, string newamt, string tranamt, string neid)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into tbl_Bank_Challan_Transfer (naccid,straccnum,strchallannum,stroldamount,strnewamount,strtransferamount,neid,bisDeleted,bPaid,tmAddTime,dtAddDate,nu_id,nsch_id) Values((Select  nbnk_id from tbl_Bank where strAccNum = @accnum and bisDeleted=@fbit and nsch_id=@schid),@accnum,@challno,@oldamt,@newamt,@tranamt,@neid,@fbit,@fbit,@tm,@dt,@uid,@schid)";
                cmd.Parameters.AddWithValue("@accnum",accnum);
                cmd.Parameters.AddWithValue("@challno",challan);
                cmd.Parameters.AddWithValue("@oldamt", oldamt);
                cmd.Parameters.AddWithValue("@newamt", newamt);
                cmd.Parameters.AddWithValue("@tranamt",tranamt);
                cmd.Parameters.AddWithValue("@neid",neid);
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@tm",DATE_FORMAT.time());
                cmd.Parameters.AddWithValue("@dt",DATE_FORMAT.format());
                cmd.Parameters.AddWithValue("@uid",Session["uid"].ToString());
                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"].ToString());
                cmd.ExecuteNonQuery();

                con.Close();    
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Error')", true);
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                    cmd.Parameters.Clear();
                    cmd.Dispose();
                }
            }
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
        protected void btngo_Click(object sender, EventArgs e)
        {
            mvsub.ActiveViewIndex = 1;
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            mvsub.ActiveViewIndex = 2;
        }

        protected void btndel_Click(object sender, EventArgs e)
        {
            //try
            //{
              
            //    string bit = "True";
            //    GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            //    // Label nfr_id=(Label)gvr.FindControl()
            //    string del = gvr.Cells[1].Text;
            //    con.Open();
            //    cmd.Connection = con;
            //    cmd.CommandType = CommandType.Text;
            //    cmd.CommandText = "update tbl_RecieveFee set dtDeleteDate=@date, bisDeleted=@bit where nfr_id='" + del + "' and nsch_id='" + Session["nschoolid"] + "'";
            //    cmd.Parameters.AddWithValue("@bit", bit);
            //    cmd.Parameters.AddWithValue("@date", dtdate);
            //    cmd.ExecuteNonQuery();
            //    con.Close();
            //    PopulateData();
            //    mvsub.ActiveViewIndex = 0;
            //}
            //catch (Exception ex)
            //{
            //    Response.Redirect("Error.aspx");
            //}
            //finally
            //{
            //    if (con.State == ConnectionState.Open)
            //    {
            //        con.Close();
            //    }
            //}
        }

        protected void txtstnum_TextChanged(object sender, EventArgs e)
        {
            //string regfee = "", genfee = "", flderfee = "",examfee="",bookfee="",statfee="" ;
            //try
            //{
            //    con.Open();
            //    cmd.Connection = con;
            //    cmd.CommandType = CommandType.Text;
            //    cmd.CommandText = "select e.strLname,c.strClass,s.strSection,f.strTutionFee,f.dtDueDate,f.nFine,f.strRegFee,f.strFolderFee,f.strGeneratorFee,f.strBookFee,f.strStationaryFee,f.strAnnualExamFee from tbl_Enrollment e inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Section s on e.nsc_id=s.nsc_id inner join tbl_Fee f on e.nfee_id=f.nfee_id where e.strStudentNum='" + txtstnum.Text + "' and e.bisDeleted='False' and e.nsch_id='" + Session["nschoolid"] + "'";
            //    dr = cmd.ExecuteReader();
            //    if (dr.Read())
            //    {

            //       // regfee = dr["strRegFee"].ToString();
            //        genfee = dr["strGeneratorFee"].ToString();
            //        flderfee = dr["strFolderFee"].ToString();
            //       // examfee = dr["strAnnualExamFee"].ToString();
            //       // bookfee = dr["strBookFee"].ToString();
            //        statfee = dr["strStationaryFee"].ToString();

            //        txtnm.Text = dr["strLname"].ToString();
            //        txtDueDate.Text = dr["dtDueDate"].ToString();
            //        txtFine.Text = dr["nFine"].ToString();
            //        txtfee.Text = dr["strTutionFee"].ToString();
            //        txtgenfee.Text = genfee;
            //        txtstatfee.Text = statfee;
            //        txtflderfee.Text = flderfee;
            //    }
            //    else
            //    {

            //    }
            //    con.Close();
            //}
            //catch (Exception ex)
            //{
            //    Response.Redirect("Error.aspx");
            //}
            //finally
            //{
            //    if (con.State == ConnectionState.Open)
            //    {
            //        con.Close();
            //    }
            //}
        }

        protected void btnrcv_Click(object sender, EventArgs e)
        {
           
            string bit = "False";
            List<string> things = new List<string>();
            string mmm = "";
            Boolean mmflag = true;
            if (chkmonth.Checked)
            {



            }
            Boolean flagfiner = true,upflag=true;


            if (ddcl.SelectedIndex != 0 && ddsec.SelectedIndex != 0 && ddst.SelectedIndex != 0 && txtTotfee.Text != "")
            {
                try
                {
                    if (chkmonth.Checked)
                    {
                        int i = 0, inv = 0;
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "Select Max(nChallanNum) as num from tbl_RecieveFee ";
                        dr = cmd.ExecuteReader();
                        if (dr.Read())
                        {
                            inv = Convert.ToInt32(dr["num"].ToString()) + 1;
                        }

                        con.Close();
                        foreach (ListItem item in monthlist.Items)
                        {
                            if (item.Selected)
                            {
                                //things.Add(item.Value);




                                string mmid = item.Value;
                                string mm1 = item.Text;
                                int dashemm = mm1.IndexOf('-');
                                string mm2 = mm1.Substring(dashemm + 1, mm1.Length - (dashemm + 1));

                                string mm = mm2;
                                string yy = DateTime.Now.Year.ToString();
                                string dd = DateTime.Now.ToString("dd");

                                string monthfee = dd.Trim() + "-" + mm.Trim() + "-" + yy.Trim();
                                con.Open();
                                cmd.Connection = con;
                                cmd.CommandType = CommandType.Text;
                                string stnumid = ddst.SelectedValue;
                                int dashe = stnumid.IndexOf('_');
                                string neid = stnumid.Substring(dashe + 1, stnumid.Length - (dashe + 1));
                                //cmd.CommandText = "select * from tbl_RecieveFee where strRecieveType='Class' and  ne_id=(select ne_id from tbl_Enrollment where strStudentNum='" + txtstnum.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted=0) and DATEPART(m,dtAddDate)=DATEPART(m,convert(date,SYSDATETIME()))  and bisDeleted='False'";
                                cmd.CommandText = "select * from tbl_RecieveFee where   ne_id='" + neid + "' and SUBSTRING(strFeeMonth ,4,2)=@m" + i.ToString() + " and SUBSTRING(strFeeMonth ,7,10)=SUBSTRING(@date" + i.ToString() + ",7,10)  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                                cmd.Parameters.AddWithValue("@m" + i.ToString(), mm);

                                cmd.Parameters.AddWithValue("@date" + i.ToString(), dtdate);
                                dr = cmd.ExecuteReader();
                                if (dr.HasRows)
                                {
                                    con.Close();
                                    //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Fee Received already exist.');", true);
                                }
                                else
                                {




                                    con.Close();
                                    /// int inv=0;
                                    if (mmflag)
                                    {

                                        foreach (ListItem mm3 in monthlist.Items)
                                        {
                                            if (mm3.Selected)
                                            {
                                                mmm += mm3.Text + "-";
                                            }
                                        }
                                        mmm.Remove(mmm.Length - 2);
                                        mmflag = false;
                                    }
                                    con.Open();
                                    cmd.Connection = con;
                                    cmd.CommandType = CommandType.Text;
                                    if (txtfeecons.Text == "" && !chkfeecons.Checked)
                                        txtfeecons.Text = "nill";

                                    //cmd.CommandText = "insert into tbl_RecieveFee(ne_id,nu_id,nsch_id,strFeeAmount,strFeeAmountReceived,strFeeAmountRemaining,strFeeConcession,strRecieveType,dtAddDate,bisDeleted) values ((select ne_id from tbl_Enrollment where strStudentNum='" + txtstnum.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted=0),'" + Session["uid"] + "','" + Session["nschoolid"] + "',@famnt,'" + txtRcvfee.Text + "' ,'" + txtRemnfee.Text + "','" + txtfeecons.Text + "','Class',convert(date,SYSDATETIME()),'False')";
                                    cmd.CommandText = "insert into tbl_RecieveFee(strMonths,nChallanNum,nMonth_id,strFeeMonth,bisPaid,nc_id,nsc_id,ne_id,nu_id,nsch_id,strFeeAmount,strFeeAmountReceived,strFeeAmountRemaining,strFeeConcession,strRecieveType,dtAddDate,bisDeleted) values (@mm2" + i.ToString() + ",@ivc" + i.ToString() + ",@mid" + i.ToString() + ",@mm" + i.ToString() + ",0,'" + ddcl.SelectedValue + "','" + ddsec.SelectedValue + "','" + neid + "','" + Session["uid"] + "','" + Session["nschoolid"] + "',@famnt" + i.ToString() + ",'" + txtRcvfee.Text + "' ,'" + txtRemnfee.Text + "','" + txtfeecons.Text + "','Class',@date2" + i.ToString() + ",@bit2" + i.ToString() + ")";
                                    cmd.Parameters.AddWithValue("@famnt" + i.ToString(), txtfee.Text);
                                    cmd.Parameters.AddWithValue("@mm" + i.ToString(), monthfee);
                                    cmd.Parameters.AddWithValue("@mm2" + i.ToString(), mmm);
                                    cmd.Parameters.AddWithValue("@mid" + i.ToString(), mmid);
                                    cmd.Parameters.AddWithValue("@ivc" + i.ToString(), inv);
                                    cmd.Parameters.AddWithValue("@bit2" + i.ToString(), bit);
                                    cmd.Parameters.AddWithValue("@date2" + i.ToString(), dtdate);
                                    cmd.ExecuteNonQuery();
                                    con.Close();
                                    int amount = 0;
                                    int total = 0;
                                    if (upflag)
                                    {
                                        upflag = false;
                                        con.Open();
                                        cmd.Connection = con;
                                        cmd.CommandType = CommandType.Text;
                                        cmd.CommandText = "select strAmount from tbl_Bank where strAccNum='" + ddacnum.SelectedValue + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
                                        dr = cmd.ExecuteReader();
                                        if (dr.Read())
                                        {
                                            amount = Convert.ToInt32(dr["strAmount"].ToString());
                                        }
                                        // total = amount + Convert.ToInt32(txtfee.Text) + Convert.ToInt32(txtFine.Text) - Convert.ToInt32(txtRemnfee.Text);
                                        total = amount + Convert.ToInt32(txtTotfee.Text) - Convert.ToInt32(txtRemnfee.Text);

                                        con.Close();
                                        con.Open();
                                        cmd.Connection = con;
                                        cmd.CommandType = CommandType.Text;
                                        cmd.CommandText = "update tbl_Bank set strAmount=@amnt" + i.ToString() + " where strAccNum='" + ddacnum.Text + "'  and nsch_id='" + Session["nschoolid"] + "'";
                                        cmd.Parameters.AddWithValue("@amnt" + i.ToString(), total);
                                        cmd.ExecuteNonQuery();
                                        con.Close();

                                        AdminFunctions add = new AdminFunctions();
                                        add.challanTransferRecordWith_False_Bit(inv.ToString(), ddacnum.SelectedValue, amount.ToString(), total.ToString(), (Convert.ToInt32(txtTotfee.Text) - Convert.ToInt32(txtRemnfee.Text)).ToString(), neid, Session["uid"].ToString(), Session["nschoolid"].ToString());
                                    }
                                    PopulateData();
                                    //////////////////////////////////////////
                                    lblbnk1.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;
                                    lblbnk2.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;
                                    lblbnk3.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;

                                    tststInvc.Text = inv.ToString();
                                    txtinv1.Text = inv.ToString();
                                    lblchallan2.Text = inv.ToString();
                                    lblchallan3.Text = inv.ToString();

                                    date.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                                    txtdate1.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                                    lblissuedt2.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                                    lblissuedt3.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

                                    duedate.Text = txtDueDate.Text;
                                    lblduedt1.Text = txtDueDate.Text;
                                    lblduedt2.Text = txtDueDate.Text;
                                    lblduedt3.Text = txtDueDate.Text;

                                    txtstName.Text = ddst.SelectedItem.ToString();
                                    txtname1.Text = ddst.SelectedItem.ToString();
                                    lblstnm2.Text = ddst.SelectedItem.ToString();
                                    lblstnm3.Text = ddst.SelectedItem.ToString();

                                    txtstClass.Text = ddcl.SelectedItem.ToString();
                                    txtcls1.Text = ddcl.SelectedItem.ToString();
                                    lblcls2.Text = ddcl.SelectedItem.ToString();
                                    lblcl3.Text = ddcl.SelectedItem.ToString();

                                    txtstSec.Text = ddsec.SelectedItem.ToString();
                                    txtsec1.Text = ddsec.SelectedItem.ToString();
                                    lblsec2.Text = ddsec.SelectedItem.ToString();
                                    lblsec3.Text = ddsec.SelectedItem.ToString();

                                    txtstRoll.Text = txtstnum.Text;
                                    txtreg1.Text = txtstnum.Text;
                                    lbladm2.Text = txtstnum.Text;
                                    lbladmnum3.Text = txtstnum.Text;

                                    txtstFee.Text = txtfee.Text;
                                    txtstFee1.Text = txtfee.Text;
                                    lblfee2.Text = txtfee.Text;
                                    lblfee3.Text = txtfee.Text;
                                    ////////////////////////////MONTH///
                                    txtmonths.Text += item.Text + ",";
                                    lblfeemonth.Text += item.Text + ",";
                                    lblfeebillmnth2.Text += item.Text + ",";
                                    lblbilmnth3.Text += item.Text + ",";
                                    ////////////////////////////MONTH///
                                    txtstFine.Text = txtFine.Text;
                                    //txtstFine1.Text = txtFine.Text;
                                    //lblfine2.Text = txtFine.Text;
                                    //lblfeefine3.Text = txtFine.Text;
                                    //if (flagfiner)
                                    //{
                                    //    
                                    //    flagfiner = false;
                                    //    txtRemnfee.Text = "0";
                                    //}
                                    txtstRemainingFee.Text = txtRemnfee.Text;
                                    lblrem1.Text = txtRemnfee.Text;
                                    lblfeerem3.Text = txtRemnfee.Text;
                                    lblfine2.Text = txtRemnfee.Text;

                                    //txtstConc.Text = txtfeecons.Text;
                                    //txtstConc1.Text = txtfeecons.Text;
                                    //txtstConc2.Text = txtfeecons.Text;
                                    //txtstConc3.Text = txtfeecons.Text;
                                    int totalpbdd = Convert.ToInt32(txtRcvfee.Text) + Convert.ToInt32(txtRemnfee.Text);
                                    txtstRcvFee.Text = totalpbdd.ToString();
                                    lblpbddt1.Text = totalpbdd.ToString();
                                    lblpbddt2.Text = totalpbdd.ToString();
                                    lblpbddt3.Text = totalpbdd.ToString();

                                    int totrcvfee = Convert.ToInt32(txtRcvfee.Text) + Convert.ToInt32(lblfeefine3.Text) + Convert.ToInt32(txtRemnfee.Text);

                                    txtstTOTFee.Text = totrcvfee.ToString();
                                    lblpaddt.Text = totrcvfee.ToString();
                                    lblpaddt2.Text = totrcvfee.ToString();
                                    lblpaddt3.Text = totrcvfee.ToString();




                                    txtstTOTRcvfee.Text = txtRcvfee.Text;
                                    //txtstTOTRcvfee1.Text = txtRcvfee.Text;
                                    //txtstTOTRcvfee2.Text = txtRcvfee.Text;
                                    //txtstTOTRcvfee3.Text = txtRcvfee.Text;

                                    string words1 = NumberToWords(Convert.ToInt64(lblpbddt1.Text));
                                    lbltotfeeinwords1.Text = words1;

                                    string words2 = NumberToWords(Convert.ToInt64(lblpbddt2.Text));
                                    lbltotfeeinwords2.Text = words2;

                                    string words3 = NumberToWords(Convert.ToInt64(lblpbddt3.Text));
                                    lbltotfeeinwords3.Text = words3;
                                    mvsub.ActiveViewIndex = 4;
                                }

                                i++;

                            }

                        }

                    }
                    else
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
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;







                        string stnumid = ddst.SelectedValue;
                        int dashe = stnumid.IndexOf('_');
                        string neid = stnumid.Substring(dashe + 1, stnumid.Length - (dashe + 1));
                        //cmd.CommandText = "select * from tbl_RecieveFee where strRecieveType='Class' and  ne_id=(select ne_id from tbl_Enrollment where strStudentNum='" + txtstnum.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted=0) and DATEPART(m,dtAddDate)=DATEPART(m,convert(date,SYSDATETIME()))  and bisDeleted='False'";
                        //cmd.CommandText = "select * from tbl_RecieveFee where strRecieveType='Class' and  ne_id='" + neid + "' and DATEPART(m,dtAddDate)=DATEPART(m,convert(date,SYSDATETIME())) and DATEPART(yyyy,dtAddDate)=DATEPART(yyyy,convert(date,SYSDATETIME()))  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                        cmd.CommandText = "select * from tbl_RecieveFee where   ne_id='" + neid + "' and SUBSTRING(strFeeMonth ,4,2)=SUBSTRING(@date3,4,2) and SUBSTRING(strFeeMonth ,7,10)=SUBSTRING(@date3 ,7,10)  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                        cmd.Parameters.AddWithValue("@date3", dtdate);
                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            con.Close();
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Fee Received already exist.');", true);
                        }
                        else
                        {
                            con.Close();
                            int inv = 0;
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
                            if (txtfeecons.Text == "" && !chkfeecons.Checked)
                                txtfeecons.Text = "nill";
                            string mmm2 = DateTime.Now.ToString("MMM");
                            //cmd.CommandText = "insert into tbl_RecieveFee(ne_id,nu_id,nsch_id,strFeeAmount,strFeeAmountReceived,strFeeAmountRemaining,strFeeConcession,strRecieveType,dtAddDate,bisDeleted) values ((select ne_id from tbl_Enrollment where strStudentNum='" + txtstnum.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted=0),'" + Session["uid"] + "','" + Session["nschoolid"] + "',@famnt,'" + txtRcvfee.Text + "' ,'" + txtRemnfee.Text + "','" + txtfeecons.Text + "','Class',convert(date,SYSDATETIME()),'False')";
                            //last change cmd.CommandText = "insert into tbl_RecieveFee(bisPaid,nc_id,nsc_id,ne_id,nu_id,nsch_id,strFeeAmount,strFeeAmountReceived,strFeeAmountRemaining,strFeeConcession,strRecieveType,dtAddDate,bisDeleted) values (0,'" + ddcl.SelectedValue + "','" + ddsec.SelectedValue + "','" + neid + "','" + Session["uid"] + "','" + Session["nschoolid"] + "',@famnt,'" + txtRcvfee.Text + "' ,'" + txtRemnfee.Text + "','" + txtfeecons.Text + "','Class',convert(date,SYSDATETIME()),'False')";
                            //last change cmd.Parameters.AddWithValue("@famnt", txtfee.Text);
                            cmd.CommandText = "insert into tbl_RecieveFee(strMonths,nChallanNum,nMonth_id,strFeeMonth,bisPaid,nc_id,nsc_id,ne_id,nu_id,nsch_id,strFeeAmount,strFeeAmountReceived,strFeeAmountRemaining,strFeeConcession,strRecieveType,dtAddDate,bisDeleted) values (@mm,@inv1,@mid,@date4,0,'" + ddcl.SelectedValue + "','" + ddsec.SelectedValue + "','" + neid + "','" + Session["uid"] + "','" + Session["nschoolid"] + "',@famnt,'" + txtRcvfee.Text + "' ,'" + txtRemnfee.Text + "','" + txtfeecons.Text + "','Class',@date4,'False')";
                            cmd.Parameters.AddWithValue("@famnt", txtfee.Text);
                            cmd.Parameters.AddWithValue("@mm", mmm2);
                            cmd.Parameters.AddWithValue("@mid", mid);
                            cmd.Parameters.AddWithValue("@inv1", inv);

                            cmd.Parameters.AddWithValue("@date4", dtdate);
                            cmd.ExecuteNonQuery();
                            con.Close();
                            int amount = 0;
                            int total = 0;
                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "select strAmount from tbl_Bank where strAccNum='" + ddacnum.Text + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
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
                            cmd.CommandText = "update tbl_Bank set strAmount=@amnt where strAccNum='" + ddacnum.Text + "'  and nsch_id='" + Session["nschoolid"] + "'";
                            cmd.Parameters.AddWithValue("@amnt", total);
                            cmd.ExecuteNonQuery();
                            con.Close();
                            ///////////////////////////////////////

                            AdminFunctions add = new AdminFunctions();
                            add.challanTransferRecordWith_False_Bit(inv.ToString(), ddacnum.SelectedValue, amount.ToString(), total.ToString(), (Convert.ToInt32(txtTotfee.Text) - Convert.ToInt32(txtRemnfee.Text)).ToString(), neid, Session["uid"].ToString(), Session["nschoolid"].ToString());

                            ///////////////////////////////////////
                            PopulateData();
                            //////////////////////////////////////////

                            lblbnk1.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;
                            lblbnk2.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;
                            lblbnk3.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;

                            tststInvc.Text = inv.ToString();
                            txtinv1.Text = inv.ToString();
                            lblchallan2.Text = inv.ToString();
                            lblchallan3.Text = inv.ToString();

                            date.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                            txtdate1.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                            lblissuedt2.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                            lblissuedt3.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

                            duedate.Text = txtDueDate.Text;
                            lblduedt1.Text = txtDueDate.Text;
                            lblduedt2.Text = txtDueDate.Text;
                            lblduedt3.Text = txtDueDate.Text;

                            txtstName.Text = ddst.SelectedItem.ToString();
                            txtname1.Text = ddst.SelectedItem.ToString();
                            lblstnm2.Text = ddst.SelectedItem.ToString();
                            lblstnm3.Text = ddst.SelectedItem.ToString();

                            txtstClass.Text = ddcl.SelectedItem.ToString();
                            txtcls1.Text = ddcl.SelectedItem.ToString();
                            lblcls2.Text = ddcl.SelectedItem.ToString();
                            lblcl3.Text = ddcl.SelectedItem.ToString();

                            txtstSec.Text = ddsec.SelectedItem.ToString();
                            txtsec1.Text = ddsec.SelectedItem.ToString();
                            lblsec2.Text = ddsec.SelectedItem.ToString();
                            lblsec3.Text = ddsec.SelectedItem.ToString();

                            txtstRoll.Text = txtstnum.Text;
                            txtreg1.Text = txtstnum.Text;
                            lbladm2.Text = txtstnum.Text;
                            lbladmnum3.Text = txtstnum.Text;

                            txtstFee.Text = txtfee.Text;
                            txtstFee1.Text = txtfee.Text;
                            lblfee2.Text = txtfee.Text;
                            lblfee3.Text = txtfee.Text;
                            ////////////////////////////MONTH///
                            txtmonths.Text = DateTime.Now.ToString("MMM");
                            lblfeemonth.Text = DateTime.Now.ToString("MMM");
                            lblfeebillmnth2.Text = DateTime.Now.ToString("MMM");
                            lblbilmnth3.Text = DateTime.Now.ToString("MMM");
                            ////////////////////////////MONTH///
                            txtstFine.Text = txtFine.Text;
                            //txtstFine1.Text = txtFine.Text;
                            //lblfine2.Text = txtFine.Text;
                            //lblfeefine3.Text = txtFine.Text;
                            //if (flagfiner)
                            //{
                            //    
                            //    flagfiner = false;
                            //    txtRemnfee.Text = "0";
                            //}
                            txtstRemainingFee.Text = txtRemnfee.Text;
                            lblrem1.Text = txtRemnfee.Text;
                            lblfeerem3.Text = txtRemnfee.Text;
                            lblfine2.Text = txtRemnfee.Text;

                            //txtstConc.Text = txtfeecons.Text;
                            //txtstConc1.Text = txtfeecons.Text;
                            //txtstConc2.Text = txtfeecons.Text;
                            //txtstConc3.Text = txtfeecons.Text;

                            int totalpbdd = Convert.ToInt32(txtRcvfee.Text) + Convert.ToInt32(txtRemnfee.Text);
                            txtstRcvFee.Text = totalpbdd.ToString();
                            lblpbddt1.Text = totalpbdd.ToString();
                            lblpbddt2.Text = totalpbdd.ToString();
                            lblpbddt3.Text = totalpbdd.ToString();

                            int totrcvfee = Convert.ToInt32(txtRcvfee.Text) + Convert.ToInt32(lblfeefine3.Text) + Convert.ToInt32(txtRemnfee.Text);

                            txtstTOTFee.Text = totrcvfee.ToString();
                            lblpaddt.Text = totrcvfee.ToString();
                            lblpaddt2.Text = totrcvfee.ToString();
                            lblpaddt3.Text = totrcvfee.ToString();





                            txtstTOTRcvfee.Text = txtRcvfee.Text;
                            //txtstTOTRcvfee1.Text = txtRcvfee.Text;
                            //txtstTOTRcvfee2.Text = txtRcvfee.Text;
                            //txtstTOTRcvfee3.Text = txtRcvfee.Text;

                            string words1 = NumberToWords(Convert.ToInt64(lblpbddt1.Text));
                            lbltotfeeinwords1.Text = words1;

                            string words2 = NumberToWords(Convert.ToInt64(lblpbddt2.Text));
                            lbltotfeeinwords2.Text = words2;

                            string words3 = NumberToWords(Convert.ToInt64(lblpbddt3.Text));
                            lbltotfeeinwords3.Text = words3;

                            mvsub.ActiveViewIndex = 4;

                        }
                    }

                    {

                        Session["SKU"] = txtinv1.Text;
                      
                        printbarcode();

                        Session.Remove("SKU");
                     

                       // ScriptManager.RegisterStartupScript(this, GetType(), "barcode", "document.getElementById('stdbarcode').innerHTML = 'AdminPrintBarCodes.aspx?val=" + Session["SKU"] + "&size=" + Session["size"] + "';", true);
                    }


                    //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "", true);
                }
                catch (Exception)
                {
                    Response.Redirect("Error.aspx?msg=AdminDirectRecievingFee.aspx");
                }
                finally
                {
                    if (con.State == ConnectionState.Open)
                    {
                        con.Close();
                    }
                }
            }

            else
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('All Feilds Required.');", true);
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {

        }
        private DataTable GetRecords()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select rf.nfr_id,rf.strFeeMonth,rf.strFeeAmount,e.strFname+' '+e.strLname as strname,c.strClass,s.strSection,rf.dtAddDate from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Section s on e.nsc_id=s.nsc_id where rf.strRecieveType='Class' and rf.bisDeleted='False' and rf.nsch_id='" + Session["nschoolid"] + "'";
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
        private void PopulateData()
        {
            try
            {
                DataTable table = new DataTable();

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString()))
                {

                    string sql = "select rf.nfr_id,rf.strFeeMonth,rf.strFeeAmount,e.strFname+' '+e.strLname as strname,c.strClass,s.strSection,rf.dtAddDate from tbl_RecieveFee rf inner join tbl_Enrollment e on rf.ne_id=e.ne_id inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Section s on e.nsc_id=s.nsc_id where rf.strRecieveType='Class' and rf.bisDeleted='False' and rf.nsch_id='" + Session["nschoolid"] + "'";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {

                        using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                        {

                            ad.Fill(table);

                        }

                    }

                }

                gvfee.DataSource = table;

                gvfee.DataBind();
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
        /// <summary>
        /// ////////////////////////////BIND CLASS DD ////////////////////////////
        /// </summary>
        public void Bind_ddlClass()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT [strClass],nc_id FROM [tbl_Class] WHERE ([bisDeleted] = 0) and nsch_id='" + Session["nschoolid"] + "'", con);
                SqlDataReader dr = cmd.ExecuteReader();

                ddcl.Items.Clear();
                ddcl.Items.Add("--Please Select Class--");
                ddcl.DataSource = dr;
                ddcl.DataTextField = "strClass";
                ddcl.DataValueField = "nc_id";
                ddcl.DataBind();
                con.Close();
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

        public void Bind_ddlSection()
        {
            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT [strSection],[nsc_id] FROM [tbl_Section] WHERE [nc_id] ='" + ddcl.SelectedValue + "'  AND [bisDeleted] = 0 and nsch_id='" + Session["nschoolid"] + "'", con);

                SqlDataReader dr = cmd.ExecuteReader();
                ddsec.DataSource = dr;
                ddsec.Items.Clear();
                ddsec.Items.Add("--Please Select Section--");
                ddsec.DataTextField = "strSection";
                ddsec.DataValueField = "nsc_id";
                ddsec.DataBind();
                con.Close();
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

        public void Bind_ddlStudent()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT [strFname]+' '+[strlname] as name, [strStudentNum]+'-'+CAST(bRegisteredNum as VARCHAR(MAX))+'_'+CAST(ne_id as VARCHAR(MAX)) as stnum FROM [tbl_Enrollment] WHERE (([nc_id] =  '" + ddcl.SelectedValue + "' ) AND ([nsc_id] ='" + Convert.ToInt32(ddsec.SelectedValue) + "')  AND ([bisDeleted] =0) and nsch_id='" + Session["nschoolid"] + "')", con);

                SqlDataReader dr = cmd.ExecuteReader();

                ddst.Items.Clear();
                ddst.Items.Add("--Please Select students--");
                ddst.DataSource = dr;
                ddst.DataTextField = "name";
                ddst.DataValueField = "stnum";
                ddst.DataBind();
                con.Close();
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

        protected void ddcl_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddcl.SelectedIndex != 0)
                Bind_ddlSection();
        }

        protected void ddsec_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddsec.SelectedIndex != 0)
                Bind_ddlStudent();
        }

        protected void ddst_SelectedIndexChanged(object sender, EventArgs e)
        {

            //string regfee = "", genfee = "", flderfee = "", examfee = "", bookfee = "", statfee = "";
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
                string stnumid = ddst.SelectedValue;
                int dashe = stnumid.IndexOf('_');
                string neid = stnumid.Substring(dashe + 1, stnumid.Length - (dashe + 1));
                lstpaidmonth.Items.Clear();
                lblneidd.Text = neid;
                Paidmonths.DataBind();
                string stnumber = stnumid.Substring(0, dashe);
                txtstnum.Text = stnumber;
                cmd.CommandText = "select u.strfname+' '+u.strlname as fathername,e.bRegisteredNum, e.strLname,c.strClass,s.strSection,f.strTutionFee,f.dtDueDate,f.nFine,f.strRegFee,f.strFolderFee,f.strGeneratorFee,f.strBookFee,f.strStationaryFee,f.strAnnualExamFee from tbl_Enrollment e inner join tbl_Users u on e.nu_id=u.nu_id inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Section s on e.nsc_id=s.nsc_id inner join tbl_Fee f on e.nfee_id=f.nfee_id where e.ne_id='" + neid + "' and e.bisDeleted='False' and e.nsch_id='" + Session["nschoolid"] + "'";
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtnm.Text = dr["strLname"].ToString();
                    txtDueDate.Text = dr["dtDueDate"].ToString();
                    txtfname1.Text = dr["fathername"].ToString();
                    lblfnm2.Text = dr["fathername"].ToString();
                    lblfnm3.Text = dr["fathername"].ToString();
                   // genfee = dr["strGeneratorFee"].ToString();
                   // flderfee = dr["strFolderFee"].ToString();
                    txtstFine1.Text = dr["nFine"].ToString();
                    lbllatefine2.Text = dr["nFine"].ToString();
                    lblfeefine3.Text = dr["nFine"].ToString();
                    txtstnum.Text = dr["bRegisteredNum"].ToString();
                   // statfee = dr["strStationaryFee"].ToString();

                    if (txtDueDate.Text != "")
                    {
                        if (Convert.ToInt32(DateTime.Now.Day.ToString()) > Convert.ToInt32(txtDueDate.Text))
                        {
                            int today = Convert.ToInt32(DateTime.Now.Day.ToString());
                            int dueday = Convert.ToInt32(txtDueDate.Text);
                            int numofdays = today - dueday;
                            Int64 totfine = Convert.ToInt64(dr["nFine"].ToString());
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
                cmd.CommandText = "Select strFeeAmountRemaining from tbl_RecieveFee where nfr_id=(select Max(nfr_id) from tbl_RecieveFee where ne_id='" + neid + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "')and   bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
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

                    chkfeecons.Checked = true;
                    txtfeecons.Text = concessionamount.ToString();
                    txtfee.Text = totfeee.ToString();

                }
                con.Close();
                Int64 totfeeofmonths = 0;
                int mmcounter = 0;
                Boolean flagmm = false;
                //foreach (ListItem item in monthlist.Items)
                //{
                //    if (item.Selected)
                //    {

                //        flagmm = true;

                //        mmcounter++;
                //    }
                //}
                //if (flagmm)
                //{
                //    totfeeofmonths = Convert.ToInt64(mmcounter) * Convert.ToInt64(txtfee.Text);

                //    Int64 tot1Amount = Convert.ToInt64(txtRemnfee.Text) + totfeeofmonths + Convert.ToInt64(txtFine.Text);
                //    txtTotfee.Text = tot1Amount.ToString();

                //}
                //else
                //{
                //    Int64 tot1Amount = Convert.ToInt64(txtRemnfee.Text) + Convert.ToInt64(txtfee.Text) + Convert.ToInt64(txtFine.Text);
                //    txtTotfee.Text = tot1Amount.ToString();
                //}
                {
                    if (txtflderfee.Text == "") txtflderfee.Text = "0";
                    if (txtstatfee.Text == "") txtstatfee.Text = "0";
                   // if (txt == "") txtstatfee.Text = "0";
                    Int64 tot1Amount = Convert.ToInt64(txtRemnfee.Text) + Convert.ToInt64(txtfee.Text) + Convert.ToInt64(txtFine.Text);
                    txtTotfee.Text = tot1Amount.ToString();
                }
            }
            catch (Exception)
            {
                Response.Redirect("Error.aspx?msg=AdminDirectRecievingFee.aspx");
            }
            txtRcvfee.Focus();
        }

        protected void txtRcvfee_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (txtRcvfee.Text != "")
                {
                    if (Convert.ToInt64(txtRcvfee.Text) <= Convert.ToInt64(txtTotfee.Text))
                    {
                        if (txtRemnfee.Text != "" && txtTotfee.Text != "")
                        {
                            Int64 remainfee = Convert.ToInt64(txtTotfee.Text) - Convert.ToInt64(txtRcvfee.Text);
                            txtRemnfee.Text = remainfee.ToString();
                        }
                    }
                }
            }
            catch (Exception) { }
            btnrcv.Focus();
        }

        protected void chkfeecons_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                if (chkfeecons.Checked)
                {
                    txtfeecons.Visible = true;
                    txtfeecons.Focus();
                }
                else
                {
                    txtfeecons.Visible = false;
                    txtRcvfee.Focus();
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }

        }

        protected void txtfeecons_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (txtfeecons.Text != "")
                {
                    if (chkfeecons.Checked)
                    {
                        if (Convert.ToInt64(txtfeecons.Text) <= Convert.ToInt64(txtTotfee.Text))
                        {
                            if (txtTotfee.Text != "")
                            {
                                Int64 remainfee = Convert.ToInt64(txtTotfee.Text) - Convert.ToInt64(txtfeecons.Text);
                                txtTotfee.Text = remainfee.ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception) { }
            txtRcvfee.Focus();
        }

        protected void gvfee_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvfee.PageIndex = e.NewPageIndex;
                PopulateData();
            }
            catch (Exception ex)
            {
                //Response.Redirect("Error.aspx");
            }

        }
        private DataTable GetRecords_std()
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
            con.Close();
            return objDs.Tables[0];

        }
        private void bindGrid_std()
        {
            try
            {
                DataTable dt = GetRecords_std();
                if (dt.Rows.Count > 0)
                {
                    gvtermstd.DataSource = dt;
                    gvtermstd.DataBind();
                    gvtermstd.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
            }
            catch (Exception) { }
        }
        private DataTable GetRecords_sch()
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
            con.Close();
            return objDs.Tables[0];

        }
        private void bindGrid_sch()
        {
            try
            {
                DataTable dt = GetRecords_sch();
                if (dt.Rows.Count > 0)
                {
                    gvtermsch.DataSource = dt;
                    gvtermsch.DataBind();
                    gvtermsch.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
            }
            catch (Exception) { }
        }
        private DataTable GetRecords_bnk()
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
            con.Close();
            return objDs.Tables[0];

        }
        private void bindGrid_bnk()
        {
            try
            {
                DataTable dt = GetRecords_bnk();
                if (dt.Rows.Count > 0)
                {
                    gvtermbnk.DataSource = dt;
                    gvtermbnk.DataBind();
                    gvtermbnk.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
            }
            catch (Exception) { }
        }
        protected void btnPaid_Click(object sender, EventArgs e)
        {

            string bit = "False";
            List<string> things = new List<string>();
            string mmm = "";
            Boolean mmflag = true;
            if (chkmonth.Checked)
            {



            }
            Boolean flagfiner = true, upflag = true;


            if (ddcl.SelectedIndex != 0 && ddsec.SelectedIndex != 0 && ddst.SelectedIndex != 0 && txtTotfee.Text != "")
            {
                try
                {
                    if (chkmonth.Checked)
                    {
                        int i = 0, inv = 0;
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "Select Max(nChallanNum) as num from tbl_RecieveFee";
                        dr = cmd.ExecuteReader();
                        if (dr.Read())
                        {
                            inv = Convert.ToInt32(dr["num"].ToString()) + 1;
                        }

                        con.Close();
                        foreach (ListItem item in monthlist.Items)
                        {
                            if (item.Selected)
                            {
                                //things.Add(item.Value);




                                string mmid = item.Value;
                                string mm1 = item.Text;
                                int dashemm = mm1.IndexOf('-');
                                string mm2 = mm1.Substring(dashemm + 1, mm1.Length - (dashemm + 1));

                                string mm = mm2;
                                string yy = DateTime.Now.Year.ToString();
                                string dd = DateTime.Now.ToString("dd");

                                string monthfee = dd.Trim() + "-" + mm.Trim() + "-" + yy.Trim();
                                con.Open();
                                cmd.Connection = con;
                                cmd.CommandType = CommandType.Text;
                                string stnumid = ddst.SelectedValue;
                                int dashe = stnumid.IndexOf('_');
                                string neid = stnumid.Substring(dashe + 1, stnumid.Length - (dashe + 1));
                                //cmd.CommandText = "select * from tbl_RecieveFee where strRecieveType='Class' and  ne_id=(select ne_id from tbl_Enrollment where strStudentNum='" + txtstnum.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted=0) and DATEPART(m,dtAddDate)=DATEPART(m,convert(date,SYSDATETIME()))  and bisDeleted='False'";
                                cmd.CommandText = "select * from tbl_RecieveFee where   ne_id='" + neid + "' and SUBSTRING(strFeeMonth ,4,2)=@m" + i.ToString() + " and SUBSTRING(strFeeMonth ,7,10)=SUBSTRING(@date" + i.ToString() + ",7,10)  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                                cmd.Parameters.AddWithValue("@m" + i.ToString(), mm);

                                cmd.Parameters.AddWithValue("@date" + i.ToString(), dtdate);
                                dr = cmd.ExecuteReader();
                                if (dr.HasRows)
                                {
                                    con.Close();
                                    //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Fee Received already exist.');", true);
                                }
                                else
                                {




                                    con.Close();
                                    /// int inv=0;
                                    if (mmflag)
                                    {

                                        foreach (ListItem mm3 in monthlist.Items)
                                        {
                                            if (mm3.Selected)
                                            {
                                                mmm += mm3.Text + "-";
                                            }
                                        }
                                        mmm.Remove(mmm.Length - 2);
                                        mmflag = false;
                                    }
                                    con.Open();
                                    cmd.Connection = con;
                                    cmd.CommandType = CommandType.Text;
                                    if (txtfeecons.Text == "" && !chkfeecons.Checked)
                                        txtfeecons.Text = "nill";

                                    //cmd.CommandText = "insert into tbl_RecieveFee(ne_id,nu_id,nsch_id,strFeeAmount,strFeeAmountReceived,strFeeAmountRemaining,strFeeConcession,strRecieveType,dtAddDate,bisDeleted) values ((select ne_id from tbl_Enrollment where strStudentNum='" + txtstnum.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted=0),'" + Session["uid"] + "','" + Session["nschoolid"] + "',@famnt,'" + txtRcvfee.Text + "' ,'" + txtRemnfee.Text + "','" + txtfeecons.Text + "','Class',convert(date,SYSDATETIME()),'False')";
                                    cmd.CommandText = "insert into tbl_RecieveFee(strMonths,nChallanNum,nMonth_id,strFeeMonth,bisPaid,nc_id,nsc_id,ne_id,nu_id,nsch_id,strFeeAmount,strFeeAmountReceived,strFeeAmountRemaining,strFeeConcession,strRecieveType,dtAddDate,bisDeleted) values (@mm2" + i.ToString() + ",@ivc" + i.ToString() + ",@mid" + i.ToString() + ",@mm" + i.ToString() + ",1,'" + ddcl.SelectedValue + "','" + ddsec.SelectedValue + "','" + neid + "','" + Session["uid"] + "','" + Session["nschoolid"] + "',@famnt" + i.ToString() + ",'" + txtRcvfee.Text + "' ,'" + txtRemnfee.Text + "','" + txtfeecons.Text + "','Class',@date2" + i.ToString() + ",@bit2"+ i.ToString()+")";
                                    cmd.Parameters.AddWithValue("@famnt" + i.ToString(), txtfee.Text);
                                    cmd.Parameters.AddWithValue("@mm" + i.ToString(), monthfee);
                                    cmd.Parameters.AddWithValue("@mm2" + i.ToString(), mmm);
                                    cmd.Parameters.AddWithValue("@mid" + i.ToString(), mmid);
                                    cmd.Parameters.AddWithValue("@ivc" + i.ToString(), inv);
                                    cmd.Parameters.AddWithValue("@bit2"+ i.ToString(), bit);
                                    cmd.Parameters.AddWithValue("@date2" + i.ToString(), dtdate);
                                    cmd.ExecuteNonQuery();
                                    con.Close();
                                    int amount = 0;
                                    int total = 0;
                                    if (upflag)
                                    {
                                        upflag = false;
                                        con.Open();
                                        cmd.Connection = con;
                                        cmd.CommandType = CommandType.Text;
                                        cmd.CommandText = "select strAmount from tbl_Bank where strAccNum='" + ddacnum.SelectedValue + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
                                        dr = cmd.ExecuteReader();
                                        if (dr.Read())
                                        {
                                            amount = Convert.ToInt32(dr["strAmount"].ToString());
                                        }
                                        // total = amount + Convert.ToInt32(txtfee.Text) + Convert.ToInt32(txtFine.Text) - Convert.ToInt32(txtRemnfee.Text);
                                        total = amount + Convert.ToInt32(txtTotfee.Text) - Convert.ToInt32(txtRemnfee.Text);
                                        con.Close();
                                        con.Open();
                                        cmd.Connection = con;
                                        cmd.CommandType = CommandType.Text;
                                        cmd.CommandText = "update tbl_Bank set strAmount=@amnt" + i.ToString() + " where strAccNum='" + ddacnum.Text + "'  and nsch_id='" + Session["nschoolid"] + "'";
                                        cmd.Parameters.AddWithValue("@amnt" + i.ToString(), total);
                                        cmd.ExecuteNonQuery();
                                        con.Close();

                                        AdminFunctions add = new AdminFunctions();
                                        add.challanTransferRecordWith_True_Bit(inv.ToString(), ddacnum.SelectedValue, amount.ToString(), total.ToString(), (Convert.ToInt32(txtTotfee.Text) - Convert.ToInt32(txtRemnfee.Text)).ToString(), neid, Session["uid"].ToString(), Session["nschoolid"].ToString());
                                    }
                                    PopulateData();
                                    //////////////////////////////////////////

                                    lblbnk1.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;
                                    lblbnk2.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;
                                    lblbnk3.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;

                                    tststInvc.Text = inv.ToString();
                                    txtinv1.Text = inv.ToString();
                                    lblchallan2.Text = inv.ToString();
                                    lblchallan3.Text = inv.ToString();

                                    date.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                                    txtdate1.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                                    lblissuedt2.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                                    lblissuedt3.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

                                    duedate.Text = txtDueDate.Text;
                                    lblduedt1.Text = txtDueDate.Text;
                                    lblduedt2.Text = txtDueDate.Text;
                                    lblduedt3.Text = txtDueDate.Text;

                                    txtstName.Text = ddst.SelectedItem.ToString();
                                    txtname1.Text = ddst.SelectedItem.ToString();
                                    lblstnm2.Text = ddst.SelectedItem.ToString();
                                    lblstnm3.Text = ddst.SelectedItem.ToString();

                                    txtstClass.Text = ddcl.SelectedItem.ToString();
                                    txtcls1.Text = ddcl.SelectedItem.ToString();
                                    lblcls2.Text = ddcl.SelectedItem.ToString();
                                    lblcl3.Text = ddcl.SelectedItem.ToString();

                                    txtstSec.Text = ddsec.SelectedItem.ToString();
                                    txtsec1.Text = ddsec.SelectedItem.ToString();
                                    lblsec2.Text = ddsec.SelectedItem.ToString();
                                    lblsec3.Text = ddsec.SelectedItem.ToString();

                                    txtstRoll.Text = txtstnum.Text;
                                    txtreg1.Text = txtstnum.Text;
                                    lbladm2.Text = txtstnum.Text;
                                    lbladmnum3.Text = txtstnum.Text;

                                    txtstFee.Text = txtfee.Text;
                                    txtstFee1.Text = txtfee.Text;
                                    lblfee2.Text = txtfee.Text;
                                    lblfee3.Text = txtfee.Text;
                                    ////////////////////////////MONTH///
                                    txtmonths.Text += item.Text + ",";
                                    lblfeemonth.Text += item.Text + ",";
                                    lblfeebillmnth2.Text += item.Text + ",";
                                    lblbilmnth3.Text += item.Text + ",";
                                    ////////////////////////////MONTH///
                                    txtstFine.Text = txtFine.Text;
                                    //txtstFine1.Text = txtFine.Text;
                                    //lblfine2.Text = txtFine.Text;
                                    //lblfeefine3.Text = txtFine.Text;
                                    //if (flagfiner)
                                    //{
                                    //    
                                    //    flagfiner = false;
                                    //    txtRemnfee.Text = "0";
                                    //}
                                    txtstRemainingFee.Text = txtRemnfee.Text;
                                    lblrem1.Text = txtRemnfee.Text;
                                    lblfeerem3.Text = txtRemnfee.Text;
                                    lblfine2.Text = txtRemnfee.Text;

                                    //txtstConc.Text = txtfeecons.Text;
                                    //txtstConc1.Text = txtfeecons.Text;
                                    //txtstConc2.Text = txtfeecons.Text;
                                    //txtstConc3.Text = txtfeecons.Text;

                                    int totalpbdd = Convert.ToInt32(txtRcvfee.Text) + Convert.ToInt32(txtRemnfee.Text);
                                    txtstRcvFee.Text = totalpbdd.ToString();
                                    lblpbddt1.Text = totalpbdd.ToString();
                                    lblpbddt2.Text = totalpbdd.ToString();
                                    lblpbddt3.Text = totalpbdd.ToString();

                                    int totrcvfee = Convert.ToInt32(txtRcvfee.Text) + Convert.ToInt32(lblfeefine3.Text) + Convert.ToInt32(txtRemnfee.Text);

                                    txtstTOTFee.Text = totrcvfee.ToString();
                                    lblpaddt.Text = totrcvfee.ToString();
                                    lblpaddt2.Text = totrcvfee.ToString();
                                    lblpaddt3.Text = totrcvfee.ToString();





                                    txtstTOTRcvfee.Text = txtRcvfee.Text;
                                    //txtstTOTRcvfee1.Text = txtRcvfee.Text;
                                    //txtstTOTRcvfee2.Text = txtRcvfee.Text;
                                    //txtstTOTRcvfee3.Text = txtRcvfee.Text;
                                    string words1 = NumberToWords(Convert.ToInt64(lblpbddt1.Text));
                                    lbltotfeeinwords1.Text = words1;

                                    string words2 = NumberToWords(Convert.ToInt64(lblpbddt2.Text));
                                    lbltotfeeinwords2.Text = words2;

                                    string words3 = NumberToWords(Convert.ToInt64(lblpbddt3.Text));
                                    lbltotfeeinwords3.Text = words3;
                                    mvsub.ActiveViewIndex = 4;
                                }

                                i++;

                            }

                        }

                    }
                    else
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
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;







                        string stnumid = ddst.SelectedValue;
                        int dashe = stnumid.IndexOf('_');
                        string neid = stnumid.Substring(dashe + 1, stnumid.Length - (dashe + 1));
                        //cmd.CommandText = "select * from tbl_RecieveFee where strRecieveType='Class' and  ne_id=(select ne_id from tbl_Enrollment where strStudentNum='" + txtstnum.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted=0) and DATEPART(m,dtAddDate)=DATEPART(m,convert(date,SYSDATETIME()))  and bisDeleted='False'";
                        //cmd.CommandText = "select * from tbl_RecieveFee where strRecieveType='Class' and  ne_id='" + neid + "' and DATEPART(m,dtAddDate)=DATEPART(m,convert(date,SYSDATETIME())) and DATEPART(yyyy,dtAddDate)=DATEPART(yyyy,convert(date,SYSDATETIME()))  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                        cmd.CommandText = "select * from tbl_RecieveFee where   ne_id='" + neid + "' and SUBSTRING(strFeeMonth ,4,2)=SUBSTRING(@date3,4,2) and SUBSTRING(strFeeMonth ,7,10)=SUBSTRING(@date3,7,10)  and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                        cmd.Parameters.AddWithValue("@date3", dtdate);
                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            con.Close();
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Fee Received already exist.');", true);
                        }
                        else
                        {
                            con.Close();
                            int inv = 0;
                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "Select Max(nChallanNum) as num from tbl_RecieveFee";
                            dr = cmd.ExecuteReader();
                            if (dr.Read())
                            {
                                inv = Convert.ToInt32(dr["num"].ToString()) + 1;
                            }

                            con.Close();
                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            if (txtfeecons.Text == "" && !chkfeecons.Checked)
                                txtfeecons.Text = "nill";
                            string mmm2 = DateTime.Now.ToString("MMM");
                            //cmd.CommandText = "insert into tbl_RecieveFee(ne_id,nu_id,nsch_id,strFeeAmount,strFeeAmountReceived,strFeeAmountRemaining,strFeeConcession,strRecieveType,dtAddDate,bisDeleted) values ((select ne_id from tbl_Enrollment where strStudentNum='" + txtstnum.Text + "' and nsch_id='" + Session["nschoolid"] + "' and bisDeleted=0),'" + Session["uid"] + "','" + Session["nschoolid"] + "',@famnt,'" + txtRcvfee.Text + "' ,'" + txtRemnfee.Text + "','" + txtfeecons.Text + "','Class',convert(date,SYSDATETIME()),'False')";
                            //last change cmd.CommandText = "insert into tbl_RecieveFee(bisPaid,nc_id,nsc_id,ne_id,nu_id,nsch_id,strFeeAmount,strFeeAmountReceived,strFeeAmountRemaining,strFeeConcession,strRecieveType,dtAddDate,bisDeleted) values (0,'" + ddcl.SelectedValue + "','" + ddsec.SelectedValue + "','" + neid + "','" + Session["uid"] + "','" + Session["nschoolid"] + "',@famnt,'" + txtRcvfee.Text + "' ,'" + txtRemnfee.Text + "','" + txtfeecons.Text + "','Class',convert(date,SYSDATETIME()),'False')";
                            //last change cmd.Parameters.AddWithValue("@famnt", txtfee.Text);
                            cmd.CommandText = "insert into tbl_RecieveFee(strMonths,nChallanNum,nMonth_id,strFeeMonth,bisPaid,nc_id,nsc_id,ne_id,nu_id,nsch_id,strFeeAmount,strFeeAmountReceived,strFeeAmountRemaining,strFeeConcession,strRecieveType,dtAddDate,bisDeleted) values (@mm,@inv1,@mid,@date4,1,'" + ddcl.SelectedValue + "','" + ddsec.SelectedValue + "','" + neid + "','" + Session["uid"] + "','" + Session["nschoolid"] + "',@famnt,'" + txtRcvfee.Text + "' ,'" + txtRemnfee.Text + "','" + txtfeecons.Text + "','Class',@date4,'False')";
                            cmd.Parameters.AddWithValue("@famnt", txtfee.Text);
                            cmd.Parameters.AddWithValue("@mm", mmm2);
                            cmd.Parameters.AddWithValue("@mid", mid);
                            cmd.Parameters.AddWithValue("@inv1", inv);

                            cmd.Parameters.AddWithValue("@date4", dtdate);
                            cmd.ExecuteNonQuery();
                            con.Close();
                            int amount = 0;
                            int total = 0;
                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "select strAmount from tbl_Bank where strAccNum='" + ddacnum.Text + "' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
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
                            cmd.CommandText = "update tbl_Bank set strAmount=@amnt where strAccNum='" + ddacnum.Text + "'  and nsch_id='" + Session["nschoolid"] + "'";
                            cmd.Parameters.AddWithValue("@amnt", total);
                            cmd.ExecuteNonQuery();
                            con.Close();

                            AdminFunctions add = new AdminFunctions();
                            add.challanTransferRecordWith_True_Bit(inv.ToString(), ddacnum.SelectedValue, amount.ToString(), total.ToString(), (Convert.ToInt32(txtTotfee.Text) - Convert.ToInt32(txtRemnfee.Text)).ToString(), neid, Session["uid"].ToString(), Session["nschoolid"].ToString());

                            PopulateData();
                            //////////////////////////////////////////

                            lblbnk1.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;
                            lblbnk2.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;
                            lblbnk3.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;

                            tststInvc.Text = inv.ToString();
                            txtinv1.Text = inv.ToString();
                            lblchallan2.Text = inv.ToString();
                            lblchallan3.Text = inv.ToString();

                            date.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                            txtdate1.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                            lblissuedt2.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                            lblissuedt3.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

                            duedate.Text = txtDueDate.Text;
                            lblduedt1.Text = txtDueDate.Text;
                            lblduedt2.Text = txtDueDate.Text;
                            lblduedt3.Text = txtDueDate.Text;

                            txtstName.Text = ddst.SelectedItem.ToString();
                            txtname1.Text = ddst.SelectedItem.ToString();
                            lblstnm2.Text = ddst.SelectedItem.ToString();
                            lblstnm3.Text = ddst.SelectedItem.ToString();

                            txtstClass.Text = ddcl.SelectedItem.ToString();
                            txtcls1.Text = ddcl.SelectedItem.ToString();
                            lblcls2.Text = ddcl.SelectedItem.ToString();
                            lblcl3.Text = ddcl.SelectedItem.ToString();

                            txtstSec.Text = ddsec.SelectedItem.ToString();
                            txtsec1.Text = ddsec.SelectedItem.ToString();
                            lblsec2.Text = ddsec.SelectedItem.ToString();
                            lblsec3.Text = ddsec.SelectedItem.ToString();

                            txtstRoll.Text = txtstnum.Text;
                            txtreg1.Text = txtstnum.Text;
                            lbladm2.Text = txtstnum.Text;
                            lbladmnum3.Text = txtstnum.Text;

                            txtstFee.Text = txtfee.Text;
                            txtstFee1.Text = txtfee.Text;
                            lblfee2.Text = txtfee.Text;
                            lblfee3.Text = txtfee.Text;
                            ////////////////////////////MONTH///
                            txtmonths.Text = DateTime.Now.ToString("MMM");
                            lblfeemonth.Text = DateTime.Now.ToString("MMM");
                            lblfeebillmnth2.Text = DateTime.Now.ToString("MMM");
                            lblbilmnth3.Text = DateTime.Now.ToString("MMM");
                            ////////////////////////////MONTH///
                            txtstFine.Text = txtFine.Text;
                            //txtstFine1.Text = txtFine.Text;
                            //lblfine2.Text = txtFine.Text;
                            //lblfeefine3.Text = txtFine.Text;
                            //if (flagfiner)
                            //{
                            //    
                            //    flagfiner = false;
                            //    txtRemnfee.Text = "0";
                            //}
                            txtstRemainingFee.Text = txtRemnfee.Text;
                            lblrem1.Text = txtRemnfee.Text;
                            lblfeerem3.Text = txtRemnfee.Text;
                            lblfine2.Text = txtRemnfee.Text;

                            //txtstConc.Text = txtfeecons.Text;
                            //txtstConc1.Text = txtfeecons.Text;
                            //txtstConc2.Text = txtfeecons.Text;
                            //txtstConc3.Text = txtfeecons.Text;

                            int totalpbdd = Convert.ToInt32(txtRcvfee.Text)  + Convert.ToInt32(txtRemnfee.Text);
                            txtstRcvFee.Text = totalpbdd.ToString();
                            lblpbddt1.Text = totalpbdd.ToString();
                            lblpbddt2.Text = totalpbdd.ToString();
                            lblpbddt3.Text = totalpbdd.ToString();

                            int totrcvfee = Convert.ToInt32(txtRcvfee.Text) + Convert.ToInt32(lblfeefine3.Text) + Convert.ToInt32(txtRemnfee.Text);

                            txtstTOTFee.Text = totrcvfee.ToString();
                            lblpaddt.Text = totrcvfee.ToString();
                            lblpaddt2.Text = totrcvfee.ToString();
                            lblpaddt3.Text = totrcvfee.ToString();





                            txtstTOTRcvfee.Text = txtRcvfee.Text;
                            //txtstTOTRcvfee1.Text = txtRcvfee.Text;
                            //txtstTOTRcvfee2.Text = txtRcvfee.Text;
                            //txtstTOTRcvfee3.Text = txtRcvfee.Text;

                            string words1 = NumberToWords(Convert.ToInt64(lblpbddt1.Text));
                            lbltotfeeinwords1.Text = words1;

                            string words2 = NumberToWords(Convert.ToInt64(lblpbddt2.Text));
                            lbltotfeeinwords2.Text = words2;

                            string words3 = NumberToWords(Convert.ToInt64(lblpbddt3.Text));
                            lbltotfeeinwords3.Text = words3;



                            mvsub.ActiveViewIndex = 4;

                        }
                    }
                        /////////////////BAECODE//////////////////////
                    Session["SKU"] = txtinv1.Text;
                    bindGrid_bnk();
                    bindGrid_sch();
                    bindGrid_std();
                    printbarcode();

                    Session.Remove("SKU");
                        /////////////////////////////////////////////
                }
                catch (Exception)
                {
                    Response.Redirect("Error.aspx?msg=AdminDirectRecievingFee.aspx");
                }
                finally
                {
                    if (con.State == ConnectionState.Open)
                    {
                        con.Close();
                    }
                }
            }

            else
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('All Feilds Required.');", true);
         


        }

        protected void chkmonth_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                if (chkmonth.Checked)
                {
                    monthlist.DataBind();
                    monthlist.Visible = true;
                    month.Visible = true;
                    Int64 tot1Amount = Convert.ToInt64(txtRemnfee.Text) + Convert.ToInt64(txtFine.Text);
                    txtTotfee.Text = tot1Amount.ToString();
              
                }
                else
                {
                    Int64 tot1Amount = Convert.ToInt64(txtRemnfee.Text) + Convert.ToInt64(txtfee.Text) + Convert.ToInt64(txtFine.Text);
                    txtTotfee.Text = tot1Amount.ToString();
                    monthlist.Visible = false;
                    month.Visible = false;
                    monthlist.Items.Clear();

                }
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }

        public static string NumberToWords(long number)
        {
            if (number == 0)
            {
                return "Zero";
            }
            if (number < 0)

                return "Minus" + NumberToWords(Math.Abs(number)) + " ";
            string words = "";

            if ((number / 100000000) > 0)
            {
                words += NumberToWords(number / 10000000) + " " + "Crore" + " ";
                number %= 10000000;
            }
            if ((number / 1000000) > 0)
            {
                words += NumberToWords(number / 100000) + " " + "Lakh" + " ";
                number %= 100000;
            }
            if ((number / 1000) > 0)
            {
                words += NumberToWords(number / 1000) + " " + "Thousand" + " ";
                number %= 1000;
            }
            if ((number / 100) > 0)
            {
                words += NumberToWords(number / 100) + " " + "Hundred" + " ";
                number %= 100;
            }
            if (number > 0)
            {
                if (words != "")

                    words += "and" + " ";
                var unitW = new[] { "Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Tweleve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen" };
                var tenW = new[] { "Zero", "Ten", "Twenty", "Thirty", "Forty", "Fivety", "Sixty", "Seventy", "Eighty", "Ninety" };


                if (number < 20)

                    words += unitW[number];
                else
                {
                    words += tenW[number / 10];
                    if ((number % 10) > 0)
                    {
                        words += " " + unitW[number % 10];
                    }
                }
            }
            return words;
        }
        protected void ddlseepaid_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                if (ddlseepaid.Checked)
                {
                    if (lstpaidmonth.Items.Count == 0)
                        lstpaidmonth.DataBind();
                    lstpaidmonth.Visible = true;
                    lstpaidmonth.Visible = true;
                }
                else
                {
                    lstpaidmonth.Visible = false;
                    lstpaidmonth.Visible = false;
                    //monthlist.Items.Clear();

                }
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }

        protected void monthlist_SelectedIndexChanged(object sender, EventArgs e)
        {
            string value = string.Empty;

            string result = Request.Form["__EVENTTARGET"];

            string[] checkedBox = result.Split('$'); ;

            int index = int.Parse(checkedBox[checkedBox.Length - 1]);

            if (monthlist.Items[index].Selected)
            {
                //value = monthlist.Items[index].Value;
                txtTotfee.Text = (Convert.ToInt64(txtTotfee.Text) + Convert.ToInt64(txtfee.Text)).ToString();
            }
            else
            {
                txtTotfee.Text = (Convert.ToInt64(txtTotfee.Text) - Convert.ToInt64(txtfee.Text)).ToString();
            }
            int count = 0;
            //foreach (ListItem item in monthlist.Items)
            //{
            //    if (item.Selected)
            //    { }
            //    else
            //    { }

            //}
            // if (count != 0)
            // CheckBoxList c = (CheckBoxList)sender;
            //// string selectedvalue = c.SelectedValue;

            //    if (monthlist.SelectedItem != null)
            //    {
            //        if (monthlist.SelectedItem.Selected)
            //        {
            //            // Response.Write("You checked " + monthlist.SelectedItem.Text);
            //            txtTotfee.Text = (Convert.ToInt64(txtTotfee.Text) + Convert.ToInt64(txtfee.Text)).ToString();
            //        }
            //        else
            //        {
            //            // Response.Write("You unchecked " + monthlist.SelectedItem.Text);
            //            txtTotfee.Text = (Convert.ToInt64(txtTotfee.Text) - Convert.ToInt64(txtfee.Text)).ToString();
            //        }
            //    }
            //    else
            //        txtTotfee.Text = (Convert.ToInt64(txtTotfee.Text) - Convert.ToInt64(txtfee.Text)).ToString();

            //    txtTotfee.Text = (Convert.ToInt64(txtTotfee.Text) + Convert.ToInt64(txtfee.Text)).ToString();
            //}


        }
    }
}