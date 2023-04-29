<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminQuizResult.aspx.cs" Inherits="SchoolPRO.AdminQuizResult" %>
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
                            
                            <asp:View ID="View2" runat="server">
                                <div class="col-xs-12 col-sm-12 widget-container-span">
                                    <div class="widget-box" id="printable">
                                        <div class="widget-header header-color-blue">
												<h5 class=" bigger lighter">
													<i class="icon-table"></i>
													Quiz Report
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="hidden-print icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                        <div class="widget-body">
												<div class="widget-main no-padding">
                                                    <div class="clearfix"></div>
                                                    <div class="hidden-print space-4"></div>
                                                    <div class=" hidden-print col-lg-3">
                                                        <%--<asp:Label ID="Label3" runat="server" Text="Select Class"></asp:Label>--%>
                                                        <asp:DropDownList runat="server" ID="ddlType" AppendDataBoundItems="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" AutoPostBack="true" DataSourceID="ddlexam" DataTextField="strExamName" DataValueField="nExam_id">
                                                            <asp:ListItem Text="<---Select Type of Exam--->" Value="0"></asp:ListItem>
                                                           <%-- <asp:ListItem Text="Quiz" Value="Quiz"></asp:ListItem>
                                                            <asp:ListItem Text="1st Term Exam" Value="1st Term Exam"></asp:ListItem>
                                                            <asp:ListItem Text="2nd Term Exam" Value="2nd Term Exam"></asp:ListItem>
                                                            <asp:ListItem Text="Final Exam" Value="Final Exam"></asp:ListItem>
                                                            <%-- <asp:ListItem Text="All Exams" Value="All Exam"></asp:ListItem>--%>
                                                            <%--<asp:ListItem Text="Admission Result" Value="Admission Marks"></asp:ListItem>--%>
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource runat="server" ID="ddlexam" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nExam_id, strExamName, bisDeleted, nsch_id FROM tbl_Quiz WHERE (nsch_id = @schid) AND (bisDeleted = @bit)">
                                                            <SelectParameters>
                                                                <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                                                <asp:Parameter DefaultValue="False" Name="bit"></asp:Parameter>
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </div>
                                                    <div class=" hidden-print col-lg-3">
                                                        <%--<asp:Label ID="Label1" runat="server" Text="Select Class"></asp:Label>--%>
                                                        <asp:DropDownList AutoPostBack="true" runat="server" ID="ddcl" OnSelectedIndexChanged="ddcl_SelectedIndexChanged" AppendDataBoundItems="true"></asp:DropDownList>
                                                    </div>
                                                    <div class="hidden-print col-lg-3">
                                                        <%--<asp:Label ID="Label2" runat="server" Text="Select Section"></asp:Label>--%>
                                                        <asp:DropDownList AutoPostBack="true" runat="server" ID="ddsec" OnSelectedIndexChanged="ddsec_SelectedIndexChanged" AppendDataBoundItems="true" ></asp:DropDownList>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                    <div class="space-4"></div>
                                                    <asp:GridView ID="gv_detail_list" AutoGenerateColumns="false" CssClass=" table table-striped table-bordered table-hover" runat="server">
                                                        <Columns>
                                                            
                                                            <asp:BoundField  HeaderText="S.No"  DataField="sno"/>
                                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"  HeaderText="S.No"  DataField="S_No"/>
                                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" HeaderText="cla"  DataField="nc_id"/>
                                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" HeaderText="Sec"  DataField="nsc_id"/>
                                                            
                                                            <asp:BoundField HeaderText="Roll No"  DataField="Roll_Number"/>
                                                            <asp:BoundField HeaderText="Name"  DataField="Name"/>
                                                            <asp:BoundField HeaderText="Class"  DataField="Class"/>
                                                            <asp:BoundField HeaderText="Section"  DataField="Section"/>
                                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" HeaderText="Status"  DataField="Status"/>

                                                            <asp:TemplateField  HeaderText="">
                                                                <ItemTemplate>
                                                                    <%--<asp:Label ID="lblststatus" runat="server" Text=""></asp:Label>--%>
                                                                  
                                                                    <asp:DropDownList runat="server" ID="ddlstatus" >
                                                                        <asp:ListItem Text="Pass" Value="Pass"></asp:ListItem>
                                                                        <asp:ListItem Text="Fail" Value="Fail"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <%--<asp:TemplateField   HeaderText="Class">
                                                                <ItemTemplate>
                                                                    <asp:DropDownList runat="server" AutoPostBack="true" ID="ddlclas" DataSourceID="ddlclassDS" DataTextField="strClass" DataValueField="nc_id">
                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource runat="server" ID="ddlclassDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nc_id, strClass FROM tbl_Class WHERE (bisDeleted = 'False') and nsch_id=@nschid">
        <SelectParameters>
            <asp:SessionParameter Name="nschid" SessionField="nschoolid" />
        </SelectParameters>
    </asp:SqlDataSource>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField  HeaderText="Section">
                                                                <ItemTemplate>
                                                                    <asp:DropDownList runat="server"  ID="ddlsec" DataSourceID="SqlDataSource1" DataTextField="strSection" DataValueField="nsc_id">
                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nsc_id], [strSection] FROM [tbl_Section] WHERE (([bisDeleted] = @bisDeleted) AND ([nc_id] = @nc_id) and nsch_id=@nschid)">
                                                                        <SelectParameters>
                                                                            <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                            <asp:ControlParameter ControlID="ddlclas" PropertyName="SelectedValue" DefaultValue="0" Name="nc_id" Type="Int32"></asp:ControlParameter>
                                                                            <asp:SessionParameter Name="nschid" SessionField="nschoolid" />
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>--%>
                                                             <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print"   HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Button CssClass="btn btn-success"  ID="btnViewDetail" Text="View Full Result" runat="server" OnClick="btnViewDetail_Click" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" HeaderText="S"  DataField="feeid"/>
                                                           <%-- <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print"   HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Button CssClass="btn btn-success"  ID="btnViewFullResult" Text="View All Terms Result" runat="server" OnClick="btnViewFullResult_Click" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>--%>
                                                        </Columns>
                                                      

                                                        </asp:GridView>
                                                        <div class="pull-right">
                                                            <%--<asp:Button CssClass="hidden-print btn btn-success"  ID="btnPromote" Text="Click Here To Promote" runat="server" OnClick="btnPromote_Click" />--%>
                                                        </div>
                                                    <%--<asp:GridView ID="gv_detail_list" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="FinalresultDS">
                                                        <Columns>
                                                            <asp:BoundField DataField="strTotalMarks" HeaderText="strTotalMarks" SortExpression="strTotalMarks" />
                                                            <asp:BoundField DataField="strStudentNum" HeaderText="strStudentNum" SortExpression="strStudentNum" />
                                                            <asp:BoundField DataField="strSubject" HeaderText="strSubject" SortExpression="strSubject" />
                                                            <asp:BoundField DataField="strType" HeaderText="strType" SortExpression="strType" />
                                                            <asp:BoundField DataField="strClass" HeaderText="strClass" SortExpression="strClass" />
                                                            <asp:BoundField DataField="strSection" HeaderText="strSection" SortExpression="strSection" />

                                                            <asp:BoundField DataField="SubjectPer" HeaderText="SubjectPer" SortExpression="SubjectPer" ReadOnly="True"></asp:BoundField>
                                                            <asp:CheckBoxField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status"></asp:CheckBoxField>
                                                            <asp:BoundField DataField="strPercentage" HeaderText="strPercentage" SortExpression="strPercentage"></asp:BoundField>
                                                        </Columns>
                                                    </asp:GridView>

                                                    <asp:SqlDataSource runat="server" ID="FinalresultDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Result.strTotalMarks, tbl_Enrollment.strStudentNum, tbl_Subject.strSubject, tbl_Result.strType, tbl_Class.strClass, tbl_Section.strSection, CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 AS SubjectPer, CAST(CASE WHEN CAST(tbl_Result.strObtMarks AS float) / CAST(tbl_Result.strTotalMarks AS float) * 100 >= CAST(tbl_Percentage.strPercentage AS float) THEN 1 ELSE 0 END AS bit) AS Status, tbl_Percentage.strPercentage FROM tbl_Result INNER JOIN tbl_Enrollment ON tbl_Result.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Subject ON tbl_Result.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Class ON tbl_Enrollment.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_Enrollment.nsc_id = tbl_Section.nsc_id CROSS JOIN tbl_Percentage WHERE (tbl_Result.strType = 'Final Exam') AND (tbl_Result.bisDeleted = 0) AND (DATEPART(yyyy, tbl_Result.dtAddDate) = DATEPART(yyyy, CONVERT (date, SYSDATETIME()))) AND (tbl_Enrollment.nc_id = @cid) AND (tbl_Enrollment.nsc_id = @scid) AND (tbl_Enrollment.ne_id = @neid)">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="cid"></asp:Parameter>
                                                            <asp:Parameter Name="scid"></asp:Parameter>
                                                            <asp:Parameter Name="neid"></asp:Parameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>--%>
                                                </div>
                                            </div>
                                    </div>
                                </div>
                               
                            </asp:View>
                            <asp:View ID="View1"  runat="server">
                                <div class="pull-right">
                    <asp:Button CssClass="btn btn-success" Text="Back" runat="server" ID="btnback" OnClick="btnback_Click" />
                </div>
                        <div class="page-content-area">
						<div class="row">
							<div id="Div1" class="col-xs-12">
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
														</div><!-- /.col -->
													</div><!-- /.row -->

													<div class="space"></div>
                                                    <div class="row">
																<div class="col-xs-11 label label-lg label-info arrowed-in arrowed-right">
																	<b><asp:Label runat="server" ID="txtterm"  Text="Term"></asp:Label></b>
																</div>
															</div>
													<div>
                                                               
                                                            <asp:GridView CssClass="table table-striped table-bordered table-hover" runat="server" ID="gvresult" AutoGenerateColumns="false" >
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
													

													<div class="hr hr8 hr-double hr-dotted"></div>

													<div class="row">
														<div class="col-sm-5 pull-right">
															<h4 class="pull-right">
																Obt/Total :
																<span class="red"><td><asp:Label runat="server" ID="txttotobtmarks"></asp:Label></span>
                                                                <span>/</span>
                                                                <span class="red"><td><asp:Label runat="server" ID="txttotAllsubmarks"></asp:Label></span>
															</h4>
														</div>
                                                        <div class="col-sm-5 pull-right">
															<h4 class="pull-right">
																Status :
																<span class="red"><td><asp:Label runat="server" ID="txtPercentage"></asp:Label></span>
                                                            </h4>
														</div>
														<%--<div class="col-sm-7 pull-left"> Extra Information </div>--%>
													</div>

													<div class="space-6"></div>
													<div class="well">
                                                        <div class="align-center">
														Powered By LENOX Technologies , LENOX School Solutions| hss.heaventechnologies.com
                                                                    0333-9957111 |  0319-97062989
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
