<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminStudentLeavingCert.aspx.cs" Inherits="SchoolPRO.AdminStudentLeavingCert" %>
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
        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Student Leaving Cert
            </h4>

            <div class="space-6"></div>
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvatnd" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <%--<asp:Button ID="btngotoAdd" runat="server" Text="Mark Attendance" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />--%>
                            <%--<asp:Label ID="Label1" Text="Enter Student Enrollment No." runat="server" CssClass="label" ></asp:Label>
                            <asp:TextBox  ID="txtstnum" placeholder="123" runat="server" class="width-10"  OnTextChanged="txtstnum_TextChanged" AutoPostBack="true" >
                            </asp:TextBox>
                            <br />
                            <label class="label-yellow"  >OR</label>
                            <br />--%>
                            <asp:Label ID="Label2" CssClass="label"  Text="Enter Admission Year  :" runat="server" ></asp:Label>
                            <asp:TextBox ID="txtyear" runat="server" placeholder="yyyy"  class="width-10"  AutoPostBack="true" OnTextChanged="txtyear_TextChanged" ></asp:TextBox>

                            <asp:Label ID="Label3" CssClass="label"  Text="Select Student Class  :" runat="server" ></asp:Label>
                            <asp:DropDownList ID="ddcl" runat="server" AutoPostBack="true" AppendDataBoundItems="True" OnSelectedIndexChanged="ddcl_SelectedIndexChanged"></asp:DropDownList>

                            &nbsp;
                           
                            <asp:Label ID="Label4" CssClass="label"  Text="Select Student Class Section :" runat="server" ></asp:Label>
                            <asp:DropDownList ID="ddsec" runat="server"  AutoPostBack="true" AppendDataBoundItems="True" OnSelectedIndexChanged="ddsec_SelectedIndexChanged" ></asp:DropDownList>

                            <asp:Label ID="Label5" CssClass="label"  Text="Select Student  :" runat="server" ></asp:Label>
                            <asp:DropDownList ID="ddst" runat="server" AutoPostBack="true" AppendDataBoundItems="True"  OnSelectedIndexChanged="ddst_SelectedIndexChanged" ></asp:DropDownList>

                            <div class="clearfix"></div>

                            <%--<asp:Button Text="Leave" ID="btnleave" runat="server" class="width-20 pull-right btn btn-sm btn-success" />--%>
                                
                            <div class="space-22"></div>
                           
                            <%--<lable ID="btnprint" runat="server" class="width-10 pull-left btn btn-sm btn-success" onclick="printDiv('printable')">
                                Print Attendance

                            </lable>--%>
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
													 <asp:Label ID="txtSchool" runat="server" Text="School"></asp:Label>
												</h3>

												<div class="widget-toolbar no-border invoice-info">
													
													<br />
													<span class="invoice-info-label">Date    :</span>
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
																	<b>Student Info</b>
																</div>
															</div>

															<div class="row">
																<ul class="list-unstyled spaced">
																	<li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Name : <div class="tab-space-3"></div>  <asp:Label runat="server" ID="txtstName"></asp:Label> <%--<% Response.Write(txtnm.Text); %>--%>
																	</li>

																	<li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Roll No :<div class="tab-space-3"></div>  <asp:Label runat="server" ID="txtstRoll"></asp:Label><%-- <% Response.Write(txtstnum.Text); %>--%>
																	</li>

																	<li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Class :<div class="tab-space-3"></div>  <asp:Label runat="server" ID="txtstClass"></asp:Label> <%-- <% Response.Write(ddcl.Text); %>--%></li>
                                                                    <li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Section :<div class="tab-space-3"></div>  <asp:Label runat="server" ID="txtstSec"></asp:Label> <%-- <% Response.Write(ddsec.Text); %>--%></li>
                                                                    <li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Admission Date :<div class="tab-space-2"></div>  <asp:Label runat="server" ID="txtdate"></asp:Label> <%-- <% Response.Write(ddsec.Text); %>--%></li>
                                                                    
																	<li class="hidden-print">
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Leave Fee :<div class="tab-space-3"></div> <asp:TextBox runat="server" ID="txtLvFee"></asp:TextBox></li>
                                                                    <li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                       Leave Remarks : <div class="tab-space-3"></div>   <asp:TextBox ID="txtRemarks" runat="server" CssClass="width-10"></asp:TextBox>
                                                                    </li>
                                                                    <li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                       Leaving Date : <div class="tab-space-3"></div>    <asp:TextBox ID="txtenddate" TextMode="Date" runat="server" CssClass="width-10"></asp:TextBox>
                                                                    </li>
																</ul>
															</div>
														</div><!-- /.col -->
													</div><!-- /.row -->

													<div class="space"></div>

													
												</div>
											</div>
										</div>
									</div>
								</div>

								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
                            <asp:Button Text="Add Leaving Cert" CssClass="width-30 pull-right btn btn-sm btn-success" ID="btnAdd" runat="server" OnClick="btnAdd_Click" />
                            <%--<asp:Label runat="server" Visible="false" ID="btnprnt" class="width-30 pull-left btn btn-sm btn-success" onclick="printDiv('printable')"> Print</asp:Label>--%>
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

            <div class="space-12"></div>

            <!-- /.page-content -->
        </div>
        <!-- /.main-content -->

    </div>

</asp:Content>
