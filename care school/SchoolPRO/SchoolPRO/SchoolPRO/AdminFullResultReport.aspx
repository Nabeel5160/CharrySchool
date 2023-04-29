<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminFullResultReport.aspx.cs" Inherits="SchoolPRO.AdminFullResultReport" %>
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
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <div class="row-fluid">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                 <div class="pull-right">
                    <asp:Button CssClass="btn btn-success" Text="Back" runat="server" ID="btnback" OnClick="btnback_Click" />
                </div>
                        <div class="page-content-area">
						<div class="row">
							<div id="printable" class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->
								<div class="space-6"></div>

								<div class="row">
									<div class="col-sm-10 col-sm-offset-1">
										<div class="widget-box transparent">
											<div class="widget-header widget-header-large">
												<h3 class="widget-title grey lighter">
													<i class="ace-icon fa fa-leaf green"></i>
													 <asp:Label ID="txtSchool" runat="server"></asp:Label>
												</h3>

												<div class="widget-toolbar no-border invoice-info">
											
													<br />
													<span class="invoice-info-label"> Date    :</span>
													<span class="blue"><asp:Label runat="server" ID="date"></asp:Label></span>
                                                    <br />
													
												</div>

												<div class="widget-toolbar hidden-480">
													<a href="#">
														<i class="ace-icon fa fa-print"></i>
													</a>
												</div>
											</div>

											<div class="widget-body">
												<div  class="widget-main padding-24">
													<div class="row">
														<div class="col-sm-6">
															<div class="row">
																<div class="col-xs-11 label label-lg label-info arrowed-in arrowed-right">
																	<b>Student Result</b>
																</div>
															</div>

															<div class="row">
                                                                <div class="col-xs-9">
																<ul class="list-unstyled spaced">
																	<li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Name&nbsp;&nbsp;&nbsp;&nbsp; : <asp:Label runat="server" ID="txtstName"></asp:Label> <%--<% Response.Write(txtnm.Text); %>--%>
																	</li>

																	<li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Roll No&nbsp;&nbsp; : <asp:Label runat="server" ID="txtstRoll"></asp:Label><%-- <% Response.Write(txtstnum.Text); %>--%>
																	</li>

																	<li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Class&nbsp;&nbsp;&nbsp;&nbsp; : <asp:Label runat="server" ID="txtstClass"></asp:Label> <%-- <% Response.Write(ddcl.Text); %>--%></li>
                                                                    <li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Section&nbsp;  :<asp:Label runat="server" ID="txtstSec"></asp:Label> <%-- <% Response.Write(ddsec.Text); %>--%></li>
																	
																</ul>
                                                                    </div>
                                                                <div class="col-xs-2">
                                                                <div class="pull-right">
                                                                    <asp:Image ImageUrl="" Height="150" Width="110" Id="imgstdnt" runat="server" />
                                                                </div>
                                                                    </div>
															</div>
														</div><!-- /.col -->
													</div><!-- /.row -->

													<div class="space"></div>

													<div>
                                                       
                                                        <%--<asp:GridView CssClass="table table-striped table-bordered table-hover" runat="server" ID="gvresult" AutoGenerateColumns="false" DataSourceID="test">
                                                            <Columns>
                                                                <asp:BoundField HeaderText="strTotalMarks" DataField="strTotalMarks" SortExpression="strTotalMarks" />
                                                                <asp:BoundField HeaderText="strObtMarks" DataField="strObtMarks" SortExpression="strObtMarks" />
                                                                <asp:BoundField HeaderText="strStudentNum" DataField="strStudentNum" SortExpression="strStudentNum" />
                                                                <asp:BoundField HeaderText="Name" DataField="Name" ReadOnly="True" SortExpression="Name" />
                                                                <asp:BoundField HeaderText="strSubject" DataField="strSubject" SortExpression="strSubject" />
                                                                <asp:BoundField HeaderText="strCourseCode" DataField="strCourseCode" SortExpression="strCourseCode" />
                                                                <asp:BoundField HeaderText="strType" DataField="strType" SortExpression="strType" />
                                                                <asp:BoundField DataField="SubjectPer" HeaderText="SubjectPer" SortExpression="SubjectPer" ReadOnly="True"></asp:BoundField>
                                                                <asp:CheckBoxField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status"></asp:CheckBoxField>
                                                                <asp:BoundField DataField="strPercentage" HeaderText="strPercentage" SortExpression="strPercentage"></asp:BoundField>
                                                            </Columns>

                                                        </asp:GridView>--%>
                                                        <div class="row">
																<div class="col-xs-11 label label-lg label-info arrowed-in arrowed-right">
																	<b>1st Term Result</b>
																</div>
															</div>
                                                        <asp:GridView CssClass="table table-striped table-bordered table-hover" runat="server" ID="gvresult1" AutoGenerateColumns="false" >
                                                                <Columns>
                                                                    <asp:BoundField HeaderText="S.No" DataField="nc_id" />
                                                                    <asp:BoundField HeaderText="Subject Code" DataField="Name" />
                                                                    <asp:BoundField HeaderText="Subject Name" DataField="Class" />
                                                                    <asp:BoundField HeaderText="Total Marks" DataField="Section" />
                                                                    <asp:BoundField HeaderText="Obtain Marks" DataField="Roll_Number" />
                                                                    <asp:BoundField HeaderText="Percentage" DataField="S_No" />
                                                                    <asp:BoundField HeaderText="Status" DataField="status" />
                                                                </Columns>

                                                            </asp:GridView>
                                                        <div class="row">
														<div class="col-sm-5 pull-right">
															<h4 class="pull-right">
																Obt/Total :
																<span class="red"><td><asp:Label runat="server" ID="txttotobtmarks1"></asp:Label></span>
                                                                <span>/</span>
                                                                <span class="red"><td><asp:Label runat="server" ID="txttotAllsubmarks1"></asp:Label></span>
															</h4>
														</div>
                                                        <div class="col-sm-5 pull-right">
															<h4 class="pull-right">
																Status :
																<span class="red"><td><asp:Label runat="server" ID="txtPercentage1"></asp:Label></span>
                                                            </h4>
														</div>
														<%--<div class="col-sm-7 pull-left"> Extra Information </div>--%>
													</div>
                                                        <div class="row">
																<div class="col-xs-11 label label-lg label-info arrowed-in arrowed-right">
																	<b>2nd Term Result</b>
																</div>
															</div>
                                                        <asp:GridView CssClass="table table-striped table-bordered table-hover" runat="server" ID="gvresult2" AutoGenerateColumns="false" >
                                                                <Columns>
                                                                    <asp:BoundField HeaderText="S.No" DataField="nc_id" />
                                                                    <asp:BoundField HeaderText="Subject Code" DataField="Name" />
                                                                    <asp:BoundField HeaderText="Subject Name" DataField="Class" />
                                                                    <asp:BoundField HeaderText="Total Marks" DataField="Section" />
                                                                    <asp:BoundField HeaderText="Obtain Marks" DataField="Roll_Number" />
                                                                    <asp:BoundField HeaderText="Percentage" DataField="S_No" />
                                                                    <asp:BoundField HeaderText="Status" DataField="status" />
                                                                </Columns>

                                                            </asp:GridView>
                                                        <div class="row">
														<div class="col-sm-5 pull-right">
															<h4 class="pull-right">
																Obt/Total :
																<span class="red"><td><asp:Label runat="server" ID="txttotobtmarks2"></asp:Label></span>
                                                                <span>/</span>
                                                                <span class="red"><td><asp:Label runat="server" ID="txttotAllsubmarks2"></asp:Label></span>
															</h4>
														</div>
                                                        <div class="col-sm-5 pull-right">
															<h4 class="pull-right">
																Status :
																<span class="red"><td><asp:Label runat="server" ID="txtPercentage2"></asp:Label></span>
                                                            </h4>
														</div>
														<%--<div class="col-sm-7 pull-left"> Extra Information </div>--%>
													</div>

                                                        <div class="row">
																<div class="col-xs-11 label label-lg label-info arrowed-in arrowed-right">
																	<b>Final Result</b>
																</div>
															</div>
                                                        <asp:GridView CssClass="table table-striped table-bordered table-hover" runat="server" ID="gvresult3" AutoGenerateColumns="false" >
                                                                <Columns>
                                                                    <asp:BoundField HeaderText="S.No" DataField="nc_id" />
                                                                    <asp:BoundField HeaderText="Subject Code" DataField="Name" />
                                                                    <asp:BoundField HeaderText="Subject Name" DataField="Class" />
                                                                    <asp:BoundField HeaderText="Total Marks" DataField="Section" />
                                                                    <asp:BoundField HeaderText="Obtain Marks" DataField="Roll_Number" />
                                                                    <asp:BoundField HeaderText="Percentage" DataField="S_No" />
                                                                    <asp:BoundField HeaderText="Status" DataField="status" />
                                                                </Columns>

                                                            </asp:GridView>
                                                        

<%--                                                        <asp:SqlDataSource runat="server" ID="test" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Result.strTotalMarks, tbl_Result.strObtMarks, tbl_Enrollment.strStudentNum, tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS Name, tbl_Subject.strSubject, tbl_Subject.strCourseCode, tbl_Result.strType, CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 AS SubjectPer, CAST(CASE WHEN CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 >= CAST(tbl_Percentage.strPercentage AS float) THEN 1 ELSE 0 END AS bit) AS Status, tbl_Percentage.strPercentage FROM tbl_Result INNER JOIN tbl_Enrollment ON tbl_Result.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Subject ON tbl_Result.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Class ON tbl_Enrollment.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_Enrollment.nsc_id = tbl_Section.nsc_id CROSS JOIN tbl_Percentage WHERE (tbl_Result.strType <> 'Quiz') AND (tbl_Result.bisDeleted = 0) AND (DATEPART(yyyy, tbl_Result.dtAddDate) = DATEPART(yyyy, CONVERT (date, SYSDATETIME()))) AND (tbl_Result.nc_id = @cid) AND (tbl_Result.nsc_id = @scid) AND (tbl_Enrollment.nc_id = @cid) AND (tbl_Enrollment.nsc_id = @scid) AND (tbl_Enrollment.ne_id = @neid) AND(tbl_Result.nsch_id = @schid)" ' + tbl_Enrollment.strLname AS Name, tbl_Subject.strSubject, tbl_Subject.strCourseCode, tbl_Result.strType, tbl_Class.strClass, tbl_Section.strSection, CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 AS SubjectPer, CAST(CASE WHEN CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 >= CAST(tbl_Percentage.strPercentage AS float) THEN 1 ELSE 0 END AS bit) AS Status, tbl_Percentage.strPercentage FROM tbl_Result INNER JOIN tbl_Enrollment ON tbl_Result.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Subject ON tbl_Result.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Class ON tbl_Enrollment.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_Enrollment.nsc_id = tbl_Section.nsc_id CROSS JOIN tbl_Percentage WHERE (tbl_Result.strType = '" + ddlType.SelectedValue + "') AND (tbl_Result.bisDeleted = 0) AND (DATEPART(yyyy, tbl_Result.dtAddDate) = DATEPART(yyyy, CONVERT (date, SYSDATETIME()))) AND (tbl_Result.nc_id = @cid) AND (tbl_Result.nsc_id = @scid) AND (tbl_Enrollment.nc_id = @cid) AND (tbl_Enrollment.nsc_id = @scid) AND (tbl_Enrollment.ne_id = @neid)'><SelectParameters>
<asp:Parameter Name="cid" DefaultValue=""></asp:Parameter>
<asp:Parameter Name="scid"></asp:Parameter>
<asp:Parameter Name="neid"></asp:Parameter>
<asp:SessionParameter SessionField="nschoolid" DefaultValue="0" Name="schid"></asp:SessionParameter>
</SelectParameters>
</asp:SqlDataSource>--%>
                                                        <div class="hr hr8 hr-double hr-dotted"></div>

													<div class="row">
														<div class="col-sm-5 pull-right">
															<h4 class="pull-right">
																Obt/Total :
																<span class="red"><td><asp:Label runat="server" ID="txttotobtmarks3"></asp:Label></span>
                                                                <span>/</span>
                                                                <span class="red"><td><asp:Label runat="server" ID="txttotAllsubmarks3"></asp:Label></span>
															</h4>
														</div>
                                                        <div class="col-sm-5 pull-right">
															<h4 class="pull-right">
																Status :
																<span class="red"><td><asp:Label runat="server" ID="txtPercentage3"></asp:Label></span>
                                                            </h4>
														</div>
														<%--<div class="col-sm-7 pull-left"> Extra Information </div>--%>
													</div>

													<div class="space-6"></div>
													<div class="well">
                                                        <div class="align-center">
														Powered By LENOX Technologies , CHERRY School Solution | www.lenoxtechnologies.com
                                                                    0333-9957111 | 
                                                            </div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>

								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
                            <label class="hidden-print width-30 pull-right btn btn-sm btn-success" onclick="printDiv('printable')"  > Print</label>
						</div><!-- /.row -->
					</div><!-- /.page-content-area -->
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
