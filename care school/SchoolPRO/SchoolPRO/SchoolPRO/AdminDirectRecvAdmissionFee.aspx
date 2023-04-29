<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDirectRecvAdmissionFee.aspx.cs" Inherits="SchoolPRO.AdminDirectRecvAdmissionFee" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="DropDownCheckBoxes" Namespace="Saplin.Controls" TagPrefix="cc1" %>
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
        .PnlDesign {
            border: solid 1px #000000;
            height: 150px;
            width: 330px;
            overflow-y: scroll;
            background-color: #EAEAEA;
            font-size: 15px;
            font-family: Arial;
        }

        .txtbox {
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
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nfr_id" SortExpression="nfr_id" HeaderText="S.NO" />
                                    <asp:BoundField DataField="strname" SortExpression="strTutionFee" HeaderText="Name" />
                                    <asp:BoundField DataField="strClass" SortExpression="strClass" HeaderText="Class" />
                                    <asp:BoundField DataField="strSection" SortExpression="strSection" HeaderText="Section" />
                                    <asp:BoundField DataField="strFeeAmount" SortExpression="strFeeAmount" HeaderText="Fee" />
                                    <asp:BoundField DataField="strFeeMonth" SortExpression="strFeeMonth" HeaderText="Month" />
                                    <asp:BoundField DataField="dtAddDate" SortExpression="dtAddDate" HeaderText="Receive Date" />
                                </Columns>
                            </asp:GridView>
                        </asp:View>
                        <asp:View ID="View2" runat="server">
                            <div class="login-container" style="width: 60%;">
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
                                                            <label class="block clearfix">Account Number :</label>

                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddacnum" DataTextField="name" DataValueField="strAccNum" DataSourceID="sqlacnum" class="form-control" runat="server"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                                <asp:SqlDataSource ID="sqlacnum" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strAccNum],[strBname]+'-'+[strBrname] as name FROM [tbl_Bank] WHERE ([bisDeleted] = @bisDeleted) and nsch_id=@nschid">
                                                                    <SelectParameters>
                                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean" />
                                                                        <asp:SessionParameter Name="nschid" SessionField="nschoolid" />
                                                                        <asp:SessionParameter Name="uid" SessionField="uid" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Select Class :</label>
                                                            <span class="block input-icon input-icon-right">

                                                                <asp:DropDownList AutoPostBack="true" CssClass="form-control" ID="ddcl" runat="server" OnSelectedIndexChanged="ddcl_SelectedIndexChanged" AppendDataBoundItems="True"></asp:DropDownList>
                                                               
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Select Section :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="form-control" ID="ddsec" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddsec_SelectedIndexChanged" AppendDataBoundItems="True"></asp:DropDownList>
                                                                
                                                                
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Select Student :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList runat="server" AutoPostBack="true" CssClass="form-control" ID="ddst"  OnSelectedIndexChanged="ddst_SelectedIndexChanged" AppendDataBoundItems="True"></asp:DropDownList>
                                                                
                                                                <i class="icon-user"></i>
                                                            </span>
                                                            <asp:Label Text="0" ID="lblneidd" Visible="false" runat="server" />
                                                        </label>
                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Student Number :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtstnum" ReadOnly="true" class="form-control" placeholder="Student Number" runat="server" OnTextChanged="txtstnum_TextChanged"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:CheckBox runat="server" Text="Check If Pay Fee For More then one Month " ID="chkmonth" AutoPostBack="true" CssClass="form-control" OnCheckedChanged="chkmonth_CheckedChanged" />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <asp:Label runat="server" ID="month" Visible="false" class="block clearfix">Select Months :</asp:Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:CheckBoxList OnSelectedIndexChanged="monthlist_SelectedIndexChanged" AutoPostBack="true" ID="monthlist" Visible="false" runat="server" DataSourceID="Months" DataTextField="name" DataValueField="nMonth_id">
                                                                </asp:CheckBoxList>




                                                                <asp:SqlDataSource runat="server" ID="Months" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_FeeMonth.nMonth_id, tbl_FeeMonth.strMonthName + '-' + tbl_FeeMonth.strMonthNo AS name, tbl_FeeMonth.strMonthNo FROM tbl_FeeMonth ORDER BY nseq  ASC">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="lblneidd" PropertyName="Text" DefaultValue="0" Name="eid"></asp:ControlParameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:CheckBox runat="server" Text="See Paid Months" ID="ddlseepaid" AutoPostBack="true" CssClass="form-control" OnCheckedChanged="ddlseepaid_CheckedChanged" />
                                                                <i class="icon-user"></i>
                                                                <asp:ListBox Visible="false" runat="server" ID="lstpaidmonth" DataSourceID="Paidmonths" CssClass="list-items" DataTextField="strMonthName" DataValueField="strMonthName"></asp:ListBox>
                                                                <asp:SqlDataSource runat="server" ID="Paidmonths" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_FeeMonth.strMonthName, tbl_RecieveFee.strFeeMonth FROM tbl_RecieveFee INNER JOIN tbl_FeeMonth ON tbl_RecieveFee.nMonth_id = tbl_FeeMonth.nMonth_id WHERE (tbl_RecieveFee.bisDeleted = 'False') AND (tbl_RecieveFee.ne_id = @eid) AND (tbl_RecieveFee.nsch_id = @schid)  AND (SUBSTRING(tbl_RecieveFee.strFeeMonth ,7,10) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10))">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="lblneidd" PropertyName="Text" DefaultValue="0" Name="eid"></asp:ControlParameter>
                                                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                            </span>
                                                        </label>
                                                        <label class="hidden block clearfix">
                                                            <label class="block clearfix">Student Name :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtnm" ReadOnly="true" class="form-control" placeholder="Name" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Fee Due Date :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtDueDate" ReadOnly="true" class="form-control" placeholder="Due Date " runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Class Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtfee" ReadOnly="false" class="form-control" placeholder="Class Fee" AutoPostBack="true" OnTextChanged="txtfee_TextChanged" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Admission Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtadmissionfee" ReadOnly="false" class="form-control" placeholder="Admission Fee" AutoPostBack="true" OnTextChanged="txtadmissionfee_TextChanged" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class=" block clearfix">
                                                            <label class="block clearfix">Annual Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtregfee" ReadOnly="false" class="form-control" placeholder="Annual Fee" AutoPostBack="true" OnTextChanged="txtregfee_TextChanged" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class=" block clearfix">
                                                            <label class="block clearfix">Annual Exam  Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtexamfee" ReadOnly="true" class="form-control" placeholder="Annual Exam Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class=" block clearfix">
                                                            <label class="block clearfix">Books  Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtbookfee" ReadOnly="true" class="form-control" placeholder="Books Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class=" block clearfix">
                                                            <label class="block clearfix">Generator Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtgenfee" ReadOnly="true" class="form-control" placeholder="Generator Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class=" block clearfix">
                                                            <label class="block clearfix">Folder Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtflderfee" ReadOnly="true" class="form-control" placeholder="Folder Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>

                                                        <label class=" block clearfix">
                                                            <label class="block clearfix">Stationary Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtstatfee" ReadOnly="true" class="form-control" placeholder="Stationary Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        
                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Concession Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ReadOnly="true" ID="txtfeecons" AutoPostBack="true" class="form-control" placeholder="Student Concession Fee" runat="server" OnTextChanged="txtfeecons_TextChanged"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Total Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtTotfee" ReadOnly="true" class="form-control" placeholder="Student Total  Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:CheckBox CssClass="hidden" runat="server" Text="Check If Any Concession " ID="chkfeecons" AutoPostBack="true" OnCheckedChanged="chkfeecons_CheckedChanged" />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Enter Receive :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtRcvfee" AutoPostBack="true" class="form-control" placeholder="Student Receive  Fee" runat="server" OnTextChanged="txtRcvfee_TextChanged"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                <asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator1" ErrorMessage=" (digits only)" ValidationExpression="^\d+$" ControlToValidate="txtRcvfee" runat="server" />
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Remaining Dues :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtRemnfee" ReadOnly="true" class="form-control" placeholder="Student Remaining Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Issue Date :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtissueDate"  class="form-control" runat="server"></asp:TextBox>
                                                                <cc1:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtissueDate" runat="server"></cc1:CalendarExtender>
                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator21" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression="^[\s\S]{10,10}$" ControlToValidate="txtissueDate"></asp:RequiredFieldValidator>
                                                <label id='lblCaption' style="font-family: Tahoma; font-size: 1em; font-weight: bold" cssclass="red"></label>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <asp:Button ID="btnrcv" Visible="false" runat="server" Text="Enter and Print" class="width-30 pull-right btn btn-sm btn-success" OnClick="btnrcv_Click" />
                                                            <asp:Button ID="btnPaid" runat="server" Text="Fee Received and Print" class="width-30 pull-Left btn btn-sm btn-success" OnClick="btnPaid_Click" />
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
                        <asp:View ID="View4" runat="server">
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
                                                            <span class="invoice-info-label">Date    :</span>
                                                            <span class="blue">
                                                                <asp:Label runat="server" ID="date"></asp:Label></span>
                                                            <br />
                                                            <span class="invoice-info-label">Due Date:</span>
                                                            <span class="blue">
                                                                <asp:Label runat="server" ID="duedate"></asp:Label></span>
                                                        </div>

                                                        <div class="widget-toolbar hidden-480">
                                                            <a href="#">
                                                                <i class="ace-icon fa fa-print"></i>
                                                            </a>
                                                        </div>
                                                    </div>

                                                    <div class="widget-body">
                                                        <div class="widget-main padding-24">
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
                                                                                Name&nbsp;&nbsp;&nbsp; :&nbsp;
                                                                                <asp:Label runat="server" ID="txtstName"></asp:Label>
                                                                                <%--<% Response.Write(txtnm.Text); %>--%>
                                                                            </li>

                                                                            <li>
                                                                                <i class="ace-icon fa fa-caret-right blue"></i>
                                                                                Roll No&nbsp; :&nbsp;
                                                                                <asp:Label runat="server" ID="txtstRoll"></asp:Label><%-- <% Response.Write(txtstnum.Text); %>--%>
                                                                            </li>

                                                                            <li>
                                                                                <i class="ace-icon fa fa-caret-right blue"></i>
                                                                                Class&nbsp;&nbsp;&nbsp;&nbsp; :&nbsp;
                                                                                <asp:Label runat="server" ID="txtstClass"></asp:Label>
                                                                                <%-- <% Response.Write(ddcl.Text); %>--%></li>
                                                                            <li>
                                                                                <i class="ace-icon fa fa-caret-right blue"></i>
                                                                                Section&nbsp; :&nbsp;
                                                                                <asp:Label runat="server" ID="txtstSec"></asp:Label>
                                                                                <%-- <% Response.Write(ddsec.Text); %>--%></li>
                                                                            <li>
                                                                                <i class="ace-icon fa fa-caret-right blue"></i>
                                                                                Paymant Info : New Admission
                                                                            </li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <!-- /.col -->
                                                            </div>
                                                            <!-- /.row -->

                                                            <div class="space"></div>

                                                            <div>
                                                                <table class="table table-striped table-bordered">
                                                                    <thead>
                                                                        <tr>
                                                                            <th class="center">#</th>
                                                                            <th>Fee</th>
                                                                            <th>Admission Fee</th>
                                                                            <th>Months</th>

                                                                            <th>Concession</th>
                                                                            <th>Remaining Fee</th>

                                                                            <th>Total Fee</th>

                                                                            <th>Received Fee</th>


                                                                        </tr>
                                                                    </thead>

                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="center">1</td>

                                                                            <td>
                                                                                <asp:Label runat="server" ID="txtstFee"></asp:Label><%--<% Response.Write(txtfee.Text); %>--%>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label runat="server" ID="txtadms"></asp:Label><%--<% Response.Write(txtfee.Text); %>--%>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label runat="server" Text="" ID="txtmonths"></asp:Label><%--<% Response.Write(txtfee.Text); %>--%>
                                                                            </td>
                                                                            <%--<td >
                                                                        <asp:Label runat="server" ID="txtstFine"></asp:Label>
																		<%--<% Response.Write(txtFine.Text); %>--%
																	</td>--%>
                                                                            <td>
                                                                                <asp:Label runat="server" ID="txtstConc"></asp:Label>
                                                                                <%--<% Response.Write(txtfeecons.Text); %>--%></td>
                                                                            <td>
                                                                                <asp:Label runat="server" ID="txtstRemainingFee"></asp:Label>
                                                                                <%--<% Response.Write(txtRemnfee.Text); %>--%></td>

                                                                            <td>
                                                                                <asp:Label runat="server" ID="txtstTOTFee"></asp:Label>
                                                                                <%--<% Response.Write(txtTotfee.Text); %>--%></td>
                                                                            <td>
                                                                                <asp:Label runat="server" ID="txtstRcvFee"></asp:Label>
                                                                                <%--<% Response.Write(txtRcvfee.Text); %>--%></td>



                                                                        </tr>


                                                                    </tbody>
                                                                </table>
                                                            </div>

                                                            <div class="hr hr8 hr-double hr-dotted"></div>

                                                            <div class="row">
                                                                <div class="col-sm-5 pull-right">
                                                                    <h4 class="pull-right">Total Fee Received :
																<span class="red">
                                                                    <td>
                                                                        <asp:Label runat="server" ID="txtstTOTRcvfee"></asp:Label>
                                                                </span>
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
                                    </div>
                                    <!-- /.col -->
                                    <label class="width-30 pull-right btn btn-sm btn-success" onclick="printDiv('printable')">Print</label>

                                    <%--<asp:Button  class="width-30 pull-left btn btn-sm btn-success" Text="Fee Paid and Print" ID="btnPaid" runat="server"></asp:Button>--%>
                                </div>
                                <!-- /.row -->
                            </div>
                            <!-- /.page-content-area -->
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
                                                        <td class="invoice-info-label">Challan #..</td>
                                                        <td><span class="red">
                                                            <asp:Label ID="txtinv1" runat="server"></asp:Label></span></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Date.......</td>
                                                        <td><span class="blue">
                                                            <asp:Label ID="txtdate1" runat="server"></asp:Label>
                                                        </span></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Due Date...</td>
                                                        <td><span class="blue">
                                                            <asp:Label ID="txtduedate1" runat="server"></asp:Label>
                                                        </span></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Reg #....</td>
                                                        <td>
                                                            <asp:Label ID="txtreg1" runat="server"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Name.....</td>
                                                        <td>
                                                            <asp:Label ID="txtname1" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Class....</td>
                                                        <td>
                                                            <asp:Label ID="txtcls1" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Section..</td>
                                                        <td>
                                                            <asp:Label ID="txtsec1" runat="server"></asp:Label></td>
                                                    </tr>
                                                </table>
                                                <table class="table table-striped table-bordered">
                                                    <thead>

                                                        <tr>
                                                            <th>Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtstFee1" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Months</th>
                                                            <td>
                                                                <asp:Label ID="txtmonths1" runat="server" Text=""></asp:Label>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <th>Admission Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtstadmsfee1" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Registeration Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtregfee1" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Books Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtbookfee1" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Stationary Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtstatfee1" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Generator Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtgenfee1" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Annaul Exam Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtexamfee1" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Folder  Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtfldrfee1" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <th>Concession</th>
                                                            <td>
                                                                <asp:Label ID="txtstConc1" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Remaining Fee</th>
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
                                                        <h4 class="pull-right">Total Fee Received :
																<span class="red">
                                                                    <td>
                                                                        <asp:Label runat="server" Text="000" ID="txtstTOTRcvfee1"></asp:Label>
                                                                </span>
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
                                                        <h6 class="pull-right">Student Copy
																
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
                                                        <td class="invoice-info-label">Challan #..</td>
                                                        <td><span class="red">
                                                            <asp:Label ID="txtinv2" runat="server"></asp:Label></span></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Date.......</td>
                                                        <td><span class="blue">
                                                            <asp:Label ID="txtdate2" runat="server"></asp:Label>
                                                        </span></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Due Date...</td>
                                                        <td><span class="blue">
                                                            <asp:Label ID="txtduedate2" runat="server"></asp:Label>
                                                        </span></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Reg #....</td>
                                                        <td>
                                                            <asp:Label ID="txtreg2" runat="server"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Name.....</td>
                                                        <td>
                                                            <asp:Label ID="txtname2" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Class....</td>
                                                        <td>
                                                            <asp:Label ID="txtcls2" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Section..</td>
                                                        <td>
                                                            <asp:Label ID="txtsec2" runat="server"></asp:Label></td>
                                                    </tr>
                                                </table>
                                                <table class="table table-striped table-bordered">
                                                    <thead>

                                                        <tr>
                                                            <th>Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtstFee2" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Months</th>
                                                            <td>
                                                                <asp:Label ID="txtmonths2" runat="server" Text=""></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Admission Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtstadmsfee2" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Registeration Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtregfee2" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Books Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtbookfee2" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Stationary Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtstatfee2" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Generator Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtgenfee2" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Annaul Exam Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtexamfee2" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Folder  Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtfldrfee2" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Concession</th>
                                                            <td>
                                                                <asp:Label ID="txtstConc2" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Remaining Fee</th>
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
                                                        <h4 class="pull-right">Total Fee Received :
																<span class="red">
                                                                    <td>
                                                                        <asp:Label runat="server" Text="000" ID="txtstTOTRcvfee2"></asp:Label>
                                                                </span>
                                                        </h4>
                                                    </div>
                                                     <div class="col-sm-4">
                                                           <div id="stdbarcode">

                                                          
                                                            <asp:Panel ID="pnlPrint1" runat="server">
                                                              
                                                                    <asp:Image ID="img1" runat="server" Style="height: 43px; width: 130px;" /> 
                                                            
              
                                                            </asp:Panel>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <h6 class="pull-right">School Copy
																
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
                                                        <td class="invoice-info-label">Challan #..</td>
                                                        <td><span class="red">
                                                            <asp:Label ID="txtinv3" runat="server"></asp:Label></span></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Date.......</td>
                                                        <td><span class="blue">
                                                            <asp:Label ID="txtdate3" runat="server"></asp:Label>
                                                        </span></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Due Date...</td>
                                                        <td><span class="blue">
                                                            <asp:Label ID="txtduedate3" runat="server"></asp:Label>
                                                        </span></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Reg #....</td>
                                                        <td>
                                                            <asp:Label ID="txtreg3" runat="server"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Name.....</td>
                                                        <td>
                                                            <asp:Label ID="txtname3" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Class....</td>
                                                        <td>
                                                            <asp:Label ID="txtcls3" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="invoice-info-label">Section..</td>
                                                        <td>
                                                            <asp:Label ID="txtsec3" runat="server"></asp:Label></td>
                                                    </tr>
                                                </table>
                                                <table class="table table-striped table-bordered">
                                                    <thead>

                                                        <tr>
                                                            <th>Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtstFee3" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Months</th>
                                                            <td>
                                                                <asp:Label ID="txtmonths3" runat="server" Text=""></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Admission Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtstadmsfee3" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Registeration Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtregfee3" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Books Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtbookfee3" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Stationary Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtstatfee3" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Generator Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtgenfee3" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Annaul Exam Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtexamfee3" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Folder  Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtfldrfee3" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Concession</th>
                                                            <td>
                                                                <asp:Label ID="txtstConc3" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Remaining Fee</th>
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
                                                        <h4 class="pull-right">Total Fee Received :
																<span class="red">
                                                                    <td>
                                                                        <asp:Label runat="server" Text="000" ID="txtstTOTRcvfee3"></asp:Label>
                                                                </span>
                                                        </h4>
                                                    </div>
                                                     <div class="col-sm-4">
                                                           <div id="Div1">

                                                          
                                                            <asp:Panel ID="pnlPrint2" runat="server">
                                                              
                                                                    <asp:Image ID="img2" runat="server" Style="height: 43px; width: 130px;" /> 
                                                            
              
                                                            </asp:Panel>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <h6 class="pull-right">Bank Copy
																
                                                        </h6>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <label class="width-30 pull-right btn btn-sm btn-success" onclick="printDiv('printable1')">Print</label>
                            </div>
                        </asp:View>
                    </asp:MultiView>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="UpdateProgress1" DisplayAfter="10" runat="server">
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
