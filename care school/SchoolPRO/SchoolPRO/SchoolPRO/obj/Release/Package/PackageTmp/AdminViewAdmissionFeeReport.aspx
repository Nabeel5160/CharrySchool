<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewAdmissionFeeReport.aspx.cs" Inherits="SchoolPRO.AdminViewAdmissionFeeReport" %>
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
                                    <asp:DropDownList CssClass="form-control" ID="ddlmonth" AutoPostBack="true" runat="server" AppendDataBoundItems="true" DataSourceID="ddlmonthDS" DataTextField="strMonthName" DataValueField="strMonthNo">
                                        <asp:ListItem Value="0" >--Please Select Month--</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="ddlmonthDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT strMonthName, strMonthNo FROM tbl_FeeMonth WHERE (bisDeleted = 'False')"></asp:SqlDataSource>
                                    </span>
                                                                    </label>
                                    <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList CssClass="form-control" AutoPostBack="true" ID="ddlclass" OnSelectedIndexChanged="ddlclass_SelectedIndexChanged" runat="server" AppendDataBoundItems="true" DataSourceID="ddlclassDS" DataTextField="strClass" DataValueField="nc_id">
                                        <asp:ListItem  Value="0" >--Please Select Class--</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="ddlclassDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nc_id, strClass FROM tbl_Class WHERE (bisDeleted = 'False') AND (nsch_id = @schid)">
                                        <SelectParameters>
                                            <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                                                    </span></label>
                                    <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                    <asp:DropDownList  AutoPostBack="True" CssClass="form-control" ID="ddlsc" runat="server" DataSourceID="ddlscDS" DataTextField="strSection" DataValueField="nsc_id">
                                        <asp:ListItem  Value="0" >--Please Select Section--</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="ddlscDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nsc_id, strSection FROM tbl_Section WHERE (bisDeleted = 'False') AND (nsch_id = @schid) AND (nc_id = @cid)">
                                        <SelectParameters>
                                            <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                            <asp:ControlParameter ControlID="ddlclass" PropertyName="SelectedValue" Name="cid"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                                                    </span></label>

                                    <div class="clearfix"></div>
                                    <div class="widget-box" id="printable">
                                        <div class="widget-header  header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Class Admission Fee Report
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                        <div class="widget-body">
												<div class="widget-main no-padding">

                                                    
                                                    <asp:GridView ID="gv_detail_list" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="fEEREPORT">
                                                        <Columns>
                                                            <asp:BoundField DataField="Challan #" HeaderText="Challan #" SortExpression="Challan #"></asp:BoundField>

                                                            <asp:BoundField DataField="Reg #" HeaderText="Reg #" SortExpression="Reg #" ReadOnly="True"></asp:BoundField>
                                                            <asp:BoundField DataField="Student Name" HeaderText="Student Name" ReadOnly="True" SortExpression="Student Name"></asp:BoundField>
                                                            <asp:BoundField DataField="Guardian Name" HeaderText="Guardian Name" ReadOnly="True" SortExpression="Guardian Name"></asp:BoundField>
                                                            <asp:BoundField DataField="Guardian  Phone" HeaderText="Guardian  Phone" SortExpression="Guardian  Phone"></asp:BoundField>
                                                            <asp:BoundField DataField="Class" HeaderText="Class" SortExpression="Class"></asp:BoundField>
                                                            <asp:BoundField DataField="Section" HeaderText="Section" SortExpression="Section"></asp:BoundField>
                                                            <asp:BoundField DataField="Class Fee" HeaderText="Class Fee" SortExpression="Class Fee"></asp:BoundField>
                                                            <asp:BoundField DataField="Class Fee Charged" HeaderText="Class Fee Charged" SortExpression="Class Fee Charged"></asp:BoundField>
                                                            <asp:BoundField DataField="Admission Fee" HeaderText="Admission Fee" SortExpression="Admission Fee"></asp:BoundField>
                                                            <asp:BoundField DataField="ConcessionPer" HeaderText="ConcessionPer" SortExpression="ConcessionPer" ReadOnly="True"></asp:BoundField>
                                                            <asp:BoundField DataField="Recieved Fee" HeaderText="Recieved Fee" SortExpression="Recieved Fee"></asp:BoundField>


                                                            <asp:BoundField DataField="Remaining Fee" HeaderText="Remaining Fee" SortExpression="Remaining Fee"></asp:BoundField>
                                                            <asp:BoundField DataField="Concession Fee" HeaderText="Concession Fee" SortExpression="Concession Fee"></asp:BoundField>
                                                            
                                                            <asp:BoundField DataField="Fee Month" HeaderText="Fee Month" SortExpression="Fee Month"></asp:BoundField>
                                                            <asp:BoundField DataField="Months Fee Paid" HeaderText="Months Fee Paid" SortExpression="Months Fee Paid"></asp:BoundField>

                                                            <asp:BoundField DataField="Recieve Date" HeaderText="Recieve Date" SortExpression="Recieve Date"></asp:BoundField>
                                                            <%--  --%>

                                                          
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

                                                    <asp:SqlDataSource runat="server" ID="fEEREPORT" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_RecieveFee.nChallanNum AS 'Challan #', CAST(tbl_Enrollment.bRegisteredNum AS varchar(MAX)) + ' ' + tbl_Enrollment.strStudentNum AS 'Reg #', tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS 'Student Name', tbl_Users.strfname + ' ' + tbl_Users.strlname AS 'Guardian Name', tbl_Users.strPhone AS 'Guardian  Phone', tbl_Class.strClass AS Class, tbl_Section.strSection AS Section, tbl_Fee.strTutionFee AS 'Class Fee', tbl_RecieveFee.strFeeAmount AS 'Class Fee Charged',tbl_RecieveFee.strAdmissionFee as 'Admission Fee' ,CASE WHEN tbl_RecieveFee.strFeeConcession = 0 THEN 'Nill' ELSE CAST((((CAST(tbl_Fee.strTutionFee AS float) - CAST(tbl_RecieveFee.strFeeAmount AS float))) / CAST(tbl_Fee.strTutionFee AS float)) * 100 AS varchar(MAX)) + '%' END AS ConcessionPer, tbl_RecieveFee.strFeeAmountReceived AS 'Recieved Fee', tbl_RecieveFee.strFeeAmountRemaining AS 'Remaining Fee', tbl_RecieveFee.strFeeConcession AS 'Concession Fee', tbl_RecieveFee.strFeeMonth AS 'Fee Month', tbl_RecieveFee.strMonths AS 'Months Fee Paid', tbl_RecieveFee.dtAddDate AS 'Recieve Date'  FROM tbl_RecieveFee INNER JOIN (SELECT nc_id, strClass FROM tbl_Class AS tbl_Class_1 WHERE (bisDeleted = 'False')) AS tbl_Class ON tbl_RecieveFee.nc_id = tbl_Class.nc_id INNER JOIN (SELECT nsc_id, strSection FROM tbl_Section AS sec WHERE (bisDeleted = 'False')) AS tbl_Section ON tbl_RecieveFee.nsc_id = tbl_Section.nsc_id INNER JOIN (SELECT nsc_id, bRegisteredNum, strStudentNum, strFname, strLname, ne_id, nc_id, nfee_id, nu_id FROM tbl_Enrollment AS enroll WHERE (bisDeleted = 'False')) AS tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id INNER JOIN (SELECT strfname, strlname, nu_id, strPhone FROM tbl_Users AS usr WHERE (bisDeleted = 'False')) AS tbl_Users ON tbl_Enrollment.nu_id = tbl_Users.nu_id INNER JOIN (SELECT nfee_id, strTutionFee FROM tbl_Fee AS fe WHERE (bisDeleted = 'False')) AS tbl_Fee ON tbl_Enrollment.nfee_id = tbl_Fee.nfee_id WHERE (tbl_RecieveFee.bisDeleted = 'False') AND (tbl_RecieveFee.nsch_id = @schid) AND (SUBSTRING(tbl_RecieveFee.strFeeMonth,4,2) = @month) AND (tbl_RecieveFee.strRecieveType = 'Admission') AND (tbl_RecieveFee.nc_id = @cid) AND (tbl_RecieveFee.nsc_id = @sc) AND (SUBSTRING(tbl_RecieveFee.strFeeMonth ,7,10) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10))">
                                                        <SelectParameters>
                                                            <asp:SessionParameter SessionField="nschoolid" Name="schid"   />
                                                           
                                                            <asp:ControlParameter ControlID="ddlmonth" PropertyName="SelectedValue" Name="month" DefaultValue="0"></asp:ControlParameter>
                                                            <asp:ControlParameter ControlID="ddlclass" PropertyName="SelectedValue" Name="cid" DefaultValue="0"></asp:ControlParameter>
                                                            <asp:ControlParameter ControlID="ddlsc" PropertyName="SelectedValue" Name="sc" DefaultValue="0"></asp:ControlParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
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
