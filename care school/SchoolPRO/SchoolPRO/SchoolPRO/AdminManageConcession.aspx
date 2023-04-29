<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageConcession.aspx.cs" Inherits="SchoolPRO.AdminManageConcession" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Manage Concession
                </h4>

                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvdep" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                <div class="table-responsive">
                                    <asp:GridView ID="gvdep" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnPageIndexChanging="gvdep_PageIndexChanging" OnRowCommand="gvsearchclass_RowCommand" OnRowUpdating="gvsearchclass_RowUpdating" DataKeyNames="nConc_id" EnableViewState="true">
                                        <Columns>
                                            <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nConc_id" HeaderText="S.NO" SortExpression="nConc_id" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                                </HeaderTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Concession">
                                                <ItemTemplate>
                                                    
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strConcTitle") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strConcCode" SortExpression="strConcCode" HeaderText="Concession Code" />
                                            <asp:BoundField DataField="nConcPer" SortExpression="nConcPer" HeaderText="Concession in Figures" />
                                            <asp:BoundField DataField="strConcType" SortExpression="strConcType" HeaderText="Type" />
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
                                                       Manage Concession
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Concession Name: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txteconctitle" class="form-control" placeholder="Concession Name" runat="server"></asp:TextBox>
                                                                    
                                                                    <asp:TextBox ID="txteconccode" runat="server" class="form-control" placeholder="Concession Code"></asp:TextBox>
                                                                     <asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator3" ErrorMessage=" (digits only)" ValidationExpression="^\d+$" ControlToValidate="txteconccode" runat="server" />
                                                                    <asp:TextBox ID="txteconcper" OnTextChanged="txteconcper_TextChanged" runat="server" class="form-control" placeholder="Concession $"></asp:TextBox>
                                                                     <asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator4" ErrorMessage=" (digits only)" ValidationExpression="^\d+$" ControlToValidate="txteconcper" runat="server" />
                                                                    
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
                                                        Manage Concession
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Concession : </p>
                                                    <form id="Form2">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddconctype" runat="server">
                                                                        <asp:ListItem Text="Select Concession Type"></asp:ListItem>
                                                                        <asp:ListItem Text="Concession in Amount" />
                                                                        <asp:ListItem Text="Concession in Percentage" />
                                                                    </asp:DropDownList>
                                                                    </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtconctitle" class="form-control" placeholder="Concession Title" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Concession Title" ControlToValidate="txtconctitle"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtconccode" class="form-control" placeholder="Concession Code" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator1" ErrorMessage=" (digits only)" ValidationExpression="^\d+$" ControlToValidate="txtconccode" runat="server" />
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Concession Code" ControlToValidate="txtconccode"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                             <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtconcper" AutoPostBack="true" class="form-control" placeholder="Concession in Figures" OnTextChanged="txtconcper_TextChanged" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator2" ErrorMessage=" (digits only)" ValidationExpression="^\d+$" ControlToValidate="txtconcper" runat="server" />
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Concession in Percentage" ControlToValidate="txtconcper"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnaddclass" runat="server" Text="Submit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddclass_Click" />
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
