<%@ Page Title="" Language="C#" MasterPageFile="~/Library.Master" AutoEventWireup="true" CodeBehind="AdminLibraryManageCategory.aspx.cs" Inherits="SchoolPRO.AdminLibraryManageCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Search By Name
                </h4>

                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvdep" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                <div class="table-responsive">
                                    <asp:GridView ID="gvcat" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvsearchclass_RowCommand" OnRowUpdating="gvsearchclass_RowUpdating" DataKeyNames="ncat_id" EnableViewState="true">
                                        <Columns><asp:TemplateField >
                                           <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"  DataField="ncat_id" HeaderText="S.NO" SortExpression="ncat_id" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                                </HeaderTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Category">
                                                <ItemTemplate>
                                                    <%--<asp:Label ID="lblcname" runat="server" Text='<%# Highlight(Eval("c_name").ToString()) %>'></asp:Label>--%>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strCategory") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="nCatCode" SortExpression="nCatCode" HeaderText="Category Code" />
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
                                                        Manage Category
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Category Name: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtecat" class="form-control" placeholder="Category Name" runat="server"></asp:TextBox>
                                                                    <asp:TextBox ID="txtedc" runat="server" class="form-control" placeholder="Category Code"></asp:TextBox>
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
                                                        Manage Category
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Category Name: </p>
                                                    <form id="Form2">
                                                        <fieldset>
                                                            
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtcat" class="form-control" placeholder="Category Name" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Class Name" ControlToValidate="txtcat"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtccode" class="form-control" placeholder="Category Code" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtccode"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnaddclass" runat="server" Text="Add Category" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddclass_Click" />
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
    
</asp:Content>
