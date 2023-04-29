using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace SchoolPRO
{
    public partial class AdminIssueFeeReciept : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            lblinvoice.Text = NewKey();
            //getdata();

        }
        List<string> keys = new List<string>();
        private string NewKey()
        {
            Random ran = new Random(DateTime.Now.Millisecond);
            int keyFirstPart = 0;
            string result = null;
            do
            {
                keyFirstPart = ran.Next(1000, 9999);
                result = keyFirstPart.ToString();
            }
            while (keys.Contains(result));
            keys.Add(result);
            return result;
        }

        string cid = "",sid="";

        protected void btnvful_Click(object sender, EventArgs e)
        {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            cid = gvr.Cells[0].Text;
            sid = gvr.Cells[2].Text;
            getdata();
            mvt.ActiveViewIndex = 1;


        }

        public void getdata()
        {
            string query = "select e.strFname,e.strLname,u.strfname,u.strlname,c.strClass,f.strTutionFee,f.strAdmsFee from tbl_Enrollment e inner join tbl_Users u on e.nu_id=u.nu_id inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Fee f on e.nfee_id=f.nfee_id where e.nc_id='" + cid + "' and e.nsc_id=(select nsc_id from tbl_Section where strSection='" + sid + "' and nc_id='" + cid + "' and nsch_id= '" + Session["nschoolid"] + "') and e.nsch_id= '" + Session["nschoolid"] + "'";
            con.Open();
            cmd.Connection = con;
            
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = query;
            List<enrollment> tempList = null;

            using (con)
            {
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    tempList = new List<enrollment>();
                    while (dr.Read())
                    {
                        enrollment c = new enrollment();

                        c.classnm = dr["strClass"].ToString();
                        c.fee = dr["strTutionFee"].ToString();
                        c.efname = dr["strFname"].ToString();
                        c.emname = dr["strLname"].ToString();
                        
                        c.admsfee = dr["strAdmsFee"].ToString();
                        c.gfn = dr["strfname"].ToString();
                        c.gmn = dr["strlname"].ToString();
                        tempList.Add(c);
                    }
                    tempList.TrimExcess();
                    con.Close();
                    foreach (var c in tempList)
                    {
                        lbldate.Text = DateTime.Now.Date.ToString();
                        lblname.Text = c.efname + "" + c.emname;
                        lblfname.Text = c.gfn +""+ c.gmn;
                        lblclass.Text = c.classnm;
                        lbltotal.Text = c.fee;
                        lbltuitionfee.Text = c.fee;
                        lbladmissionfee.Text = c.admsfee;



                    }


                }
            }
        }
    }
}