using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace Farmecole.admins
{
    public partial class _default1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_ServerClick(object sender, EventArgs e)
        {
           // using ADOEDMODEL();
            using (var _dc = new AdminEntities())
            {
                string UserNtxt = UserNametxt.Value;
                string Pastxt = Passwordtxt.Value;
                var tblUser = new tblUser();
                var _login = _dc.tblUsers.Where(u =>  u.strUName == UserNtxt && u.strPassword == Pastxt && u.bIsDel== false).FirstOrDefault();

                if (_login != null)
                {
                    Session["AdminId"] = tblUser.nUid;

                    Response.Redirect("home.aspx");

                }

                else
                {
                    Response.Redirect("default.aspx");
                }



            }

        }
    }
}