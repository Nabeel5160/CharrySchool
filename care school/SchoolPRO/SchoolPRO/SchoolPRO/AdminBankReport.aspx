<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminBankReport.aspx.cs" Inherits="SchoolPRO.AdminBankReport" %>
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
													Bank Amount Report
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')">
                                                        
                                                    </div>
												</div>
											</div>

											<div class="widget-body" >
												<div class="widget-main no-padding">
                                                    <asp:GridView ID="gvbank" AllowSorting="true" CssClass="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="BANKDS">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Bank Name" HeaderText="Bank Name" SortExpression="Bank Name"></asp:BoundField>
                                                            <asp:BoundField DataField="Branch Name" HeaderText="Branch Name" SortExpression="Branch Name"></asp:BoundField>
                                                            <asp:BoundField DataField="Branh Code" HeaderText="Branh Code" SortExpression="Branh Code"></asp:BoundField>
                                                            <asp:BoundField DataField="Account Name" HeaderText="Account Name" SortExpression="Account Name"></asp:BoundField>
                                                            <asp:BoundField DataField="Account #" HeaderText="Account #" SortExpression="Account #"></asp:BoundField>
                                                            <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount"></asp:BoundField>
                                                            <asp:BoundField DataField="Creation Date" HeaderText="Creation Date" SortExpression="Creation Date"></asp:BoundField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <%--<table class="table table-striped table-bordered table-hover">
														<thead class="thin-border-bottom">
															<tr>
                                                                <th>
                                                                    <i class="icon-star"></i>
                                                                    Bank Name
                                                                </th>
																<th>
																	<i class="icon-user"></i>
																	Branch Name
																</th>
                                                                <th>
                                                                    <i class="icon-user"></i>
                                                                    Branch Code
                                                                </th>
																<th>
                                                                    <i class="icon-user"></i>
                                                                    Account Title
                                                                </th>
                                                                <th>
                                                                    <i class="icon-user"></i>
                                                                    Account Number
                                                                </th>
                                                                <th>
                                                                    <i class="icon-user"></i>
                                                                    Amount
                                                                </th>
																
															</tr>
														</thead>

														<tbody>
															<tr>
                                                               
																<td class="">
                                                                    <asp:Label ID="lblbn" runat="server" Text=""></asp:Label>
																</td>
                                                                <td>
                                                                    <asp:Label ID="lblbrnm" runat="server" Text=""></asp:Label>
                                                                </td>
																<td>
																	<a href="#">
                                                                        <asp:Label ID="lblbc" runat="server" Text=""></asp:Label></a>
																</td>
                                                                <td>
																	<a href="#">
                                                                        <asp:Label ID="lblat" runat="server" Text=""></asp:Label></a>
																</td>
                                                                <td>
																	<a href="#">
                                                                        <asp:Label ID="lblac" runat="server" Text=""></asp:Label></a>
																</td>
                                                                <td>
																	<a href="#">
                                                                        <asp:Label ID="lblamnt" runat="server" Text=""></asp:Label></a>
																</td>
															</tr>

														</tbody>
													</table>--%>
                                                    <asp:SqlDataSource runat="server" ID="BANKDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT strBname AS 'Bank Name', strBrname AS 'Branch Name', strBcode AS 'Branh Code', strAccTitle AS 'Account Name', strAccNum AS 'Account #', strAmount AS 'Amount', dtAddDate AS 'Creation Date' FROM tbl_Bank WHERE (bisDeleted = @fbit) AND (nsch_id = @schid)">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="false" Name="fbit"></asp:Parameter>
                                                            <asp:SessionParameter SessionField="nschoolid" DefaultValue="" Name="schid"></asp:SessionParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
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