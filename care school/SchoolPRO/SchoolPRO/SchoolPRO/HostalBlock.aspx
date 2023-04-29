<%@ Page Title="" Language="C#" MasterPageFile="~/Hostel.Master" AutoEventWireup="true" CodeBehind="HostalBlock.aspx.cs" Inherits="SchoolPRO.HostalBlock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Manage Hostal Block
            </h4>

            <div class="space-6"></div>
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvdep" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                            <div class="table-responsive">
                                <asp:GridView ID="gvdep" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nHBlock_id" DataSourceID="sqlBlock">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nHBlock_id" HeaderText="nHBlock_id" ReadOnly="True" InsertVisible="False" SortExpression="nHBlock_id"></asp:BoundField>

                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nHos_id" HeaderText="nHos_id" SortExpression="nHos_id"></asp:BoundField>
                                        
                                        <asp:BoundField DataField="Hostal Name" HeaderText="Hostal Name" SortExpression="Hostal Name"></asp:BoundField>
                                        <asp:BoundField DataField="Block Name" HeaderText="Block Name" SortExpression="Block Name"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="sqlBlock" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_ManageHostalBlock.nHBlock_id, tbl_ManageHostalBlock.nHos_id, tbl_ManageHostalBlock.strBlock AS 'Block Name', tbl_ManageHostal.strHname AS 'Hostal Name' FROM tbl_ManageHostalBlock INNER JOIN tbl_ManageHostal ON tbl_ManageHostalBlock.nHos_id = tbl_ManageHostal.nHos_id WHERE (tbl_ManageHostalBlock.bisDeleted = @fbit)">
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
                                                    Manage Hostal Hostal
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Enter Hostal Floor: </p>
                                                <form id="Form2">
                                                    <fieldset>

                                                        <asp:DropDownList ID="ddcl" Width="250px" runat="server" CssClass="input-medium" AutoPostBack="true" AppendDataBoundItems="True" DataSourceID="Sqlhstblock" DataTextField="Hostal Name" DataValueField="nHos_id">
                                                            <asp:ListItem>Select Hostal</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource runat="server" ID="Sqlhstblock" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nHos_id, strHname AS 'Hostal Name' FROM tbl_ManageHostal WHERE (bisDeleted = @fbit)">
                                                            <SelectParameters>
                                                                <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtblk" class="form-control" placeholder="Block" runat="server"></asp:TextBox>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ErrorMessage="Hostal Block" ValidationExpression="[0-9a-zA-Z-_. ()]+$" ForeColor="Red" ControlToValidate="txtblk" runat="server" />
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Hostal Block" ForeColor="Red" ControlToValidate="txtblk"></asp:RequiredFieldValidator>
                                                                <i class="icon-user"></i>
                                                               </span>
                                                        </label>
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
        </div>

    </div>

</asp:Content>
