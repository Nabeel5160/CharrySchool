﻿using System;
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
    public partial class TeacherReplyMessage : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        //private void senname()
        //{
        //    try
        //    {
        //        con.Open();
        //        cmd.CommandType = CommandType.Text;
        //        cmd.CommandText = "select strfname+' '+strlname  as name from tbl_Users where nu_id='" + Session["senderid"] + "'";
        //        dr = cmd.ExecuteReader();
        //        while (dr.Read())
        //        {
        //            Session["name"] = dr["name"].ToString();
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Response.Redirect("Error.aspx");
        //    }
                
        //}
        protected void btnaddMessage_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType =CommandType.Text;
                cmd.CommandText = "insert into tbl_Message (nU_sndr_id,nsch_id,strMsgTitle,strMsgDesc,nU_rcv_id,bisRead,bisDeleted,dtAddDate) Values (@uid,@mgsch,@mgstitle,@mgsdes,@mgssend,@fbit,@fbit,@date)";
                cmd.Parameters.AddWithValue("@mgstitle", txtaddMessagetitle.Text);
                cmd.Parameters.AddWithValue("@mgsdes", txtaddMessagedesc.Text);
                cmd.Parameters.AddWithValue("@mgssend", Session["senderid1"].ToString());
                cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                cmd.Parameters.AddWithValue("@mgsch", Session["nschoolid"].ToString());
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                cmd.Parameters.AddWithValue("@date", DATE_FORMAT.format());
                
                //cmd.CommandText = query;
                cmd.ExecuteNonQuery();

                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Message Send successfully.');", true);
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
                    txtaddMessagedesc.Text = "";
                    txtaddMessagetitle.Text = "";
                }
            }
        }
    }
}