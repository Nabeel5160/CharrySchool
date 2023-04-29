<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageResultDecalaration.aspx.cs" Inherits="SchoolPRO.AdminManageResultDecalaration" %>

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

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Manage Result Declaration Date
                </h4>

                <div class="space-6"></div>
                <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>

                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="MultiView1" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                <div class="space-30"></div>
                                <div id="printable" class="table-responsive">
                                    <div class="widget-header header-color-blue">
                                        <h5 class="bigger lighter">
                                            <i class="icon-table"></i>
                                            Result Declaration Date List
                                        </h5>

                                        <div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                            <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                        </div>
                                    </div>
                                    <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" OnPageIndexChanging="gvsearchclass_PageIndexChanging" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvsearchclass_RowCommand" OnRowUpdating="gvsearchclass_RowUpdating" DataKeyNames="nRShw_id" EnableViewState="true" OnSelectedIndexChanged="gvsearchclass_SelectedIndexChanged">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nRShw_id" HeaderText="S.NO" SortExpression="nRShw_id" />
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <HeaderTemplate>
                                                    <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                                </HeaderTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Exam Type">
                                                <ItemTemplate>
                                                    <%--<asp:Label ID="lblcname" runat="server" Text='<%# Highlight(Eval("c_name").ToString()) %>'></asp:Label>--%>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("exam") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strStartDate" HeaderText="Start Date" SortExpression="nExam_id" />
                                            <asp:BoundField DataField="strEndDate" HeaderText="End Date" SortExpression="nExam_id" />
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnedit_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <ItemTemplate>
                                                    <asp:Button ID="btndel" runat="server" Text="Delete" class="width-65 pull-right btn btn-sm btn-success" OnClick="btndel_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <div class="space-4"></div>

                                </div>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Result Decalaration Date
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Result Decalaration Dates </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtestdate" class="form-control" placeholder="Start Date" runat="server"></asp:TextBox>
                                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender3" TargetControlID="txtestdate" runat="server"></asp:CalendarExtender>
                                                                    <asp:RequiredFieldValidator ValidationGroup="up" ForeColor="Red" Font-Bold="true" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression="^[\s\S]{10,10}$" ControlToValidate="txtestdate"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ValidationGroup="up" ForeColor="Red" Font-Bold="true" runat="server" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ControlToValidate="txtestdate" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>

                                                                    <asp:TextBox ID="txteendtate" class="form-control" placeholder="End Date" OnTextChanged="txteendtate_TextChanged" AutoPostBack="true" runat="server"></asp:TextBox>
                                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender4" TargetControlID="txteendtate" runat="server"></asp:CalendarExtender>
                                                                    <asp:RequiredFieldValidator ValidationGroup="up" ForeColor="Red" Font-Bold="true" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression="^[\s\S]{10,10}$" ControlToValidate="txteendtate"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ValidationGroup="up" ForeColor="Red" Font-Bold="true" runat="server" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ControlToValidate="txteendtate" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>
                                                                    <asp:Label Text="" ID="lblwarning" Visible="false" ForeColor="Red" runat="server" />
                                                                    <asp:TextBox ReadOnly="true" ID="txteexam" class="form-control" placeholder="Code" runat="server"></asp:TextBox>

                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnupdate" ValidationGroup="up" runat="server" Text="Update" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnupdate_Click" />
                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </asp:View>
                            <asp:View ID="View3" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Result Decalaration Dates
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Result Decalaration Dates </p>
                                                    <form id="Form2">
                                                        <fieldset>
                                                            <div class="form-group">
                                                                <div>
                                                                    <asp:DropDownList ID="dddlexam" CssClass="form-control" AppendDataBoundItems="true" runat="server" DataSourceID="dddexamds" DataTextField="strExamName" DataValueField="nExam_id">
                                                                        <asp:ListItem Text="<--Please Select Eaxm Type-->" />

                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource runat="server" ID="dddexamds" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nExam_id, strExamName, bisDeleted, nsch_id FROM tbl_ExamType WHERE (bisDeleted = @bit) AND (nsch_id = @schid)">
                                                                        <SelectParameters>
                                                                            <asp:Parameter DefaultValue="False" Name="bit"></asp:Parameter>
                                                                            <asp:SessionParameter SessionField="nschoolid" DefaultValue="" Name="schid"></asp:SessionParameter>
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                </div>
                                                            </div>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtstdate" class="form-control" placeholder="Start Date" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtstdate" runat="server"></asp:CalendarExtender>
                                                                    <asp:RequiredFieldValidator ValidationGroup="add" ForeColor="Red" Font-Bold="true" ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression="^[\s\S]{10,10}$" ControlToValidate="txtstdate"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ValidationGroup="add" ForeColor="Red" Font-Bold="true" runat="server" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ControlToValidate="txtstdate" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>

                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtenddate" class="form-control" OnTextChanged="txtenddate_TextChanged" AutoPostBack="true" placeholder="End Date" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtenddate" runat="server"></asp:CalendarExtender>
                                                                    <asp:RequiredFieldValidator ValidationGroup="add" ForeColor="Red" Font-Bold="true" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression="^[\s\S]{10,10}$" ControlToValidate="txtenddate"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationGroup="add" ForeColor="Red" Font-Bold="true" runat="server" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ControlToValidate="txtenddate" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>

                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnaddclass" ValidationGroup="add" runat="server" Text="ADD" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddclass_Click" />
                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
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

                <div class="space-12"></div>

                <!-- /.page-content -->
            </div>
            <!-- /.main-content -->

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
