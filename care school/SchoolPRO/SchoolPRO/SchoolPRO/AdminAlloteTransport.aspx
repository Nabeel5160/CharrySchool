<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAlloteTransport.aspx.cs" Inherits="SchoolPRO.AdminAlloteTransport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                     Allot Transport
                </h4>

                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="MultiView1" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                <div class="table-responsive">
                                    <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvsearchclass_RowCommand" OnRowUpdating="gvsearchclass_RowUpdating" DataKeyNames="nalt_id" EnableViewState="true">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nalt_id" HeaderText="S.NO" SortExpression="nalt_id" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                                </HeaderTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strStudentNum" SortExpression="strStudentNum" HeaderText="Student Number" />
                                            <asp:TemplateField HeaderText="Route Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strRouteName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strBusNumber" SortExpression="strBusNumber" HeaderText="Bus Number" />
                                            <asp:BoundField DataField="strCapacity" SortExpression="strCapacity" HeaderText="Capacity" />
                                            <asp:BoundField DataField="strAmount" SortExpression="strAmount" HeaderText="Transport Fee" />
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
                                                        Manage Transport Allotment
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Allotment Information: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <%--  <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddeacnum" DataTextField="name" DataValueField="strAccNum" DataSourceID="sqleacnum" class="form-control" runat="server"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                               <%-- <asp:SqlDataSource ID="sqlacnum" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strAccNum] FROM [tbl_Bank] WHERE ([bisDeleted] = @bisDeleted)">
                                                                <SelectParameters>
                                                                    <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>--%
                                                                 <asp:SqlDataSource ID="sqleacnum" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strAccNum],[strAccTitle]+'-'+[strAccNum] as name FROM [tbl_Bank] WHERE ([bisDeleted] = @bisDeleted)  and nsch_id=@nschid">
                                         <SelectParameters>
                                             <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                             <asp:SessionParameter Name="nschid" SessionField="nschoolid" />
                                         </SelectParameters>
                                </asp:SqlDataSource>
                                                            </span>
                                                        </label>--%>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtestnm" class="form-control" ReadOnly="true" placeholder="Enter Student Number" runat="server" AutoPostBack="true" OnTextChanged="txtestnm_TextChanged"></asp:TextBox>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtefn" ReadOnly="true" class="form-control" placeholder="First Name" runat="server"></asp:TextBox>
                                                                    <asp:TextBox ID="txteln" ReadOnly="true" class="form-control" placeholder="Last Name" runat="server"></asp:TextBox>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddert" DataSourceID="sqlrt" DataTextField="strRouteName" DataValueField="nrt_id" runat="server" AppendDataBoundItems="true">
                                                                        <asp:ListItem>--Please Select Rout--</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtebn" class="form-control" placeholder="Bus Number" ReadOnly="true" runat="server"></asp:TextBox>
                                                                    <asp:TextBox ID="txtert" runat="server" class="form-control" ReadOnly="true" placeholder="Bus Model"></asp:TextBox>
                                                                    <asp:TextBox ID="txtecap" runat="server" class="form-control" ReadOnly="true" placeholder="Capacity"></asp:TextBox>
                                                                    <asp:TextBox ID="txtepr" runat="server" class="form-control" ReadOnly="true" placeholder="Price"></asp:TextBox>
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
                                                        Manage Allotments
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Allotment Information: </p>
                                                    <form id="Form2">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddacnum" DataTextField="name" DataValueField="strAccNum" DataSourceID="sqlacnum" class="form-control" runat="server"></asp:DropDownList>
                                                                    <i class="icon-user"></i>
                                                                    <%-- <asp:SqlDataSource ID="sqlacnum" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strAccNum] FROM [tbl_Bank] WHERE ([bisDeleted] = @bisDeleted)">
                                                                <SelectParameters>
                                                                    <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>--%>
                                                                    <asp:SqlDataSource ID="sqlacnum" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strAccNum],[strAccTitle]+'-'+[strAccNum] as name FROM [tbl_Bank] WHERE ([bisDeleted] = @bisDeleted)  and nsch_id=@nschid">
                                                                        <SelectParameters>
                                                                            <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                            <asp:SessionParameter Name="nschid" SessionField="nschoolid" />
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtstnum" class="form-control" placeholder="Enter Student Number" runat="server" AutoPostBack="true" OnTextChanged="txtstnum_TextChanged"></asp:TextBox>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtfn" ReadOnly="true" class="form-control" placeholder="First Name" runat="server"></asp:TextBox>
                                                                    <asp:TextBox ID="txtln" ReadOnly="true" class="form-control" placeholder="Last Name" runat="server"></asp:TextBox>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <asp:DropDownList ID="ddrt" DataSourceID="sqlrt" DataTextField="strRouteName" DataValueField="nrt_id" runat="server" OnSelectedIndexChanged="ddrt_SelectedIndexChanged" AutoPostBack="true" AppendDataBoundItems="true">
                                                                    <asp:ListItem>--Please Select Rout--</asp:ListItem>
                                                                </asp:DropDownList>

                                                                <asp:SqlDataSource ID="sqlrt" runat="server" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strRouteName],nrt_id  FROM [tbl_Route]WHERE ([bisDeleted] = @bisDeleted) and nsch_id=@schid">
                                                                    <SelectParameters>
                                                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />

                                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <asp:TextBox ID="txtbn" class="form-control" placeholder="Bus Number" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="Enter City Name" ControlToValidate="txtbn"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtrt" class="form-control" placeholder="Route Number" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Total Seats" ControlToValidate="txtrt"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtcap" class="form-control" placeholder="Capacity" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Enter Total Seats" ControlToValidate="txtcap"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtpr" class="form-control" placeholder="Price" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Enter Total Seats" ControlToValidate="txtpr"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>


                                                            <div class="clearfix">
                                                                <asp:Button ID="btnaddclass" runat="server" Text="Alot Vehicle" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddclass_Click" />
                                                                <asp:Button ID="btngoback" runat="server" Text="View Alotment" class="width-65 pull-right btn btn-sm btn-success" OnClick="btngoback_Click" />
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
