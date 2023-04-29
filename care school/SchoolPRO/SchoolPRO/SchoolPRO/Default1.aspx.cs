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
using System.IO;
using System.Globalization;

namespace SchoolPRO
{
    public partial class Default1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ADD_Makers_ToMap();
        }
        public void ADD_Makers_ToMap()
        {
            List<string> markers = GetMarkers();
            Literal1.Text = @"
     <script type='text/javascript'>
     function initialize() {
     var mapOptions = {
     center: new google.maps.LatLng(24.3505839, 53.9396418),
     zoom: 4,
     mapTypeId: google.maps.MapTypeId.ROADMAP
     };
     var myMap = new google.maps.Map(document.getElementById('mapArea'),
     mapOptions);"
     + markers[0] +
     @"}
     </script>";
        }

        protected List<string> GetMarkers()
        {
            List<string> markers = new List<string>();
            string m1 = "";
            string m2 = "";
            markers.Add(m1);
            markers.Add(m2);
            markers[0] = "";
            markers[1] = "";
            try
            {

                using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SchoolPro"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand("Select nsch_id,strSchName+' '+strAddress as address,strLat as 'Latitude',strLng as 'Longitude' from tbl_School where bisDeleted=@fbit", con);
                    con.Open();
                    cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                    cmd.Parameters.AddWithValue("@tbit", BIT_T_F.TrueBit());
                    SqlDataReader reader = cmd.ExecuteReader();
                    int i = 0;

                    while (reader.Read())
                    {
                        if (reader["Latitude"].ToString() == "" || reader["Longitude"].ToString() == "")
                        { }
                        else
                        {

                            i++;
                            markers[0] +=
                            @"var marker" + i.ToString() + @" = new google.maps.Marker({
                            position: new google.maps.LatLng(" + reader["Latitude"].ToString() + ", " +
                            reader["Longitude"].ToString() + ")," +
                            @"map: myMap,
                            title:'" + reader["address"].ToString() + "'});";
                            //string url = reader["url"].ToString();
                            //if (url == "")
                            //{
                            //    url = "";
                            //}
                            //                            string urljs = Regex.Replace(url, "\\\\", "\\\\");
                            //                            string idd = reader["nsch_id"].ToString();
                            //                            string conn = reader["con"].ToString();
                            //                            string cty = reader["cty"].ToString();
                            //                            string title = reader["name"].ToString();
                            //                            string type = reader["type"].ToString();
                            //                            string bed = reader["bed"].ToString();
                            //                            string bath = reader["bath"].ToString();
                            //                            string price = reader["price"].ToString();
                            //                            string add = reader["Description"].ToString();
                            markers[0] += @"
                            google.maps.event.addListener(marker" + i.ToString() + ", 'click', function() { window.location = 'Parent-Registration.aspx'   }); ";
                        }
                    }
                }
            }
            catch { }
            return markers;
        }

        protected void btnsend_Click(object sender, EventArgs e)
        {
            Response.Redirect("Parent-Registration.aspx");
        }
    }
}




//                            markers[1] += @"
//                                           google.maps.event.addListener(marker" + i.ToString() + ", 'click', function() {    viewimg('" + idd + "','" + urljs + "','" + title + "','" + type + "','" + price + "','" + bed + "','" + bath + "','" + conn + "','" + cty + "','" + add + "');  }); ";