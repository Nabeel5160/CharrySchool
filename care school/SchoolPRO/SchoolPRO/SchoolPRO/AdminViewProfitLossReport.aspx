<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewProfitLossReport.aspx.cs" Inherits="SchoolPRO.AdminViewProfitLossReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
													Profit Loss Report
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>

											<div class="widget-body">
												<div class="widget-main no-padding">
													<table class="table table-striped table-bordered table-hover">
														<thead class="thin-border-bottom">
															<tr>
                                                                <th>
                                                                    <i class="icon-star"></i>
                                                                    Total Fee
                                                                </th>
																<th>
																	<i class="icon-user"></i>
																	Total Fee Recieved
																</th>
                                                                <th>
                                                                    <i class="icon-user"></i>
                                                                    Total Fee Pending
                                                                </th>
																<th>
                                                                    <i class="icon-user"></i>
                                                                   Total Salaries
                                                                </th>
                                                                <th>
                                                                    <i class="icon-user"></i>
                                                                   Total Salaries Paid
                                                                </th>
                                                                <th>
                                                                    <i class="icon-user"></i>
                                                                   Total Salaries Pending
                                                                </th>
                                                                <th>
                                                                    <i class="icon-user"></i>
                                                                   Total Expense
                                                                </th>
                                                                <th>
                                                                    <i class="icon-user"></i>
                                                                   Total Profit
                                                                </th>
																<th>
                                                                    <i class="icon-user"></i>
                                                                   Total Loss
                                                                </th>
															</tr>
														</thead>

														<tbody>
															<tr>
                                                               
																<td class="">
                                                                    <asp:Label ID="lbltfee" runat="server" Text=""></asp:Label>
																</td>
                                                                <td>
                                                                    <asp:Label ID="lbltfeercvd" runat="server" Text=""></asp:Label>
                                                                </td>
																<td>
																	<a href="#">
                                                                        <asp:Label ID="lbltfeepnd" runat="server" Text=""></asp:Label>
                                                                        
																	</a>
																</td>
                                                                <td>
																	<a href="#">
                                                                        <asp:Label ID="lbltsal" runat="server" Text=""></asp:Label></a>
																</td>
                                                                <td>
																	<a href="#">
                                                                        <asp:Label ID="lbltsalpaid" runat="server" Text=""></asp:Label></a>
																</td>
                                                                <td>
																	<a href="#">
                                                                        <asp:Label ID="lbltsalpnd" runat="server" Text=""></asp:Label></a>
																</td>
                                                                <td>
																	<a href="#">
                                                                        <asp:Label ID="lblexp" runat="server" Text=""></asp:Label></a>
																</td>
                                                                <td>
																	<a href="#">
                                                                        <asp:Label ID="lblprft" runat="server" Text=""></asp:Label></a>
																</td>
                                                                <td>
																	<a href="#">
                                                                        <asp:Label ID="lblloss" runat="server" Text=""></asp:Label></a>
																</td>
                                                                
															</tr>

														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div><!-- /span -->

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