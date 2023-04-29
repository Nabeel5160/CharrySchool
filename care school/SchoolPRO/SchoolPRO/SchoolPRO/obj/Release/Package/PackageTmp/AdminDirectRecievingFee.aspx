<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDirectRecievingFee.aspx.cs" Inherits="SchoolPRO.AdminRecievingFee" %>

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
        
        .tblstdinfo tr,th,td {
            border:1px solid black;
           
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
                                    <%-- <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnedit" runat="server" class="width-65 pull-left btn btn-sm btn-success" Text="Edit" OnClick="btnedit_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <%--<asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btndel" runat="server" class="width-65 pull-left btn btn-sm btn-success" Text="Delete" OnClick="btndel_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
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
                                                    Recieve Fee
                                                </h4>

                                                <div class="space-6"></div>

                                                <form id="freg">
                                                    <fieldset>
                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Account Number :</label>

                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddacnum" DataTextField="name" DataValueField="strAccNum" DataSourceID="sqlacnum" class="form-control" runat="server"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                                <asp:SqlDataSource ID="sqlacnum" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strAccNum],[strBname]+'-'+[strBrname] as name FROM [tbl_Bank] WHERE ([bisDeleted] = @bisDeleted)  and nsch_id=@nschid">
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
                                                                <%--<asp:SqlDataSource runat="server" ID="ClassDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strClass] FROM [tbl_Class] WHERE ([bisDeleted] = @bisDeleted)">
                                                                    <SelectParameters>
                                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>--%>
                                                                
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Select Section :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="form-control" ID="ddsec" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddsec_SelectedIndexChanged" AppendDataBoundItems="True"></asp:DropDownList>
                                                                <%--<asp:SqlDataSource runat="server" ID="SectionDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strSection] FROM [tbl_Section] WHERE (([nc_id] =(Select nc_id from tbl_Class where strClass= @nc_id)) AND ([bisDeleted] = @bisDeleted))">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="ddcl" Name="nc_id" Type="String"></asp:ControlParameter>
                                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>--%>
                                                                
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Select Student :</label>
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
                                                                <asp:SqlDataSource runat="server" ID="Paidmonths" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_FeeMonth.strMonthName, tbl_RecieveFee.strFeeMonth FROM tbl_RecieveFee INNER JOIN tbl_FeeMonth ON tbl_RecieveFee.nMonth_id = tbl_FeeMonth.nMonth_id WHERE (tbl_RecieveFee.bisDeleted = 'False') AND (tbl_RecieveFee.ne_id = @eid) AND SUBSTRING(tbl_RecieveFee.strFeeMonth ,7,10)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10)">
                                                                    <SelectParameters>

                                                                        <asp:ControlParameter ControlID="lblneidd" PropertyName="Text" DefaultValue="0" Name="eid"></asp:ControlParameter>
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
                                                            <label class="block clearfix">Fee Fine :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtFine" ReadOnly="true" class="form-control" placeholder="Fine" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Class Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtfee" ReadOnly="true" class="form-control" placeholder="Class Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="hidden block clearfix">
                                                            <label class="block clearfix">Generator Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtgenfee" ReadOnly="true" class="form-control" placeholder="Generator Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="hidden block clearfix">
                                                            <label class="block clearfix">Folder Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtflderfee" ReadOnly="true" class="form-control" placeholder="Folder Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>

                                                        <label class="hidden block clearfix">
                                                            <label class="block clearfix">Stationary Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtstatfee" ReadOnly="true" class="form-control" placeholder="Stationary Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
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
                                                                <asp:TextBox ID="txtRcvfee" AutoPostBack="true" class="form-control" placeholder="Student receive  fee" runat="server" OnTextChanged="txtRcvfee_TextChanged"></asp:TextBox>
                                                                <asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator1" ErrorMessage=" (digits only)" ValidationExpression="^\d+$" ControlToValidate="txtRcvfee" runat="server" />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <asp:Button ID="btnrcv" runat="server" Text="Enter and Print" class="width-30 pull-right btn btn-sm btn-success" OnClick="btnrcv_Click" />
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
                        <asp:View runat="server">
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
                                                                                Paymant Info
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
                                                                            <th>Months</th>
                                                                            <th>Late Fee Fine</th>
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
                                                                                <asp:Label runat="server" Text="" ID="txtmonths"></asp:Label><%--<% Response.Write(txtfee.Text); %>--%>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label runat="server" ID="txtstFine"></asp:Label>
                                                                                <%--<% Response.Write(txtFine.Text); %>--%>
                                                                            </td>
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
                                                                Powered By Heaven Technologies , Heaven School Management Sys | www.heaventechnologies.com
                                                                    051-4853801
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
                        <asp:View runat="server">
                            <div class="container">
                                <div id="printable1" class="row">
                                    <div class="col-lg-12 col-xs-12">
                                        <div class="col-md-4 col-xs-4">
                                            <div>
                                                <div class="pull-left">
                                                    <img class="img-responsive" src="assets/img/sch_logo.jpg" />
                                                </div>
                                                <div>
                                                  <span style="text-align:center; text-decoration:solid; font-size:12px"> <asp:Label ID="lblsch1" Text="" runat="server"></asp:Label></span><br />
                                                   <span style="text-align:center; font-size:9px;"><asp:Label ID="lbladrs1" Text="" runat="server"></asp:Label></span> <br />
                                                    <span style="text-align:center; font-size:9px;"><asp:Label ID="lblbnk1" Text="" runat="server"></asp:Label></span> 
                                                </div>

                                                <table style="font-size:10px"  class="no-margin tblstdinfo table table-striped">
                                                   <tr>
                                                        <th><span style="background-color:black;color:white">Fee Bill of <asp:Label Text="" runat="server" ID="lblfeemonth"></asp:Label></span>  </th>
                                                        <td><span class="blue">
                                                          <span style="background-color:black; color:white">Issue Date <asp:Label ID="txtdate1" Text="" runat="server"></asp:Label></span>
                                                        </span></td>
                                                    </tr>
                                                     <tr>
                                                        <th>Due Date <span class="blue">
                                                            <asp:Label ID="lblduedt1" Text="" runat="server"></asp:Label>
                                                        </span></th>
                                                         <th>Challan # <span class="red">
                                                            <asp:Label ID="txtinv1" Text="" runat="server"></asp:Label></span></th>
                                                        
                                                    </tr>
                                                    
                                                    
                                                    <tr>
                                                        <th>Admission #</th>
                                                        <td>
                                                            <asp:Label ID="txtreg1" Text="" runat="server"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <th>Student's Name</th>
                                                        <td>
                                                            <asp:Label ID="txtname1" Text="" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Father's Name</th>
                                                        <td>
                                                            <asp:Label ID="txtfname1" Text="" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Class <asp:Label ID="txtcls1" Text="" runat="server"></asp:Label></th>
                                                        <th>Section <asp:Label ID="txtsec1" Text="" runat="server"></asp:Label></th>
                                                       
                                                    </tr>
                                                    
                                                </table>
                                                <table style="font-size:9px;" class="no-margin table table-striped">
                                                    <%--<thead>--%>

                                                        <tr>
                                                            <th>Fee</th>
                                                            <td>
                                                                <asp:Label ID="txtstFee1" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Annual Fund</th>
                                                            <td>
                                                                <asp:Label ID="Label1" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Admission Fee</th>
                                                            <td>
                                                                <asp:Label ID="Label2" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Arrears</th>
                                                            <td>
                                                                <asp:Label ID="lblrem1" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Payable before Due Date</th>
                                                            <td>
                                                                <asp:Label ID="lblpbddt1" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Late Fee Fine</th>
                                                            <td>
                                                                <asp:Label ID="txtstFine1" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr>
                                                            <th>Payable After Due Date</th>
                                                            <td>
                                                                <asp:Label ID="lblpaddt" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr>
                                                            <td colspan="2">
                                                               <span style="text-align:center; text-decoration:solid"> <asp:Label ID="lbltotfeeinwords1" runat="server"></asp:Label></spa>
                                                            </td>
                                                        </tr>
                                                    <%--</thead>--%>

                                                </table>
                                                <div class="row">
                                                   
                                                   <div class="col-xs-12">
                                                                    <asp:GridView ID="gvtermstd" EmptyDataText="No Data Found" class="table table-striped table-hover" runat="server" AllowPaging="True" ShowHeader="false" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nct_id" EnableViewState="true">
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <%# Container.DataItemIndex+1 %>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nct_id" HeaderText="S.NO" SortExpression="nct_id" />
                                                                            <asp:BoundField DataField="strChallanTerms" SortExpression="strChallanTerms"  />
                                                                        </Columns>
                                                                        <RowStyle BorderColor="Black" Font-Size="6" />
                                                                    </asp:GridView>
                                                                </div>
                                                     <div class="clearfix"></div>
                                                    <div class="col-sm-4">
                                                           <div id="stdbarcode">

                                                            <asp:TextBox ID="getCodetxt" runat="server" Visible="false"></asp:TextBox>
                                                            <asp:Panel ID="pnlPrint" runat="server">
                                                              
                                                                    <asp:Image ID="img1"  runat="server" Style="height: 43px; width: 130px;" /> 
                                                            
              
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
                                        <div class="col-md-4 col-xs-4">
                                            <div>
                                                <div class="pull-left">
                                                    <img class="img-responsive" src="assets/img/sch_logo.jpg" />
                                                </div>
                                                <div>
                                                  <span style="text-align:center; text-decoration:solid; font-size:12px"> <asp:Label ID="lblsch2" Text="" runat="server"></asp:Label></span><br />
                                                   <span style="text-align:center; font-size:9px;"><asp:Label ID="lbladrs2" Text="" runat="server"></asp:Label></span> <br />
                                                    <span style="text-align:center; font-size:9px;"><asp:Label ID="lblbnk2" Text="" runat="server"></asp:Label></span> 
                                                </div>

                                                <table style="font-size:10px" class="no-margin table table-striped">
                                                   <tr>
                                                        <th><span style="background-color:black;color:white">Fee Bill of <asp:Label Text="" runat="server" ID="lblfeebillmnth2"></asp:Label></span>  </th>
                                                        <td><span class="blue">
                                                          <span style="background-color:black; color:white">Issue Date <asp:Label ID="lblissuedt2" Text="" runat="server"></asp:Label></span>
                                                        </span></td>
                                                    </tr>
                                                     <tr>
                                                        <th>Due Date <span class="blue">
                                                            <asp:Label ID="lblduedt2" Text="" runat="server"></asp:Label>
                                                        </span></th>
                                                         <th>Challan # <span class="red">
                                                            <asp:Label ID="lblchallan2" Text="" runat="server"></asp:Label></span></th>
                                                        
                                                    </tr>
                                                    
                                                    
                                                    <tr>
                                                        <th>Admission #</th>
                                                        <td>
                                                            <asp:Label ID="lbladm2" Text="" runat="server"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <th>Student's Name</th>
                                                        <td>
                                                            <asp:Label ID="lblstnm2" Text="" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Father's Name</th>
                                                        <td>
                                                            <asp:Label ID="lblfnm2" Text="" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Class <asp:Label ID="lblcls2" Text="" runat="server"></asp:Label></th>
                                                        <th>Section <asp:Label ID="lblsec2" Text="" runat="server"></asp:Label></th>
                                                       
                                                    </tr>
                                                    
                                                </table>
                                                <table style="font-size:9px" class="no-margin table table-striped">
                                                    <%--<thead>--%>

                                                        <tr>
                                                            <th>Fee</th>
                                                            <td>
                                                                <asp:Label ID="lblfee2" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Annual Fund</th>
                                                            <td>
                                                                <asp:Label ID="Label16" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Admission Fee</th>
                                                            <td>
                                                                <asp:Label ID="Label17" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Arrears</th>
                                                            <td>
                                                                <asp:Label ID="lblfine2" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Payable before Due Date</th>
                                                            <td>
                                                                <asp:Label ID="lblpbddt2" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Late Fee Fine</th>
                                                            <td>
                                                                <asp:Label ID="lbllatefine2" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr>
                                                            <th>Payable After Due Date</th>
                                                            <td>
                                                                <asp:Label ID="lblpaddt2" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Label ID="lbltotfeeinwords2" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    <%--</thead>--%>

                                                </table>
                                                <div class="row">
                                                   <div class="col-xs-12">
                                                                    <asp:GridView ID="gvtermsch" EmptyDataText="No Data Found" ShowHeader="false" class="table table-striped table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nct_id" EnableViewState="true">
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <%# Container.DataItemIndex+1 %>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nct_id" HeaderText="S.NO" SortExpression="nct_id" />
                                                                            <asp:BoundField DataField="strChallanTerms" SortExpression="strChallanTerms" />
                                                                        </Columns>
                                                                         <RowStyle BorderColor="Black" Font-Size="6" />
                                                                    </asp:GridView>
                                                                </div>
                                                    <div class="clearfix"></div>
                                                    <div class="col-sm-4">
                                                           <div id="Div1">

                                                            <asp:TextBox ID="TextBox1" runat="server" Visible="false"></asp:TextBox>
                                                            <asp:Panel ID="Panel1" runat="server">
                                                              
                                                                    <asp:Image ID="Image2" runat="server" Style="height: 43px; width: 130px;" /> 
                                                            
              
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
                                        <div class="col-md-4 col-xs-4">
                                            <div>
                                                <div class="pull-left">
                                                    <img class="img-responsive" src="assets/img/sch_logo.jpg" />
                                                </div>
                                                <div>
                                                  <span style="text-align:center; text-decoration:solid; font-size:12px"> <asp:Label ID="lblsch3" Text="" runat="server"></asp:Label></span><br />
                                                   <span style="text-align:center; font-size:9px;"><asp:Label ID="lbladrs3" Text="" runat="server"></asp:Label></span> <br />
                                                    <span style="text-align:center; font-size:9px;"><asp:Label ID="lblbnk3" Text="" runat="server"></asp:Label></span> 
                                                </div>

                                                <table style="font-size:10px" class="no-margin table table-striped">
                                                   <tr>
                                                        <th><span style="background-color:black;color:white">Fee Bill of <asp:Label Text="" runat="server" ID="lblbilmnth3"></asp:Label></span>  </th>
                                                        <td><span class="blue">
                                                          <span style="background-color:black; color:white">Issue Date <asp:Label ID="lblissuedt3" Text="" runat="server"></asp:Label></span>
                                                        </span></td>
                                                    </tr>
                                                     <tr>
                                                        <th>Due Date <span class="blue">
                                                            <asp:Label ID="lblduedt3" Text="" runat="server"></asp:Label>
                                                        </span></th>
                                                         <th>Challan # <span class="red">
                                                            <asp:Label ID="lblchallan3" Text="" runat="server"></asp:Label></span></th>
                                                        
                                                    </tr>
                                                    
                                                    
                                                    <tr>
                                                        <th>Admission #</th>
                                                        <td>
                                                            <asp:Label ID="lbladmnum3" Text="" runat="server"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <th>Student's Name</th>
                                                        <td>
                                                            <asp:Label ID="lblstnm3" Text="" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Father's Name</th>
                                                        <td>
                                                            <asp:Label ID="lblfnm3" Text="" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Class <asp:Label ID="lblcl3" Text="" runat="server"></asp:Label></th>
                                                        <th>Section <asp:Label ID="lblsec3" Text="" runat="server"></asp:Label></th>
                                                       
                                                    </tr>
                                                    
                                                </table>
                                                <table style="font-size:9px" class="no-margin table table-striped">
                                                    <%--<thead>--%>

                                                        <tr>
                                                            <th>Fee</th>
                                                            <td>
                                                                <asp:Label ID="lblfee3" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Annual Fund</th>
                                                            <td>
                                                                <asp:Label ID="lblannualfnd3" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Admission Fee</th>
                                                            <td>
                                                                <asp:Label ID="lbladissnfee3" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Arrears</th>
                                                            <td>
                                                                <asp:Label ID="lblfeerem3" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Payable before Due Date</th>
                                                            <td>
                                                                <asp:Label ID="lblpbddt3" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Late Fee Fine</th>
                                                            <td>
                                                                <asp:Label ID="lblfeefine3" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr>
                                                            <th>Payable After Due Date</th>
                                                            <td>
                                                                <asp:Label ID="lblpaddt3" Text="" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Label ID="lbltotfeeinwords3" runat="server"></asp:Label>
                                                            </td>
                                                            
                                                        </tr>
                                                    <%--</thead>--%>

                                                </table>
                                                <div class="row">
                                                   
                                                    <div class="col-xs-12">
                                                                    <asp:GridView ID="gvtermbnk" EmptyDataText="No Data Found" ShowHeader="false" class="table table-striped table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nct_id" EnableViewState="true">
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <%# Container.DataItemIndex+1 %>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nct_id" HeaderText="S.NO" SortExpression="nct_id" />
                                                                            <asp:BoundField DataField="strChallanTerms" SortExpression="strChallanTerms"  />
                                                                        </Columns>
                                                                         <RowStyle BorderColor="Black" Font-Size="6" />
                                                                    </asp:GridView>
                                                                </div>
                                                                <div class="clearfix"></div>
                                                    <div class="col-sm-4">
                                                           <div id="Div2">

                                                            <asp:TextBox ID="TextBox2" runat="server" Visible="false"></asp:TextBox>
                                                            <asp:Panel ID="Panel2" runat="server">
                                                              
                                                                    <asp:Image ID="Image3" runat="server" Style="height: 43px; width: 130px;" /> 
                                                            
              
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
