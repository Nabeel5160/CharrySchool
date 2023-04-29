<%@ Page Title="" Language="C#" MasterPageFile="~/Library.Master" AutoEventWireup="true" CodeBehind="AdminLibrarianBooks.aspx.cs" Inherits="SchoolPRO.AdminLibrarianBooks" %>

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
                        <asp:MultiView ID="MultiView1" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                <div class="table-responsive">
                                    <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvsearchclass_RowCommand" OnRowUpdating="gvsearchclass_RowUpdating" DataKeyNames="nbk_id" EnableViewState="true">
                                        <Columns>
                                            <asp:TemplateField >
                                           <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nbk_id" HeaderText="S.NO" SortExpression="nbk_id" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                                </HeaderTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Author Name">
                                                <ItemTemplate>
                                                    <%--<asp:Label ID="lblcname" runat="server" Text='<%# Highlight(Eval("c_name").ToString()) %>'></asp:Label>--%>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strAuthorName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ncat_id" HeaderText="S.NO" SortExpression="ncat_id" />
                                             <asp:BoundField DataField="strBook" SortExpression="strBook" HeaderText="Book Name" />
                                            <asp:BoundField DataField="strPublisherName" SortExpression="strPublisherName" HeaderText="Publisher Name" />
                                            <asp:BoundField DataField="nQTY" SortExpression="nQTY" HeaderText="QTY" />
                                            <asp:BoundField DataField="strBookNum" SortExpression="strBookNum" HeaderText="Book Number" />
                                            <asp:BoundField DataField="strPrice" SortExpression="strPrice" HeaderText="Price" />
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
                                                        Manage Classes
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Class Name: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddecat" DataTextField="strCategory" DataValueField="ncat_id" DataSourceID="sqlcat" runat="server"></asp:DropDownList>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtebk" class="form-control" placeholder="Book Name" runat="server"></asp:TextBox>
                                                                    <asp:TextBox ID="txtebn" runat="server" class="form-control" placeholder="Book Num"></asp:TextBox>
                                                            <asp:TextBox ID="txteath" runat="server" class="form-control" placeholder="Author Name"></asp:TextBox>
                                                            <asp:TextBox ID="txtepn" runat="server" class="form-control" placeholder=" Publisher Name"></asp:TextBox>
                                                            <asp:TextBox ID="txteqty" runat="server" class="form-control" placeholder="Quantity"></asp:TextBox>
                                                            <asp:TextBox ID="txtepri" runat="server" class="form-control" placeholder="Price"></asp:TextBox>
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
                                                        Manage Books
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Books Information: </p>
                                                    <form id="Form2">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddcat" DataTextField="strCategory" DataValueField="ncat_id" DataSourceID="sqlcat" runat="server"></asp:DropDownList>
                                                                </span>
                                                            </label>
                                                            <asp:SqlDataSource ID="sqlcat" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strCategory],ncat_id FROM [tbl_Category] WHERE ([bisDeleted] = @bisDeleted and strType='Library' and nsch_id=@schid)">
                                                                <SelectParameters>
                                                                    <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean" />
                                                                    <asp:SessionParameter SessionField="nschoolid" DefaultValue="0" Name="schid" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtbk" class="form-control" placeholder="Book Name" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Class Name" ControlToValidate="txtbk"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtbnum" class="form-control" placeholder="Book Num" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtbnum"></asp:RequiredFieldValidator>
                                                                </span>
                                                                </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtath" class="form-control" placeholder="Author Name" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtath"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtpnm" class="form-control" placeholder=" Publisher Name" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtpnm"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtqty" class="form-control" placeholder="Quantity" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtqty"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                                <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtprice" class="form-control" placeholder="Price" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtprice"></asp:RequiredFieldValidator>
                                                                </span>

                                                            </label>
                                                            
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnaddclass" runat="server" Text="Add Class" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddclass_Click" />
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
