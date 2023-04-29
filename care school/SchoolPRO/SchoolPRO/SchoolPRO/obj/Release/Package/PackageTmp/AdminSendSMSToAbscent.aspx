<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminSendSMSToAbscent.aspx.cs" Inherits="SchoolPRO.AdminSendSMSToAbscent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
     <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <div class="col-xs-12">
        <%--<asp:Timer ID="tRefresh" runat="server" OnTick="tRefresh_Tick" Interval="6000"></asp:Timer>--%>
        <div class="table-responsive">
            <asp:TextBox ID="txtmsg" TextMode="MultiLine" runat="server"></asp:TextBox>
            <div class="space-12"></div>
            <asp:GridView ID="gvattnd" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="sqlattnd">
                <Columns>

                    <asp:BoundField DataField="strStudentNum" SortExpression="strStudentNum" HeaderText="Student Number" />
                    <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                    <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strLname" />
                    <asp:BoundField DataField="strfname" HeaderText="First Name" SortExpression="strfname" />
                    <asp:BoundField DataField="strlname" HeaderText="Last Name" SortExpression="strlname" />
                    <asp:BoundField DataField="strCell" HeaderText="Cell Number" SortExpression="strCell" />
                    <asp:BoundField DataField="strStatus" HeaderText="Status" SortExpression="strStatus" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sqlattnd" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Enrollment.strStudentNum, tbl_Enrollment.strFname, tbl_Enrollment.strLname, tbl_Users.strfname AS Expr1, tbl_Users.strlname AS Expr2, tbl_Users.strCell, tbl_Attendance.strStatus FROM tbl_Attendance INNER JOIN tbl_Enrollment ON tbl_Attendance.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Users ON tbl_Enrollment.nu_id = tbl_Users.nu_id WHERE (tbl_Attendance.dtAddDate = CONVERT(VARCHAR(10), GETDATE(), 105 ) and tbl_Attendance.strStatus='Abscent' and tbl_Attendance.nsch_id=@schid) ">
            <SelectParameters>
                <asp:SessionParameter Name="schid" SessionField="nschoolid" />
            </SelectParameters>
            </asp:SqlDataSource>
            <asp:Button ID="btnsubmitattend" class="width-35 pull-right btn btn-sm btn-primary" runat="server" Text="Submit" OnClick="btnsubmitattend_Click" />
        </div>
        <!-- /.table-responsive -->
    </div>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
