<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewClassResultReport.aspx.cs" Inherits="SchoolPRO.AdminViewClassResultReport" %>

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
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="row-fluid">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">

                        <asp:View ID="View2" runat="server">

                            <div class="clearfix"></div>
                            <div class="clearfix"></div>
                            <div class="col-xs-12 col-sm-12 widget-container-span">
                                <label class="block clearfix">
                                    <span class="block input-icon input-icon-right">
                                        <asp:DropDownList CssClass="form-control" ID="ddlmonth" AutoPostBack="true" runat="server" AppendDataBoundItems="true" DataSourceID="ddlmonthDS" DataTextField="strExamName" DataValueField="nExam_id">
                                            <asp:ListItem Value="0">--Please Select Exam--</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource runat="server" ID="ddlmonthDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT strExamName,nExam_id, bisDeleted FROM tbl_ExamType WHERE (bisDeleted = 'False') and nsch_id=@schid">
                                            <SelectParameters>
                                                <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </span>
                                </label>
                                <label class="block clearfix">
                                    <span class="block input-icon input-icon-right">
                                        <%-- <asp:DropDownList CssClass="form-control" AutoPostBack="true" ID="ddlclass" OnSelectedIndexChanged="ddlclass_SelectedIndexChanged" runat="server" AppendDataBoundItems="true" DataSourceID="ddlclassDS" DataTextField="strClass" DataValueField="nc_id">
                                            <asp:ListItem Value="0">--Please Select Class--</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource runat="server" ID="ddlclassDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nc_id, strClass FROM tbl_Class WHERE (bisDeleted = 'False') AND (nsch_id = @schid)">
                                            <SelectParameters>
                                                <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>--%>
                                        <asp:DropDownList runat="server" ID="ddcl" OnSelectedIndexChanged="ddcl_SelectedIndexChanged" AppendDataBoundItems="true" AutoPostBack="true">
                                        </asp:DropDownList>
                                        <%--<asp:DropDownList AutoPostBack="true" runat="server" ID="ddcl" OnSelectedIndexChanged="ddcl_SelectedIndexChanged" AppendDataBoundItems="true"></asp:DropDownList>--%>
                                    </span>
                                </label>
                                <label class="block clearfix">
                                    <span class="block input-icon input-icon-right">
                                        <%--<asp:DropDownList AutoPostBack="True" CssClass="form-control" ID="ddlsc" runat="server" DataSourceID="ddlscDS" DataTextField="strSection" DataValueField="nsc_id">
                                            <asp:ListItem Value="0">--Please Select Section--</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource runat="server" ID="ddlscDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nsc_id, strSection FROM tbl_Section WHERE (bisDeleted = 'False') AND (nsch_id = @schid) AND (nc_id = @cid)">
                                            <SelectParameters>
                                                <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                                <asp:ControlParameter ControlID="ddlclass" PropertyName="SelectedValue" Name="cid"></asp:ControlParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>--%>
                                        <asp:DropDownList AutoPostBack="true" runat="server" ID="ddsec" AppendDataBoundItems="true"></asp:DropDownList>
                                    </span>
                                </label>

                                <div class="clearfix"></div>
                                <div class="widget-box" id="printable">
                                    <div class="widget-header  header-color-blue">
                                        <h5 class="bigger lighter">
                                            <i class="icon-table"></i>
                                            Class Result Report
                                        </h5>

                                        <div class="widget-toolbar widget-toolbar-light no-border">
                                            <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                        </div>
                                    </div>
                                    <div class="widget-body">
                                        <div class="widget-main no-padding">


                                            <asp:GridView ID="gv_detail_list" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="fEEREPORT">
                                                <Columns>
                                                    <asp:BoundField DataField="Reg #" HeaderText="Reg #" SortExpression="Reg #" ReadOnly="True"></asp:BoundField>
                                                    <asp:BoundField DataField="Student Name" HeaderText="Student Name" ReadOnly="True" SortExpression="Student Name"></asp:BoundField>
                                                    <asp:BoundField DataField="Father Name" HeaderText="Father Name" ReadOnly="True" SortExpression="Father Name"></asp:BoundField>
                                                    <asp:BoundField DataField="Father Phone" HeaderText="Father Phone" SortExpression="Father Phone"></asp:BoundField>
                                                    <asp:BoundField DataField="Class" HeaderText="Class" SortExpression="Class"></asp:BoundField>
                                                    <asp:BoundField DataField="Section" HeaderText="Section" SortExpression="Section"></asp:BoundField>
                                                    <asp:BoundField DataField="Subject Name" HeaderText="Subject Name" SortExpression="Subject Name"></asp:BoundField>
                                                    <asp:BoundField DataField="Subject Code" HeaderText="Subject Code" SortExpression="Subject Code"></asp:BoundField>
                                                    <asp:BoundField DataField="T M Subject" HeaderText="T M Subject" SortExpression="T M Subject"></asp:BoundField>
                                                    <asp:BoundField DataField="O M in Subject" HeaderText="O M in Subject" SortExpression="O M in Subject"></asp:BoundField>
                                                    <asp:BoundField DataField="SubjectPer" HeaderText="SubjectPer" SortExpression="SubjectPer" ReadOnly="True"></asp:BoundField>


                                                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" ReadOnly="True"></asp:BoundField>
                                                    <asp:BoundField DataField="Exam Type" HeaderText="Exam Type" SortExpression="Exam Type"></asp:BoundField>

                                                    <%--<asp:BoundField DataField="nc_id" HeaderText="nc_id" SortExpression="nc_id"></asp:BoundField>
                                                            <asp:BoundField DataField="nsc_id" HeaderText="nsc_id" SortExpression="nsc_id"></asp:BoundField>

                                                            <asp:BoundField DataField="nsch_id" HeaderText="nsch_id" SortExpression="nsch_id"></asp:BoundField>
                                                    --%> <%--  --%>



                                                    <asp:BoundField DataField="Total Marks" HeaderText="Total Marks" ReadOnly="True" SortExpression="Total Marks"></asp:BoundField>
                                                    <asp:BoundField DataField="Obtained Marks" HeaderText="Obtained Marks" ReadOnly="True" SortExpression="Obtained Marks"></asp:BoundField>
                                                    <asp:BoundField DataField="Total Percentage " HeaderText="Total Percentage " ReadOnly="True" SortExpression="Total Percentage "></asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <%-- <asp:GridView ID="gv_detail_list" CssClass=" table table-striped table-bordered table-hover" runat="server" DataSourceID="FeereportDS">
                                                    </asp:GridView>
                                                    <asp:SqlDataSource runat="server" ID="FeereportDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_RecieveFee.nChallanNum AS 'Challan #', CAST(tbl_Enrollment.bRegisteredNum AS varchar(MAX)) + ' ' + tbl_Enrollment.strStudentNum AS 'Reg #', tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS 'Student Name', tbl_Users.strfname + ' ' + tbl_Users.strlname AS 'Guardian Name', tbl_Users.strPhone AS 'Guardian  Phone', tbl_Class.strClass AS Class, tbl_Section.strSection AS Section, tbl_RecieveFee.strFeeAmount AS 'Class Fee', tbl_RecieveFee.strFeeAmountReceived AS 'Recieved Fee', tbl_RecieveFee.strFeeAmountRemaining AS 'Remaining Fee', tbl_RecieveFee.strFeeConcession, tbl_RecieveFee.strFeeMonth FROM tbl_RecieveFee INNER JOIN tbl_Class ON tbl_RecieveFee.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_RecieveFee.nsc_id = tbl_Section.nsc_id INNER JOIN tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Users ON tbl_Enrollment.nu_id = tbl_Users.nu_id WHERE (tbl_RecieveFee.bisDeleted = 'False') AND (tbl_RecieveFee.nsch_id = @schid) AND (DATEPART(mm, tbl_RecieveFee.strFeeMonth) = @month) AND (tbl_RecieveFee.strRecieveType = 'Class') AND (tbl_RecieveFee.nc_id = @cid) AND (tbl_RecieveFee.nsc_id = @sc) AND DATEPART(yyyy, tbl_RecieveFee.strFeeMonth) = DATEPART(yyyy, CONVERT(date,SYSDATETIME())">
                                                        <SelectParameters>
                                                            <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                                            <asp:ControlParameter ControlID="ddlmonth" PropertyName="SelectedValue" Name="month"></asp:ControlParameter>
                                                            <asp:ControlParameter ControlID="ddlclass" PropertyName="SelectedValue" Name="cid"></asp:ControlParameter>
                                                            <asp:ControlParameter ControlID="ddlsc" PropertyName="SelectedValue" Name="sc"></asp:ControlParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>--%>

                                            <asp:SqlDataSource runat="server" ID="fEEREPORT" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT CAST(tbl_Enrollment.bRegisteredNum AS Varchar(MAX)) + ' ' + tbl_Enrollment.strStudentNum AS 'Reg #', tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS 'Student Name', tbl_Users.strfname + ' ' + tbl_Users.strlname AS 'Father Name', tbl_Users.strPhone AS 'Father Phone', tbl_Class.strClass AS 'Class', tbl_Section.strSection AS 'Section', tbl_Subject.strSubject AS 'Subject Name', tbl_Subject.strCourseCode AS 'Subject Code', tbl_Result.strTotalMarks AS 'T M Subject', tbl_Result.strObtMarks AS 'O M in Subject', CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 AS SubjectPer, CAST(CASE WHEN CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 >= CAST(tbl_Percentage.strPercentage AS float) THEN 'Pass' ELSE 'Fail' END AS varchar(10)) AS Status, tbl_Result.strType AS 'Exam Type', tbl_Result.nc_id, tbl_Result.nsc_id, tbl_Result.nsch_id, (SELECT SUM(CAST(strTotalMarks AS int)) AS tt FROM tbl_Result AS rr WHERE (ne_id = tbl_Result.ne_id) AND (nc_id = @cid) AND (nsc_id = @scid) AND (nsch_id = @schid) AND (nExam_id = @examtype) AND (SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10)) AS 'Total Marks', (SELECT SUM(CAST(strObtMarks AS int)) AS tt FROM tbl_Result AS rr WHERE (ne_id = tbl_Result.ne_id) AND (nc_id = @cid) AND (nsc_id = @scid) AND (nsch_id = @schid) AND (nExam_id = @examtype) AND (SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10)) AS 'Obtained Marks', CAST((SELECT SUM(CAST(strObtMarks AS int)) AS tt FROM tbl_Result AS rr WHERE (ne_id = tbl_Result.ne_id) AND (nc_id = @cid) AND (nsc_id = @scid) AND (nsch_id = @schid) AND (nExam_id = @examtype) AND (SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10)) AS float) / CAST((SELECT SUM(CAST(strTotalMarks AS int)) AS tt FROM tbl_Result AS rr WHERE (ne_id = tbl_Result.ne_id) AND (nc_id = @cid) AND (nsc_id = @scid) AND (nsch_id = @schid) AND (nExam_id = @examtype) AND (SUBSTRING(dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10)) AS float) * 100 AS 'Total Percentage ' FROM tbl_Result INNER JOIN tbl_Enrollment ON tbl_Result.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Class ON tbl_Result.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_Result.nsc_id = tbl_Section.nsc_id INNER JOIN tbl_Subject ON tbl_Result.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Users ON tbl_Enrollment.nu_id = tbl_Users.nu_id CROSS JOIN (SELECT strPercentage FROM tbl_Percentage AS tbl_Percentage_1 WHERE (nsch_id = @schid)) AS tbl_Percentage WHERE (tbl_Result.nc_id = @cid) AND (tbl_Result.nsc_id = @scid) AND (tbl_Result.nsch_id = @schid) AND (tbl_Result.nExam_id = @examtype) AND (SUBSTRING(tbl_Result.dtAddDate ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10)) ORDER BY tbl_Result.ne_id">
                                                <SelectParameters>

                                                    <asp:ControlParameter ControlID="ddcl" PropertyName="SelectedValue" Name="cid" DefaultValue="0"></asp:ControlParameter>
                                                    <asp:ControlParameter ControlID="ddsec" PropertyName="SelectedValue" Name="scid" DefaultValue=""></asp:ControlParameter>
                                                    <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                                    <asp:ControlParameter ControlID="ddlmonth" PropertyName="SelectedValue" Name="examtype"></asp:ControlParameter>
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
   

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
