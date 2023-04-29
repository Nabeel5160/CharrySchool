<%@ Page Title="" Language="C#" MasterPageFile="~/Hostel.Master" AutoEventWireup="true" CodeBehind="ManageHostal.aspx.cs" Inherits="SchoolPRO.ManageHostal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Manage Hostal
            </h4>

            <div class="space-6"></div>
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvdep" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                            <div class="table-responsive">
                                <asp:GridView ID="gvdep" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nHos_id" DataSourceID="sqlBlock">

                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nHos_id" HeaderText="nHos_id" ReadOnly="True" InsertVisible="False" SortExpression="nHos_id"></asp:BoundField>
                                        <asp:BoundField DataField="Hostal Name" HeaderText="Hostal Name" SortExpression="Hostal Name"></asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnedit_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="sqlBlock" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nHos_id, strHname AS 'Hostal Name' FROM tbl_ManageHostal WHERE (bisDeleted = @fbit)">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
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
                                                    Manage Hostal Block
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Enter Block #: </p>
                                                <form id="freg">
                                                    <fieldset>
                                                        <label class="block clearfix">
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txteblk" class="form-control" placeholder="Hostal Name" runat="server"></asp:TextBox>
                                                               <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ErrorMessage="Hostal Name" ValidationExpression="[0-9a-zA-Z-_. ()]+$" ForeColor="Red" ControlToValidate="txteblk" runat="server" />
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Hostal Name" ForeColor="Red" ControlToValidate="txteblk"></asp:RequiredFieldValidator>
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
                                                    Manage Hostal Block
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Enter Block #: </p>
                                                <form id="Form2">
                                                    <fieldset>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtblk" class="form-control" placeholder="Hostal Name" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ErrorMessage="Hostal Block" ValidationExpression="[0-9a-zA-Z-_. ()]+$" ForeColor="Red" ControlToValidate="txtblk" runat="server" />
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Hostal Block" ForeColor="Red" ControlToValidate="txtblk"></asp:RequiredFieldValidator>
                                                                
                                                            </span>
                                                        </label>
                                                       <%-- <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtflor" class="form-control" placeholder="Number Of Block" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ErrorMessage="Number Of Block" ValidationExpression="^\d+$" ControlToValidate="txtflor" runat="server" />
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Number Of Floor" ControlToValidate="txtflor"></asp:RequiredFieldValidator>
                                                            </span>
                                                        </label>--%>
                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <asp:Button ID="btnaddclass" runat="server" Text="Add Block" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddclass_Click" />
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
