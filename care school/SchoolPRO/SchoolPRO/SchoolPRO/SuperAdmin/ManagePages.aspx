<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/admin.Master" AutoEventWireup="true" CodeBehind="ManagePages.aspx.cs" Inherits="SchoolPRO.SuperAdmin.ManagePages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="page-header">
                    <i class="page-header"></i>
                   Pages
                </h4>
                <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-dashboard"></i> Dashboard
                            </li>
                        </ol>
                <div class="space-6"></div><div class="space-6"></div><div class="space-6"></div><div class="space-6"></div>
                <div class="space-6"></div>
                <%--<asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>--%>
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
													
												</h5>

												<div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                   <%--  --%>
                                     <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" DataSourceID="Pages" AutoGenerateColumns="false">
                                         <Columns>
                                             <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                             <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nPid" HeaderText="nPid"  SortExpression="nPid" InsertVisible="False" ReadOnly="True" />

                                             <asp:TemplateField HeaderText="Class">
                                                 <ItemTemplate>
                                                     <%--<asp:Label ID="lblcname" runat="server" Text='<%# Highlight(Eval("c_name").ToString()) %>'></asp:Label>--%>
                                                     <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strPname") %>'></asp:Label>
                                                 </ItemTemplate>
                                             </asp:TemplateField>
                                             <asp:BoundField DataField="nPcode" SortExpression="nPcode" HeaderText="Page Code" />
                                             <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print" >
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
                                     <%-- --%>
                                     <asp:SqlDataSource runat="server" ID="Pages" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nPid], [strPname], [nPcode] FROM [tbl_Page]"></asp:SqlDataSource>
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
                                                        Manage Pages
                                                    </h4>
                                                    <div class="space-6"></div>
                                                    <div class="space-6"></div>
                                              
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtpagename" class="form-control" placeholder="Page Name" runat="server"></asp:TextBox>
                                                                     <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Page Name" ControlToValidate="txtpagename"></asp:RequiredFieldValidator>
                                                                    <asp:TextBox ID="txtpagecode" runat="server" class="form-control" placeholder="Page Code"></asp:TextBox>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="pull-left">
                                                                <asp:Button ID="btnAdd" runat="server" Text="Add" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnAdd_Click" />
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
                                                        Update Page
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Page Name: </p>
                                                    <form id="Form2">
                                                        <fieldset>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtuppagename" class="form-control" placeholder="Page Name" runat="server"></asp:TextBox>
                                                                   
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtuppagecode" class="form-control" placeholder="Page Code" runat="server"></asp:TextBox>
                                                                    
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnupdatepage" runat="server" Text="Update" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnupdatepage_Click" />
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
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <%--<img src="" alt="Searching" />--%>
                    </ProgressTemplate>
                </asp:UpdateProgress>

                <div class="space-12"></div>

                <!-- /.page-content -->
            </div>
            <!-- /.main-content -->

        </div>
    </div>
</asp:Content>
