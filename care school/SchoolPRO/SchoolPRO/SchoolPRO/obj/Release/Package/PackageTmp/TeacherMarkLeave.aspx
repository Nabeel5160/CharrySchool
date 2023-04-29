<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherMarkLeave.aspx.cs" Inherits="SchoolPRO.TeacherMarkLeave" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ToolkitScriptManager runat="server"></asp:ToolkitScriptManager>
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Teacher Leave
            </h4>
            <div class="space-6"></div>
            <asp:UpdatePanel ID="upquiz" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvquiz" ActiveViewIndex="0" runat="server">
                        <asp:View runat="server" ID="v0">
                            <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Add" class="width-10 pull-left btn btn-sm btn-success" />
                            <div class="table-responsive">
                                <asp:GridView ID="gvadmin" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="nLeav_id" DataSourceID="DSViewLeave">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nLeav_id" HeaderText="nLeav_id" ReadOnly="True" InsertVisible="False" SortExpression="nLeav_id"></asp:BoundField>
                                        <asp:BoundField DataField="Teacher Name" HeaderText="Teacher Name" SortExpression="Teacher Name" ReadOnly="True"></asp:BoundField>
                                        <asp:BoundField DataField="From" HeaderText="From" SortExpression="From"></asp:BoundField>
                                        <asp:BoundField DataField="To" HeaderText="To" SortExpression="To"></asp:BoundField>
                                        <asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason"></asp:BoundField>
                                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="DSViewLeave" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Leave.nLeav_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS 'Teacher Name', tbl_Leave.strFrom AS 'From', tbl_Leave.strTo AS 'To', tbl_Leave.strReason AS 'Reason', tbl_Leave.bPanding AS 'Status' FROM tbl_Leave INNER JOIN tbl_Users ON tbl_Leave.nG_id = tbl_Users.nu_id WHERE (tbl_Leave.bisDeleted = @fbit) AND (tbl_Users.bisDeleted = @fbit) AND (tbl_Leave.nsch_id = @sch) AND (tbl_Users.nsch_id = @sch) AND (tbl_Leave.nG_id = @uidd)">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                        <asp:SessionParameter SessionField="nschoolid" DefaultValue="0" Name="sch"></asp:SessionParameter>
                                        <asp:SessionParameter SessionField="uid" DefaultValue="0" Name="uidd"></asp:SessionParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
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
                                                    Select Leave Date Here
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Select Leave Date: </p>
                                                <asp:Label ID="lbltopic" runat="server"></asp:Label>
                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <asp:TextBox ID="txtfrom" ValidationGroup="add" runat="server" placeholder=" Date From" class="form-control"></asp:TextBox>
                                                        <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtfrom" runat="server"></asp:CalendarExtender>
                                                        <i class="icon-user"></i>
                                                    </span>
                                                </label>
                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <asp:TextBox ID="txtto" ValidationGroup="add" runat="server" placeholder=" Date To" class="form-control"></asp:TextBox>
                                                        <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtto" runat="server"></asp:CalendarExtender>
                                                        <i class="icon-user"></i>
                                                    </span>
                                                </label>
                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <textarea runat="server" id="txtreason" class="form-control" placeholder=" Reason"></textarea>
                                                        <i class="icon-user"></i>
                                                    </span>
                                                </label>

                                                <div class="space-24"></div>

                                                <div class="clearfix">
                                                    <asp:Button ID="btnaddLeave" runat="server" Text="Leave" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddLeave_Click" />
                                                </div>
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
        </div>
    </div>
</asp:Content>
