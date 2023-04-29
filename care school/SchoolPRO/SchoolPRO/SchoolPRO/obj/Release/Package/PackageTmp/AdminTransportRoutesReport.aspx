<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminTransportRoutesReport.aspx.cs" Inherits="SchoolPRO.AdminTransportRoutesReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Transport Routes Report
                </h4>
                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="MultiView1" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <%--<asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" />--%>
                                <div class="table-responsive">
                                    <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="DSRotRepot">

                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Route Name" HeaderText="Route Name" SortExpression="Route Name"></asp:BoundField>
                                            <asp:BoundField DataField="Route #" HeaderText="Route #" SortExpression="Route #"></asp:BoundField>
                                            <asp:BoundField DataField="PickTime" HeaderText="PickTime" SortExpression="PickTime"></asp:BoundField>
                                            <asp:BoundField DataField="DropTime" HeaderText="DropTime" SortExpression="DropTime"></asp:BoundField>
                                            <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount"></asp:BoundField>
                                            <asp:BoundField DataField="Vehicle Type" HeaderText="Vehicle Type" SortExpression="Vehicle Type"></asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource runat="server" ID="DSRotRepot" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Route.strRouteName AS 'Route Name', tbl_Route.strRouteNumber AS 'Route #', tbl_Route.strPickTime AS 'PickTime', tbl_Route.strDropTime AS 'DropTime', tbl_Route.strAmount AS 'Amount', tbl_Vehicle.strType AS 'Vehicle Type' FROM tbl_Vehicle INNER JOIN tbl_Route ON tbl_Vehicle.nrt_id = tbl_Route.nrt_id WHERE (tbl_Vehicle.bisDeleted = @fbit) AND (tbl_Route.bisDeleted = @fbit) AND (tbl_Vehicle.nsch_id=@schid)">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                            <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <div class="space-4"></div>
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
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
