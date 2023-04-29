<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewSalaryReport.aspx.cs" Inherits="SchoolPRO.AdminViewSalaryReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
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
         <%--   <asp:ScriptManager ID="ScriptManager1" runat="server" />--%>
            <asp:ToolkitScriptManager  ID="tool1" runat="server"  ></asp:ToolkitScriptManager>
            <div class="row-fluid">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <div class="col-xs-12 col-sm-12 widget-container-span">
                                    <div class="widget-box" id="printable">
                                        <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Employee Salary Report
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                        <div class="widget-body">
												<div class="widget-main no-padding">
                                                    <div class="clearfix"></div>
                                                    <div class="space-4"></div>
                                                    <div class="col-lg-3">
                                                        <asp:TextBox ID="txtfrom" runat="server"></asp:TextBox>
                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtfrom" runat="server"></asp:CalendarExtender>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <asp:TextBox ID="txtto" AutoPostBack="true" runat="server"></asp:TextBox>
                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtto" runat="server"></asp:CalendarExtender>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                    <div class="space-4"></div>
                                <asp:GridView ID="gvstlist" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sqlstlist">
                                    <Columns>
                                         <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nsal_id" HeaderText="S.NO" SortExpression="nsal_id" />
                                        <asp:BoundField DataField="strfname" HeaderText="First Name" SortExpression="strfname" />
                                        <asp:BoundField DataField="strlname" HeaderText="Last Name" SortExpression="strlname" />
                                        <asp:BoundField DataField="strSalary" HeaderText="Salary" SortExpression="strSalary" />
                                        <asp:BoundField DataField="strBonus" HeaderText="Bonus" SortExpression="strBonus" />
                                        <asp:BoundField DataField="strFine" HeaderText="Fine" SortExpression="strFine" />
                                        <asp:BoundField DataField="dtAddDate" HeaderText="Salary Date" SortExpression="dtAddDate" />
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sqlstlist" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="select s.nsal_id, s.strSalary,s.strBonus,s.strFine,s.dtAddDate,u.strfname,u.strlname from tbl_Salary s inner join tbl_Users u on s.nu_id=u.nu_id  where s.dtAddDate>=@from and s.dtAddDate<=@to and s.bisDeleted='False' s.nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:ControlParameter Name="from" ControlID="txtfrom" Type="String" />
                                        <asp:ControlParameter Name="to" ControlID="txtto" Type="String" />
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

