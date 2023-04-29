<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherviewStudents.aspx.cs" Inherits="SchoolPRO.TeacherviewStudents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Students
            </h4>

            <div class="space-6"></div>
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvatnd" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">

                            <div class="space-22"></div>
                            <div id="printable" class="table-responsive">
                                <div class="widget-header header-color-blue">
                                    <h5 class="bigger lighter">
                                        <i class="icon-table"></i>
                                        Students
                                    </h5>

                                    <div class="widget-toolbar widget-toolbar-light no-border">
                                        <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                    </div>
                                </div>
                                <asp:GridView ID="gvsubst" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="sqlst">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nc_id" SortExpression="nc_id" HeaderText="S.NO" />
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nsc_id" SortExpression="nc_id" HeaderText="S.NO" />
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                        <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                        <%--<asp:BoundField DataField="strCourseCode" HeaderText="Course Code" SortExpression="strCourseCode" />--%>
                                        <%--<asp:BoundField DataField="strSubject" HeaderText="Subject" SortExpression="strSubject" />--%>
                                        <asp:TemplateField HeaderText="Students Info">
                                            <ItemTemplate>
                                                <asp:Button ID="btndattnd" runat="server" Text="View Students" CssClass="width-55 pull-left btn btn-sm btn-primary" OnClick="btndattnd_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>


                                <asp:SqlDataSource ID="sqlst" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT Distinct c.strClass,c.nc_id,sc.nsc_id, sc.strSection FROM tbl_TimeTable AS t inner join tbl_Section sc on t.nsc_id=sc.nsc_id INNER JOIN tbl_Class AS c ON t.nc_id = c.nc_id INNER JOIN tbl_Subject AS s ON t.nsbj_id = s.nsbj_id INNER JOIN tbl_Users AS u ON t.nu_id = u.nu_id WHERE (u.strEmail =@uem ) and t.bisDeleted='False' and t.nsch_id=@schid1">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="schid1" SessionField="nschoolid" />
                                        <asp:SessionParameter SessionField="userval" Name="uem" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <div class="space-4"></div>

                            </div>
                            <%--<lable ID="btnprint" runat="server" class="width-10 pull-left btn btn-sm btn-success" onclick="printDiv('printable')">
                                Print Attendance

                            </lable>--%>
                        </asp:View>
                        <asp:View runat="server" ID="v2">
                            <asp:Button ID="btnback" runat="server" Text="Back" CssClass="width-55 pull-left btn btn-sm btn-primary" OnClick="btnback_Click" />
                            <div class="table-responsive">
                                <%--<asp:TemplateField>
                                    <itemtemplate>
                                        <%# Container.DataItemIndex+1 %>
                                    </itemtemplate>
                                </asp:TemplateField>--%>


                                <asp:GridView ID="gvattnd" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="sqlattnd" DataKeyNames="ne_id">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ne_id" SortExpression="ne_id" HeaderText="ne_id" InsertVisible="False" ReadOnly="True" />
                                        <asp:BoundField DataField="strStudentNum" HeaderText="Student Number" SortExpression="strStudentNum" />
                                        <asp:BoundField DataField="stname" HeaderText="Name" SortExpression="stname" ReadOnly="True" />
                                        <asp:BoundField DataField="name" HeaderText="Garudian Name" SortExpression="name" ReadOnly="True" />
                                        <asp:BoundField DataField="strPhone" HeaderText="Garudian Phone Number" SortExpression="name" ReadOnly="True" />
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <asp:Button ID="btnRating" runat="server" Text="Student Rating" CssClass="width-55 pull-left btn btn-sm btn-primary" OnClick="btnRating_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nc_id" SortExpression="nc_id" HeaderText="" InsertVisible="False" ReadOnly="True" />
                                    </Columns>
                                </asp:GridView>

                                <asp:SqlDataSource ID="sqlattnd" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Enrollment.ne_id,tbl_Enrollment.nc_id, tbl_Enrollment.strStudentNum, tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS stname, tbl_Users.strfname + ' ' + tbl_Users.strlname AS name, tbl_Users.strPhone FROM tbl_Enrollment INNER JOIN tbl_Users ON tbl_Enrollment.nu_id = tbl_Users.nu_id WHERE (tbl_Enrollment.nc_id = @cid) And (tbl_Enrollment.nsc_id = @scid) AND (tbl_Enrollment.strStudentNum IS NOT NULL) AND (tbl_Enrollment.nsch_id = @sn) AND (tbl_Enrollment.bisDeleted = 'False') AND (tbl_Users.bisDeleted = 'False') AND (tbl_Users.nLevel = '3')">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="0" Name="cid"></asp:Parameter>
                                        <asp:Parameter DefaultValue="0" Name="scid"></asp:Parameter>
                                        <asp:SessionParameter SessionField="nschoolid" Name="sn" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

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

            <div class="space-12"></div>

            <!-- /.page-content -->
        </div>
        <!-- /.main-content -->

    </div>
</asp:Content>
