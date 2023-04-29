<%@ Page Title="" Language="C#" MasterPageFile="~/Parent.Master" AutoEventWireup="true" CodeBehind="ParentViewRating.aspx.cs" Inherits="SchoolPRO.ParentViewRating" %>
<%@ Import Namespace="SchoolPRO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lbluval" runat="server" Text="Label" Visible="false"></asp:Label>
    <asp:Label ID="lbluemail" runat="server" Text="Label" Visible="false"></asp:Label>
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
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
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnrate" runat="server" Text="View Rating" class="width-65 pull-left btn btn-sm btn-success" OnClick="btnrate_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>

                                <asp:SqlDataSource ID="pstview" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT e.ne_id,e.strStudentNum,e.strFname,e.strLname,c.strClass from tbl_Enrollment e inner join tbl_Class c on e.nc_id=c.nc_id where e.bisDeleted='False' and e.nu_id=@u_id AND e.nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="u_id" SessionField="uid" Type="Int32" />
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
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
                                  
                                string query = "select e.strImage,e.strFname,e.strLname,sb.strSubject,r.strPoints,r.strOutOf,r.strRemarks from tbl_Rating r inner join tbl_Enrollment e on r.ne_id=e.ne_id inner join tbl_Subject sb on r.nsbj_id=sb.nsbj_id where e.ne_id='"+Session["id"]+"' and r.bisDeleted='False' and r.nsch_id='"+Session["nschoolid"]+"'";
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
                                            c.emname = dr["strLname"].ToString();
                                            c.points = dr["strPoints"].ToString();
                                            c.tpnts = dr["strOutOf"].ToString();
                                            c.remarks = dr["strRemarks"].ToString();
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

                                        <div class="col-xs-12 col-sm-9">


                                            <div class="space-12"></div>

                                            <div class="profile-user-info profile-user-info-striped">


                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Total Points </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="username"><%lblem.Text = c.tpnts; %><asp:Label ID="lblem" runat="server" Text="Label"></asp:Label></span>
                                                    </div>
                                                </div>

                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Obtain Marks </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="age"><%lbldob.Text = c.points; %><asp:Label ID="lbldob" runat="server" Text="Label"></asp:Label></span>
                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Remarks </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span1"><%lblbp.Text = c.remarks; %><asp:Label ID="lblbp" runat="server" Text="Label"></asp:Label></span>
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

