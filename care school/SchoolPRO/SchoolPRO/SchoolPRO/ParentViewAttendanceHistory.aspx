<%@ Page Title="" Language="C#" MasterPageFile="~/Parent.Master" AutoEventWireup="true" CodeBehind="ParentViewAttendanceHistory.aspx.cs" Inherits="SchoolPRO.ParentViewAttendanceHistory" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="col-xs-12">
        <h3 class="header smaller lighter blue">Attendane Report</h3>
        <div class="table-header">
            Results for "Student Attendance"
        </div>

<%--        <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>--%>
         <asp:ToolkitScriptManager  ID="tool1" runat="server"  ></asp:ToolkitScriptManager>
        <asp:UpdatePanel ID="upst_att" runat="server">
            <ContentTemplate>
                <asp:MultiView ID="mvst_att" ActiveViewIndex="0" runat="server">

                    <asp:View ID="View1" runat="server">
                        <asp:Button ID="btnviewother" class="width-25 pull-left btn btn-sm btn-success" runat="server" Text="Go Back" OnClick="btnviewother_Click" />
                        <asp:Button Text="View All" class="width-25 pull-left btn btn-sm btn-success" runat="server" ID="btngoall" OnClick="btngoall_Click" />
                        <div class="space-12"></div>
                        <br />
                        <br />
                        <asp:TextBox runat="server" ID="txtstnum" ReadOnly="true" placeholder="Student Number" />
                        From:
                        <asp:TextBox ID="txtdtfrom" runat="server" placeholder="From.." ></asp:TextBox>
                         <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtdtfrom" runat="server"></asp:CalendarExtender>
                        To:
                        <asp:TextBox ID="txtdtto" runat="server" placeholder="To.."  AutoPostBack="true" Enabled="true"></asp:TextBox>
                         <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtfrom" runat="server"></asp:CalendarExtender>
                        <div class="table-responsive">
                            <asp:GridView ID="gddtatt" class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sql_attbydate">
                                <Columns>
                                    <asp:BoundField DataField="strStudentNum" HeaderText="Student Number" SortExpression="strStudentNum" />
                                    <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                                    <asp:BoundField DataField="strMname" HeaderText="Middle Name" SortExpression="strMname" />
                                    <asp:BoundField DataField="strStatus" HeaderText="Status" SortExpression="strStatus" />
                                    <asp:BoundField DataField="dtAddDate" HeaderText="Date" SortExpression="dtAddDate" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sql_attbydate" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Enrollment.strStudentNum, tbl_Enrollment.strFname, tbl_Enrollment.strMname, tbl_Attendance.strStatus, tbl_Attendance.dtAddDate FROM tbl_Attendance INNER JOIN tbl_Enrollment ON tbl_Attendance.ne_id = tbl_Enrollment.ne_id WHERE (tbl_Enrollment.strStudentNum = @stnum) and tbl_Attendance.dtAddDate>=@dtfrom and tbl_Attendance.dtAddDate<=@dtto and tbl_Attendance.nsch_id=@schid">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="txtstnum" Name="stnum" Type="String" />
                                    <asp:ControlParameter ControlID="txtdtfrom" Name="dtfrom" Type="String" />
                                    <asp:ControlParameter ControlID="txtdtto" Name="dtto" Type="String" />
                                    <asp:SessionParameter SessionField="nschoolid" Name="schid" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </asp:View>
                    <asp:View runat="server">
                        <asp:Button ID="btngobck" class="width-25 pull-left btn btn-sm btn-success" runat="server" Text="Go Back" OnClick="btngobck_Click" />
                        <asp:Button ID="btngoback" runat="server" class="width-25 pull-left btn btn-sm btn-success" Text="View By Date" OnClick="btngoback_Click" />
                        <div class="space-12"></div>
                        <div class="table-responsive">
                            <asp:GridView ID="gvat" class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sqlat">
                                <Columns>
                                    <asp:BoundField DataField="strStudentNum" HeaderText="Student Number" SortExpression="strStudentNum" />
                                    <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                                    <asp:BoundField DataField="strMname" HeaderText="Middle Name" SortExpression="strMname" />
                                    <asp:BoundField DataField="strStatus" HeaderText="Status" SortExpression="strStatus" />
                                    <asp:BoundField DataField="dtAddDate" HeaderText="Date" SortExpression="dtAddDate" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sqlat" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT s.strStudentNum,s.strFname,s.strMname,a.strStatus,a.dtAddDate from tbl_Attendance a inner join tbl_Enrollment s on a.ne_id=s.ne_id where s.ne_id=@uid a.nsch_id=@schid">
                                <SelectParameters>
                                    <asp:SessionParameter Name="uid" SessionField="enum" />
                                    <asp:SessionParameter SessionField="nschoolid" Name="schid" />
                                </SelectParameters>
                            </asp:SqlDataSource>
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
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->


</asp:Content>
