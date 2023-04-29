<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageExpense.aspx.cs" Inherits="SchoolPRO.AdminManageExpense" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Manage Expense
                </h4>

                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvbnk" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                <div class="table-responsive">
                                    <asp:GridView ID="gvbnk" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowCommand="gvvend_RowCommand" DataKeyNames="nex_id" >
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nex_id" HeaderText="S.NO" SortExpression="nex_id" />
                                            <asp:BoundField DataField="strVoucherNum" SortExpression="strVoucherNum" HeaderText="Voucher Number" />
                                            <asp:TemplateField HeaderText="Reason Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strReason") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strfname" SortExpression="strfname" HeaderText="Name" />
                                            <asp:BoundField DataField="strAmount" SortExpression="strAmount" HeaderText="Amount" />
                                            <asp:BoundField DataField="strPaymentMethod" SortExpression="strPaymentMethod" HeaderText="Payment Method" />
                                            <asp:BoundField DataField="strAccNum" SortExpression="strAccNum" HeaderText="Account Number" />
                                            <asp:BoundField DataField="dtAddDate" SortExpression="dtAddDate" HeaderText="Add Date" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnedit_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button ID="btndel" runat="server" Text="Delete" class="width-65 pull-right btn btn-sm btn-success" OnClick="btndel_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource runat="server" ID="SqlDataSource1"></asp:SqlDataSource>
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
                                                        Manage Expense
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Expense: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddacnum" class="form-control" DataSourceID="sqlacnum" DataValueField="strAccNum" DataTextField="name" runat="server"></asp:DropDownList>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Class Name" ControlToValidate="txtcupdate"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtvnum" runat="server" class="form-control" placeholder="Voucher Number"></asp:TextBox>

                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Total Seats" ControlToValidate="txtenos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtamnt" runat="server" class="form-control" placeholder="Amount"></asp:TextBox>

                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter Total Seats" ControlToValidate="txtenos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <%--<asp:DropDownList ID="ddenm" CssClass="form-control" DataValueField="strfname" DataTextField="strfname" DataSourceID="sqlemp" runat="server"></asp:DropDownList>--%>
                                                                    <asp:TextBox ID="txtname" class="form-control" placeholder="Person Name" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Total Seats" ControlToValidate="txtenos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtrzn" runat="server" class="form-control" placeholder="Reason"></asp:TextBox>

                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Enter Total Seats" ControlToValidate="txtenos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddpm" CssClass="form-control" runat="server">
                                                                        <asp:ListItem Text="Select Payment Method" />
                                                                        <asp:ListItem Text="Cash" />
                                                                        <asp:ListItem Text="Cheque" />
                                                                        <asp:ListItem Text="Others" />
                                                                    </asp:DropDownList>

                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Enter Total Seats" ControlToValidate="txtenos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnadd" runat="server" Text="Add" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnadd_Click" />
                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                              <%--  <asp:SqlDataSource ID="sqlacnum" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strAccNum] FROM [tbl_Bank] WHERE ([bisDeleted] = @bisDeleted) and nsch_id=@schid">
                                         <SelectParameters>
                                             <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                             <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                         </SelectParameters>
                                </asp:SqlDataSource>--%>
                                  <asp:SqlDataSource ID="sqlacnum" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strAccNum],[strAccTitle]+'-'+[strAccNum] as name FROM [tbl_Bank] WHERE ([bisDeleted] = @bisDeleted)  and nsch_id=@nschid">
                                         <SelectParameters>
                                             <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                             <asp:SessionParameter Name="nschid" SessionField="nschoolid" />
                                         </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="sqlemp" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strfname]+' '+[strlname] as name ,nu_id FROM [tbl_Users] WHERE ([bisDeleted] = @bisDeleted) and nsch_id=@schid">
                                         <SelectParameters>
                                             <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                             <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                         </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:View>
                            <asp:View ID="View3" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Expense
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Expense: </p>
                                                    <form id="Form2">
                                                        <fieldset>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtemnt" runat="server" class="form-control" placeholder="Amount"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Class Name" ControlToValidate="txtaddclass"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddemn" class="form-control" DataValueField="nu_id" DataTextField="name" DataSourceID="sqlemp" runat="server"></asp:DropDownList>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtnos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txterzn" runat="server" class="form-control" placeholder="Reason"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtnos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddepm" CssClass="form-control" runat="server">
                                                                        <asp:ListItem Text="Select Payment Method" />
                                                                        <asp:ListItem Text="Cash" />
                                                                        <asp:ListItem Text="Cheque" />
                                                                        <asp:ListItem Text="Others" />
                                                                    </asp:DropDownList>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtnos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>

                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnupdate" runat="server" Text="Update" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnupdate_Click" />
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
