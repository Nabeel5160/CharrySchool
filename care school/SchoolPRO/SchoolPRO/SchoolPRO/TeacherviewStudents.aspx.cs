using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class TeacherviewStudents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //string ss = Session["uid"].ToString() + " ---- " + Session["nschoolid"];
            }
            catch (Exception Ex) { }
        }

        protected void btndattnd_Click(object sender, EventArgs e)
        {
            try
            {
            mvatnd.ActiveViewIndex = 1;
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            sqlattnd.SelectParameters["cid"].DefaultValue = gvr.Cells[1].Text;
            sqlattnd.SelectParameters["scid"].DefaultValue = gvr.Cells[2].Text;
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
            }
        }

        protected void btnback_Click(object sender, EventArgs e)
        {
            mvatnd.ActiveViewIndex = 0;
        }

        protected void btnRating_Click(object sender, EventArgs e)
        {
            try{
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            string neid = gvr.Cells[1].Text;
            string ncid = gvr.Cells[7].Text;
            //if (Request.Browser.Cookies) // To check that the browser support cookies
           // {
                //HttpCookie cookie1 = new HttpCookie("eid");
                //cookie1.Value = neid;
                //cookie1.Expires = DateTime.Now.AddDays(1);
                //Response.Cookies.Add(cookie1);
                //HttpCookie cookie2 = new HttpCookie("cid");
                //cookie2.Value = ncid;
                //cookie2.Expires = DateTime.Now.AddDays(1);
                //Response.Cookies.Add(cookie2);

                Session["nneeiidd"]=neid;
                Session["nncciidd"]=ncid;
                
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
          
           
            Response.Redirect("TeacherRateStudents.aspx");
                // You have to follow other option.
            }
        }
    }
