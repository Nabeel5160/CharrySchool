<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminClassFeeReport.aspx.cs" Inherits="SchoolPRO.AdminClassFeeReport" %>
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
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Class Fee Report
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>

											<div class="widget-body">
												<div class="widget-main no-padding">
                                                    <asp:GridView ID="gvfee" CssClass="table table-responsive table-hover" runat="server" AllowSorting="true" DataKeyNames="nfee_id" AutoGenerateColumns="false" EnableViewState="true">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nfee_id" SortExpression="nfee_id" HeaderText="S.NO" />
                                            <asp:BoundField DataField="strClass" SortExpression="strClass" HeaderText="Class" />
                                            <asp:BoundField DataField="strTutionFee" SortExpression="strTutionFee" HeaderText="Tution Fee" />
                                            <asp:BoundField DataField="strAdmsFee" SortExpression="strAdmsFee" HeaderText="Admission Fee" />
                                            <asp:BoundField NullDisplayText="N/A" DataField="strRegFee" SortExpression="strRegFee" HeaderText="Registration Fee" />
                                            <asp:BoundField NullDisplayText="N/A" DataField="strFolderFee" SortExpression="strFolderFee" HeaderText="Folder Fee" />
                                            <asp:BoundField NullDisplayText="N/A" DataField="strGeneratorFee" SortExpression="strGeneratorFee" HeaderText="Generator Fee" />
                                            <asp:BoundField NullDisplayText="N/A" DataField="strBookFee" SortExpression="strBookFee" HeaderText="Books Fee" />
                                            <asp:BoundField NullDisplayText="N/A" DataField="strStationaryFee" SortExpression="strStationaryFee" HeaderText="Stationary Fee" />
                                            <asp:BoundField NullDisplayText="N/A" DataField="strAnnualExamFee" SortExpression="strAnnualExamFee" HeaderText="Exam Fee" />
                                            <asp:BoundField DataField="strLeaveFee" SortExpression="strLeaveFee" HeaderText="Leave Fee" />
                                            
                                           
                                        </Columns>
                                    </asp:GridView>
													<%--<table class="table table-striped table-bordered table-hover">
														<thead class="thin-border-bottom">
															<tr>
                                                                <th>
                                                                    <i class="icon-star"></i>
                                                                    Class Name
                                                                </th>
																<th>
																	<i class="icon-user"></i>
																	Tution Fee
																</th>
                                                                <th>
                                                                    <i class="icon-user"></i>
                                                                    Admission Fee
                                                                </th>
																
																
															</tr>
														</thead>

														<tbody>
															<tr>
                                                                <td>
                                                                    <asp:Label ID="lblcn" runat="server" Text="Label"></asp:Label>
                                                                    
                                                                </td>
																<td class="">
                                                                    <asp:Label ID="lbltf" runat="server" Text="Label"></asp:Label>
																</td>
                                                                <td>
                                                                    <asp:Label ID="lblaf" runat="server" Text="Label"></asp:Label>
                                                                </td>
																

															</tr>

														</tbody>
													</table>--%>
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
    </div>
</asp:Content>

