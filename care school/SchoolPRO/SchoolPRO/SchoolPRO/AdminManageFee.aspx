<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageFee.aspx.cs" Inherits="SchoolPRO.AdminManageFee" %>

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
            <div class="col-lg-12">
                    <h5 style="color:red">Instruction</h5>
            <ul>
                <li>Add Admission and Student Fee of the Class of which you want to make the Fee </li>
            </ul>
                </div>
            <div class="row-fluid">
              
                <div class="space-10"></div>
                <%--<div class="clearfix"><asp:Button ID="btnsrch" runat="server" class="width-20 pull-left btn btn-sm " Text="Search" /></div>--%>
                <asp:ScriptManager ID="sc" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upregst" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ActiveViewIndex="0" ID="mvsub" runat="server">
                            <asp:View ID="View1" runat="server">
                                <div class="row">
                                <div class="col-lg-4">
                                <asp:Button ID="btngo" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngo_Click" />
                                    </div>
                                    </div>
                                <div class="space-6></div>
                                <div id="printable" class="table-responsive">
                                    <div class="widget-header header-color-blue">
                                        <h5 class="bigger lighter">
                                            <i class="icon-table"></i>
                                            Fee List
                                        </h5>

                                        <div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                            <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                        </div>
                                    </div>
                                    <asp:GridView ID="gvfee" CssClass="table table-responsive table-hover" runat="server" AllowSorting="true" AllowPaging="true" DataKeyNames="nfee_id" AutoGenerateColumns="false" EnableViewState="true" OnPageIndexChanging="gvfee_PageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nfee_id" SortExpression="nfee_id" HeaderText="S.NO" />
                                            <asp:BoundField DataField="strTutionFee" SortExpression="strTutionFee" HeaderText="Tution Fee" />
                                            <asp:BoundField DataField="strAdmsFee" SortExpression="strAdmsFee" HeaderText="Admission Fee" />
                                            <asp:BoundField NullDisplayText="N/A" DataField="strRegFee" SortExpression="strRegFee" HeaderText="Registration Fee" />
                                            <asp:BoundField NullDisplayText="N/A" DataField="strFolderFee" SortExpression="strFolderFee" HeaderText="Folder Fee" />
                                            <asp:BoundField NullDisplayText="N/A" DataField="strGeneratorFee" SortExpression="strGeneratorFee" HeaderText="Generator Fee" />
                                            <asp:BoundField NullDisplayText="N/A" DataField="strBookFee" SortExpression="strBookFee" HeaderText="Books Fee" />
                                            <asp:BoundField NullDisplayText="N/A" DataField="strStationaryFee" SortExpression="strStationaryFee" HeaderText="Stationary Fee" />
                                            <asp:BoundField NullDisplayText="N/A" DataField="strAnnualExamFee" SortExpression="strAnnualExamFee" HeaderText="Exam Fee" />
                                            <asp:BoundField DataField="strLeaveFee" SortExpression="strLeaveFee" HeaderText="Leave Fee" />
                                            <asp:BoundField DataField="strClass" SortExpression="strClass" HeaderText="Class" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button ID="btnedit" runat="server" class="width-10 pull-left btn btn-sm btn-success" Text="Edit" OnClick="btnedit_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button ID="btndel" runat="server" class="width-10 pull-left btn btn-sm btn-success" Text="Delete" OnClick="btndel_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
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
                                                        Manage Fees
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter details of Fees according to their Classes: </p>
                                                    <form id="freg">
                                                        <fieldset>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddcl" runat="server" DataSourceID="sqlcl" DataTextField="strClass" DataValueField="nc_id"></asp:DropDownList>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtadm" class="form-control" placeholder="Admission Fee" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Admission Fee" ControlToValidate="txtadm"></asp:RequiredFieldValidator>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtregfee" class="form-control" placeholder="Registeration Fee" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Registeration Fee" ControlToValidate="txtregfee"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="red" ErrorMessage="Enter Registeration Fee(0-9)" ControlToValidate="txtregfee" ValidationExpression="^\d+$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtexamfee" class="form-control" placeholder="Annual Exam Fee" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter Annual Exam Fee" ControlToValidate="txtexamfee"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="red" ErrorMessage="Enter Annual Exam Fee(0-9)" ControlToValidate="txtexamfee" ValidationExpression="^\d+$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtstatfee" class="form-control" placeholder="Stationary Fee If Any" runat="server"></asp:TextBox>

                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" CssClass="red" ErrorMessage="Enter Stationary Fee if any (0-9)" ControlToValidate="txtstatfee" ValidationExpression="^\d*$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtbookfee" class="form-control" placeholder="Book Fee If Any" runat="server"></asp:TextBox>

                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" CssClass="red" ErrorMessage="Enter Book Fee if any (0-9)" ControlToValidate="txtbookfee" ValidationExpression="^\d*$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtgenfee" class="form-control" placeholder="Generator Fee If Any" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator8" runat="server" ErrorMessage="Enter Generator  Fee" ControlToValidate="txtgenfee"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" CssClass="red" ErrorMessage="Enter Generator Fee (0-9)" ControlToValidate="txtgenfee" ValidationExpression="^\d+$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtfolderfee" class="form-control" placeholder="Folder Fee If Any" runat="server"></asp:TextBox>

                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator7" CssClass="red" ErrorMessage="Enter Folder Fee if any (0-9)" ControlToValidate="txtfolderfee" ValidationExpression="^\d*$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtclfee" class="form-control" placeholder=" Tuition Fee" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Class Fee" ControlToValidate="txtclfee"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" CssClass="red" ErrorMessage="Enter Class Fee (0-9)" ControlToValidate="txtclfee" ValidationExpression="^\d+$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtLvFee" class="form-control" placeholder="Class Leave Fee" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Class Leave Fee" ControlToValidate="txtLvFee"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator8" CssClass="red" ErrorMessage="Enter Class Leave Fee (0-9)" ControlToValidate="txtLvFee" ValidationExpression="^\d+$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnsub" runat="server" Text="Add Fee" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnsub_Click" />
                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <asp:SqlDataSource ID="sqlcl" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strClass],nc_id FROM [tbl_Class] where bisDeleted='False' and nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:View>
                            <asp:View ID="View4" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Fees
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter details of Fees according to their Classes: </p>
                                                    <form id="Form1">
                                                        <fieldset>

                                                            <label class="block clearfix">
                                                                Admission Fee
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtadfee" class="form-control" placeholder="Admission Fee" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Admission Fee" ControlToValidate="txtadfee"></asp:RequiredFieldValidator>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                Registeration Fee
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtregfe" class="form-control" placeholder="Registeration Fee" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator7" runat="server" ErrorMessage="Enter Registeration Fee" ControlToValidate="txtregfe"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator9" CssClass="red" ErrorMessage="Enter Registeration Fee(0-9)" ControlToValidate="txtregfe" ValidationExpression="^\d+$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <label class="block clearfix">
                                                                    Annual Exam Fee
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtannulfees" class="form-control" placeholder="Annual Exam Fee" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator9" runat="server" ErrorMessage="Enter Annual Exam Fee" ControlToValidate="txtannulfees"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator10" CssClass="red" ErrorMessage="Enter Annual Exam Fee(0-9)" ControlToValidate="txtannulfees" ValidationExpression="^\d+$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                                </label>
                                                                <label class="block clearfix">
                                                                    Stationary Fee
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtstanfee" class="form-control" placeholder="Stationary Fee If Any" runat="server"></asp:TextBox>

                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator11" CssClass="red" ErrorMessage="Enter Stationary Fee if any (0-9)" ControlToValidate="txtstanfee" ValidationExpression="^\d*$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                                </label>
                                                                <label class="block clearfix">
                                                                    Book Fee
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtbookfee1" class="form-control" placeholder="Book Fee If Any" runat="server"></asp:TextBox>

                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator12" CssClass="red" ErrorMessage="Enter Book Fee if any (0-9)" ControlToValidate="txtbookfee1" ValidationExpression="^\d*$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                                </label>
                                                                <label class="block clearfix">
                                                                    Generator Fee
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtgenfee1" class="form-control" placeholder="Generator Fee If Any" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator10" runat="server" ErrorMessage="Enter Generator  Fee" ControlToValidate="txtgenfee1"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator13" CssClass="red" ErrorMessage="Enter Generator Fee (0-9)" ControlToValidate="txtgenfee1" ValidationExpression="^\d+$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                                </label>
                                                                <label class="block clearfix">
                                                                    Folder Fee
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtfolfee" class="form-control" placeholder="Folder Fee If Any" runat="server"></asp:TextBox>

                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator14" CssClass="red" ErrorMessage="Enter Folder Fee if any (0-9)" ControlToValidate="txtfolfee" ValidationExpression="^\d*$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                                </label>
                                                                <label class="block clearfix">
                                                                    Tution Fee
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txttutifee" class="form-control" placeholder="Tution Fee" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator11" runat="server" ErrorMessage="Enter Class Fee" ControlToValidate="txttutifee"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator15" CssClass="red" ErrorMessage="Enter Class Fee (0-9)" ControlToValidate="txttutifee" ValidationExpression="^\d+$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                                </label>
                                                                <label class="block clearfix">
                                                                    Class Leave Fee
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtleavfee" class="form-control" placeholder="Class Leave Fee" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator12" runat="server" ErrorMessage="Enter Class Leave Fee" ControlToValidate="txtleavfee"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator16" CssClass="red" ErrorMessage="Enter Class Leave Fee (0-9)" ControlToValidate="txtleavfee" ValidationExpression="^\d+$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                                </label>
                                                                <div class="space-24"></div>

                                                                <div class="clearfix">
                                                                    <asp:Button ID="Button1" runat="server" Text="Add Fee" class="width-65 pull-right btn btn-sm btn-success" OnClick="Button1_Click" />
                                                                </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </asp:View>

                            <%--<asp:View ID="View3" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Fees
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter details of Fees according to their Classes: </p>
                                                    <form id="Form2">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddecl" runat="server" DataSourceID="sqlcl" DataTextField="strClass" DataValueField="nc_id"></asp:DropDownList>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtefee" class="form-control" placeholder="Tution Fee" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txteadm" class="form-control" placeholder="Admission Fee" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtLvFee1" class="form-control" placeholder="Leave Fee" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnupdate" runat="server" Text="Update" class="width-30 pull-left btn btn-sm " OnClick="btnupdate_Click" />

                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%--<asp:SqlDataSource ID="sqlcl" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strClass],nc_id FROM [tbl_Class] where bisDeleted='False' and nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:View>--%>
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
            <!-- PAGE CONTENT ENDS -->
        </div>
    </div>
</asp:Content>
