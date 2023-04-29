<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageItem.aspx.cs" Inherits="SchoolPRO.AdminManageItem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
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
                                    <asp:GridView ID="gvpro" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvsearchclass_RowCommand" OnRowUpdating="gvsearchclass_RowUpdating" DataKeyNames="npro_id" EnableViewState="true">
                                        <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                             <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="npro_id" HeaderText="S.NO" SortExpression="npro_id" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                                </HeaderTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strDepartment" SortExpression="strDepartment" HeaderText="Department" />
                                            <asp:BoundField DataField="strCategory" SortExpression="strCategory" HeaderText="Category" />
                                            <asp:TemplateField HeaderText="Product">
                                                <ItemTemplate>
                                                    <%--<asp:Label ID="lblcname" runat="server" Text='<%# Highlight(Eval("c_name").ToString()) %>'></asp:Label>--%>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strProduct") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="nSKU" SortExpression="nSKU" HeaderText="SKU" />
                                            <asp:BoundField DataField="strDescription" SortExpression="strDescription" HeaderText="Description" />
                                            
                                            <asp:BoundField DataField="strQuant" SortExpression="strQuant" HeaderText="Item Quantity" />
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
                                                        Manage Items
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Items Information: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddedep"  DataTextField="strDepartment" DataValueField="ndep_id" DataSourceID="sqldep" runat="server" AutoPostBack="true"></asp:DropDownList>
                                                                </span>
                                                            </label>
                                                            <asp:SqlDataSource ID="sqldep" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strDepartment],ndep_id FROM [tbl_Department] WHERE ([bisDeleted] = @bisDeleted) and nsch_id=@schid">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean" />
                                                <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                            </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddecat" OnSelectedIndexChanged="ddecat_SelectedIndexChanged" AutoPostBack="true" DataTextField="strCategory" DataValueField="ncat_id" DataSourceID="sqlecat" runat="server"></asp:DropDownList>
                                                                </span>
                                                            </label>
                                                            <asp:SqlDataSource ID="sqlecat" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strCategory],ncat_id FROM [tbl_Category] WHERE [bisDeleted] = @bisDeleted and ndep_id=@edep and nsch_id=@schid">
                                            <SelectParameters>
                                               
                                                <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                            
                                                                    <asp:ControlParameter ControlID="ddedep" Name="edep" Type="String" />
                                                                    <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtepro" class="form-control" placeholder="Product Name" runat="server" OnTextChanged="txtepro_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                                    <asp:TextBox ID="txtesku" runat="server" class="form-control" placeholder="SKU"></asp:TextBox>
                                                                     <asp:TextBox ID="txtequant" class="form-control" placeholder="Product Quantity" runat="server" ></asp:TextBox>
                                                                    <asp:TextBox ID="txtedesc" runat="server" class="form-control" placeholder="Description" TextMode="MultiLine"></asp:TextBox>
                                                               
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
                                                        Manage Item
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Item Information: </p>
                                                    <form id="Form2">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="dddep" DataTextField="strDepartment" DataValueField="ndep_id" DataSourceID="sqldep" runat="server" AutoPostBack="true" Enabled="true"></asp:DropDownList>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddcat" DataTextField="strCategory" DataValueField="ncat_id" DataSourceID="sqlcat" runat="server"></asp:DropDownList>
                                                                </span>
                                                            </label>
                                                            <asp:SqlDataSource ID="sqlcat" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strCategory],ncat_id FROM [tbl_Category] WHERE [bisDeleted] = @bisDeleted and ndep_id=@edep and nsch_id=@schid">
                                            <SelectParameters>
                                               
                                                <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                                                    <asp:ControlParameter ControlID="dddep" Name="edep" Type="String" />
                                                                    <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtpro" class="form-control" placeholder="Product Name" runat="server" OnTextChanged="txtpro_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Product Name" ControlToValidate="txtpro"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtsku" class="form-control" placeholder="SKU" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Complete 8 Code" ControlToValidate="txtsku"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                             <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                             <asp:TextBox ID="txtquant" class="form-control" placeholder="Product Quantity" runat="server" ></asp:TextBox>
                                                           <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Only Numbers" ControlToValidate="txtquant"></asp:RequiredFieldValidator>
                                                                        </span>
                                                            </label> <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtdesc" TextMode="MultiLine" class="form-control" placeholder="Description" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter Description" ControlToValidate="txtdesc"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnaddclass" runat="server" Text="Add Product" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddclass_Click" />
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
