<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDirectRecvBoardFee.aspx.cs" Inherits="SchoolPRO.AdminDirectRecvBoardFee" %>


<%@ Register Assembly="DropDownCheckBoxes" Namespace="Saplin.Controls" TagPrefix="cc1" %>

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

          //$(document).ready(function () {
          //    $('#example-example-enableFiltering-optgroups').multiselect({
          //        enableFiltering: true
          //    });
          //});

    </script>
      <style type="text/css">
        .PnlDesign
        {
            border: solid 1px #000000;
            height: 150px;
            width: 330px;
            overflow-y:scroll;
            background-color: #EAEAEA;
            font-size: 15px;
            font-family: Arial;
        }
        .txtbox
        {
            background-image: url(../images/drpdwn.png);
            background-position: right top;
            background-repeat: no-repeat;
            cursor: pointer;
            cursor: hand;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <div class="form-search">
                <span class="input-icon">
                    <p>Receive Student Fee</p>

                </span>
            </div>
            <div class="space-10"></div>
            <%--<div class="clearfix"><asp:Button ID="btnsrch" runat="server" class="width-20 pull-left btn btn-sm " Text="Search" /></div>--%>
            <asp:ScriptManager ID="sc" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upregst" runat="server">
                <ContentTemplate>
                    <asp:MultiView ActiveViewIndex="0" ID="mvsub" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:Button ID="btngo" runat="server" Text="Receive Fee" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngo_Click" />
                            <div class="space-10"></div>
                            <asp:GridView ID="gvfee" CssClass="table table-responsive table-hover" OnPageIndexChanging="gvfee_PageIndexChanging" runat="server" AllowSorting="true" AllowPaging="true" DataKeyNames="nfr_id" AutoGenerateColumns="false" EnableViewState="true">
                                <Columns>
                                    <asp:TemplateField >
                                    <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nfr_id" SortExpression="nfr_id" HeaderText="S.NO" />
                                    <asp:BoundField DataField="strname" SortExpression="strTutionFee" HeaderText="Name" />
                                    <asp:BoundField DataField="strClass" SortExpression="strClass" HeaderText="Class" />
                                   
                                     <asp:BoundField DataField="strSection" SortExpression="strSection" HeaderText="Section" />
                                     <asp:BoundField DataField="strBoardRegAmount" SortExpression="strFeeAmount" HeaderText="Board Registeration Fee" />
                                    <asp:BoundField DataField="strBoardAmount" SortExpression="strFeeAmount" HeaderText="Board Fee" />
                                     <asp:BoundField DataField="strFeeMonth" SortExpression="strFeeMonth" HeaderText="Month" />
                                    <asp:BoundField DataField="dtAddDate" SortExpression="dtAddDate" HeaderText="Receive Date" />
                                   <%-- <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnedit" runat="server" class="width-65 pull-left btn btn-sm btn-success" Text="Edit" OnClick="btnedit_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                   <%-- <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btndel" runat="server" class="width-65 pull-left btn btn-sm btn-success" Text="Delete" OnClick="btndel_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                </Columns>
                            </asp:GridView>
                        </asp:View>
                        <asp:View ID="View2" runat="server">
                            <div class="login-container" style="width:60%;">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Receive Fee
                                                </h4>

                                                <div class="space-6"></div>
                                                
                                                <form id="freg">
                                                    <fieldset>
                                                        <label class="block clearfix">
                                                            <Label class="block clearfix">Account Number :</Label>
                                                            
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddacnum" DataTextField="name" DataValueField="strAccNum" DataSourceID="sqlacnum" class="form-control" runat="server"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                                <asp:SqlDataSource ID="sqlacnum" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strAccNum],[strAccTitle]+'-'+[strAccNum] as name FROM [tbl_Bank] WHERE ([bisDeleted] = @bisDeleted)  and nsch_id=@nschid">
                                                                <SelectParameters>
                                                                    <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean" />
                                                                    <asp:SessionParameter Name="nschid" SessionField="nschoolid" />
                                                                     <asp:SessionParameter Name="uid" SessionField="uid" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            </span>
                                                        </label>
                                                        
                                                        <label class="block clearfix">
                                                             <Label class="block clearfix">Select Class :</Label>
                                                            <span class="block input-icon input-icon-right">

                                                                <asp:DropDownList AutoPostBack="true" CssClass="form-control" ID="ddcl" runat="server" OnSelectedIndexChanged="ddcl_SelectedIndexChanged" AppendDataBoundItems="True"></asp:DropDownList>
                                                                <%--<asp:SqlDataSource runat="server" ID="ClassDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strClass] FROM [tbl_Class] WHERE ([bisDeleted] = @bisDeleted)">
                                                                    <SelectParameters>
                                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>--%>
                                                                
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                             <Label class="block clearfix">Select Section :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList   CssClass="form-control" ID="ddsec" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddsec_SelectedIndexChanged" AppendDataBoundItems="True"></asp:DropDownList>
                                                                <%--<asp:SqlDataSource runat="server" ID="SectionDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strSection] FROM [tbl_Section] WHERE (([nc_id] =(Select nc_id from tbl_Class where strClass= @nc_id)) AND ([bisDeleted] = @bisDeleted))">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="ddcl" Name="nc_id" Type="String"></asp:ControlParameter>
                                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>--%>
                                                                
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                             <Label class="block clearfix">Select Student :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="form-control" ID="ddst" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddst_SelectedIndexChanged" AppendDataBoundItems="True"></asp:DropDownList>
                                                               <%-- <asp:SqlDataSource runat="server" ID="StudentDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strFname], [strStudentNum] FROM [tbl_Enrollment] WHERE (([nc_id] = (Select nc_id from tbl_Class where strClass= @nc_id and bisDeleted=0)) AND ([nsc_id] = (Select nsc_id from tbl_Section where nc_id=(Select nc_id from tbl_Class where strClass= @nc_id and bisDeleted=0) and bisDeleted=0)) AND ([bisDeleted] = @bisDeleted))">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="ddcl" PropertyName="SelectedValue" DefaultValue="0" Name="nc_id" ></asp:ControlParameter>
                                                                        <asp:ControlParameter ControlID="ddsec" PropertyName="SelectedValue" DefaultValue="0" Name="nsc_id" ></asp:ControlParameter>
                                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>--%>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                            <asp:Label Text="0" ID="lblneidd" Visible="false" runat="server" />
                                                        </label>
                                                        <%--<label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtstnum" class="form-control" placeholder="Student Number" runat="server" AutoPostBack="true" OnTextChanged="txtstnum_TextChanged"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Student Number" ControlToValidate="txtstnum"></asp:RequiredFieldValidator>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>--%>
                                                        <label class="block clearfix">
                                                            <Label class="block clearfix">Student Number :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtstnum" ReadOnly="true" class="form-control" placeholder="Student Number" runat="server" OnTextChanged="txtstnum_TextChanged" ></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        
                                                        <label class="hidden block clearfix">
                                                             <Label class="block clearfix">Student Name :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtnm" ReadOnly="true" class="form-control" placeholder="Name" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                       <%-- <label class="block clearfix">
                                                            <Label class="block clearfix">Fee Due Date :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtDueDate" ReadOnly="true" class="form-control" placeholder="Due Date " runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                             <Label class="block clearfix">Fee Fine :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtFine" ReadOnly="true" class="form-control" placeholder="Fine" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>--%>
                                                        <label class="block clearfix">
                                                            <Label class="block clearfix">Board Registeration Fee :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtbregfee" ReadOnly="true" class="form-control" placeholder="Board Registeration Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                         <label class="block clearfix">
                                                            <Label class="block clearfix">Board Fee :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtbfee" ReadOnly="true" class="form-control" placeholder="Board  Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                       
                                                       <%--  <label class="block clearfix">
                                                             <Label class="block clearfix">Concession Fee :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox  ReadOnly="true" ID="txtfeecons" AutoPostBack="true" class="form-control" placeholder="Student Concession Fee" runat="server" OnTextChanged="txtfeecons_TextChanged"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>--%>
                                                        <label class="block clearfix">
                                                            <Label class="block clearfix">Total Fee :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtTotfee" ReadOnly="true" class="form-control" placeholder="Student Total  Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:CheckBox CssClass="hidden" runat="server" Text="Check If Any Concession " ID="chkfeecons"  AutoPostBack="true" OnCheckedChanged="chkfeecons_CheckedChanged" />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                       
                                                        <label class="block clearfix">
                                                            <Label class="block clearfix">Enter Received :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtRcvfee" AutoPostBack="true" class="form-control" placeholder="Student Recive  Fee" runat="server" OnTextChanged="txtRcvfee_TextChanged"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                   <asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator1" ErrorMessage=" (digits only)" ValidationExpression="^\d+$" ControlToValidate="txtRcvfee" runat="server" />
                                                            </span>
                                                        </label>
                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <asp:Button ID="btnrcv" runat="server" Text="Enter and Print" class="width-30 pull-right btn btn-sm btn-success" OnClick="btnrcv_Click" />
                                                           <asp:Button ID="btnPaid" runat="server" Text="Fee Recieved and Print" class="width-30 pull-Left btn btn-sm btn-success" OnClick="btnPaid_Click" />
                                                        </div>

                                                    </fieldset>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:View>
                        <asp:View ID="View3" runat="server">
                          <%--  <div class="login-container">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Manage Recieving Fee
                                                </h4>

                                                <div class="space-6"></div>
                                                <form id="Form2">
                                                    <fieldset>
                                                        
                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <asp:Button ID="btnupdate" runat="server" Text="Update" class="width-30 pull-left btn btn-sm " OnClick="btnupdate_Click" />

                                                        </div>
                                                    </fieldset>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>--%>
                            
                        </asp:View>
                        <asp:View ID="View4"  runat="server">
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
													<span class="invoice-info-label">Fee Invoice :</span>
													<span class="red">#<asp:Label runat="server" ID="tststInvc"></asp:Label></span>

													<br />
													<span class="invoice-info-label"> Date    :</span>
													<span class="blue"><asp:Label runat="server" ID="date"></asp:Label></span>
                                                    <br />
													<span class="invoice-info-label"> Due Date:</span>
													<span class="blue"><asp:Label runat="server" ID="duedate"></asp:Label></span>
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
                                                                        Name&nbsp;&nbsp;&nbsp; :&nbsp; <asp:Label runat="server" ID="txtstName"></asp:Label> <%--<% Response.Write(txtnm.Text); %>--%>
																	</li>

																	<li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Roll No&nbsp; :&nbsp; <asp:Label runat="server" ID="txtstRoll"></asp:Label><%-- <% Response.Write(txtstnum.Text); %>--%>
																	</li>

																	<li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Class&nbsp;&nbsp;&nbsp;&nbsp; :&nbsp; <asp:Label runat="server" ID="txtstClass"></asp:Label> <%-- <% Response.Write(ddcl.Text); %>--%></li>
                                                                    <li>
																		<i class="ace-icon fa fa-caret-right blue"></i>
                                                                        Section&nbsp; :&nbsp; <asp:Label runat="server" ID="txtstSec"></asp:Label> <%-- <% Response.Write(ddsec.Text); %>--%></li>
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
																	<th>Fee</th>
                                                                    <th >Months</th>
																	<th >Late Fee Fine</th>
																	<th >Concession</th>
                                                                    <th >Remaining Fee</th>
																	
                                                                    <th >Total Fee</th>
                                                                    <th >Received Fee</th>


																</tr>
															</thead>

															<tbody>
																<tr>
																	<td class="center">1</td>

																	<td >
																		<asp:Label runat="server" ID="txtstFee"></asp:Label><%--<% Response.Write(txtfee.Text); %>--%>
																	</td>
                                                                    <td >
																		<asp:Label runat="server" Text="" ID="txtmonths"></asp:Label><%--<% Response.Write(txtfee.Text); %>--%>
																	</td>
																	<td >
                                                                        <asp:Label runat="server" ID="txtstFine"></asp:Label>
																		<%--<% Response.Write(txtFine.Text); %>--%>
																	</td>
                                                                    <td><asp:Label runat="server" ID="txtstConc"></asp:Label> <%--<% Response.Write(txtfeecons.Text); %>--%></td>
																	<td ><asp:Label runat="server" ID="txtstRemainingFee"></asp:Label> <%--<% Response.Write(txtRemnfee.Text); %>--%></td>
																	
                                                                    <td><asp:Label runat="server" ID="txtstTOTFee"></asp:Label> <%--<% Response.Write(txtTotfee.Text); %>--%></td>
                                                                    <td><asp:Label runat="server" ID="txtstRcvFee"></asp:Label> <%--<% Response.Write(txtRcvfee.Text); %>--%></td>
                                                                    
                                                                    

																</tr>

																
															</tbody>
														</table>
													</div>

													<div class="hr hr8 hr-double hr-dotted"></div>

													<div class="row">
														<div class="col-sm-5 pull-right">
															<h4 class="pull-right">
																Total Fee Received :
																<span class="red"><td><asp:Label runat="server" ID="txtstTOTRcvfee"></asp:Label></span>
															</h4>
														</div>
														<%--<div class="col-sm-7 pull-left"> Extra Information </div>--%>
													</div>

													<div class="space-6"></div>
													<div class="well">
														Powered By AT-Teachsoul , Farmecole School Management Sys | www.farmecole.com
                                                                    0321-9883140 | 051-4853771
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>

								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
                            <label class="width-30 pull-right btn btn-sm btn-success" onclick="printDiv('printable')"  > Print</label>
                          
                            <%--<asp:Button  class="width-30 pull-left btn btn-sm btn-success" Text="Fee Paid and Print" ID="btnPaid" runat="server"></asp:Button>--%>
						</div><!-- /.row -->
					</div><!-- /.page-content-area -->
				</div>
          
                        </asp:View>
                        <asp:View ID="View5" runat="server">
                            <div class="container">
        <div id="printable1" class="row">
            <div class="col-lg-12">
            <div class="col-md-4">
                 <div>
                                     <h3 class="widget-title grey lighter"><i class="ace-icon fa fa-leaf green"></i>
                                                    <asp:Label ID="txtschool1" Text="Schoollllllllll sd" runat="server"></asp:Label>
                                                </h3>
                                   
                                    <table>
                                        <tr>
                                            <td class="invoice-info-label">Challan #..</td><td><span class="red"><asp:Label ID="txtinv1" runat="server"></asp:Label></span></td></tr><tr>
                                            <td class="invoice-info-label">Date.......</td><td><span class="blue">
                                                    <asp:Label ID="txtdate1" runat="server"></asp:Label>
                                                    </span></td></tr><tr>
                                            <td class="invoice-info-label">Due Date...</td><td><span class="blue">
                                                    <asp:Label ID="txtduedate1" runat="server"></asp:Label>
                                                    </span></td></tr><tr>
                                             <td class="invoice-info-label"> Reg #....</td><td>  <asp:Label ID="txtreg1" runat="server"></asp:Label></td></tr><tr>
                                             <td class="invoice-info-label"> Name.....</td><td>   <asp:Label ID="txtname1" runat="server"></asp:Label> </td></tr><tr>
                                             <td class="invoice-info-label"> Class....</td><td>   <asp:Label ID="txtcls1" runat="server"></asp:Label> </td></tr><tr>
                                             <td class="invoice-info-label"> Section..</td><td>  <asp:Label ID="txtsec1" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                    <table class="table table-striped table-bordered">
                                                            <thead>
                                                                
                                                                
                                                                <tr>
                                                                    <th>Months</th>
                                                                    <td>
                                                                        <asp:Label ID="txtmonths1" runat="server" Text=""></asp:Label>
                                                                       </td>
                                                                </tr>
                                                               
                                                                <tr>
                                                                    <th>Board Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstConc1" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Board Registeration Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstRemainingFee1" runat="server"></asp:Label>
                                                                      </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Total Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstTOTFee1" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Received Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstRcvFee1" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                            </thead>
                                                           
                                                        </table>
                                   <div class="row">
														<div class="col-sm-4 pull-right">
															<h4 class="pull-right">
																Total Fee Received :
																<span class="red"><td><asp:Label runat="server" Text="000" ID="txtstTOTRcvfee1"></asp:Label></span>
															</h4>
														</div>
                                         <div class="col-sm-4">
                                                           <div id="stdbacode">

                                                            <asp:TextBox ID="getCodetxt" runat="server" Visible="false"></asp:TextBox>
                                                            <asp:Panel ID="pnlPrint" runat="server">
                                                              
                                                                    <asp:Image ID="img" runat="server" Style="height: 43px; width: 130px;" /> 
                                                            
              
                                                            </asp:Panel>
                                                        </div>
                                                    </div>
                                                         <div class="col-sm-4">
															<h6 class="pull-right">
																Student Copy
																
															</h6>
														</div>
														
													</div>
                                </div>
            </div>
            <div class="col-md-4">
                 <div>
                                     <h3 class="widget-title grey lighter"><i class="ace-icon fa fa-leaf green"></i>
                                                    <asp:Label ID="txtschool2" Text="Schoollllllllll sd" runat="server"></asp:Label>
                                                </h3>
                                   
                                    <table>
                                        <tr>
                                            <td class="invoice-info-label">Challan #..</td><td><span class="red"><asp:Label ID="txtinv2" runat="server"></asp:Label></span></td></tr><tr>
                                            <td class="invoice-info-label">Date.......</td><td><span class="blue">
                                                    <asp:Label ID="txtdate2" runat="server"></asp:Label>
                                                    </span></td></tr><tr>
                                            <td class="invoice-info-label">Due Date...</td><td><span class="blue">
                                                    <asp:Label ID="txtduedate2" runat="server"></asp:Label>
                                                    </span></td></tr><tr>
                                             <td class="invoice-info-label"> Reg #....</td><td>  <asp:Label ID="txtreg2" runat="server"></asp:Label></td></tr><tr>
                                             <td class="invoice-info-label"> Name.....</td><td>   <asp:Label ID="txtname2" runat="server"></asp:Label> </td></tr><tr>
                                             <td class="invoice-info-label"> Class....</td><td>   <asp:Label ID="txtcls2" runat="server"></asp:Label> </td></tr><tr>
                                             <td class="invoice-info-label"> Section..</td><td>  <asp:Label ID="txtsec2" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                    <table class="table table-striped table-bordered">
                                                            <thead>
                                                                
                                                               
                                                                <tr>
                                                                    <th>Months</th>
                                                                    <td>
                                                                        <asp:Label ID="txtmonths2" runat="server" Text=""></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                
                                                                <tr>
                                                                    <th>Board  Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstConc2" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                   <th>Board Registeration Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstRemainingFee2" runat="server"></asp:Label>
                                                                      </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Total Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstTOTFee2" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Received Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstRcvFee2" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                            </thead>
                                                           
                                                        </table>
                                   <div class="row">
														<div class="col-sm-4 pull-right">
															<h4 class="pull-right">
																Total Fee Received :
																<span class="red"><td><asp:Label runat="server" Text="000" ID="txtstTOTRcvfee2"></asp:Label></span>
															</h4>
														</div>
                                         <div class="col-sm-4">
                                                           <div id="stdbddacode">

                                                          
                                                            <asp:Panel ID="pnlPrint1" runat="server">
                                                              
                                                                    <asp:Image ID="img1" runat="server" Style="height: 43px; width: 130px;" /> 
                                                            
              
                                                            </asp:Panel>
                                                        </div>
                                                    </div>
                                                         <div class="col-sm-4">
															<h6 class="pull-right">
																School Copy
																
															</h6>
														</div>
														
													</div>
                                </div>
            </div>
            <div class="col-md-4">
                 <div>
                                     <h3 class="widget-title grey lighter"><i class="ace-icon fa fa-leaf green"></i>
                                                    <asp:Label ID="txtschool3" Text="Schoollllllllll sd" runat="server"></asp:Label>
                                                </h3>
                                   
                                    <table>
                                        <tr>
                                            <td class="invoice-info-label">Challan #..</td><td><span class="red"><asp:Label ID="txtinv3" runat="server"></asp:Label></span></td></tr><tr>
                                            <td class="invoice-info-label">Date.......</td><td><span class="blue">
                                                    <asp:Label ID="txtdate3" runat="server"></asp:Label>
                                                    </span></td></tr><tr>
                                            <td class="invoice-info-label">Due Date...</td><td><span class="blue">
                                                    <asp:Label ID="txtduedate3" runat="server"></asp:Label>
                                                    </span></td></tr><tr>
                                             <td class="invoice-info-label"> Reg #....</td><td>  <asp:Label ID="txtreg3" runat="server"></asp:Label></td></tr><tr>
                                             <td class="invoice-info-label"> Name.....</td><td>   <asp:Label ID="txtname3" runat="server"></asp:Label> </td></tr><tr>
                                             <td class="invoice-info-label"> Class....</td><td>   <asp:Label ID="txtcls3" runat="server"></asp:Label> </td></tr><tr>
                                             <td class="invoice-info-label"> Section..</td><td>  <asp:Label ID="txtsec3" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                    <table class="table table-striped table-bordered">
                                                            <thead>
                                                                
                                                                
                                                                <tr>
                                                                    <th>Months</th>
                                                                    <td>
                                                                        <asp:Label ID="txtmonths3" runat="server" Text=""></asp:Label>
                                                                       </td>
                                                                </tr>
                                                              
                                                                <tr>
                                                            <th>Board  Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstConc3" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Board Registeration Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstRemainingFee3" runat="server"></asp:Label>
                                                                      </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Total Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstTOTFee3" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Received Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstRcvFee3" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                            </thead>
                                                           
                                                        </table>
                                   <div class="row">
														<div class="col-sm-4 pull-right">
															<h4 class="pull-right">
																Total Fee Received :
																<span class="red"><td><asp:Label runat="server" Text="000" ID="txtstTOTRcvfee3"></asp:Label></span>
															</h4>
														</div>
                                         <div class="col-sm-4">
                                                           <div id="stdbacode">

                                                          
                                                            <asp:Panel ID="pnlPrint2" runat="server">
                                                              
                                                                    <asp:Image ID="img2" runat="server" Style="height: 43px; width: 130px;" /> 
                                                            
              
                                                            </asp:Panel>
                                                        </div>
                                                    </div>
                                                         <div class="col-sm-4">
															<h6 class="pull-right">
																Bank Copy
																
															</h6>
														</div>
														
													</div>
                                </div>
            </div>
                </div>
               
        </div>
                                <label class="width-30 pull-right btn btn-sm btn-success" onclick="printDiv('printable1')"  > Print</label>
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
        <!-- PAGE CONTENT ENDS -->
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
