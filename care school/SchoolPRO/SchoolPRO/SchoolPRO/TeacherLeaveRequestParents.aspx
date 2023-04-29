<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherLeaveRequestParents.aspx.cs" Inherits="SchoolPRO.TeacherLeaveRequestParents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
        <asp:ScriptManager runat="server" ID="scr" />
        <div class="row-fluid">
            <asp:UpdatePanel ID="upt" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">

                        <asp:View runat="server" ID="v2">
                            <%--<asp:Button ID="btnBack" runat="server" Text="Back" class="width-95 pull-left btn btn-sm btn-success" OnClick="btnBack_Click" />--%>
                            <div class="table-responsive">
                                <asp:GridView ID="gvteacher" OnRowDataBound="gvteacher_RowDataBound" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="nLeav_id" DataSourceID="DSTPRL">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nLeav_id" HeaderText="nLeav_id" ReadOnly="True" InsertVisible="False" SortExpression="nLeav_id"></asp:BoundField>
                                        <asp:BoundField DataField="Requested By" HeaderText="Requested By" SortExpression="Requested By"></asp:BoundField>
                                        <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation"></asp:BoundField>
                                        <asp:BoundField DataField="Student Name" HeaderText="Student Name" SortExpression="Student Name" ReadOnly="True"></asp:BoundField>
                                        <asp:BoundField DataField="Class" HeaderText="Class" SortExpression="Class"></asp:BoundField>
                                        <asp:BoundField DataField="Section" HeaderText="Section" SortExpression="Section"></asp:BoundField>
                                        <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject"></asp:BoundField>
                                        <asp:BoundField DataField="Subject Code" HeaderText="Subject Code" SortExpression="Subject Code"></asp:BoundField>
                                        <asp:BoundField DataField="From" HeaderText="From" SortExpression="From"></asp:BoundField>
                                        <asp:BoundField DataField="To" HeaderText="To" SortExpression="To"></asp:BoundField>
                                        <asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason"></asp:BoundField>
                                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"></asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnaccept" OnClick="btnaccept_Click" CommandArgument='<%# Eval("nLeav_id") %>' runat="server" Text="Accept" CssClass="width-70 pull-left btn btn-sm btn-primary" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnreject" OnClick="btnreject_Click" CommandArgument='<%# Eval("nLeav_id") %>' runat="server" Text="Reject" CssClass="width-70 pull-left btn btn-sm btn-primary" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="DSTPRL" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT DISTINCT tbl_Leave.nLeav_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS 'Requested By', tbl_Users.strRelation AS 'Relation', tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS 'Student Name', tbl_Class.strClass AS 'Class', tbl_Section.strSection AS 'Section', tbl_Subject.strSubject AS 'Subject', tbl_Subject.strCourseCode AS 'Subject Code', tbl_Leave.strFrom AS 'From', tbl_Leave.strTo AS 'To', tbl_Leave.strReason AS 'Reason', tbl_Leave.bPanding AS 'Status', tbl_TimeTable.nsbj_id FROM tbl_Leave INNER JOIN tbl_Class ON tbl_Leave.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_Leave.nsc_id = tbl_Section.nsc_id INNER JOIN tbl_Subject ON tbl_Leave.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Enrollment ON tbl_Leave.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Users ON tbl_Leave.nG_id = tbl_Users.nu_id INNER JOIN tbl_TimeTable ON tbl_Class.nc_id = tbl_TimeTable.nc_id AND tbl_Leave.nsbj_id = tbl_TimeTable.nsbj_id AND tbl_Leave.nc_id = tbl_TimeTable.nc_id AND tbl_Leave.nsc_id = tbl_TimeTable.nsc_id WHERE (tbl_Class.bisDeleted = @fbit) AND (tbl_Enrollment.bisDeleted = @fbit) AND (tbl_Leave.bisDeleted = @fbit) AND (tbl_Section.bisDeleted = @fbit) AND (tbl_Subject.bisDeleted = @fbit) AND (tbl_Users.bisDeleted = @fbit) AND (tbl_Class.nsch_id = @schid) AND (tbl_Leave.nsch_id = @schid) AND (tbl_Section.nsch_id = @schid) AND (tbl_Subject.nsch_id = @schid) AND (tbl_Users.nsch_id = @schid) AND (tbl_Enrollment.nsch_id = @schid) AND (tbl_TimeTable.nu_id = @uwid)">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                        <asp:SessionParameter SessionField="nschoolid" DefaultValue="0" Name="schid"></asp:SessionParameter>
                                        <asp:SessionParameter SessionField="uid" DefaultValue="0" Name="uwid"></asp:SessionParameter>
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
        </div>
    </div>
</asp:Content>
