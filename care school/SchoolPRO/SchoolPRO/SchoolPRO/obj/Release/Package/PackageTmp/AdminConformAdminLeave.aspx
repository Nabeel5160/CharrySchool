<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminConformAdminLeave.aspx.cs" Inherits="SchoolPRO.AdminConformAdminLeave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function myFunction() {
            document.getElementById("btnaccept").disabled = true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" ID="scr" />
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Admin Laeave
            </h4>
            <div class="space-6"></div>
            <asp:UpdatePanel ID="upquiz" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvquiz" ActiveViewIndex="0" runat="server">
                        <asp:View runat="server" ID="v0">
                            <%--<asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Add" class="width-10 pull-left btn btn-sm btn-success" />--%>
                            <div class="table-responsive">
                                <asp:GridView ID="gvadmin" OnRowDataBound="gvadmin_RowDataBound" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="nLeav_id" DataSourceID="DSAdminConformtechleav">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nLeav_id" HeaderText="nLeav_id" ReadOnly="True" InsertVisible="False" SortExpression="nLeav_id"></asp:BoundField>
                                        <asp:BoundField DataField="Teacher Name" HeaderText="Teacher Name" ReadOnly="True" SortExpression="Teacher Name"></asp:BoundField>
                                        <asp:BoundField DataField="From" HeaderText="From" SortExpression="From"></asp:BoundField>
                                        <asp:BoundField DataField="To" HeaderText="To" SortExpression="To"></asp:BoundField>
                                        <asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason"></asp:BoundField>
                                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"></asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnaccept" OnClientClick="myFunction()" runat="server" CommandArgument='<%# Eval("nLeav_id") %>' OnClick="btnaccept_Click" Text="Accept" CssClass="width-70 pull-left btn btn-sm btn-primary" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnreject" OnClick="btnreject_Click" CommandArgument='<%# Eval("nLeav_id") %>' runat="server" Text="Reject" CssClass="width-70 pull-left btn btn-sm btn-primary" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="DSAdminConformtechleav" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Leave.nLeav_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS 'Teacher Name', tbl_Leave.strFrom AS 'From', tbl_Leave.strTo AS 'To', tbl_Leave.strReason AS 'Reason', tbl_Leave.bPanding AS 'Status' FROM tbl_Leave INNER JOIN tbl_Users ON tbl_Leave.nG_id = tbl_Users.nu_id WHERE (tbl_Leave.nLevel = 1) AND (tbl_Leave.nsch_id = @sch) AND (tbl_Leave.bisDeleted = @fbit) AND (tbl_Users.nsch_id = @sch) AND (tbl_Users.bisDeleted = @fbit)">
                                    <SelectParameters>
                                        <asp:SessionParameter SessionField="nschoolid" DefaultValue="0" Name="sch"></asp:SessionParameter>
                                        <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
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
