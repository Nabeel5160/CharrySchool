<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDailyDiary.aspx.cs" Inherits="SchoolPRO.AdminDailyDiary" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="DropDownCheckBoxes" Namespace="Saplin.Controls" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .modalBackground {
            background-color: white;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .modalPopup h2 {
            color: white;
        }
    </style>
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
            <div class="col-lg-12">
                <h5 style="color: red">Instruction</h5>
                <ul>
                    <li>Select class Name and Enter respective Diary </li>
                </ul>
            </div>
            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Manage Diary
                </h4>

                <div class="space-4"></div>

                <%--<cc1:ToolkitScriptManager runat="server"></cc1:ToolkitScriptManager>--%>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="MultiView1" ActiveViewIndex="0" runat="server">
                            <%--<asp:View ID="View1" runat="server">--%>
                              <%--<asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />--%>
                                 <%-- <div class="space-30"></div>
                                <div id="printable" class="table-responsive">
                                    <div class="widget-header header-color-blue">
                                        <h5 class="bigger lighter">
                                            <i class="icon-table"></i>
                                            Today Diary
                                        </h5>

                                        <div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                            <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                        </div>
                                    </div>
                                    <div class="space-30"></div>
                                    <asp:GridView ID="gvsearchclass" PageSize="10" EmptyDataText="No Data Found" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" DataKeyNames="nc_id" EnableViewState="true" >
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nc_id" HeaderText="S.NO" SortExpression="nc_id" />
                                            <%--<asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <HeaderTemplate>
                                                    <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                                </HeaderTemplate>
                                            </asp:TemplateField>--%>

                                            <%--<asp:TemplateField HeaderText="Class">
                                                <ItemTemplate>
                                                    <%--<asp:Label ID="lblcname" runat="server" Text='<%# Highlight(Eval("c_name").ToString()) %>'></asp:Label>--%>
                                                    <%--<asp:Label ID="lblcname" runat="server" Text='<%# Eval("strClass") %>'></asp:Label>--%>
                                                <%--</ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strNOSeats" SortExpression="strNOSeats" HeaderText="Total Seats" />
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-65 pull-right btn btn-sm btn-success"  />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <ItemTemplate>
                                                    <asp:Button ID="btndel" runat="server" Text="Delete" class="width-65 pull-right btn btn-sm btn-success" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <div class="space-4"></div>

                                </div>--%>
                            <%--</asp:View>--%>

                            <asp:View ID="View3" runat="server">
                                <div class="login-container" style="width: 60%;">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Recieve Fee
                                                </h4>

                                                <div class="space-6"></div>

                                                <form id="Form2">
                                                    <fieldset>
                                                        

                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Select Class :</label>
                                                            <span class="block input-icon input-icon-right">

                                                                <asp:DropDownList AutoPostBack="true" CssClass="form-control" ID="ddcl" runat="server" OnSelectedIndexChanged="ddcl_SelectedIndexChanged" AppendDataBoundItems="True"></asp:DropDownList>
                                                                <%--<asp:SqlDataSource runat="server" ID="ClassDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strClass] FROM [tbl_Class] WHERE ([bisDeleted] = @bisDeleted)">
                                                                    <SelectParameters>
                                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>--%>
                                                                
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Select Student :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                
                                                                <cc1:DropDownCheckBoxes CssClass="form-control" UseSelectAllNode="True" ID="ddst" runat="server" AppendDataBoundItems="True"></cc1:DropDownCheckBoxes>
                                                                <cc1:ExtendedRequiredFieldValidator ID="ExtendedRequiredFieldValidator1" runat="server" ControlToValidate="ddst" ErrorMessage="Required" ForeColor="Red"></cc1:ExtendedRequiredFieldValidator>

                                                                <i class="icon-user"></i>
                                                            </span>
                                                            <asp:Label Text="0" ID="lblneidd" Visible="false" runat="server" />
                                                        </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtdiary" TextMode="MultiLine" class="form-control" placeholder="Diary (Maths, Computer, Science...)" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Diary" ControlToValidate="txtdiary"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnsubmit" UseSubmitBehavior="false" runat="server" Text="Add Diary" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnsubmit_Click" />
                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="pnl1" TargetControlID="btnsubmit"
                            CancelControlID="btnClose" BackgroundCssClass="modalBackground">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="pnl1" runat="server" CssClass="modalPopup" align="center" Style="display: none">
                            <img src="assets/images/loader.gif" />
                            <br />
                            <asp:HiddenField ID="btnClose" runat="server" />
                        </asp:Panel>
                                                </div>
                                            </div>
                                        </div>
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
    </div>

</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
