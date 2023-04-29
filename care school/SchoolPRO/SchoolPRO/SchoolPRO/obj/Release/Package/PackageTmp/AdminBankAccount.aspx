<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminBankAccount.aspx.cs" Inherits="SchoolPRO.AdminBankAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Bank Accounts
                </h4>

                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvbnk" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                <asp:Button ID="btntransfer" runat="server" Text="Transfer" class="width-10 pull-left btn btn-sm btn-success" OnClick="btntransfer_Click" />
                                <div class="table-responsive">
                                    <asp:GridView ID="gvbnk" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvsearchclass_RowCommand" DataKeyNames="nbnk_id" EnableViewState="true">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nbnk_id" HeaderText="S.NO" SortExpression="nbnk_id" />

                                            <asp:BoundField DataField="strBName" SortExpression="strBName" HeaderText="Bank Name" />

                                            <asp:BoundField DataField="strBrName" SortExpression="strBrName" HeaderText="Branch Name" />

                                            <asp:TemplateField HeaderText="Branch Code">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strBCode") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strAccTitle" SortExpression="strAccTitle" HeaderText="Account Title" />
                                            <asp:BoundField DataField="strAccNum" SortExpression="strAccNum" HeaderText="Account Number" />
                                            <asp:BoundField DataField="strAmount" SortExpression="strAmount" HeaderText="Amount" />
                                            <asp:BoundField DataField="dtAddDate" SortExpression="dtAddDate" HeaderText="Joining Date" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-90 pull-right btn btn-sm btn-success" OnClick="btnedit_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button ID="btndel" runat="server" Text="Delete" class="width-90 pull-right btn btn-sm btn-success" OnClick="btndel_Click" />
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
                                                        Manage Bank Account
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Bank Name: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtbn" runat="server" class="form-control" placeholder="Bank Name"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Bank Name" ControlToValidate="txtbn"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtbrnm" runat="server" class="form-control" placeholder="Branch Name"></asp:TextBox>

                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Branch Name" ControlToValidate="txtbrnm"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtbrc" runat="server" class="form-control" placeholder="Branch Code"></asp:TextBox>

                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Branch Code" ControlToValidate="txtbrc"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtat" runat="server" class="form-control" placeholder="Account Title"></asp:TextBox>

                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Total Seats" ControlToValidate="txtenos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtan" runat="server" class="form-control" placeholder="Account Number"></asp:TextBox>

                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Enter Total Seats" ControlToValidate="txtenos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtamnt" runat="server" class="form-control" placeholder="Amount"></asp:TextBox>

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

                            </asp:View>
                            <asp:View ID="View3" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Class
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Class Name: </p>
                                                    <form id="Form2">
                                                        <fieldset>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtebn" runat="server" class="form-control" placeholder="Bank Name"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Class Name" ControlToValidate="txtaddclass"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtebrn" runat="server" class="form-control" placeholder="Branch Name"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtnos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtebc" runat="server" class="form-control" placeholder="Branch Code"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtnos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txteat" runat="server" class="form-control" placeholder="Account Title"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtnos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtean" runat="server" class="form-control" placeholder="Account Number"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtnos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txteamnt" runat="server" class="form-control" placeholder="Amount"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtnos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnupdate" runat="server" Text="Add Class" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnupdate_Click" />
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
