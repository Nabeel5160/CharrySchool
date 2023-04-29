<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewTeacherSalaryFeeReport.aspx.cs" Inherits="SchoolPRO.AdminViewTeacherSalaryFeeReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="row-fluid">
            <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>--%>
            <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">

                <asp:View ID="View2" runat="server">

                    <div class="clearfix"></div>
                    <div class="clearfix"></div>
                    <div class="col-xs-12 col-sm-12 widget-container-span">
                        <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                                <asp:DropDownList CssClass="form-control" ID="ddldpt" AutoPostBack="true" runat="server" AppendDataBoundItems="true" DataSourceID="ddlmonthDS" DataTextField="strMonthName" DataValueField="strMonthNo">
                                    <asp:ListItem Value="0">--Please Select Month--</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="ddlmonthDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT strMonthName, strMonthNo FROM tbl_FeeMonth"></asp:SqlDataSource>
                            </span>
                        </label>



                        <div class="clearfix"></div>
                        <div class="widget-box" id="printable">
                            <div class="widget-header  header-color-blue">
                                <h5 class="bigger lighter">
                                    <i class="icon-table"></i>
                                    Teacher Salary Fee Report
                                </h5>

                                <div class="widget-toolbar widget-toolbar-light no-border">
                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                </div>
                            </div>
                            <div class="widget-body">
                                <div class="widget-main no-padding">


                                    <asp:GridView ID="gv_detail_list" AllowPaging="true" PageSize="15" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="salaryDS">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Invc #" HeaderText="Invc #" SortExpression="Invc #"></asp:BoundField>
                                            <asp:BoundField DataField="Teacher Name" HeaderText="Teacher Name" SortExpression="Teacher Name" ReadOnly="True"></asp:BoundField>
                                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone"></asp:BoundField>
                                            <%--  --%>
                                            <asp:BoundField DataField="Salary" HeaderText="Salary" SortExpression="Salary"></asp:BoundField>
                                            <asp:BoundField DataField="Fine" HeaderText="Fine" SortExpression="Fine"></asp:BoundField>
                                            <asp:BoundField DataField="Given Date" HeaderText="Given Date" SortExpression="Given Date"></asp:BoundField>
                                            <asp:BoundField DataField="Given By" HeaderText="Given By" ReadOnly="True" SortExpression="Given By"></asp:BoundField>
                                            <asp:BoundField DataField="Teacher Present" HeaderText="Teacher Present" ReadOnly="True" SortExpression="Teacher Present"></asp:BoundField>
                                            <asp:BoundField DataField="Teacher Absents" HeaderText="Teacher Absents" ReadOnly="True" SortExpression="Teacher Absents"></asp:BoundField>
                                            <asp:BoundField DataField="Teacher Full Leaves" HeaderText="Teacher Full Leaves" ReadOnly="True" SortExpression="Teacher Full Leaves"></asp:BoundField>
                                            <asp:BoundField DataField="Teacher Half Leaves" HeaderText="Teacher Half Leaves" ReadOnly="True" SortExpression="Teacher Half Leaves"></asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                    <%-- <asp:GridView ID="gv_detail_list" CssClass=" table table-striped table-bordered table-hover" runat="server" DataSourceID="FeereportDS">
                                                    </asp:GridView>
                                                    <asp:SqlDataSource runat="server" ID="FeereportDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_RecieveFee.nChallanNum AS 'Challan #', CAST(tbl_Enrollment.bRegisteredNum AS varchar(MAX)) + ' ' + tbl_Enrollment.strStudentNum AS 'Reg #', tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS 'Student Name', tbl_Users.strfname + ' ' + tbl_Users.strlname AS 'Guardian Name', tbl_Users.strPhone AS 'Guardian  Phone', tbl_Class.strClass AS Class, tbl_Section.strSection AS Section, tbl_RecieveFee.strFeeAmount AS 'Class Fee', tbl_RecieveFee.strFeeAmountReceived AS 'Recieved Fee', tbl_RecieveFee.strFeeAmountRemaining AS 'Remaining Fee', tbl_RecieveFee.strFeeConcession, tbl_RecieveFee.strFeeMonth FROM tbl_RecieveFee INNER JOIN tbl_Class ON tbl_RecieveFee.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_RecieveFee.nsc_id = tbl_Section.nsc_id INNER JOIN tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Users ON tbl_Enrollment.nu_id = tbl_Users.nu_id WHERE (tbl_RecieveFee.bisDeleted = 'False') AND (tbl_RecieveFee.nsch_id = @schid) AND (DATEPART(mm, tbl_RecieveFee.strFeeMonth) = @month) AND (tbl_RecieveFee.strRecieveType = 'Class') AND (tbl_RecieveFee.nc_id = @cid) AND (tbl_RecieveFee.nsc_id = @sc) AND DATEPART(yyyy, tbl_RecieveFee.strFeeMonth) = DATEPART(yyyy, CONVERT(VARCHAR(10), GETDATE(), 105 )">
                                                        <SelectParameters>
                                                            <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                                            <asp:ControlParameter ControlID="ddlmonth" PropertyName="SelectedValue" Name="month"></asp:ControlParameter>
                                                            <asp:ControlParameter ControlID="ddlclass" PropertyName="SelectedValue" Name="cid"></asp:ControlParameter>
                                                            <asp:ControlParameter ControlID="ddlsc" PropertyName="SelectedValue" Name="sc"></asp:ControlParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>--%>

                                    <asp:SqlDataSource runat="server" ID="salaryDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT sal.nPayslip as 'Invc #', u1.strfname + ' ' + u1.strlname AS 'Teacher Name', u1.strPhone AS Phone, sal.strSalary AS Salary, sal.strFine AS Fine, sal.dtAddDate AS 'Given Date', u2.strfname + ' ' + u2.strlname AS 'Given By', (SELECT COUNT(strStatus) AS prsnt FROM tbl_TeacherAttendance WHERE (strStatus = 'Present') AND (nu_id = sal.nu_id) AND (SUBSTRING(dtAddDate ,4,2) = @mm) AND (SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10)) AND (bisDeleted = 'False') AND (nsch_id = @schid44)) AS 'Teacher Present', (SELECT COUNT(strStatus) AS absnt FROM tbl_TeacherAttendance AS tbl_TeacherAttendance_1 WHERE (strStatus = 'Abscent') AND (nu_id = sal.nu_id) AND (SUBSTRING(dtAddDate ,4,2) = @mm) AND (SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10)) AND (bisDeleted = 'False') AND (nsch_id = @schid44)) AS 'Teacher Absents', (SELECT COUNT(strStatus) AS fullev FROM tbl_TeacherAttendance AS tbl_TeacherAttendance_1 WHERE (strStatus = 'Full Leave Application') AND (nu_id = sal.nu_id) AND (SUBSTRING(dtAddDate ,4,2) = @mm) AND (SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10)) AND (bisDeleted = 'False') AND (nsch_id = @schid44)) AS 'Teacher Full Leaves', (SELECT COUNT(strStatus) AS fullev FROM tbl_TeacherAttendance AS tbl_TeacherAttendance_1 WHERE (strStatus = 'Half Leave Application') AND (nu_id = sal.nu_id) AND (SUBSTRING(dtAddDate ,4,2) = @mm) AND (SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10)) AND (bisDeleted = 'False') AND (nsch_id = @schid44)) AS 'Teacher Half Leaves' FROM tbl_Salary AS sal INNER JOIN tbl_Users AS u1 ON sal.nu_id = u1.nu_id INNER JOIN tbl_Users AS u2 ON sal.userid = u2.nu_id WHERE (SUBSTRING(sal.dtAddDate,4,2) = @mm) AND SUBSTRING(sal.dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10) AND (sal.bisDeleted = 'False') AND (sal.nsch_id = @schid44)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ddldpt" PropertyName="SelectedValue" Name="mm"></asp:ControlParameter>
                                            <asp:SessionParameter SessionField="nschoolid" Name="schid44"></asp:SessionParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:SqlDataSource runat="server" ID="fEEREPORT" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT FROM tbl_Salary"></asp:SqlDataSource>
                                </div>
                            </div>
                        </div>
                    </div>

                </asp:View>
            </asp:MultiView>
            <%--   </ContentTemplate>
                </asp:UpdatePanel>--%>
        </div>
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
