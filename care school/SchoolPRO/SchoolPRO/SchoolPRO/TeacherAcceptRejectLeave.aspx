<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherAcceptRejectLeave.aspx.cs" Inherits="SchoolPRO.TeacherAcceptRejectLeave" %>

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
                                <asp:GridView ID="gvteacher" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="DSTcsml">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Student Name" HeaderText="Student Name" SortExpression="Student Name" ReadOnly="True"></asp:BoundField>
                                        <asp:BoundField DataField="Class" HeaderText="Class" SortExpression="Class"></asp:BoundField>
                                        <asp:BoundField DataField="Section" HeaderText="Section" SortExpression="Section"></asp:BoundField>
                                        <asp:BoundField DataField="Leave Date" HeaderText="Leave Date" SortExpression="Leave Date"></asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnaccept" runat="server" Text="Accept" CssClass="width-55 pull-left btn btn-sm btn-primary" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnreject" runat="server" Text="Reject" CssClass="width-55 pull-left btn btn-sm btn-primary" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="DSTcsml" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT DISTINCT tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS 'Student Name', tbl_Class.strClass AS 'Class', tbl_Section.strSection AS 'Section', tbl_Leave.Date AS 'Leave Date' FROM tbl_Class INNER JOIN tbl_Section ON tbl_Class.nc_id = tbl_Section.nc_id INNER JOIN tbl_Leave ON tbl_Class.nc_id = tbl_Leave.nc_id AND tbl_Section.nsc_id = tbl_Leave.nsc_id INNER JOIN tbl_Enrollment ON tbl_Class.nc_id = tbl_Enrollment.nc_id AND tbl_Leave.nu_id = tbl_Enrollment.ne_id INNER JOIN tbl_Users ON tbl_Class.nu_id = tbl_Users.nu_id INNER JOIN tbl_TimeTable ON tbl_Class.nc_id = tbl_TimeTable.nc_id INNER JOIN tbl_ClassIncharge ON tbl_TimeTable.nu_id = tbl_ClassIncharge.nu_id WHERE (tbl_ClassIncharge.nu_id = @secuid)">
                                    <SelectParameters>
                                        <asp:SessionParameter SessionField="uid" DefaultValue="0" Name="secuid"></asp:SessionParameter>
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
