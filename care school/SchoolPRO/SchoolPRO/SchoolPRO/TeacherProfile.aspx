<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherProfile.aspx.cs" Inherits="SchoolPRO.TeacherProfile" %>
<%@ Import Namespace="SchoolPRO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="sc" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upregst" runat="server">
                <ContentTemplate>
                    <asp:MultiView ActiveViewIndex="0" ID="mvsub" runat="server">
                          <asp:View ID="View3" runat="server">
                                <asp:Label ID="stnum" runat="server" Text="Label" Visible="false"></asp:Label>
                                <!-- PAGE CONTENT BEGINS -->
                                <%
                                    //stnum.Text = Session["email"].ToString();
                                %>
                                <%
                                    System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
                                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
                                    System.Data.SqlClient.SqlDataReader dr;
                                %>
                                <%
                                  
                                    string query = "select strImage,strFname,strMname,strDOB,strEducation,strAddress,strCity,strState,strCountry,strPincode,strPhone,strEmail,strSalary from tbl_Users where nu_id='"+Session["uid"]+"'";
                                    cmd.Connection = con;
                                    con.Open();
                                    cmd.CommandType = System.Data.CommandType.Text;
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
                                                c.image = dr["strImage"].ToString();
                                                c.efname = dr["strFname"].ToString();
                                                c.emname = dr["strMname"].ToString();
                                                c.dob = dr["strDOB"].ToString();
                                                c.edu = dr["strEducation"].ToString();
                                                c.adrs = dr["strAddress"].ToString();
                                                c.city = dr["strCity"].ToString();
                                                c.state = dr["strState"].ToString();
                                                c.country = dr["strCountry"].ToString();
                                                c.pcode = dr["strPincode"].ToString();
                                                c.phn = dr["strPhone"].ToString();
                                                c.email = dr["strEmail"].ToString();
                                                c.inc = dr["strSalary"].ToString();
                                                tempList.Add(c);
                                            }
                                            tempList.TrimExcess();
                                            con.Close();
                                            foreach (var c in tempList)
                                            {
                                %>
                                <div class="row-fluid">
                                    <div>
                                        <div id="user-profile-1" class="user-profile row">
                                            <div class="col-xs-12 col-sm-3 center">
                                                <div>
                                                    <span class="profile-picture">
                                                        <% avatar.ImageUrl = c.image; %><asp:Image ID="avatar" class="editable img-responsive" runat="server" />
                                                        <%--<img ID="avatar" class="editable img-responsive" alt="Alex's Avatar" src="assets/avatars/profile-pic.jpg" />--%>
                                                    </span>

                                                    <div class="space-4"></div>

                                                    <div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
                                                        <div class="inline position-relative">
                                                            <a href="#" class="user-title-label dropdown-toggle" data-toggle="dropdown">
                                                                <i class="icon-circle light-green middle"></i>
                                                                &nbsp;
															<span class="white"><%lblefn.Text = c.efname; %><asp:Label ID="lblefn" runat="server" Text="Label"></asp:Label>&nbsp;<%lblmn.Text = c.emname; %><asp:Label ID="lblmn" runat="server" Text="Label"></asp:Label></span>
                                                            </a>


                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="space-6"></div>



                                                <div class="hr hr12 dotted"></div>
                                                <div class="hr hr16 dotted"></div>
                                            </div>

                                            <div class="col-xs-12 col-sm-9" style="width:72%;">


                                                <div class="space-12"></div>

                                                <div class="profile-user-info profile-user-info-striped">

                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Email </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="username"><%lblem.Text = c.email; %><asp:Label ID="lblem" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>



                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Date of Birth </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="age"><%lbldob.Text = c.dob; %><asp:Label ID="lbldob" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Education </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span1"><%lbledu.Text = c.edu; %><asp:Label ID="lbledu" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Address </div>

                                                        <div class="profile-info-value">
                                                            <i class="icon-map-marker light-orange bigger-110"></i>
                                                            <span class="editable" id="country"><%lbladr.Text = c.adrs; %><asp:Label ID="lbladr" runat="server" Text="Label"></asp:Label></span>

                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">City </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span6"><%lblcit.Text = c.city; %><asp:Label ID="lblcit" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">State </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span8"><%lblst.Text = c.state; %><asp:Label ID="lblst" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Country </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span7"><%lblcnt.Text = c.country; %><asp:Label ID="lblcnt" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Pincode </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span9"><%lblpcode.Text = c.pcode; %><asp:Label ID="lblpcode" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Phone </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span10"><%lblph.Text = c.phn; %><asp:Label ID="lblph" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Salary </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span11"><%lblfee.Text = c.inc; %><asp:Label ID="lblfee" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>

                                                </div>
                                                <%}
                                                %>
                                                <%
                                                            }
                                                            else
                                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Teacher Not Found.');", true);
                                                        }
                                                %>

                                                <div class="space-20"></div>
                                                <%--<asp:Button ID="btnuedit" runat="server" Text="Edit" class="width-65 pull-left btn btn-sm btn-success" OnClick="btnuedit_Click" />
                                                <asp:Button ID="btndelete" runat="server" Text="Delete" class="width-65 pull-left btn btn-sm btn-success" OnClick="btndelete_Click" />--%>
                                                <div class="hr hr2 hr-double"></div>

                                                <div class="space-6"></div>


                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </asp:View>   
                    
                    </asp:MultiView>
                    </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress DisplayAfter="10" runat="server">
                    <ProgressTemplate>
                        <div class="loading" align="center">
                            Loading. Please wait.<br />
                            <br />
                            <img src="assets/images/loader.gif" alt="" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
    


</asp:Content>
