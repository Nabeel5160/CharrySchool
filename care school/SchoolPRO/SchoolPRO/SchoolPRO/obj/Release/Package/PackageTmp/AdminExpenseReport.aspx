<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminExpenseReport.aspx.cs" Inherits="SchoolPRO.AdminExpenseReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link rel="stylesheet" href="assets/css/jquery-ui.css">
  <script src="assets/js/jquery-1.10.2.js"></script>
  <script src="assets/js/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script>
      //$(function () {
      //    $("#ContentPlaceHolder1_txtfrom").datepicker();
      //});
      //$(function () {
      //    $("#ContentPlaceHolder1_txtto").datepicker();
      //});
  </script>
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
            <%--<asp:ScriptManager ID="ScriptManager1" runat="server" />--%>
            <asp:ToolkitScriptManager  ID="tool1" runat="server"  ></asp:ToolkitScriptManager>
            <div class="row-fluid">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <div class="col-md-4">
                                    <asp:Button ID="btnview_full" CssClass="btn btn-success" runat="server" Text="View All Expenses" OnClick="btnview_full_Click" />
                             
                                </div>
                                   <div class="clearfix"><br /></div>
                                   <div class="clearfix"><br /></div>
                                  <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Employee Expense Report
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                <div class="clearfix"><br /></div>
                                <div class="col-lg-8">
                                    <div class="col-lg-4">
                                        <asp:TextBox ID="txtfrom" runat="server"></asp:TextBox>
                                        <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtfrom" runat="server"></asp:CalendarExtender>
                                    </div>
                                    <div class="col-lg-4">
                                    <asp:TextBox ID="txtto" AutoPostBack="true" runat="server"></asp:TextBox>
                                        <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtto" runat="server"></asp:CalendarExtender>
                                        </div>
                                </div>
                                <asp:GridView ID="gvstlist" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sqlstlist">
                                    <Columns>
                                        <asp:TemplateField >
                                           <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nex_id" HeaderText="S.NO" SortExpression="nex_id" />
                                        <asp:BoundField DataField="strVoucherNum" HeaderText="Class" SortExpression="strVoucherNum" />
                                        <asp:BoundField DataField="strReason" HeaderText="Section" SortExpression="strReason" />
                                        <asp:BoundField DataField="strAmount" HeaderText="Amount" SortExpression="strAmount" />
                                        <asp:BoundField DataField="strPaymentMethod" HeaderText="Payment Method" SortExpression="strPaymentMethod" />
                                        <asp:BoundField DataField="strAccNum" HeaderText="Account #" SortExpression="strAccNum" />
                                        <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                                        <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strLname" />
                                        <asp:BoundField DataField="dtAddDate" HeaderText="Expense Date" SortExpression="dtAddDate" />
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sqlstlist" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="select e.nex_id,e.strVoucherNum,e.strReason,e.strAmount,e.strPaymentMethod,b.strAccNum,u.strfname,u.strlname, e.dtAddDate from tbl_Expense e inner join tbl_Users u on e.nu_id=u.nu_id inner join tbl_Bank b on e.nbnk_id=b.nbnk_id where e.dtAddDate>=@from and e.dtAddDate<=@to and e.bisDeleted='False' and e.nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:ControlParameter Name="from" ControlID="txtfrom" Type="String" />
                                        <asp:ControlParameter Name="to" ControlID="txtto" Type="String" />
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <div class="col-xs-12 col-sm-12 widget-container-span">
                                    <div class="widget-box" id="printable">
                                        <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Employee Expense Report
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                        <div class="widget-body">
												<div class="widget-main no-padding">
                                 <asp:GridView ID="gv_detail_list" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sql_detail_list">
                                    <Columns><asp:TemplateField >
                                           <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nex_id" HeaderText="S.NO" SortExpression="nex_id" />
                                        <asp:BoundField DataField="strVoucherNum" HeaderText="Class" SortExpression="strVoucherNum" />
                                        <asp:BoundField DataField="strReason" HeaderText="Section" SortExpression="strReason" />
                                        <asp:BoundField DataField="strAmount" HeaderText="Amount" SortExpression="strAmount" />
                                        <asp:BoundField DataField="strPaymentMethod" HeaderText="Payment Method" SortExpression="strPaymentMethod" />
                                        <asp:BoundField DataField="strAccNum" HeaderText="Account #" SortExpression="strAccNum" />
                                        <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                                        <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strLname" />
                                        <asp:BoundField DataField="dtAddDate" HeaderText="Expense Date" SortExpression="dtAddDate" />
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sql_detail_list" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="select e.nex_id,e.strVoucherNum,e.strReason,e.strAmount,e.strPaymentMethod,b.strAccNum,u.strfname,u.strlname, e.dtAddDate from tbl_Expense e inner join tbl_Users u on e.nu_id=u.nu_id inner join tbl_Bank b on e.nbnk_id=b.nbnk_id where e.bisDeleted='False' and e.nsch_id=@schid">
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
