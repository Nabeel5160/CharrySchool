<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminStudentAttendanceReport.aspx.cs" Inherits="SchoolPRO.AdminStudentAttendanceReport" %>
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
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
           <%-- <asp:ScriptManager ID="ScriptManager1" runat="server" />--%>
             <asp:ToolkitScriptManager  ID="tool1" runat="server"  ></asp:ToolkitScriptManager>
            <div class="row-fluid">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:GridView ID="gvstlist" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataKeyNames="nc_id" DataSourceID="sqlstlist">
                                    <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nc_id" HeaderText="S.NO" SortExpression="nc_id" />
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                        <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnview" class="width-80 pull-left btn btn-sm btn-success" runat="server" Text="View" OnClick="btnview_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sqlstlist" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Class.nc_id, tbl_Class.strClass, tbl_Section.strSection FROM tbl_Class INNER JOIN tbl_Section ON tbl_Class.nc_id = tbl_Section.nc_id WHERE (tbl_Class.nsch_id = @sch_id AND tbl_Section.bisDeleted=0 AND tbl_Class.bisDeleted=0)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="sch_id" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <div class="col-xs-12 col-sm-12 widget-container-span">
                                    <div class="widget-box" id="printable">
                                        <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Students Attendance Report
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                        <div class="widget-body">
												<div class="widget-main no-padding">
                                                    <div class="clearfix"></div>
                                                    <div class="space-4"></div>
                                                    <div class="col-lg-3">
                                                        <asp:Label runat="server" Text="From"></asp:Label>
                                                        <asp:TextBox ID="txtfrom" runat="server"></asp:TextBox>
                                                         <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtfrom" runat="server"></asp:CalendarExtender>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <asp:Label runat="server" Text="To"></asp:Label>
                                                        <asp:TextBox ID="txtto"  AutoPostBack="true" runat="server"></asp:TextBox>
                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtto" runat="server"></asp:CalendarExtender>
                                                         </div>
                                                    <div class="clearfix"></div>
                                                    <div class="space-4"></div>
                                                    <asp:GridView ID="gv_detail_list" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sql_detail_list">
                                    <Columns>
                                        <asp:BoundField DataField="strStudentNum" HeaderText="Roll #" SortExpression="strStudentNum" />
                                        <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                                        <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strLname" />
                                        <asp:BoundField DataField="strfname" HeaderText="Gaurdian First Name" SortExpression="strfname" />
                                        <asp:BoundField DataField="strlname" HeaderText="Gaurdian Last Name" SortExpression="strlname" />
                                        <asp:BoundField DataField="strStatus" HeaderText="Status" SortExpression="strStatus" />
                                        
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sql_detail_list" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="select e.strStudentNum,e.strFname,e.strLname,u.strfname,u.strlname,a.strStatus from tbl_Attendance a inner join tbl_Enrollment e on a.ne_id=e.ne_id inner join tbl_Users u on e.nu_id=u.nu_id where a.dtAddDate>=@from and a.dtAddDate<=@to and a.nc_id=@val and a.nsc_id=(select nsc_id from tbl_Section where strSection=@secs and nc_id=@val and bisDeleted='False' and nsch_id=@schid1) and a.bisDeleted='False' and a.nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                        <asp:SessionParameter Name="schid1" SessionField="nschoolid" />
                                        <asp:ControlParameter Name="from" ControlID="txtfrom" Type="String" />
                                        <asp:ControlParameter Name="to" ControlID="txtto" Type="String" />
                                        <asp:SessionParameter Name="secs" SessionField="secs" />
                                        <asp:SessionParameter Name="val" SessionField="val" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
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
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
