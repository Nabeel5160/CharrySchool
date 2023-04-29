<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageVehicle.aspx.cs" Inherits="SchoolPRO.AdminManageVehicle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Manage Vehicle
                </h4>

                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="MultiView1" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                <div class="table-responsive">
                                    <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvsearchclass_RowCommand" OnRowUpdating="gvsearchclass_RowUpdating" DataKeyNames="nvh_id" EnableViewState="true">
                                        <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nvh_id" HeaderText="S.NO" SortExpression="nvh_id" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                                </HeaderTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Route Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strRouteName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strBusNumber" SortExpression="strBusNumber" HeaderText="Bus Number" />
                                            <asp:BoundField DataField="strRegNumber" SortExpression="strRegNumber" HeaderText="Registration Number" />
                                            <asp:BoundField DataField="strBusModel" SortExpression="strBusModel" HeaderText="Bus Model" />
                                            <asp:BoundField DataField="strCapacity" SortExpression="strCapacity" HeaderText="Capacity" />
                                            <asp:BoundField DataField="strPrice" SortExpression="strPrice" HeaderText="Price" />
                                            <asp:BoundField DataField="strType" SortExpression="strType" HeaderText="Type" />
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
                                                        Manage Vehicles
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Vehicle Information: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddert" DataSourceID="sqlrt" DataTextField="strRouteName" DataValueField="nrt_id" runat="server"></asp:DropDownList>
                                                                </span>
                                                                    </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtebn" class="form-control" placeholder="Bus Number" runat="server"></asp:TextBox>
                                                                    <asp:TextBox ID="txtern" runat="server" class="form-control" placeholder="Registration Number"></asp:TextBox>
                                                            <asp:TextBox ID="txtebm" runat="server" class="form-control" placeholder="Bus Model"></asp:TextBox>
                                                            <asp:TextBox ID="txtecap" runat="server" class="form-control" placeholder="Capacity"></asp:TextBox>
                                                            <asp:TextBox ID="txtepr" runat="server" class="form-control" placeholder="Price"></asp:TextBox>
                                                            <asp:DropDownList ID="ddetype" runat="server" CssClass="form-control">
                                                                <asp:ListItem Text="select Type" />
                                                                <asp:ListItem Text="New" />
                                                                <asp:ListItem Text="Used" />
                                                            </asp:DropDownList>
                                                                    <i class="icon-user"></i>
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
                                                        Manage Vehicles
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Vehicle Information: </p>
                                                    <form id="Form2">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <asp:DropDownList ID="ddrt" DataSourceID="sqlrt" DataTextField="strRouteName" DataValueField="nrt_id" runat="server"></asp:DropDownList>
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
                                                                    <asp:TextBox ID="txtrn" class="form-control" placeholder="Registration Number" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Class Name" ControlToValidate="txtrn"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtbm" class="form-control" placeholder="Model Number" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Total Seats" ControlToValidate="txtbm"></asp:RequiredFieldValidator>
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
                                                            
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddtype" CssClass="form-control" runat="server">
                                                                        <asp:ListItem Text="select Type" />
                                                                        <asp:ListItem Text="New" />
                                                                        <asp:ListItem Text="Used" />
                                                                        </asp:DropDownList>
                                                                    <i class="icon-user"></i>
                                                                     </span>
                                                            </label>
                                                            <div class="space-24"></div>


                                                            <div class="clearfix">
                                                                <asp:Button ID="btnaddclass" runat="server" Text="Add Vehicle" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddclass_Click" />
                                                                <%--<asp:Button ID="btngoback" runat="server" Text="View Vehicle" class="width-65 pull-right btn btn-sm btn-success" OnClick="btngoback_Click" />
 --%>                                                           </div>
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