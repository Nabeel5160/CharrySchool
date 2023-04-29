using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminViewSubmittedFee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnview_full_Click(object sender, EventArgs e)
        {
            try{
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["val"] = gvr.Cells[1].Text;
            Session["secs"] = gvr.Cells[3].Text;
            mvstlist.ActiveViewIndex = 1;
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
               
            }
        }

        public void calc_fee()
        {try
        {
            string fee = "";
            int total = 0;
            foreach (GridViewRow row in gv_detail_list.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    fee = row.Cells[4].Text;
                    total = total + Convert.ToInt32(fee);
                }
            }

            lblcalcfee.Text = total.ToString();
        }
        catch (Exception ex)
        {
           
        }
        finally
        {
            
        }
        }

        protected void txtto_TextChanged(object sender, EventArgs e)
        {
            calc_fee();
        }

    }
}