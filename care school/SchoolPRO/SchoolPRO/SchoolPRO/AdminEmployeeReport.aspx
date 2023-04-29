<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminEmployeeReport.aspx.cs" Inherits="SchoolPRO.AdminEmployeeReport" %>

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
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <div class="row-fluid">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">

                            <asp:View ID="View2" runat="server">

                                <div class="clearfix"></div>
                                <div class="clearfix"></div>
                                <div class="col-xs-12 col-sm-12 widget-container-span">
                                    <div class="widget-box" id="printable">
                                        <div class="widget-header header-color-blue">
                                            <h5 class="bigger lighter">
                                                <i class="icon-table"></i>
                                                Employee Report
                                            </h5>

                                            <div class="widget-toolbar widget-toolbar-light no-border">
                                                <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                            </div>
                                        </div>
                                        <div class="widget-body">
                                            <div class="widget-main no-padding">



                                                <asp:GridView ID="gv_detail_list" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sql_detail_list">
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex+1 %>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:BoundField DataField="strfname" HeaderText="First Name" SortExpression="strfname" />
                                                        <asp:BoundField DataField="strlname" HeaderText="Last Name" SortExpression="strlname" />
                                                        <asp:BoundField DataField="strSalary" HeaderText="Salary" SortExpression="strSalary" />
                                                        <asp:BoundField DataField="strAddress" HeaderText="Address" SortExpression="strAddress" />
                                                        <asp:BoundField DataField="strPhone" HeaderText="Phone" SortExpression="strPhone" />

                                                    </Columns>
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="sql_detail_list" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="select strfname,strlname,strSalary,strAddress,strPhone from tbl_Users where (nLevel='5' or nLevel='2' or nLevel='10' or nLevel='11' or nLevel='1') and bisDeleted='False' and nsch_id=@schid">
                                                    <SelectParameters>
                                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />

                                                    </SelectParameters>
                                                </asp:SqlDataSource>
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
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
