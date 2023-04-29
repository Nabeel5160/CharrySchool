<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewTeacherSalary.aspx.cs" Inherits="SchoolPRO.AdminViewTeacherSalary" %>
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
                                <div class="col-xs-12 col-sm-12 widget-container-span">
                                    <div class="widget-box" id="printable">
                                        <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Teacher Salary 
												</h5>

												<div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                        <div class="widget-body">
												<div class="clearfix"></div>
                                                    <div class="space-4"></div>
                                                    <div class="col-lg-3">
                                                        <%--<asp:TextBox ID="txtfrom" placeholder="" runat="server"></asp:TextBox>--%>
                                                    </div>
                                                    <div class="hidden-print col-lg-3">
                                                        <%--<asp:TextBox ID="txtto" AutoPostBack="true" runat="server"></asp:TextBox>--%>
                                                    <label>Select Months</label>
                                                        <asp:DropDownList ID="ddlmonths" runat="server" OnSelectedIndexChanged="ddlmonths_SelectedIndexChanged" AutoPostBack="true">
                                                        <asp:ListItem Text="<---Select Month--->" Value="00"></asp:ListItem>
                                                        <asp:ListItem Text="01" Value="01"></asp:ListItem>
                                                        <asp:ListItem Text="02" Value="02"></asp:ListItem>
                                                        <asp:ListItem Text="03" Value="03"></asp:ListItem>
                                                        <asp:ListItem Text="04" Value="04"></asp:ListItem>
                                                        <asp:ListItem Text="05" Value="05"></asp:ListItem>
                                                        <asp:ListItem Text="06" Value="06"></asp:ListItem>
                                                        <asp:ListItem Text="07" Value="07"></asp:ListItem>
                                                        <asp:ListItem Text="08" Value="08"></asp:ListItem>
                                                        <asp:ListItem Text="09" Value="09"></asp:ListItem>
                                                        <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                        <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                                        <asp:ListItem Text="12" Value="12"></asp:ListItem>

                                                    </asp:DropDownList>
                                                    </div>
                                                     <div class="hidden-print col-lg-3">
                                                         <label>Select Teacher</label>
                                                         <asp:DropDownList ID="ddltchr"  runat="server" AutoPostBack="true" DataSourceID="TeacherDS" DataTextField="name" DataValueField="nu_id" OnSelectedIndexChanged="ddltchr_SelectedIndexChanged"></asp:DropDownList>
                                                         <asp:SqlDataSource runat="server" ID="TeacherDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nu_id], [strfname]+' '+[strlname] as name FROM [tbl_Users] WHERE (([bisDeleted] = @bisDeleted) AND ([nLevel] = @nLevel) and nsch_id=@schid)">
                                                             <SelectParameters>
                                                                 <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                 <asp:Parameter DefaultValue="2" Name="nLevel" Type="Int32"></asp:Parameter>
                                                                 <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                                             </SelectParameters>
                                                         </asp:SqlDataSource>
                                                     </div>
                                                    <div class="clearfix"></div>
                                                    <div class="space-4"></div>
                                        </div>
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
													<span class="invoice-info-label">Pay Invoice :</span>
													<span class="red">#<asp:Label runat="server" ID="txtempInvc"></asp:Label></span>

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
																	<b>Employee Info</b>
																</div>
															</div>

															<div class="row">
																<ul class="list-unstyled spaced">
																	<li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Name&nbsp;&nbsp;&nbsp;&nbsp; : <asp:Label runat="server" ID="txtempName"></asp:Label> <%--<% Response.Write(txtnm.Text); %>--%>
																	</li>

																	<%-- <li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Phone &nbsp;&nbsp; : <asp:Label runat="server" ID="txtempphone"></asp:Label><% Response.Write(txtstnum.Text); %>
																	</li>--%>

																	<li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
																		Paymant Info
																	</li>
																</ul>
															</div>
														</div><!-- /.col -->
													</div><!-- /.row -->

													<div class="space"></div>

													<div>
														<table class="table table-striped table-bordered">
															<thead>
																<tr>
																	<th class="center">#</th>
																	<th>Total Paid Salary</th>
																	<th>Total Absents</th>
																	<th >Total Presents</th>
                                                                    <th >Total Full Leaves</th>
                                                                    <th >Total Half Leaves</th>
																	
                                                                    <th >Fine</th>
                                                                    <th >Bonus</th>
																</tr>
															</thead>

															<tbody>
																<tr>
																	<td class="center">1</td>

																	<td >
																		<asp:Label runat="server" ID="txtempsal"></asp:Label><%--<% Response.Write(txtfee.Text); %>--%>
																	</td>
																	<td >
                                                                        <asp:Label runat="server" ID="txtempAbsnt"></asp:Label>
																		<%--<% Response.Write(txtFine.Text); %>--%>
																	</td>
                                                                    <td><asp:Label runat="server" ID="txtempprsnt"></asp:Label> <%--<% Response.Write(txtfeecons.Text); %>--%></td>

																	<td ><asp:Label runat="server" ID="txtempfulleaves"></asp:Label> <%--<% Response.Write(txtRemnfee.Text); %>--%></td>
																	<td ><asp:Label runat="server" ID="txtemphalfleaves"></asp:Label> <%--<% Response.Write(txtRemnfee.Text); %>--%></td>
                                                                    <td><asp:Label runat="server" ID="txtempfine"></asp:Label> <%--<% Response.Write(txtTotfee.Text); %>--%></td>
                                                                    <td><asp:Label runat="server" ID="txtempBonus"></asp:Label> <%--<% Response.Write(txtRcvfee.Text); %>--%></td>
                                                                    
                                                                    

																</tr>

																
															</tbody>
														</table>
													</div>

													<div class="hr hr8 hr-double hr-dotted"></div>

													<div class="row">
														<div class="col-sm-5 pull-right">
															<h4 class="pull-right">
																
																<span class="red"><td><asp:Label runat="server" ID="txtemptotsal"></asp:Label></span>
															</h4>
														</div>
														<%--<div class="col-sm-7 pull-left"> Extra Information </div>--%>
													</div>

													<div class="space-6"></div>
													<div class="well">
														Powered By Heaven Technologies , Heaven School Solution| www.heaventechnologies.com
                                                                    0321-5044354 | 051-4853801
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>

								<!-- PAGE CONTENT ENDS -->
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
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
