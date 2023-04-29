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
    public partial class testTimeTable : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btnadd_Click(object sender, EventArgs e)
        {
            CheckBox chkclassecsubjall = (CheckBox)gvclsec.HeaderRow.FindControl("chksizeok");
            CheckBox chkperiodall = (CheckBox)gvpriod.HeaderRow.FindControl("chksizeok1");
            CheckBox chkdayall = (CheckBox)gvday.HeaderRow.FindControl("chksizeok2");
            string cid = "", scid = "", subid = "";
            string storecid = "", storescid = "", storesubid = "";

            ///// this is for class section subject ....
            foreach (GridViewRow gvr in gvclsec.Rows)
            {
                
                    CheckBox chkclasssecsubj = (CheckBox)gvr.FindControl("chksizeselect");
                    if (gvr.RowType == DataControlRowType.DataRow)
                    {
                         cid = gvr.Cells[1].Text;
                         scid = gvr.Cells[2].Text;
                         subid = gvr.Cells[3].Text;
                         if (cid == storecid && scid == storescid || subid == storesubid)
                         {

                         }
                         else
                         {
                             storecid = cid; storescid = scid; storesubid = subid;
                        if (chkclassecsubjall.Checked)
                        {
                            //// this is for periods..
                            foreach (GridViewRow row in gvpriod.Rows)
                            {
                                CheckBox chkperiod = (CheckBox)row.FindControl("chksizeselect1");
                                if (row.RowType == DataControlRowType.DataRow)
                                {
                                    string period = row.Cells[1].Text;
                                    string starttime = row.Cells[2].Text;
                                    string endtime = row.Cells[3].Text;

                                    if (chkperiodall.Checked)
                                    {
                                        //this is for days
                                        foreach (GridViewRow gr in gvday.Rows)
                                        {
                                            CheckBox chkdays = (CheckBox)gr.FindControl("chksizeselect2");
                                            if (gr.RowType == DataControlRowType.DataRow)
                                            {
                                                string dayid = gr.Cells[1].Text;
                                                string dayname = gr.Cells[2].Text;
                                                if (chkdayall.Checked)
                                                {
                                                    con.Open();
                                                    cmd.Connection = con;
                                                    cmd.CommandType = CommandType.Text;
                                                    cmd.CommandText = "insert into tbl_TimeTable(nu_id,nsbj_id,nc_id,nsc_id,nsch_id,strShift,strStartTime,strEndTime,strStartDate,strEndDate,strType,strDay,dtAddDate,bisDeleted,strPeriod,nshdule_id,np_id)values((select nu_id from tbl_Users where nu_id='" + ddtchr.Text + "'),'" + subid + "','" + cid + "','" + scid + "','1','Morning','" + starttime + "','" + endtime + "',(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),'Class','" + dayname + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False','" + period + "','" + ddltimetable11.Text + "',(select np_id from tbl_Period where strPeriod='" + period + "' ))";
                                                    cmd.ExecuteNonQuery();
                                                    cmd.Parameters.Clear();
                                                    con.Close();
                                                }
                                                else if (chkdays.Checked)
                                                {
                                                    con.Open();
                                                    cmd.Connection = con;
                                                    cmd.CommandType = CommandType.Text;
                                                    cmd.CommandText = "insert into tbl_TimeTable(nu_id,nsbj_id,nc_id,nsc_id,nsch_id,strShift,strStartTime,strEndTime,strStartDate,strEndDate,strType,strDay,dtAddDate,bisDeleted,strPeriod,nshdule_id,np_id)values((select nu_id from tbl_Users where nu_id='" + ddtchr.Text + "'),'" + subid + "','" + cid + "','" + scid + "','1','Morning','" + starttime + "','" + endtime + "',(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),'Class','" + dayname + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False','" + period + "','" + ddltimetable11.Text + "',(select np_id from tbl_Period where strPeriod='" + period + "' ))";
                                                    cmd.ExecuteNonQuery();
                                                    cmd.Parameters.Clear();
                                                    con.Close();
                                                }
                                            }
                                        }

                                    }
                                    else if (chkperiod.Checked)
                                    {
                                        foreach (GridViewRow gr in gvday.Rows)
                                        {
                                            CheckBox chkdays = (CheckBox)gr.FindControl("chksizeselect2");
                                            if (gr.RowType == DataControlRowType.DataRow)
                                            {
                                                string dayid = gr.Cells[1].Text;
                                                string dayname = gr.Cells[2].Text;
                                                if (chkdayall.Checked)
                                                {
                                                    con.Open();
                                                    cmd.Connection = con;
                                                    cmd.CommandType = CommandType.Text;
                                                    cmd.CommandText = "insert into tbl_TimeTable(nu_id,nsbj_id,nc_id,nsc_id,nsch_id,strShift,strStartTime,strEndTime,strStartDate,strEndDate,strType,strDay,dtAddDate,bisDeleted,strPeriod,nshdule_id,np_id)values((select nu_id from tbl_Users where nu_id='" + ddtchr.Text + "'),'" + subid + "','" + cid + "','" + scid + "','1','Morning','" + starttime + "','" + endtime + "',(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),'Class','" + dayname + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False','" + period + "','" + ddltimetable11.Text + "',(select np_id from tbl_Period where strPeriod='" + period + "' ))";
                                                    cmd.ExecuteNonQuery();
                                                    cmd.Parameters.Clear();
                                                    con.Close();
                                                }
                                                else if (chkdays.Checked)
                                                {
                                                    con.Open();
                                                    cmd.Connection = con;
                                                    cmd.CommandType = CommandType.Text;
                                                    cmd.CommandText = "insert into tbl_TimeTable(nu_id,nsbj_id,nc_id,nsc_id,nsch_id,strShift,strStartTime,strEndTime,strStartDate,strEndDate,strType,strDay,dtAddDate,bisDeleted,strPeriod,nshdule_id,np_id)values((select nu_id from tbl_Users where nu_id='" + ddtchr.Text + "'),'" + subid + "','" + cid + "','" + scid + "','1','Morning','" + starttime + "','" + endtime + "',(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),'Class','" + dayname + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False','" + period + "','" + ddltimetable11.Text + "',(select np_id from tbl_Period where strPeriod='" + period + "' ))";
                                                    cmd.ExecuteNonQuery();
                                                    cmd.Parameters.Clear();
                                                    con.Close();
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else if (chkclasssecsubj.Checked)
                        {
                            string storeperiod = "", period = "";
                            foreach (GridViewRow row in gvpriod.Rows)
                            {
                                
                                    CheckBox chkperiod = (CheckBox)row.FindControl("chksizeselect1");
                                    if (row.RowType == DataControlRowType.DataRow)
                                    {
                                        period = row.Cells[1].Text;
                                        string starttime = row.Cells[2].Text;
                                        string endtime = row.Cells[3].Text;

                                        if(period==storeperiod)
                                        {
                                            
                                        }
                                        else if(period!=storeperiod)
                                        {
                                            storeperiod = period;
                                        

                                        if (chkperiodall.Checked)
                                        {
                                            //this is for days
                                            foreach (GridViewRow gr in gvday.Rows)
                                            {
                                                CheckBox chkdays = (CheckBox)gr.FindControl("chksizeselect2");
                                                if (gr.RowType == DataControlRowType.DataRow)
                                                {
                                                    string dayid = gr.Cells[1].Text;
                                                    string dayname = gr.Cells[2].Text;
                                                    if (chkdayall.Checked)
                                                    {
                                                        con.Open();
                                                        cmd.Connection = con;
                                                        cmd.CommandType = CommandType.Text;
                                                        cmd.CommandText = "insert into tbl_TimeTable(nu_id,nsbj_id,nc_id,nsc_id,nsch_id,strShift,strStartTime,strEndTime,strStartDate,strEndDate,strType,strDay,dtAddDate,bisDeleted,strPeriod,nshdule_id,np_id)values((select nu_id from tbl_Users where nu_id='" + ddtchr.Text + "'),'" + subid + "','" + cid + "','" + scid + "','1','Morning','" + starttime + "','" + endtime + "',(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),'Class','" + dayname + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False','" + period + "','" + ddltimetable11.Text + "',(select np_id from tbl_Period where strPeriod='" + period + "' ))";
                                                        cmd.ExecuteNonQuery();
                                                        cmd.Parameters.Clear();
                                                        con.Close();
                                                    }
                                                    else if (chkdays.Checked)
                                                    {
                                                        con.Open();
                                                        cmd.Connection = con;
                                                        cmd.CommandType = CommandType.Text;
                                                        cmd.CommandText = "insert into tbl_TimeTable(nu_id,nsbj_id,nc_id,nsc_id,nsch_id,strShift,strStartTime,strEndTime,strStartDate,strEndDate,strType,strDay,dtAddDate,bisDeleted,strPeriod,nshdule_id,np_id)values((select nu_id from tbl_Users where nu_id='" + ddtchr.Text + "'),'" + subid + "','" + cid + "','" + scid + "','1','Morning','" + starttime + "','" + endtime + "',(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),'Class','" + dayname + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False','" + period + "','" + ddltimetable11.Text + "',(select np_id from tbl_Period where strPeriod='" + period + "' ))";
                                                        cmd.ExecuteNonQuery();
                                                        cmd.Parameters.Clear();
                                                        con.Close();
                                                    }
                                                }
                                            }

                                        }
                                        else if (chkperiod.Checked)
                                        {
                                            foreach (GridViewRow gr in gvday.Rows)
                                            {
                                                CheckBox chkdays = (CheckBox)gr.FindControl("chksizeselect2");

                                                if (gr.RowType == DataControlRowType.DataRow)
                                                {
                                                    string dayid = gr.Cells[1].Text;
                                                    string dayname = gr.Cells[2].Text;
                                                    if (chkdayall.Checked)
                                                    {
                                                        con.Open();
                                                        cmd.Connection = con;
                                                        cmd.CommandType = CommandType.Text;
                                                        cmd.CommandText = "insert into tbl_TimeTable(nu_id,nsbj_id,nc_id,nsc_id,nsch_id,strShift,strStartTime,strEndTime,strStartDate,strEndDate,strType,strDay,dtAddDate,bisDeleted,strPeriod,nshdule_id,np_id)values((select nu_id from tbl_Users where nu_id='" + ddtchr.Text + "'),'" + subid + "','" + cid + "','" + scid + "','1','Morning','" + starttime + "','" + endtime + "',(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),'Class','" + dayname + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False','" + period + "','" + ddltimetable11.Text + "',(select np_id from tbl_Period where strPeriod='" + period + "' ))";
                                                        cmd.ExecuteNonQuery();
                                                        cmd.Parameters.Clear();
                                                        con.Close();
                                                    }
                                                    else if (chkdays.Checked)
                                                    {
                                                        con.Open();
                                                        cmd.Connection = con;
                                                        cmd.CommandType = CommandType.Text;
                                                        cmd.CommandText = "insert into tbl_TimeTable(nu_id,nsbj_id,nc_id,nsc_id,nsch_id,strShift,strStartTime,strEndTime,strStartDate,strEndDate,strType,strDay,dtAddDate,bisDeleted,strPeriod,nshdule_id,np_id)values((select nu_id from tbl_Users where nu_id='" + ddtchr.Text + "'),'" + subid + "','" + cid + "','" + scid + "','1','Morning','" + starttime + "','" + endtime + "',(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),(select strStartDate from tbl_Schedule where nshd_id='" + ddltimetable11.Text + "'),'Class','" + dayname + "',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False','" + period + "','" + ddltimetable11.Text + "',(select np_id from tbl_Period where strPeriod='" + period + "' ))";
                                                        cmd.ExecuteNonQuery();
                                                        cmd.Parameters.Clear();
                                                        con.Close();
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    }
                                

                            }
                        }
                    }
                }
            }
        }


        protected void chksizeok_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkselectall = (CheckBox)gvclsec.HeaderRow.FindControl("chksizeok");
            foreach (GridViewRow row in gvclsec.Rows)
            {
                CheckBox chkchecked = (CheckBox)row.FindControl("chksizeselect");
                if (chkselectall.Checked)
                {
                    chkchecked.Checked = true;
                }
                else
                {
                    chkchecked.Checked = false;
                }
            }
        }

        protected void chksizeok1_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkselectall = (CheckBox)gvpriod.HeaderRow.FindControl("chksizeok1");
            foreach (GridViewRow row in gvpriod.Rows)
            {
                CheckBox chkchecked = (CheckBox)row.FindControl("chksizeselect1");
                if (chkselectall.Checked)
                {
                    chkchecked.Checked = true;
                }
                else
                {
                    chkchecked.Checked = false;
                }
            }
        }

        protected void chksizeok2_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkselectall = (CheckBox)gvday.HeaderRow.FindControl("chksizeok2");
            foreach (GridViewRow row in gvday.Rows)
            {
                CheckBox chkchecked = (CheckBox)row.FindControl("chksizeselect2");
                if (chkselectall.Checked)
                {
                    chkchecked.Checked = true;
                }
                else
                {
                    chkchecked.Checked = false;
                }
            }
        }
    }
}