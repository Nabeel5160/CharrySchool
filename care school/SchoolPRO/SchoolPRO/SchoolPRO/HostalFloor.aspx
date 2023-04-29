<%@ Page Title="" Language="C#" MasterPageFile="~/Hostel.Master" AutoEventWireup="true" CodeBehind="HostalFloor.aspx.cs" Inherits="SchoolPRO.HostalFloor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Manage Hostal Floor
            </h4>

            <div class="space-6"></div>
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvdep" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                            <div class="table-responsive">
                                <asp:GridView ID="gvdep" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nHflor_id" DataSourceID="DSSelectFloor">

                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Hostel Name" HeaderText="Hostel Name" SortExpression="Hostel Name"></asp:BoundField>
                                        <asp:BoundField DataField="Block Name" HeaderText="Block Name" SortExpression="Block Name"></asp:BoundField>
                                        <asp:BoundField DataField="Floor #" HeaderText="Floor #" SortExpression="Floor #"></asp:BoundField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nHflor_id" HeaderText="nHflor_id" ReadOnly="True" InsertVisible="False" SortExpression="nHflor_id"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="DSSelectFloor" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_ManageHostal.strHname AS 'Hostel Name', tbl_ManageHostalBlock.strBlock AS 'Block Name', tbl_ManageHostalFloor.strFlor AS 'Floor #', tbl_ManageHostalFloor.nHflor_id FROM tbl_ManageHostal INNER JOIN tbl_ManageHostalFloor ON tbl_ManageHostal.nHos_id = tbl_ManageHostalFloor.nHos_id INNER JOIN tbl_ManageHostalBlock ON tbl_ManageHostalFloor.nHBlock_id = tbl_ManageHostalBlock.nHBlock_id WHERE (tbl_ManageHostal.bisDeleted = @fbit) AND (tbl_ManageHostalFloor.bisDeleted = @fbit) AND (tbl_ManageHostalBlock.bisDeleted = @fbit)">
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
                                                    Manage Hostal Floor
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Enter Hostal Floor: </p>
                                                <form id="Form2">
                                                    <fieldset>
                                                        <asp:DropDownList ID="ddhstl" Width="250px" OnSelectedIndexChanged="ddhstl_SelectedIndexChanged" AutoPostBack="true" runat="server" CssClass="input-medium" AppendDataBoundItems="True" DataSourceID="hostalsql" DataTextField="strHname" DataValueField="nHos_id">
                                                            <asp:ListItem Value="0">---Select Hostal---</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource runat="server" ID="hostalsql" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nHos_id, strHname FROM tbl_ManageHostal WHERE (bisDeleted = @fbit)">
                                                            <SelectParameters>
                                                                <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>

                                                        <br />
                                                        <asp:DropDownList ID="ddcl" Width="250px" AutoPostBack="true" runat="server" CssClass="input-medium" AppendDataBoundItems="True" DataSourceID="DSflor" DataTextField="strBlock" DataValueField="nHBlock_id">
                                                            <asp:ListItem>---Select Block---</asp:ListItem>
                                                        </asp:DropDownList>


                                                        <asp:SqlDataSource runat="server" ID="DSflor" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nHBlock_id, strBlock FROM tbl_ManageHostalBlock WHERE (bisDeleted = @fbit) AND (nHos_id = @hst)">
                                                            <SelectParameters>
                                                                <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                                                <asp:ControlParameter ControlID="ddhstl" PropertyName="SelectedValue" DefaultValue="0" Name="hst"></asp:ControlParameter>
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>



                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtflor" class="form-control" placeholder="Number Of Floor" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ErrorMessage="Number Of Floor" ValidationExpression="^\d+$" ForeColor="Red" ControlToValidate="txtflor" runat="server" />
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Only Number" ForeColor="Red" ControlToValidate="txtflor"></asp:RequiredFieldValidator>
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

            <!-- /.page-content -->
        </div>
        <!-- /.main-content -->

    </div>

</asp:Content>
