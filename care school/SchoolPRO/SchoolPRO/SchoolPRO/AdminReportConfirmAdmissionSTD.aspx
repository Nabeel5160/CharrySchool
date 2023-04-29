<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminReportConfirmAdmissionSTD.aspx.cs" Inherits="SchoolPRO.AdminReportConfirmAdmissionSTD" %>
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
                                   
                                    <%--<label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList CssClass="form-control" AutoPostBack="true" ID="ddlclass" OnSelectedIndexChanged="ddlclass_SelectedIndexChanged" runat="server" AppendDataBoundItems="true" DataSourceID="ddlclassDS" DataTextField="strClass" DataValueField="nc_id">
                                        <asp:ListItem  Value="0" >--Please Select Class--</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="ddlclassDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nc_id, strClass FROM tbl_Class WHERE (bisDeleted = 'False') AND (nsch_id = @schid)">
                                        <SelectParameters>
                                            <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                                                    </span></label>--%>
                                    

                                    <div class="clearfix"></div>
                                    <div class="widget-box" id="printable">
                                        <div class="widget-header  header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Admission Partial Confirm  Report(After Fee Paid their Admission would be Confirmed)
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                        <div class="widget-body">
												<div class="widget-main no-padding">

                                                    
                                                    <asp:GridView ID="gv_detail_list" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="fEEREPORT">
                                                        <Columns>
                                                           <%-- <asp:TemplateField  >
                                                               <ItemTemplate    >
                                                                   <%# Container.DataItemIndex + 1 %>
                                                               </ItemTemplate>
                                                            </asp:TemplateField>--%>
                                                            <asp:BoundField DataField="Reg No" HeaderText="Reg No" SortExpression="Reg No"></asp:BoundField>
                                                            <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name"></asp:BoundField>
                                                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone"></asp:BoundField>
                                                            <asp:BoundField DataField="Class" HeaderText="Class" SortExpression="Class"></asp:BoundField>
                                                            <asp:BoundField DataField="Section" HeaderText="Section" SortExpression="Section"></asp:BoundField>
                                                            <asp:BoundField DataField="Admission Date" HeaderText="Admission Date" SortExpression="Admission Date"></asp:BoundField>
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

                                                    <asp:SqlDataSource runat="server" ID="fEEREPORT" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Enrollment.bRegisteredNum AS 'Reg No', tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS 'Name', tbl_Enrollment.strPhone AS 'Phone', tbl_Class.strClass AS 'Class', tbl_Section.strSection AS 'Section', tbl_Enrollment.dtAddDate AS 'Admission Date' FROM tbl_Enrollment INNER JOIN tbl_Class ON tbl_Enrollment.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_Enrollment.nsc_id = tbl_Section.nsc_id WHERE (tbl_Enrollment.bisDeleted = @tbit) AND (tbl_Enrollment.strStatus = @pd) AND (tbl_Enrollment.nsch_id = @schid) AND (tbl_Class.bisDeleted = @fbit) AND (tbl_Section.bisDeleted = @fbit)">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="true" Name="tbit"></asp:Parameter>
                                                            <asp:Parameter DefaultValue="Pending" Name="pd"></asp:Parameter>
                                                            <asp:SessionParameter SessionField="nschoolid" Name="schid"   />
                                                            <%--<asp:ControlParameter ControlID="ddlsc" PropertyName="SelectedValue" Name="sc" DefaultValue="0"></asp:ControlParameter>--%>
                                                            <asp:Parameter DefaultValue="false" Name="fbit"></asp:Parameter>
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
