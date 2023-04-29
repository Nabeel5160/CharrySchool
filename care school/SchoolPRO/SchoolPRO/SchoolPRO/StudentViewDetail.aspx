<%@ Page Title="" Language="C#" MasterPageFile="~/Student.Master" AutoEventWireup="true" CodeBehind="StudentViewDetail.aspx.cs" Inherits="SchoolPRO.StudentViewDetail" %>
<%@ Import Namespace="SchoolPRO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lbluval" runat="server" Text="Label" Visible="false"></asp:Label>
                            <asp:Label ID="lbluemail" runat="server" Text="Label" Visible="false"></asp:Label>
                            <div class="col-xs-12">
                                <!-- PAGE CONTENT BEGINS -->

                                <div class="row-fluid">
                                 
                <asp:UpdatePanel ID="upt" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                    <div class="table-responsive">
                                        <asp:GridView ID="gdpstudent" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="pstview">
                                            <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ne_id" SortExpression="ne_id" HeaderText="S.NO" />
                                                <asp:BoundField DataField="strStudentNum" HeaderText="Student Number" SortExpression="strStudentNum" />
                                                <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                                                <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strLname" />
                                                <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                                <asp:BoundField DataField="strDOB" HeaderText="Date of Birth" SortExpression="strDOB" />
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnviewatndnc" runat="server" Text="View Detail" class="width-95 pull-left btn btn-sm btn-success" OnClick="btnviewatndnc_Click" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>

                                        <asp:SqlDataSource ID="pstview" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT e.ne_id,e.strStudentNum,e.strFname,e.strLname,c.strClass,e.strDOB from tbl_Enrollment e inner join tbl_Class c on e.nc_id=c.nc_id where e.bisDeleted='False' and e.ne_id=@e_id and e.nsch_id=@schid ">
                <SelectParameters>
              
                    <asp:SessionParameter Name="schid" SessionField="nschoolid" />
              
                                                <asp:SessionParameter Name="e_id" SessionField="eid" Type="Int32" />
                                        </SelectParameters>
                                        </asp:SqlDataSource>

</div>
                                </asp:View>
                            <asp:View ID="View2" runat="server">
                                
                                <!-- PAGE CONTENT BEGINS -->
                               
                                <%
                                    System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
                                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
                                    System.Data.SqlClient.SqlDataReader dr;
                                %>
                                <%
                                  
                                    string query = "select c.strClass,f.strTutionFee,e.ne_id,e.strImage,e.strFname,e.strLname,e.strDOB,e.strBirthPlace,e.strNationality,e.strMotherlang,e.strReligion,e.strPhAddress,e.strCity,e.strState,e.strCountry,e.nPincode,e.strPhone,e.strEmail from tbl_Enrollment e inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Fee f on e.nfee_id=f.nfee_id where e.ne_id='" + Session["id"] + "' and e.bisDeleted='False' and e.nsch_id='"+Session["nschoolid"]+"'";
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
                                                c.id = dr["ne_id"].ToString();
                                                c.classnm = dr["strClass"].ToString();
                                                c.fee = dr["strTutionFee"].ToString();
                                                c.image = dr["strImage"].ToString();
                                                c.efname = dr["strFname"].ToString();
                                                c.emname = dr["strLname"].ToString();
                                                c.dob = dr["strDOB"].ToString();
                                                c.bplace = dr["strBirthPlace"].ToString();
                                                c.nationality = dr["strNationality"].ToString();
                                                c.mlang = dr["strMotherlang"].ToString();
                                                c.religion = dr["strReligion"].ToString();
                                                c.adrs = dr["strPhAddress"].ToString();
                                                c.city = dr["strCity"].ToString();
                                                c.state = dr["strState"].ToString();
                                                c.country = dr["strCountry"].ToString();
                                                c.pcode = dr["nPincode"].ToString();
                                                c.phn = dr["strPhone"].ToString();
                                                c.email = dr["strEmail"].ToString();
                                                tempList.Add(c);
                                            }
                                            tempList.TrimExcess();
                                            con.Close();
                                            foreach (var c in tempList)
                                            {
                                %>
                                <div class="row-fluid"  >
                                    <div id="printable">
                                        <div id="user-profile-1" class="user-profile row" >
                                            <div class="col-xs-12 col-sm-3 center" >
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

                                            <div class="col-xs-12 col-sm-9">


                                                <div class="space-12"></div>

                                                <div class="profile-user-info profile-user-info-striped">

                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Enrolment # </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span3"><%lbleid.Text = c.id; %><asp:Label ID="lbleid" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
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
                                                        <div class="profile-info-name">BirthPlace </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span1"><%lblbp.Text = c.bplace; %><asp:Label ID="lblbp" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Nationality </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span2"><%lblntn.Text = c.nationality; %><asp:Label ID="lblntn" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                   <%--<div class="profile-info-row">
                                                        <div class="profile-info-name">Mother Language </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span3"><%lblmlng.Text = c.mlang; %><asp:Label ID="lblmlng" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>--%>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Religion </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span4"><%lblrelg.Text = c.religion; %><asp:Label ID="lblrelg" runat="server" Text="Label"></asp:Label></span>
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
                                                        <div class="profile-info-name">Fee </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span11"><%lblfee.Text = c.fee; %><asp:Label ID="lblfee" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Class </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span5"><%lblcl.Text = c.classnm; %><asp:Label ID="lblcl" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>

                                                </div>
                                                <%}
                                                %>
                                                <%
                                                            }
                                                        }
                                                %>

                                                <div class="space-20"></div>
                                                <asp:Button ID="btnuedit" runat="server" Text="Go Back" class="width-65 pull-left btn btn-sm btn-success" OnClick="btnuedit_Click" />
                                                <asp:Button ID="btnprint" runat="server" class="width-65 pull-left btn btn-sm btn-success" Text="Print Form" OnClientClick="printDiv('printable')" />
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

                                </div>
                                <!-- PAGE CONTENT ENDS -->
                            </div>
                            <!-- /.col -->
</asp:Content>
