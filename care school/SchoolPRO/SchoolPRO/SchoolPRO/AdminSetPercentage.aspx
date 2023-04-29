<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminSetPercentage.aspx.cs" Inherits="SchoolPRO.AdminSetPercentage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Manage Percentage
                </h4>

                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="MultiView1" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                               <div class="form-group">
                               <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                                
                                 </div>               
                                <div class="table-responsive">
                                    <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true"  DataKeyNames="nper_id" EnableViewState="true">
                                        <Columns>
                                            <asp:BoundField DataField="nper_id" HeaderText="S.NO" SortExpression="nper_id" />
                                            
                                            <asp:BoundField DataField="strPercentage" SortExpression="strPercentage" HeaderText="%age" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnedit_Click" />
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
                                                        Manage Percentage
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Percentage: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txteptg" class="form-control" placeholder="%age" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ErrorMessage="Only Digits" ControlToValidate="txteptg" ValidationExpression="^\d+$" runat="server" />
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter %" ControlToValidate="txteptg"></asp:RequiredFieldValidator>
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
                            <asp:View ID="View3" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Percentage
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Percentage: </p>
                                                    <form id="Form2">
                                                        <fieldset>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtptg" MaxLength="3" class="form-control" placeholder="%age" runat="server"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ErrorMessage="Only Digits" ControlToValidate="txtptg" ValidationExpression="^\d+$" runat="server" />
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter %" ControlToValidate="txtptg"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnaddclass" runat="server" Text="Add Percentage" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddclass_Click" />
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
