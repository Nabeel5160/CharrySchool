<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewAbsentStudent.aspx.cs" Inherits="SchoolPRO.AdminViewAbsentStudent" %>
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
                Absent Students
            </h4>

            <div class="space-6"></div>
           <%-- <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>--%>
             <asp:ToolkitScriptManager  ID="tool1" runat="server"  ></asp:ToolkitScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvatnd" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                              <label> Enter Date :</label> 
                            <asp:TextBox AutoPostBack="true"  ID="txtDate" placeholder="dd-MM-yyyy"   runat="server" class="width-10"  OnTextChanged="txtDate_TextChanged"></asp:TextBox>
                            <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtDate" runat="server"></asp:CalendarExtender> 
                              <div class="space-22"></div>
                            <div id="printable" class="table-responsive">
                                <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Absent Students
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                <asp:GridView ID="gvabsntstudents" class="table table-striped table-bordered table-hover" runat="server" AllowSorting="True" AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                        <asp:BoundField DataField="strStatus" HeaderText="Status" SortExpression="strStatus" />
                                        <asp:BoundField DataField="strStudentNum" SortExpression="Roll No." HeaderText="Roll No." />
                                        
                                        
                                        <asp:BoundField DataField="strFname" SortExpression="Name" HeaderText="Name" />
                                        <asp:BoundField DataField="strClass" SortExpression="Class" HeaderText="Class" />
                                        <asp:BoundField DataField="strSection" SortExpression="Section" HeaderText="Section" />
                                        
                                        
                                        
                                        <asp:BoundField DataField="strPhone" SortExpression="Phone" HeaderText="Phone" />
                                        
                                        <asp:BoundField DataField="strMobile" HeaderText="Mobile" SortExpression="strMobile"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>

                                <%--<asp:SqlDataSource runat="server" ID="AbsentStudentsDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Attendance.strStatus, tbl_Enrollment.strStudentNum, tbl_Enrollment.strFname, tbl_Class.strClass, tbl_Section.strSection, tbl_Attendance.dtAddDate, tbl_Enrollment.strPhone, tbl_Enrollment.strMobile FROM tbl_Attendance INNER JOIN tbl_Enrollment ON tbl_Attendance.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Class ON tbl_Attendance.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_Attendance.nsc_id = tbl_Section.nsc_id WHERE (DATEPART(d, tbl_Attendance.dtAddDate) = DATEPART(d, CONVERT(VARCHAR(10), GETDATE(), 105 ))) AND (tbl_Attendance.bisDeleted = 'False') AND (tbl_Attendance.strStatus = 'Absent') and tbl_Attendance.nsch_id=@schid">
                                    <SelectParameters   >
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>--%>
                                <asp:SqlDataSource runat="server" ID="AbsentStudentsDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Attendance.strStatus, tbl_Enrollment.strStudentNum, tbl_Enrollment.strFname, tbl_Class.strClass, tbl_Section.strSection, tbl_Attendance.dtAddDate, tbl_Enrollment.strPhone, tbl_Enrollment.strMobile FROM tbl_Attendance INNER JOIN tbl_Enrollment ON tbl_Attendance.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Class ON tbl_Attendance.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_Attendance.nsc_id = tbl_Section.nsc_id WHERE tbl_Attendance.dtAddDate = CONVERT(VARCHAR(10), GETDATE(), 105 ) AND (tbl_Attendance.bisDeleted = 'False') AND (tbl_Attendance.strStatus = 'Absent') and tbl_Attendance.nsch_id=@schid">
                                    <SelectParameters   >
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <div class="space-4"></div>
                                
                            </div>
                            <%--<lable ID="btnprint" runat="server" class="width-10 pull-left btn btn-sm btn-success" onclick="printDiv('printable')">
                                Print Attendance

                            </lable>--%>
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
