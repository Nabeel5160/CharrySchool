<%@ Page Title="" Language="C#" MasterPageFile="~/Hostel.Master" AutoEventWireup="true" CodeBehind="ManageHostalBed.aspx.cs" Inherits="SchoolPRO.ManageHostalBed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Manage Hostal Bed
            </h4>

            <div class="space-6"></div>
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvdep" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                            <div class="table-responsive">
                                <asp:GridView ID="gvdep" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nBed_id" DataSourceID="DSBed">

                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Hostel Name" HeaderText="Hostel Name" SortExpression="Hostel Name"></asp:BoundField>
                                        <asp:BoundField DataField="Block Name" HeaderText="Block Name" SortExpression="Block Name"></asp:BoundField>
                                        <asp:BoundField DataField="Floor#" HeaderText="Floor#" SortExpression="Floor#"></asp:BoundField>
                                        <asp:BoundField DataField="Room #" HeaderText="Room #" SortExpression="Room #"></asp:BoundField>
                                        <asp:BoundField DataField="Bed #" HeaderText="Bed #" SortExpression="Bed #"></asp:BoundField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nBed_id" HeaderText="nBed_id" ReadOnly="True" InsertVisible="False" SortExpression="nBed_id"></asp:BoundField>
                                        <%--<asp:BoundField DataField="Student Name" HeaderText="Student Name" ReadOnly="True" SortExpression="Student Name"></asp:BoundField>--%>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="DSBed" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_ManageHostal.strHname AS 'Hostel Name', tbl_ManageHostalBlock.strBlock AS 'Block Name', tbl_ManageHostalFloor.strFlor AS 'Floor#', tbl_ManageHostalRoom.strRooms AS 'Room #', tbl_ManageHostalBed.nBed AS 'Bed #', tbl_ManageHostalBed.nBed_id FROM tbl_ManageHostalRoom INNER JOIN tbl_ManageHostalBed ON tbl_ManageHostalRoom.nHrom_id = tbl_ManageHostalBed.nHrom_id INNER JOIN tbl_ManageHostalFloor ON tbl_ManageHostalBed.nHflor_id = tbl_ManageHostalFloor.nHflor_id INNER JOIN tbl_ManageHostalBlock ON tbl_ManageHostalBed.nHBlock_id = tbl_ManageHostalBlock.nHBlock_id INNER JOIN tbl_ManageHostal ON tbl_ManageHostalBed.nHos_id = tbl_ManageHostal.nHos_id WHERE (tbl_ManageHostalBlock.bisDeleted = @fbit) AND (tbl_ManageHostalFloor.bisDeleted = @fbit) AND (tbl_ManageHostalRoom.bisDeleted = @fbit) AND (tbl_ManageHostalBed.bisDeleted = @fbit) AND (tbl_ManageHostal.bisDeleted = @fbit)">
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
                                                    Manage Hostal Bed
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Enter Hostal Bed: </p>
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
                                                        <asp:DropDownList ID="ddcl" OnSelectedIndexChanged="ddcl_SelectedIndexChanged" Width="250px" AutoPostBack="true" runat="server" CssClass="input-medium" AppendDataBoundItems="True" DataSourceID="DSflor" DataTextField="strBlock" DataValueField="nHBlock_id">
                                                            <asp:ListItem Value="0">---Select Block---</asp:ListItem>
                                                        </asp:DropDownList>


                                                        <asp:SqlDataSource runat="server" ID="DSflor" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nHBlock_id, strBlock FROM tbl_ManageHostalBlock WHERE (bisDeleted = @fbit) AND (nHos_id = @hst)">
                                                            <SelectParameters>
                                                                <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                                                <asp:ControlParameter ControlID="ddhstl" PropertyName="SelectedValue" DefaultValue="0" Name="hst"></asp:ControlParameter>
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>


                                                        <br />

                                                        <asp:DropDownList ID="ddlflor" Width="250px" runat="server" OnSelectedIndexChanged="ddlflor_SelectedIndexChanged" AutoPostBack="true" CssClass="input-medium" AppendDataBoundItems="True" DataSourceID="DSFlorselect" DataTextField="strFlor" DataValueField="nHflor_id">
                                                            <asp:ListItem Value="0">---Select Floor---</asp:ListItem>
                                                        </asp:DropDownList>

                                                        <asp:SqlDataSource runat="server" ID="DSFlorselect" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nHflor_id, strFlor FROM tbl_ManageHostalFloor WHERE (bisDeleted = @fbit) AND (nHBlock_id = @blkid) AND (nHos_id = @hst)">
                                                            <SelectParameters>
                                                                <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                                                <asp:ControlParameter ControlID="ddcl" PropertyName="SelectedValue" DefaultValue="0" Name="blkid"></asp:ControlParameter>
                                                                <asp:ControlParameter ControlID="ddhstl" PropertyName="SelectedValue" DefaultValue="0" Name="hst"></asp:ControlParameter>
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                        <br />

                                                        <asp:DropDownList ID="ddlrom" Width="250px" runat="server" AutoPostBack="true" CssClass="input-medium" AppendDataBoundItems="True" DataSourceID="sqlDSRoooom" DataTextField="strRooms" DataValueField="nHrom_id">
                                                            <asp:ListItem>---Select Room---</asp:ListItem>
                                                        </asp:DropDownList>


                                                        <asp:SqlDataSource runat="server" ID="sqlDSRoooom" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nHrom_id, strRooms FROM tbl_ManageHostalRoom WHERE (bisDeleted = @fbit) AND (nHos_id = @hstl) AND (nHflor_id = @flr) AND (nHBlock_id = @blk)">
                                                            <SelectParameters>
                                                                <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                                                <asp:ControlParameter ControlID="ddhstl" PropertyName="SelectedValue" DefaultValue="0" Name="hstl"></asp:ControlParameter>
                                                                <asp:ControlParameter ControlID="ddlflor" PropertyName="SelectedValue" DefaultValue="0" Name="flr"></asp:ControlParameter>
                                                                <asp:ControlParameter ControlID="ddcl" PropertyName="SelectedValue" DefaultValue="0" Name="blk"></asp:ControlParameter>
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                        <asp:Panel ID="prow" runat="server"></asp:Panel>
                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <asp:Button ID="btnadrow" runat="server" Text="Add Row" class="width-30 pull-right btn btn-sm btn-success" OnClick="btnadrow_Click" />
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
