<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminIssueFeeReciept.aspx.cs" Inherits="SchoolPRO.AdminIssueFeeReciept" %>
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
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upt" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">
                        
                        <asp:View ID="View1" runat="server">
                            <div class="table-responsive">
                            <asp:GridView ID="gvbyclass" class="table table-striped table-bordered table-hover" AutoGenerateColumns="false" DataSourceID="sqlbyclass" runat="server">
                                <Columns>
                                    <asp:BoundField DataField="nc_id" HeaderText="S.NO" SortExpression="nc_id" />
                                    <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                    <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnvful" runat="server" Text="View Full Detail" class="width-65 pull-left btn btn-sm btn-success" OnClick="btnvful_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                                <asp:SqlDataSource ID="sqlbyclass" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Class.nc_id, tbl_Class.strClass, tbl_Section.strSection FROM tbl_Class INNER JOIN tbl_Section ON tbl_Class.nc_id = tbl_Section.nc_id WHERE (tbl_Class.bisDeleted = 'False')"></asp:SqlDataSource>
                                </div>
                        </asp:View>
                        <asp:View runat="server">

                        <div id="tel" class="col-sm-10 col-sm-offset-1">
										<div class="widget-box transparent invoice-box" id="printable">
											<div class="widget-header widget-header-large">
												<h3 class="grey lighter pull-left position-relative">
													<i class="icon-leaf green"></i>
													Student Invoice												</h3>

												<div class="widget-toolbar no-border invoice-info">
													<span class="invoice-info-label">Invoice:</span>
													<span class="red">
                                                        <asp:Label ID="lblinvoice" runat="server" Text="Label"></asp:Label></span>
                                                    
													<br />
													<span class="invoice-info-label">Date:</span>
													<span class="blue">
                                                        <asp:Label ID="lbldate" runat="server" Text="Label"></asp:Label></span>												</div>

												<div class="widget-toolbar hidden-480">
                                                  <a href="#" onclick="printDiv('printable')"> <i class="icon-print"></i></a>
                                                        </div>
											</div>

											<div class="widget-body">
												<div class="widget-main padding-24">
													<div class="row">
														<div class="col-sm-6">
															<div class="row">
																<div class="col-xs-11 label label-lg label-info arrowed-in arrowed-right">
																	<b>
                                                                        <asp:Label ID="lblschoolname" runat="server" Text="School Name"></asp:Label></b>																</div>
															</div>

															<div class="row">
                                                            <table class="table table-responsive">
                                                            <tr>
                                                            <td>
                                                            <i class="icon-caret-right blue"></i>
                                                                        <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label>	
                                                            </td>
                                                            <td>
                                                            
                                                                        <asp:Label ID="lblname" runat="server" Text="label"></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                            <td>
                                                            <i class="icon-caret-right blue"></i>
                                                                <asp:Label ID="Label2" runat="server" Text="Father Name"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblfname" runat="server" Text="Label"></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                            <td>
                                                            <i class="icon-caret-right blue"></i>
                                                                <asp:Label ID="Label3" runat="server" Text="Class"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblclass" runat="server" Text="Label"></asp:Label></td>
                                                            </tr>
                                                            </table>

                                                            															
															</div>
														</div><!-- /span -->

								
													</div><!-- row -->

													<div class="space"></div>

													<div>
														<table class="table table-responsive">
															<thead>
																<tr>
																	
																	<th>Fee</th>
																	<th class="hidden-xs">Amount</th>
																	<%--<th class="hidden-480">Discount</th>--%>
																	
																</tr>
															</thead>

															<tbody>
																<tr>
																	
																	<td>
																		
                                                                            <asp:Label ID="Label4" runat="server" Text="Tuition Fee"></asp:Label>																</td>
																	<td class="hidden-xs">
                                                                        <asp:Label ID="lbltuitionfee" runat="server" Text="Label"></asp:Label>																	</td>
																	
																</tr>

																<tr>
																	

																	<td>
                                                                        <asp:Label ID="Label5" runat="server" Text="Admission Fee"></asp:Label>																	</td>
																	<td class="hidden-xs">
                                                                        <asp:Label ID="lbladmissionfee" runat="server" Text="Label"></asp:Label>																	</td>
																	
																</tr>

																
															</tbody>
														</table>
													</div>

													<div class="hr hr8 hr-double hr-dotted"></div>

													<div class="row">
														<div class="col-sm-5 pull-right">
															<h4 class="pull-right">
																Total :
																<span class="red">
                                                                    <asp:Label ID="lbltotal" runat="server" Text="Label"></asp:Label></span>															</h4>
														</div>
														
													</div>

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
