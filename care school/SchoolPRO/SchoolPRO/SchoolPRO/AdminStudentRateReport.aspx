<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminStudentRateReport.aspx.cs" Inherits="SchoolPRO.AdminStudentRateReport" %>

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
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
     <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
         <%--   <asp:ScriptManager ID="ScriptManager1" runat="server" />--%>
            <asp:ToolkitScriptManager  ID="tool1" runat="server"  ></asp:ToolkitScriptManager>
            <div class="row-fluid">
         <%--       <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>--%>
                        <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <div class="col-xs-12 col-sm-12 widget-container-span">
                                    <div class="widget-box" id="printable">
                                        <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Student Rating Report Report
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
                                                        <asp:TextBox ID="txtfrom" AutoPostBack="true" runat="server"></asp:TextBox>
                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtfrom" runat="server"></asp:CalendarExtender>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <asp:TextBox ID="txtto" AutoPostBack="true" runat="server"></asp:TextBox>
                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtto" runat="server"></asp:CalendarExtender>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                    <div class="space-4"></div>
                                <asp:GridView ID="gvstlist" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sqlstlist">
                                    <Columns>
                                         <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ReadOnly="True" />
                                        <asp:BoundField DataField="Reg #" HeaderText="Reg #" SortExpression="Reg #" />
                                        <asp:BoundField DataField="Class" HeaderText="Class" SortExpression="Class" />
                                        <asp:BoundField DataField="Section" HeaderText="Section" SortExpression="Section" />
                                        <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject" ReadOnly="True" />
                                        <asp:BoundField DataField="Total Points" HeaderText="Total Points" SortExpression="Total Points" />
                                        <asp:BoundField DataField="Obtained Points" HeaderText="Obtained Points" SortExpression="Obtained Points" />
                                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks"></asp:BoundField>
                                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                                                    <asp:SqlDataSource ID="sqlstlist" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS 'Name', tbl_Enrollment.bRegisteredNum AS 'Reg #', tbl_Class.strClass AS 'Class', tbl_Section.strSection AS 'Section', tbl_Subject.strSubject + ' - ' + tbl_Subject.strCourseCode AS 'Subject', tbl_Rating.strOutOf AS 'Total Points', tbl_Rating.strPoints AS 'Obtained Points', tbl_Rating.strRemarks AS 'Remarks', tbl_Rating.dtAddDate AS 'Date' FROM tbl_Rating INNER JOIN tbl_Enrollment ON tbl_Rating.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Class ON tbl_Enrollment.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_Enrollment.nsc_id = tbl_Section.nsc_id INNER JOIN tbl_Subject ON tbl_Rating.nsbj_id = tbl_Subject.nsbj_id WHERE (tbl_Subject.bisDeleted = @fbit) AND (tbl_Enrollment.bisDeleted = @fbit) AND (tbl_Class.bisDeleted = @fbit) AND (tbl_Section.bisDeleted = @fbit) AND (tbl_Rating.dtAddDate <= @to ) AND (tbl_Rating.dtAddDate >= @fm) AND (tbl_Rating.nsch_id = @schid) AND (tbl_Rating.bisDeleted = @fbit)">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="false" Name="fbit"></asp:Parameter>
                                                            <asp:ControlParameter Name="to" ControlID="txtto" Type="String" />
                                                            <asp:ControlParameter Name="fm" ControlID="txtfrom" DefaultValue="" PropertyName="Text" />
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                                    </div>
                                            </div>
                                    </div>
                                </div>
                            </asp:View>
                            
                        </asp:MultiView>
           <%--         </ContentTemplate>
                </asp:UpdatePanel>--%>
                </div>
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
