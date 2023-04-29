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
    public partial class AdminDuplicateChalanForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();

        SqlDataReader dr;

        BarcodeLib.Barcode b = new BarcodeLib.Barcode();

        string dtdate = DATE_FORMAT.format();
        protected void Page_Load(object sender, EventArgs e)
        {
            
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
                var tenW = new[] { "Zero", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety" };


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
        private void BindRepeater()
        {
            string constr = ConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                if (txtchnm.Text != "")
                {
                    using (SqlCommand cmd = new SqlCommand("select e.strFname+' '+e.strLname as Name, u.strfname+' '+u.strlname as FatherName, e.bRegisteredNum,r.nfr_id,r.nChallanNum,r.strFeeAmountRemaining,r.strMonths,r.strFeeMonth,c.strClass,sec.strSection,sch.strSchName,sch.strAddress,f.strTutionFee,r.strFeeAmount,f.dtDueDate,f.nFine,r.imgChallanBcode,r.dtAddDate,r.strFeeConcession from tbl_RecieveFee r inner join tbl_Enrollment e on r.ne_id=e.ne_id inner join tbl_Users u on e.nu_id=u.nu_id inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Section sec on e.nsc_id=sec.nsc_id inner join tbl_School sch on r.nsch_id=sch.nsch_id inner join tbl_Fee f on e.nfee_id=f.nfee_id where r.bisPaid='False' and r.bisPrint='True' and r.nChallanNum='" + txtchnm.Text + "'  order by r.nfr_id desc", con))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            rpt.DataSource = dt;
                            rpt.DataBind();
                        }
                    }
                }
                else if (txtsearch.Text !="")
                {
                    using (SqlCommand cmd = new SqlCommand("select top 1 e.strFname+' '+e.strLname as Name, u.strfname+' '+u.strlname as FatherName, e.bRegisteredNum,r.nfr_id,r.nChallanNum,r.strFeeAmountRemaining,r.strMonths,r.strFeeMonth,c.strClass,sec.strSection,sch.strSchName,sch.strAddress,f.strTutionFee,r.strFeeAmount,f.dtDueDate,f.nFine,r.imgChallanBcode,r.dtAddDate,r.strFeeConcession from tbl_RecieveFee r inner join tbl_Enrollment e on r.ne_id=e.ne_id inner join tbl_Users u on e.nu_id=u.nu_id inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Section sec on e.nsc_id=sec.nsc_id inner join tbl_School sch on r.nsch_id=sch.nsch_id inner join tbl_Fee f on e.nfee_id=f.nfee_id where r.bisPaid='False' and r.bisPrint='True' and r.ne_id=(select ne_id from tbl_Enrollment where bRegisteredNum='" + txtsearch.Text + "' ) order by r.nfr_id desc", con))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            rpt.DataSource = dt;
                            rpt.DataBind();
                        }
                    }
                }
            }
        }
        private DataTable GetRecords_std()
        {

            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            
            cmd.CommandText = "Select * from tbl_ChallanTerms where bisDeleted='False'";
            SqlDataAdapter dAdapter = new SqlDataAdapter();
            dAdapter.SelectCommand = cmd;
            DataSet objDs = new DataSet();
            dAdapter.Fill(objDs);
            con.Close();
            return objDs.Tables[0];

        }
        //private void bindGrid_std()
        //{
        //    try
        //    {
        //        DataTable dt = GetRecords_std();
        //        if (dt.Rows.Count > 0)
        //        {
        //            gvtermstd.DataSource = dt;
        //            gvtermstd.DataBind();
        //            gvtermstd.HeaderRow.TableSection = TableRowSection.TableHeader;
        //        }
        //    }
        //    catch (Exception) { }
        //}
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
        //private void bindGrid_sch()
        //{
        //    try
        //    {
        //        DataTable dt = GetRecords_sch();
        //        if (dt.Rows.Count > 0)
        //        {
        //            gvtermsch.DataSource = dt;
        //            gvtermsch.DataBind();
        //            gvtermsch.HeaderRow.TableSection = TableRowSection.TableHeader;
        //        }
        //    }
        //    catch (Exception) { }
        //}
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


        protected void rpt_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //Label lblOrderID = (Label)e.Item.FindControl("lblOrderID");
                GridView gvtermsch = (GridView)e.Item.FindControl("gvtermsch");
                DataTable dt1 = GetRecords_sch();
                ViewState["gridTable"] = dt1;
                gvtermsch.DataSource = dt1;
                gvtermsch.DataBind();
                GridView gvtermstd = (GridView)e.Item.FindControl("gvtermstd");
                DataTable dt2 = GetRecords_std();
                ViewState["gridTable1"] = dt2;
                gvtermstd.DataSource = dt2;
                gvtermstd.DataBind();
                GridView gvtermbnk = (GridView)e.Item.FindControl("gvtermbnk");
                DataTable dt3 = GetRecords_bnk();
                ViewState["gridTable2"] = dt3;
                gvtermbnk.DataSource = dt3;
                gvtermbnk.DataBind();

            }
        }
        Int64 remainingfee = 0;
        private void remaining_fee()
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            if (txtchnm.Text != "")
            {
                cmd.CommandText = "Select strFeeAmountRemaining from tbl_RecieveFee where nChallanNum='"+txtchnm.Text+"' and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
            }
            else if(txtsearch.Text!="")
            {
                cmd.CommandText = "Select strFeeAmountRemaining from tbl_RecieveFee where nfr_id=(select Max(nfr_id) from tbl_RecieveFee where ne_id=(select ne_id from tbl_Enrollment where bRegisteredNum='" + txtsearch.Text + "') and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "')and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
            }
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                if (dr.Read())
                {
                    if (dr["strFeeAmountRemaining"].ToString() != "")
                    {
                        remainingfee = Convert.ToInt64(dr["strFeeAmountRemaining"]);

                        con.Close();
                    }
                    else
                    {
                        remainingfee = 0;
                        
                    }
                    con.Close();
                }
                else
                {

                }
            }
            con.Close();
        }
        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            int newfee = 0, amount = 0;
            if (txtsearch.Text != "" || txtchnm.Text!="")
            {
                if(chknewfee.Checked)
                {
                    
                    if(txtnewfee.Text!="")
                    {
                        newfee = Convert.ToInt32(txtnewfee.Text);
                        // checking if student's concession already exist
                       
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        if (txtchnm.Text != "")
                        {
                            cmd.CommandText = "update tbl_RecieveFee set strFeeAmount=" + newfee + " where nfr_id=(select nfr_id from tbl_RecieveFee where nChallanNum='" + txtchnm.Text + "' and bisPaid='False')";
                        }
                        else if (txtsearch.Text != "")
                        {
                            cmd.CommandText = "update tbl_RecieveFee set strFeeAmount=" + newfee + " where nfr_id=(select max(nfr_id) from tbl_RecieveFee where ne_id=(select ne_id from tbl_Enrollment where bRegisteredNum=" + txtsearch.Text + "))";
                        }
                        cmd.ExecuteNonQuery();
                        con.Close();
                    
                    }
                }
                else if (chkifconces.Checked)
                {
                    if (txtnewfee.Text != "")
                    {
                        newfee = Convert.ToInt32(txtnewfee.Text);
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        if (txtchnm.Text != "")
                        {
                            cmd.CommandText = "select nConc_id from tbl_ConcessionStudent where nStd_id=(select ne_id from tbl_RecieveFee where nChallanNum=@stdid) and nc_id=(select nc_id from tbl_RecieveFee where nChallanNum=@cid) and nsc_id=(select nsc_id from tbl_RecieveFee where nChallanNum=@scid) and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                            cmd.Parameters.AddWithValue("@stdid", txtchnm.Text);
                            cmd.Parameters.AddWithValue("@concid", txtchnm.Text);
                            cmd.Parameters.AddWithValue("@cid", txtchnm.Text);
                            cmd.Parameters.AddWithValue("@scid", txtchnm.Text);
                        }
                        else if(txtsearch.Text!="")
                        {
                            cmd.CommandText = "select nConc_id from tbl_ConcessionStudent where nStd_id=(select ne_id from tbl_Enrollment where bRegisteredNum=@stdid) and nc_id=(select nc_id from tbl_Enrollment where bRegisteredNum=@cid) and nsc_id=(select nsc_id from tbl_Enrollment where bRegisteredNum=@scid) and bisDeleted='False' and nsch_id='" + Session["nschoolid"] + "'";
                            cmd.Parameters.AddWithValue("@stdid", txtsearch.Text);
                            cmd.Parameters.AddWithValue("@concid", txtsearch.Text);
                            cmd.Parameters.AddWithValue("@cid", txtsearch.Text);
                            cmd.Parameters.AddWithValue("@scid", txtsearch.Text);
                        }
                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            con.Close();
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Concession  already Given to The Student .');", true);
                        }
                        else
                        {
                            con.Close();
                            // retrieving concession type and ammount
                            con.Open();
                            cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "select * from tbl_Concession where strConcTitle='"+txtnewfee.Text+"'";
                            dr = cmd.ExecuteReader();
                            if (dr.Read())
                            {
                                amount = Convert.ToInt32(lblfee.Text) - Convert.ToInt32(txtnewfee.Text);
                                con.Close();
                                con.Open();
                                cmd.Connection = con;
                                cmd.CommandType = CommandType.Text;
                                if (txtchnm.Text != "")
                                {
                                    cmd.CommandText = "insert into tbl_ConcessionStudent(nStd_id,nConc_id,nc_id,nsc_id,userid,nsch_id,dtAddDate,bisDeleted)values((select ne_id from tbl_RecieveFee where nChallanNum='" + txtchnm.Text + "' and bisPaid='False'),(select nConc_id from tbl_Concession where strConcTitle='" + txtnewfee.Text + "' and bisDeleted='False'),(select nc_id from tbl_RecieveFee where nChallanNum='" + txtchnm.Text + "' and bisPaid='False' ),(select nsc_id from tbl_RecieveFee where nChallanNum='" + txtchnm.Text + "' and bisPaid='False'),@uid,@schid,convert(date,sysdatetime()),'False')";
                                }
                                else if (txtsearch.Text != "")
                                {
                                    cmd.CommandText = "insert into tbl_ConcessionStudent(nStd_id,nConc_id,nc_id,nsc_id,userid,nsch_id,dtAddDate,bisDeleted)values((select ne_id from tbl_Enrollment where bRegisteredNum='" + txtsearch.Text + "'),(select nConc_id from tbl_Concession where strConcTitle='" + txtnewfee.Text + "' and bisDeleted='False'),(select nc_id from tbl_Enrollment where bRegisteredNum='" + txtsearch.Text + "' ),(select nsc_id from tbl_Enrollment where bRegisteredNum='" + txtsearch.Text + "'),@uid,@schid,convert(date,sysdatetime()),'False')";
                                }
                                cmd.Parameters.AddWithValue("@uid", Session["uid"]);
                                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();
                                con.Close();
                                
                                con.Open();
                                cmd.Connection = con;
                                cmd.CommandType = CommandType.Text;
                                if (txtchnm.Text != "")
                                {
                                    cmd.CommandText = "update tbl_RecieveFee set strFeeAmount=" + amount + ", strFeeConcession='"+txtnewfee.Text+"' where nChallanNum='" + txtchnm.Text + "'";
                                }
                                else if(txtsearch.Text!="")
                                {
                                    cmd.CommandText = "update tbl_RecieveFee set strFeeAmount=" + amount + ", strFeeConcession='" + txtnewfee.Text + "' where nfr_id=(select max(nfr_id) from tbl_RecieveFee where ne_id=(select ne_id from tbl_Enrollment where bRegisteredNum=" + txtsearch.Text + "))";
                                }
                                cmd.ExecuteNonQuery();
                                con.Close();
                            }
                            else
                            {
                                con.Close();
                                con.Open();
                                cmd.Connection = con;
                            cmd.CommandType = CommandType.Text;
                            cmd.CommandText = "insert into tbl_Concession(strConcTitle,strConcCode,nuserid,nConcPer,nsch_id,dtAddDate,bisDeleted)values(@ctitl,@code,@uid,@concamnt,@schid,convert(date,sysdatetime()),'False')";
                            cmd.Parameters.AddWithValue("@ctitl", txtnewfee.Text);
                            cmd.Parameters.AddWithValue("@code", txtnewfee.Text);
                            cmd.Parameters.AddWithValue("@concamnt", txtnewfee.Text);
                                cmd.Parameters.AddWithValue("@uid",Session["uid"]);
                                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();
                                con.Close();
                                con.Open();
                                cmd.Connection = con;
                                cmd.CommandType = CommandType.Text;
                                if (txtchnm.Text != "")
                                {
                                    cmd.CommandText = "insert into tbl_ConcessionStudent(nStd_id,nConc_id,nc_id,nsc_id,userid,nsch_id,dtAddDate,bisDeleted)values((select ne_id from tbl_RecieveFee where nChallanNum='" + txtchnm.Text + "' and bisPaid='False'),(select max(nConc_id) from tbl_Concession),(select nc_id from tbl_RecieveFee where nChallanNum='" + txtchnm.Text + "' and bisPaid='False' ),(select nsc_id from tbl_RecieveFee where nChallanNum='" + txtchnm.Text + "' and bisPaid='False'),@uid,@schid,convert(date,sysdatetime()),'False')";
                                }
                                else if (txtsearch.Text != "")
                                {
                                    cmd.CommandText = "insert into tbl_ConcessionStudent(nStd_id,nConc_id,nc_id,nsc_id,userid,nsch_id,dtAddDate,bisDeleted)values((select ne_id from tbl_Enrollment where bRegisteredNum='" + txtsearch.Text + "'),(select max(nConc_id) from tbl_Concession),(select nc_id from tbl_Enrollment where bRegisteredNum='" + txtsearch.Text + "' ),(select nsc_id from tbl_Enrollment where bRegisteredNum='" + txtsearch.Text + "'),@uid,@schid,convert(date,sysdatetime()),'False')";
                                }
                                cmd.Parameters.AddWithValue("@uid", Session["uid"]);
                                cmd.Parameters.AddWithValue("@schid", Session["nschoolid"]);
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();
                                con.Close();
                                amount = Convert.ToInt32(lblfee.Text) - Convert.ToInt32(txtnewfee.Text);
                                con.Open();
                                cmd.Connection = con;
                                cmd.CommandType = CommandType.Text;
                                if (txtchnm.Text != "")
                                {
                                    cmd.CommandText = "update tbl_RecieveFee set strFeeAmount=" + amount + ", strFeeConcession='"+txtnewfee.Text+"' where nChallanNum='" + txtchnm.Text + "' and bisPaid='False'";
                                }
                                else if (txtsearch.Text != "")
                                {
                                    cmd.CommandText = "update tbl_RecieveFee set strFeeAmount=" + amount + ", strFeeConcession='"+txtnewfee.Text+"' where nfr_id=(select max(nfr_id) from tbl_RecieveFee where ne_id=(select ne_id from tbl_Enrollment where bRegisteredNum=" + txtsearch.Text + "))";
                                }
                                cmd.ExecuteNonQuery();
                                con.Close();
                            }
                            con.Close();
                        }
                    }
                }


                remaining_fee();
                BindRepeater();
                
                foreach (RepeaterItem item in rpt.Items)
                {
                    int arears_amount1 = 0;
                    int actualfee = 0;
                    Label conc = (Label)item.FindControl("lblcon0");
                    Label lbltfee1 = (Label)item.FindControl("txtstFee1");
                    actualfee = Convert.ToInt32(lbltfee1.Text) - Convert.ToInt32(conc.Text);
                    Label lblpayable1 = (Label)item.FindControl("lblpbddt1");
                    arears_amount1 = Convert.ToInt32(lblpayable1.Text) - actualfee;
                    if (arears_amount1 > 0)
                    {
                        Label lblArrears0 = (Label)item.FindControl("lblArrears0");
                        lblArrears0.Text = arears_amount1.ToString();
                        Label lblArrears1 = (Label)item.FindControl("lblArrears1");
                        lblArrears1.Text = arears_amount1.ToString();
                        Label lblArrears2 = (Label)item.FindControl("lblArrears2");
                        lblArrears2.Text = arears_amount1.ToString();
                    }
                    else
                    {
                        Label lblArrears0 = (Label)item.FindControl("lblArrears0");
                        lblArrears0.Text = "0";
                        Label lblArrears1 = (Label)item.FindControl("lblArrears1");
                        lblArrears1.Text = "0";
                        Label lblArrears2 = (Label)item.FindControl("lblArrears2");
                        lblArrears2.Text = "0";
                    }

                    Label lblacnum1 = (Label)item.FindControl("lblaccnum1");
                    lblacnum1.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;
                    Label lblacnum2 = (Label)item.FindControl("lblaccnum2");
                    lblacnum2.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;
                    Label lblacnum3 = (Label)item.FindControl("lblaccnum3");
                    lblacnum3.Text = ddacnum.SelectedItem.Text + " Acc #:" + ddacnum.SelectedItem.Value;

                    Label lbltotalfee1 = (Label)item.FindControl("lblpbddt1");
                    Label lbltotalfeeinwords1 = (Label)item.FindControl("lbltotfeeinwords1");
                    string words1 = NumberToWords(Convert.ToInt64(lbltotalfee1.Text));
                    lbltotalfeeinwords1.Text = words1;

                    Label lbltotalfee2 = (Label)item.FindControl("lblfeeamnt2");
                    Label lbltotalfeeinwords2 = (Label)item.FindControl("lbltotfeeinwords2");
                    string words2 = NumberToWords(Convert.ToInt64(lbltotalfee2.Text));
                    lbltotalfeeinwords2.Text = words2;

                    Label lbltotalfee3 = (Label)item.FindControl("lblfeeamnt3");
                    Label lbltotalfeeinwords3 = (Label)item.FindControl("lbltotfeeinwords3");
                    string words3 = NumberToWords(Convert.ToInt64(lbltotalfee3.Text));
                    lbltotalfeeinwords3.Text = words3;
                }


                //DataSet ds = new DataSet();
                //DataRow rfee;
                //DataRow st;
                //DataRow cl;
                //DataRow sec;
                //DataRow fee;
                //int ne_id = Convert.ToInt32(txtsearch.Text);
                //string query = "select * from tbl_Enrollment where ne_id="+ne_id;
                //string cs = WebConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString;
                //using (SqlConnection con = new SqlConnection(cs))
                //{
                //    SqlDataAdapter da = new SqlDataAdapter(query, con);
                //    da.Fill(ds, "student");
                //}
                //st = ds.Tables["student"].Rows[0];
                //query = "select * from tbl_RecieveFee where ne_id=" + ne_id;
                //using (SqlConnection con = new SqlConnection(cs))
                //{
                //    SqlDataAdapter da = new SqlDataAdapter(query, con);
                //    da.Fill(ds, "rfee");
                //}
                //rfee = ds.Tables["rfee"].Rows[0];
                //int nc_id = Convert.ToInt32(st["nc_id"]);
                //int ncs_id = Convert.ToInt32(st["nsc_id"]);
                //query = "select * from tbl_Class where nc_id=" + nc_id;
                //using (SqlConnection con = new SqlConnection(cs))
                //{
                //    SqlDataAdapter da = new SqlDataAdapter(query, con);
                //    da.Fill(ds, "class");
                //}
                //cl = ds.Tables["class"].Rows[0];
                //query = "select * from tbl_Section where nsc_id=" + nc_id+" and nc_id="+nc_id;
                //using (SqlConnection con = new SqlConnection(cs))
                //{
                //    SqlDataAdapter da = new SqlDataAdapter(query, con);
                //    da.Fill(ds, "section");
                //}
                //query = "select * from tbl_Fee where nc_id=" + nc_id;
                //using (SqlConnection con = new SqlConnection(cs))
                //{
                //    SqlDataAdapter da = new SqlDataAdapter(query, con);
                //    da.Fill(ds, "fee");
                //}
                //fee = ds.Tables["fee"].Rows[0];
                //sec = ds.Tables["section"].Rows[0];

                //txtreg1.Text = st["bRegisteredNum"].ToString();
                //txtname1.Text = st["strFname"].ToString();
                //txtfname1.Text = st["strLname"].ToString();
                //txtcls1.Text = cl["strClass"].ToString();
                //txtsec1.Text = sec["strSection"].ToString();
                //txtstFee1.Text = fee["strTutionFee"].ToString();
                mvstlist.ActiveViewIndex = 1;
            }
        }

        protected void chknewfee_CheckedChanged(object sender, EventArgs e)
        {
            if (chknewfee.Checked)
            {
                txtnewfee.ReadOnly = false;
                chkifconces.Checked = false;
            }
            else
            {
                txtnewfee.ReadOnly = true;
            }
        }

        protected void chkifconces_CheckedChanged(object sender, EventArgs e)
        {
            if (chkifconces.Checked)
            {
                txtnewfee.ReadOnly = false;
                chknewfee.Checked = false;
            }
            else
            {
                txtnewfee.ReadOnly = true;
            }
        }

        protected void txtsearch_TextChanged(object sender, EventArgs e)
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            if (txtchnm.Text != "")
            {
                cmd.CommandText = "select e.*,r.* from tbl_RecieveFee r inner join tbl_Enrollment e on r.ne_id=e.ne_id where r.nChallanNum='" + txtchnm.Text + "'";
            }
            else if(txtsearch.Text!="")
            {
                cmd.CommandText = "select e.*,r.* from tbl_RecieveFee r inner join tbl_Enrollment e on r.ne_id=e.ne_id where e.bRegisteredNum='" + txtsearch.Text + "'";
            }
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                lblfee.Text = dr["strFeeAmount"].ToString();
                lblname.Text=dr["strFname"].ToString()+' '+dr["strLname"].ToString();
            }
            con.Close();
        }
    }
}