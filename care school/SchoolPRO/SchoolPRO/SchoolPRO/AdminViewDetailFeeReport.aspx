<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewDetailFeeReport.aspx.cs" Inherits="SchoolPRO.AdminViewDetailFeeReport" %>
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
    <script type="text/javascript">

        function KeyUp(txtsearch, gvbystnum) {
            if ($(txtsearch).val() != "") {

                $(gvbystnum).children('tbody').children('tr').each(function () {
                    $(this).show();
                });

                $(gvbystnum).children('tbody').children('tr').each(function () {
                    var match = false;
                    if ($(this).text().toUpperCase().indexOf($(txtsearch).val().toUpperCase()) > 0) match = true;
                    if (match) $(this).show();
                    else $(this).hide();
                });
            }
            else {

                $(gvbystnum).children('tbody').children('tr').each(function () {
                    $(this).show();
                });
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                View Students Fee
            </h4>
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvatnd" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <div class="table-responsive">
                                <asp:GridView ID="gvbyclass" ShowHeader="true" class="table table-striped table-bordered table-hover" AutoGenerateColumns="false" DataSourceID="sqlbyclass" runat="server">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nc_id" HeaderText="S.NO" SortExpression="nc_id">
                                            <HeaderStyle CssClass="hidden" />
                                            <ItemStyle CssClass="hidden" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                        <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnvful" runat="server" Text="View Detail" class="width-65 pull-left btn btn-sm btn-success" OnClick="btnvful_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nsc_id" HeaderText="S.NO" SortExpression="nsc_id">
                                            <HeaderStyle CssClass="hidden" />
                                            <ItemStyle CssClass="hidden" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sqlbyclass" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Class.nc_id, tbl_Class.strClass, tbl_Section.strSection,tbl_Section.nsc_id FROM tbl_Class INNER JOIN tbl_Section ON tbl_Class.nc_id = tbl_Section.nc_id WHERE (tbl_Class.bisDeleted = 'False') and (tbl_Section.bisDeleted = 'False') and tbl_Class.nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </asp:View>
                        <asp:View ID="View2" runat="server">

                            <div id="printable">
                                <div class="visible-print ">
                                    <h4 class="center text-center bigger lighter">
                                        <img src="assets/img/sch_logo.jpg" />
                                        Ozone School System
                                    </h4>
                                </div>
                                <div class="widget-header header-color-blue">
                                    <h5 class="center text-center bigger lighter">
                                        <i class="icon-table"></i>
                                        Students With Paid Fee And With All Clear Dues
                                    </h5>

                                    <div class="widget-toolbar widget-toolbar-light no-border">
                                        <div class="hidden-print icon-print icon-2x" onclick="printDiv('printable')"></div>
                                    </div>
                                </div>

                                <div class="clearfix"></div>
                                <div class="space-6"></div>
                                <asp:Button Text="Go Back" class="hidden-print width-25 pull-left btn btn-sm btn-success" runat="server" ID="btngobck" OnClick="btngobck_Click" />

                                <div class="clearfix"></div>
                                <div class="space-6"></div>
                                <div class="row">
                                    <%--<div class="hidden-print col-md-4 col-xs-4">
                                        From Date:
                                            <asp:TextBox ID="txtfrm" class="form-control" placeholder=" Date" runat="server" MaxLength="10" onkeyup="return ismaxlength(this,10)"></asp:TextBox>
                                        <%--<asp:Button CssClass="hidden-print btn btn-success col-lg-6" Style="float:right" ID="btnSearch" Text="Click Here To Search" runat="server" />
                                        <asp:CalendarExtender Format="dd-MM-yyyy" ID="calendrdate" TargetControlID="txtfrm" runat="server"></asp:CalendarExtender>

                                        <%--<asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator21" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression="^[\s\S]{10,10}$" ControlToValidate="txtadmsndate"></asp:RequiredFieldValidator>
                                        <label id='lblCaption' style="font-family: Tahoma; font-size: 1em; font-weight: bold" cssclass="red"></label>


                                        <asp:RegularExpressionValidator ID="RegularExpressiossnValidator5" runat="server" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ForeColor="Red" Font-Bold="true" ControlToValidate="txtfrm" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="hidden-print col-md-4 col-xs-4">
                                        To Date:
                                            <asp:TextBox AutoPostBack="true" ID="txtto" class="form-control" placeholder=" Date" runat="server" MaxLength="10" OnTextChanged="txtadmsndate_TextChanged"></asp:TextBox>
                                        <%--<asp:Button CssClass="hidden-print btn btn-success col-lg-6" Style="float:right" ID="btnSearch" Text="Click Here To Search" runat="server" />
                                        <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtto" runat="server"></asp:CalendarExtender>

                                        <%--<asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator21" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression="^[\s\S]{10,10}$" ControlToValidate="txtadmsndate"></asp:RequiredFieldValidator>
                                        <label id='Label1' style="font-family: Tahoma; font-size: 1em; font-weight: bold" cssclass="red"></label>


                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ForeColor="Red" Font-Bold="true" ControlToValidate="txtto" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>
                                    </div>--%>
                                    <div class="clearfix"></div>
                                    <div class="hidden-print col-md-4 col-xs-4">
                                        <asp:TextBox ID="txtsearch" Style="margin-bottom: 10px" runat="server" type="text" class="form-control" onkeyup="return KeyUp(this, '#ContentPlaceHolder1_gvsearchclass');" placeholder="Search. . . " />
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-lg-12 col-xs-4">
                                        <h4>
                                            <asp:Label Text="" ID="lblclnsec" runat="server" /></h4>
                                    </div>
                                </div>
                                <div class="space-6"></div>
                                <div class="table-responsive">
                                    <asp:GridView  ID="gvsearchclass" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Exists" ShowFooter="true" ShowHeader="true" class="table table-striped table-bordered table-hover" runat="server" AllowSorting="True" AutoGenerateColumns="False">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.NO">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strClass" SortExpression="strClass" HeaderText="Class" />
                                            <asp:BoundField DataField="strSection" SortExpression="strSection" HeaderText="Section" />
                                            <asp:BoundField DataField="name" SortExpression="name" HeaderText="Student Name" />
                                            <asp:BoundField DataField="01" SortExpression="01" HeaderText="January" />
                                            <asp:BoundField DataField="02" SortExpression="02" HeaderText="February" />
                                            <asp:BoundField DataField="03" SortExpression="03" HeaderText="March" />
                                            <asp:BoundField DataField="04" SortExpression="04" HeaderText="April" />
                                            <asp:BoundField DataField="05" SortExpression="05" HeaderText="May" />
                                            <asp:BoundField DataField="06" SortExpression="06" HeaderText="June" />
                                            <asp:BoundField DataField="07" SortExpression="07" HeaderText="July" />
                                            <asp:BoundField DataField="08" SortExpression="08" HeaderText="August" />
                                            <asp:BoundField DataField="09" SortExpression="09" HeaderText="September" />
                                            <asp:BoundField DataField="10" SortExpression="10" HeaderText="October" />
                                            <asp:BoundField DataField="11" SortExpression="11" HeaderText="November" />
                                            <asp:BoundField DataField="12" SortExpression="12" HeaderText="December" />
                                        </Columns>
                                    </asp:GridView>
                                </div>

                            </div>

                        </asp:View>

                    </asp:MultiView>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="UpdateProgress1" DisplayAfter="10" runat="server">
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
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
