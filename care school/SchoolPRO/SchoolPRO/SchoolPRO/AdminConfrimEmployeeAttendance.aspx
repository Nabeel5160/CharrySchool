<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminConfrimEmployeeAttendance.aspx.cs" Inherits="SchoolPRO.AdminConfrimEmployeeAttendance" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function printDiv(printable) {
            var printContents = document.getElementById(printable).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Admin Confirm Teacher Attendance
            </h4>

            <div class="space-6"></div>
            <%--    <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>--%>
            <asp:ToolkitScriptManager ID="tool1" runat="server"></asp:ToolkitScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvatnd" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:Button ID="btngotoAdd" runat="server" Text="Mark Attendance" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                            <asp:Label ID="Label1" Text="From :" runat="server" CssClass="label"></asp:Label>
                            <asp:TextBox ID="txtFrom" OnTextChanged="txtFrom_TextChanged" AutoPostBack="true" placeholder="dd-MM-yyyy" runat="server" class="width-10">
                            </asp:TextBox>
                            <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtFrom" runat="server"></asp:CalendarExtender>

                            <asp:Label ID="Label2" CssClass="label" Text="To :" runat="server"></asp:Label>
                            <asp:TextBox ID="txtTo" AutoPostBack="true" OnTextChanged="txtTo_TextChanged1" runat="server" placeholder="dd-MM-yyyy" class="width-10"></asp:TextBox>
                            <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtTo" runat="server"></asp:CalendarExtender>
                            &nbsp;
                            <div class="clearfix"></div>

                            <asp:Button Text="Leave" ID="btnleave" runat="server" class="width-20 pull-right btn btn-sm btn-success" OnClick="btnleave_Click" />

                            <div class="space-22"></div>
                            <div id="printable" class="table-responsive">
                                <div class="widget-header header-color-blue">
                                    <h5 class="bigger lighter">
                                        <i class="icon-table"></i>
                                        Teacher Attendance
                                    </h5>

                                    <div class="widget-toolbar widget-toolbar-light no-border">
                                        <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                    </div>
                                </div>
                                <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" OnPageIndexChanging="gvsearchclass_PageIndexChanging" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" DataKeyNames="nta_id" EnableViewState="true">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nta_id" HeaderText="S.NO" SortExpression="nta_id" />
                                        <asp:BoundField DataField="name" SortExpression="Name" HeaderText="Name" />
                                        <%--<asp:BoundField DataField="strPresentTime" SortExpression="PresentTime" HeaderText="Present Time" />--%>
                                        <%--<asp:BoundField DataField="strLeaveTime" SortExpression="LeaveTime" HeaderText="Leave Time" />--%>
                                        <asp:BoundField DataField="strNIC" SortExpression="strNIC" HeaderText="CNIC No." />
                                        <asp:BoundField DataField="strCell" SortExpression="strCell" HeaderText="Cell No." />
                                        <asp:BoundField DataField="strStatus" SortExpression="strStatus" HeaderText="Attendence Status" />
                                        <%--<asp:BoundField DataField="strLeaveDoc" SortExpression="LeaveDoc" HeaderText="LeaveDoc" />--%>
                                        <asp:BoundField DataField="strLeaveReason" SortExpression="strNIC" HeaderText="Leave Reason(if any)" />
                                        <%--<asp:BoundField DataField="bisConfirm" SortExpression="Confirm" HeaderText="Confirmation" />--%>
                                        <asp:BoundField DataField="dtAddDate" SortExpression="Date" HeaderText="Date" />
                                        <%--<asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button Text="Confirm" ID="btncnfrm" runat="server" class="width-85 pull-left btn btn-sm btn-success" OnClick="btnsubmit_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                    </Columns>
                                </asp:GridView>
                                <div class="space-4"></div>

                            </div>
                            <%--<lable ID="btnprint" runat="server" class="width-10 pull-left btn btn-sm btn-success" onclick="printDiv('printable')">
                                Print Attendance

                            </lable>--%>
                        </asp:View>
                        <asp:View ID="View2" runat="server">
                            <div class="login-container">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Manage Attendance
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Mark your Attendance: </p>
                                                <form id="freg">
                                                    <fieldset>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddtch" CssClass="input-medium" DataValueField="nu_id" DataTextField="name" DataSourceID="sqltch" runat="server"></asp:DropDownList>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddstatus" AutoPostBack="true" Enabled="true" runat="server">
                                                                    <asp:ListItem Text="Select ..." />
                                                                    <asp:ListItem Text="Present" />
                                                                    <asp:ListItem Text="Absent" />
                                                                    <%--  <asp:ListItem Text="Full Leave Application" />
                                                                    <asp:ListItem Text="Half Leave Application" />--%>
                                                                </asp:DropDownList>
                                                                <div class="space-10"></div>
                                                                <%--<asp:FileUpload ID="fulv" runat="server" />--%>
                                                                <asp:TextBox Height="90" placeholder="Enter Your Leaving Reason" ID="fulv" runat="server"></asp:TextBox>
                                                            </span>
                                                        </label>

                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <asp:Button ID="btnadd" runat="server" Text="Submit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnadd_Click" />
                                                        </div>
                                                    </fieldset>
                                                </form>
                                                -
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <asp:SqlDataSource ID="sqltch" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strfname]+' '+[strlname] as name,nu_id FROM [tbl_Users] WHERE  nsch_id=@schid and ([nLevel] =@am_emp OR [nLevel] = @adm_emp OR [nLevel] = @lib_emp OR [nLevel] = @hstl_emp )  and bisDeleted='False'">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="5" Name="am_emp" Type="Int32"></asp:Parameter>
                                    <asp:Parameter DefaultValue="10" Name="lib_emp" Type="Int32"></asp:Parameter>
                                    <asp:Parameter DefaultValue="11" Name="hstl_emp" Type="Int32"></asp:Parameter>
                                    <asp:Parameter DefaultValue="1" Name="adm_emp" Type="Int32"></asp:Parameter>
                                    <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                        </asp:View>
                        <asp:View ID="View3" runat="server">
                            <div class="login-container">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Manage Leave
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Mark your Attendance Leave: </p>
                                                <form id="Form1">
                                                    <fieldset>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddltchr" CssClass="input-medium" DataValueField="nu_id" DataTextField="name" DataSourceID="sqltch" runat="server"></asp:DropDownList>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddlstatus" AutoPostBack="true" Enabled="true" runat="server">
                                                                    <asp:ListItem Text="Select ..." />
                                                                    <asp:ListItem Text="Full Leave Application" />
                                                                    <asp:ListItem Text="Half Leave Application" />
                                                                </asp:DropDownList>
                                                                <div class="space-10"></div>
                                                                <%--<asp:FileUpload ID="fulv" runat="server" />--%>
                                                                <asp:TextBox Height="90" placeholder="Enter Your Leaving Reason" ID="txtReason" runat="server"></asp:TextBox>
                                                            </span>
                                                        </label>

                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <asp:Button ID="btnaddLeave" runat="server" Text="Submit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddLeave_Click" />
                                                        </div>
                                                    </fieldset>
                                                </form>
                                                -
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strfname],nu_id FROM [tbl_Users] WHERE ([nLevel] = @u_level) and bisDeleted='False'">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="2" Name="u_level" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>

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
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
