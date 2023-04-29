<%@ Page Title="" Language="C#" MasterPageFile="~/Parent.Master" AutoEventWireup="true" CodeBehind="ParentViewTeacher.aspx.cs" Inherits="SchoolPRO.ParentViewTeacher" %>

<%@ Import Namespace="SchoolPRO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function printDiv(printable) {
            var printContents = document.getElementById(printable).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>
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
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ne_id" SortExpression="ne_id" HeaderText="S.NO" />
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nc_id" SortExpression="nc_id" HeaderText="nsc_id.NO" />
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nsc_id" SortExpression="nsc_id" HeaderText="S.nsc_id" />
                                        <asp:BoundField DataField="strStudentNum" HeaderText="Student Number" SortExpression="strStudentNum" />
                                        <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                                        <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strLname" />
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                        <asp:BoundField DataField="strDOB" HeaderText="Date of Birth" SortExpression="strDOB" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnviewteacher" runat="server" Text="View Teacher" class="width-95 pull-left btn btn-sm btn-success" OnClick="btnviewteacher_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>

                                <asp:SqlDataSource ID="pstview" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT e.ne_id,e.strStudentNum,e.strFname,e.strLname,c.strClass,e.strDOB,e.nc_id,nsc_id from tbl_Enrollment e inner join tbl_Class c on e.nc_id=c.nc_id where e.bisDeleted='False' and e.nu_id=@u_id and e.nsch_id=@schid ">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="u_id" SessionField="uid" />
                                        <asp:SessionParameter Name="em" SessionField="userval" />
                                        <asp:SessionParameter SessionField="nschoolid" Name="schid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                            </div>
                        </asp:View>
                        <asp:View runat="server" ID="v2">
                            <asp:Button ID="btnBack" runat="server" Text="Back" class="width-60 pull-left btn btn-sm btn-success" OnClick="btnBack_Click" />
                            <div class="table-responsive">
                                <asp:GridView ID="gvteacher" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="teacherDs">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nu_id" SortExpression="ne_id" HeaderText="S.NO" />

                                        <asp:BoundField DataField="tname" HeaderText="Teacher Name" ReadOnly="True" SortExpression="tname"></asp:BoundField>
                                        <asp:BoundField DataField="strPhone" HeaderText="Teacher Phone" SortExpression="strPhone"></asp:BoundField>
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass"></asp:BoundField>
                                        <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection"></asp:BoundField>
                                        <asp:BoundField DataField="strSubject" HeaderText="Subject" SortExpression="strSubject"></asp:BoundField>
                                        <asp:BoundField DataField="strPeriod" HeaderText="Period" SortExpression="strPeriod"></asp:BoundField>
                                        <asp:BoundField DataField="strDay" HeaderText="Day" SortExpression="strDay"></asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnSndMsgteacher" runat="server" Text="Send Message" class="width-95 pull-left btn btn-sm btn-success" OnClick="btnSndMsgteacher_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button OnClick="btnviewatndnc_Click" ID="btnviewatndnc" runat="server" Text="Rating Teacher" class="width-95 pull-left btn btn-sm btn-success" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button OnClick="btnleave_Click" ID="btnleave" runat="server" Text="Request For Leave" class="width-95 pull-left btn btn-sm btn-success" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>

                                <asp:SqlDataSource ID="teacherDs" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Users.strfname + ' ' + tbl_Users.strlname AS tname, tbl_Users.nu_id, tbl_Users.strPhone, tbl_Class.strClass, tbl_Section.strSection, tbl_Subject.strSubject,tbl_TimeTable.strPeriod,tbl_TimeTable.strDay FROM tbl_Users INNER JOIN tbl_TimeTable ON tbl_Users.nu_id = tbl_TimeTable.nu_id INNER JOIN tbl_Subject ON tbl_TimeTable.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Class ON tbl_TimeTable.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_TimeTable.nsc_id = tbl_Section.nsc_id WHERE (tbl_TimeTable.nc_id = @cid) AND (tbl_TimeTable.nsc_id = @scid) And tbl_TimeTable.bisDeleted='False' And tbl_TimeTable.nsch_id=@schid ">
                                    <SelectParameters>
                                        <asp:Parameter Name="cid" DefaultValue="0"></asp:Parameter>
                                        <asp:Parameter Name="scid" DefaultValue="0"></asp:Parameter>
                                        <asp:SessionParameter SessionField="nschoolid" Name="schid" />

                                    </SelectParameters>
                                </asp:SqlDataSource>

                            </div>
                        </asp:View>
                        <asp:View ID="View3" runat="server">
                            <div class="login-container">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Manage Messages
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Enter  Title: </p>
                                                <form id="Form2">
                                                    <fieldset>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddladduser" class="form-control" runat="server" DataSourceID="teachrDS" DataTextField="strfname" DataValueField="nu_id"></asp:DropDownList>
                                                                <asp:SqlDataSource runat="server" ID="teachrDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strlname], [nu_id], [strfname] FROM [tbl_Users] WHERE (([bisDeleted] = @bisDeleted) AND ([nu_id] = @nu_id))">
                                                                    <SelectParameters>
                                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                        <asp:Parameter DefaultValue="0" Name="nu_id" Type="Int32"></asp:Parameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <i class="icon-user"></i>
                                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage=" ControlToValidate="ddladduser"></asp:RequiredFieldValidator>--%>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">

                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtaddMessagetitle" class="form-control" placeholder="Message title" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Message Name" ControlToValidate="txtaddMessagetitle"></asp:RequiredFieldValidator>--%>
                                                            </span>
                                                        </label>
                                                        <p>Enter  Description: </p>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtaddMessagedesc" class="form-control" placeholder="Description" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Description" ControlToValidate="txtaddMessagedesc"></asp:RequiredFieldValidator>--%>
                                                            </span>
                                                        </label>



                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <asp:Button ID="btnaddMessage" runat="server" Text="Add Message" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddMessage_Click" />
                                                        </div>
                                                    </fieldset>
                                                </form>
                                            </div>
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
