<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminConformCancelTeacherLeave.aspx.cs" Inherits="SchoolPRO.AdminConformCancelTeacherLeave" %>

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

                        <asp:View runat="server" ID="v0">
                            <%--<asp:Button ID="btnBack" runat="server" Text="Back" class="width-95 pull-left btn btn-sm btn-success" OnClick="btnBack_Click" />--%>
                            <div class="table-responsive">
                                <asp:GridView ID="gvadmin" OnRowDataBound="gvadmin_RowDataBound" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="DSAdminConformleave" DataKeyNames="nLeav_id">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nLeav_id" HeaderText="nLeav_id" ReadOnly="True" SortExpression="nLeav_id" InsertVisible="False"></asp:BoundField>
                                        <asp:BoundField DataField="Teacher Name" HeaderText="Teacher Name" SortExpression="Teacher Name" ReadOnly="True"></asp:BoundField>
                                        <asp:BoundField DataField="Occupation" HeaderText="Occupation" SortExpression="Occupation"></asp:BoundField>
                                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email"></asp:BoundField>
                                        <asp:BoundField DataField="From" HeaderText="From" SortExpression="From"></asp:BoundField>
                                        <asp:BoundField DataField="To" HeaderText="To" SortExpression="To"></asp:BoundField>
                                        <asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason"></asp:BoundField>
                                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"></asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button CommandArgument='<%# Eval("nLeav_id") %>' ID="btnaccept" OnClick="btnaccept_Click" runat="server" Text="Accept" CssClass="width-70 pull-left btn btn-sm btn-primary" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button CommandArgument='<%# Eval("nLeav_id") %>' ID="btnreject" OnClick="btnreject_Click" runat="server" Text="Reject" CssClass="width-70 pull-left btn btn-sm btn-primary" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="DSAdminConformleave" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Leave.nLeav_id, tbl_Leave.bPanding AS 'Status', tbl_Users.strfname + ' ' + tbl_Users.strlname AS 'Teacher Name', tbl_Users.strOccupation AS 'Occupation', tbl_Users.strEmail AS 'Email', tbl_Leave.strFrom AS 'From', tbl_Leave.strTo AS 'To', tbl_Leave.strReason AS 'Reason' FROM tbl_Leave INNER JOIN tbl_Users ON tbl_Leave.nG_id = tbl_Users.nu_id WHERE (tbl_Leave.nLevel = 2) AND (tbl_Leave.bisDeleted = @fbit) AND (tbl_Leave.nsch_id = @sch) AND (tbl_Users.bisDeleted = @fbit) AND (tbl_Users.nsch_id = @sch)">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                        <asp:SessionParameter SessionField="nschoolid" DefaultValue="0" Name="sch"></asp:SessionParameter>
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
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
