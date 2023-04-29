<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminIssueClassFeeChallan.aspx.cs" Inherits="SchoolPRO.AdminIssueClassFeeChallan" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="DropDownCheckBoxes" Namespace="Saplin.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .modalBackground {
            background-color: white;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .modalPopup h2 {
            color: white;
        }
    </style>
    <script>
        function printDiv(printable) {
            var printContents = document.getElementById(printable).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }


    </script>
    <style>
        .tblstdinfo tr, th, td {
            border: 1px solid black;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-lg-12 col-sm-12 col-xs-12">
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
                        <%--<asp:View ID="View1" runat="server">
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
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </asp:View>--%>
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
                                                            <label class="block clearfix">Months in Single Challan:</label>

                                                            <span class="block input-icon input-icon-right">
                                                                <asp:CheckBox Text="Check for MAX Months in Single Challan" ID="chkmnthchallan" runat="server" />
                                                                <i class="icon-user"></i>
                                                                
                                                            </span>
                                                        </label>
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
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:CheckBox runat="server" Text="Check If Pay Fee For More then one Month " ID="chkmonth" AutoPostBack="true" CssClass="form-control" OnCheckedChanged="chkmonth_CheckedChanged" />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <asp:Label runat="server" ID="month" Visible="false" class="block clearfix">Select Months :</asp:Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:CheckBoxList ID="monthlist" Visible="false" runat="server" DataSourceID="Months" DataTextField="name" DataValueField="nMonth_id">
                                                                </asp:CheckBoxList>

                                                                <asp:SqlDataSource runat="server" ID="Months" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_FeeMonth.nMonth_id, tbl_FeeMonth.strMonthName + '-' + tbl_FeeMonth.strMonthNo AS name, tbl_FeeMonth.strMonthNo FROM tbl_FeeMonth ORDER BY nseq  ASC">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="lblneidd" PropertyName="Text" DefaultValue="0" Name="eid"></asp:ControlParameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <label class="block clearfix">Select Student :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <%--<asp:DropDownList CssClass="form-control" ID="ddst" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddst_SelectedIndexChanged" AppendDataBoundItems="True"></asp:DropDownList>--%>
                                                                <%-- <asp:SqlDataSource runat="server" ID="StudentDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strFname], [strStudentNum] FROM [tbl_Enrollment] WHERE (([nc_id] = (Select nc_id from tbl_Class where strClass= @nc_id and bisDeleted=0)) AND ([nsc_id] = (Select nsc_id from tbl_Section where nc_id=(Select nc_id from tbl_Class where strClass= @nc_id and bisDeleted=0) and bisDeleted=0)) AND ([bisDeleted] = @bisDeleted))">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="ddcl" PropertyName="SelectedValue" DefaultValue="0" Name="nc_id" ></asp:ControlParameter>
                                                                        <asp:ControlParameter ControlID="ddsec" PropertyName="SelectedValue" DefaultValue="0" Name="nsc_id" ></asp:ControlParameter>
                                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>--%>
                                                                <cc1:DropDownCheckBoxes CssClass="form-control" UseSelectAllNode="True" ID="ddst" runat="server" AppendDataBoundItems="True"></cc1:DropDownCheckBoxes>
                                                                <cc1:ExtendedRequiredFieldValidator ID="ExtendedRequiredFieldValidator1" runat="server" ControlToValidate="ddst" ErrorMessage="Required" ForeColor="Red"></cc1:ExtendedRequiredFieldValidator>

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

                                                        <label class="hidden block clearfix">
                                                            <label class="block clearfix">Student Number :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtstnum" ReadOnly="true" class="form-control" placeholder="Student Number" runat="server" OnTextChanged="txtstnum_TextChanged"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>


                                                        <label class="hidden block clearfix">
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
                                                        <label class="hidden hidden block clearfix">
                                                            <label class="block clearfix">Student Name :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtnm" ReadOnly="true" class="form-control" placeholder="Name" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="hidden block clearfix">
                                                            <label class="block clearfix">Fee Due Date :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtDueDate" ReadOnly="true" class="form-control" placeholder="Due Date " runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="hidden block clearfix">
                                                            <label class="block clearfix">Fee Fine :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtFine" ReadOnly="true" class="form-control" placeholder="Fine" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="hidden block clearfix">
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
                                                        <label class="hidden block clearfix">
                                                            <label class="block clearfix">Remaining Dues :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtRemnfee" ReadOnly="true" class="form-control" placeholder="Student Remaining Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="hidden block clearfix">
                                                            <label class="block clearfix">Concession Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ReadOnly="true" ID="txtfeecons" AutoPostBack="true" class="form-control" placeholder="Student Concession Fee" runat="server" OnTextChanged="txtfeecons_TextChanged"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="hidden block clearfix">
                                                            <label class="block clearfix">Total Fee :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtTotfee" ReadOnly="true" class="form-control" placeholder="Student Total  Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="hidden block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:CheckBox CssClass="hidden" runat="server" Text="Check If Any Concession " ID="chkfeecons" AutoPostBack="true" OnCheckedChanged="chkfeecons_CheckedChanged" />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>

                                                        <label class="hidden block clearfix">
                                                            <label class="block clearfix">Enter Receive :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtRcvfee" AutoPostBack="true" class="form-control" placeholder="Student receive  fee" runat="server" OnTextChanged="txtRcvfee_TextChanged"></asp:TextBox>
                                                                <%--<asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator1" ErrorMessage=" (digits only)" ValidationExpression="^\d+$" ControlToValidate="txtRcvfee" runat="server" />--%>
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
                                                        <asp:Image ID="img" runat="server" />
                                                        <div class="clearfix">
                                                            <asp:Button ID="btnrcv" runat="server" Text="Enter and Print" class="hidden width-30 pull-right btn btn-sm btn-success" OnClick="btnrcv_Click" />
                                                            <asp:Button ID="btnPaid" runat="server" UseSubmitBehavior="false" Text="Fee Received and Print" class="width-30 pull-Left btn btn-sm btn-success" OnClick="btnPaid_Click" />
                                                        </div>

                                                    </fieldset>
                                                </form>
                                                <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="pnl1" TargetControlID="btnPaid"
                            CancelControlID="btnClose" BackgroundCssClass="modalBackground">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="pnl1" runat="server" CssClass="modalPopup" align="center" Style="display: none">
                            <img src="assets/images/loader.gif" />
                            <br />
                            <asp:HiddenField ID="btnClose" runat="server" />
                        </asp:Panel>
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
                            
          
                        </asp:View>
                        <asp:View ID="View5" runat="server">
                            
                                <div id="printable1">
                                    <asp:Repeater OnItemDataBound="rpt_ItemDataBound" runat="server" ID="rpt">
                                        <ItemTemplate>
                                            
                                            <div class="no-margin row">
                                                <div class="col-lg-12 col-xs-12">
                                                    <div class="col-md-4 col-xs-4">
                                                        <div>
                                                            <div class="pull-left">
                                                                <img class="img-responsive" src="assets/img/sch_logo.jpeg" />
                                                            </div>
                                                            <%--<div class="pull-right">
                                                                <img class="img-responsive" width="50" height="50" src="assets/img/bop.png" />
                                                            </div>--%>
                                                            <div>
                                                                <span style="font-size: 14px; text-align: center; font: bold">
                                                                    <asp:Label ID="Label33" Text='<%# Eval("strSchName") %>' runat="server"></asp:Label></span><br />
                                                                <span style="font-size: 10px; text-align: center; font: bold">
                                                                    <asp:Label ID="Label38" Text='<%# Eval("strAddress") %>' runat="server"></asp:Label></span>
                                                                
                                                                <span class="label label-sm label-primary arrowed arrowed-right">
                                                                    <asp:Label ID="lblaccnum1" Text="" runat="server"></asp:Label></span>
                                                            </div>

                                                            <table style="font-size: 10px" class="no-margin tblstdinfo table table-striped">
                                                                <tr >
                                                                    <th><span class="label-holder">
                                                                        <span class="h6">Fee Bill of
                                                                       <u> <asp:Label CssClass="h4" Text='<%# Eval("strMonths") %>' runat="server" ID="lblfeemonth"></asp:Label></u></span> </span></th>
                                                                    <td><span class="label-holder">
                                                                        <span class="label label-info arrowed h6">Issue Date
                                                                            <asp:Label ID="txtdate1" Text='<%# Eval("dtAddDate") %>' runat="server"></asp:Label></span>
                                                                    </span></td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="label label-danger">
                                                                        <span class="h5">Due Date 
                                                                            <asp:Label CssClass="h5" ID="Label22" Text='<%#  Eval("dtDueDate")+"-"+Eval("strFeeMonth").ToString().Substring(3,2)+"-"+DateTime.Now.Year.ToString() %>' runat="server"></asp:Label></span>
                                                                    </span></th>
                                                                    <th><span class="label label-danger">
                                                                        <span class="h5">Challan #
                                                                            <asp:Label ID="txtinv1" Text='<%# Eval("nChallanNum") %>' runat="server"></asp:Label></span> </span></th>

                                                                </tr>
                                                                </table>
                                                            <table style="font-size: 10px" class="no-margin tblstdinfo table table-striped">
                                                                <tr>
                                                                    <th><span class="h6">Admission #</span></th>
                                                                    <td>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="txtreg1" Text='<%# Eval("bRegisteredNum") %>' runat="server"></asp:Label></b></span></td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Student's Name</span></th>
                                                                    <td>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="txtname1" Text='<%# Eval("Name") %>' runat="server"></asp:Label></b></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Father's Name</span></th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="txtfname1" Text='<%# Eval("FatherName") %>' runat="server"></asp:Label></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><%--<span class="h6">Class</span>--%>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="txtcls1" Text='<%# Eval("strClass") %>' runat="server"></asp:Label></b></span></th>
                                                                    <th><%--<span class="h6">Section</span>--%>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="txtsec1" Text='<%# Eval("strSection") %>' runat="server"></asp:Label></b></span></th>

                                                                </tr>

                                                            </table>
                                                            <table style="font-size: 9px;" class="no-margin table table-striped">
                                                                <%--<thead style="font-size:9px">--%>

                                                                <tr>
                                                                    <th><span class="h6">Tution Fee</span></th>
                                                                    <td>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="txtstFee1" Text='<%# Eval("strTutionFee") %>' runat="server"></asp:Label></b></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Annual Fund</span></th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="Label1" Text="" runat="server"></asp:Label></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Concession</span></th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="conc1" Text='<%#Eval("strFeeConcession") %>' runat="server"></asp:Label></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Arrears</span>
                                                                        <asp:Label Text="" ID="lblarearmnth1" runat="server" />
                                                                    </th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="lblArrears0" Text="" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Payable before Due Date</span></th>
                                                                    <td>
                                                                        <span class="label label-success arrowed"><b>
                                                                            <asp:Label ID="lblpbddt1" Text='<%# Convert.ToInt32(Eval("strFeeAmount")) %>' runat="server"></asp:Label></b></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Late Fee Fine</span></th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="txtstFine1" Text='<%# Eval("nFine") %>' runat="server"></asp:Label></span>
                                                                    </td>
                                                                </tr>

                                                                <%--<tr>
                                                                    <th><span class="h6">Payable After Due Date</span></th>
                                                                    <td>
                                                                        <span class="label label-success arrowed"><b>
                                                                            <asp:Label ID="lblpaddt" Text='<%# Convert.ToInt32(Eval("nFine")) + Convert.ToInt32(Eval("strFeeAmount"))  %>' runat="server"></asp:Label></b></span>
                                                                    </td>
                                                                </tr>--%>

                                                                <tr>
                                                                    <td colspan="2">
                                                                        <span class="label-holder">
                                                                            <span class="label label-info arrowed">
                                                                                <asp:Label ID="lbltotfeeinwords1" runat="server"></asp:Label></span></span>
                                                                    </td>
                                                                </tr>
                                                                <%--</thead>--%>
                                                            </table>
                                                            <div class="row">

                                                                <div class="col-xs-12">
                                                                    <asp:GridView ID="gvtermstd" EmptyDataText="No Data Found" class="no-margin table table-striped table-hover" runat="server" AllowPaging="True" ShowHeader="false" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nct_id" EnableViewState="true">
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <%# Container.DataItemIndex+1 %>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nct_id" HeaderText="S.NO" SortExpression="nct_id" />
                                                                            <asp:BoundField DataField="strChallanTerms" SortExpression="strChallanTerms" />
                                                                        </Columns>
                                                                        <RowStyle BorderColor="Black" Font-Size="7" />
                                                                    </asp:GridView>
                                                                </div>
                                                                </div>
                                                            <div class="no-margin row">
                                                                <div class="col-sm-4 col-xs-4">
                                                                    <div id="stdbarcode">

                                                                        <asp:TextBox ID="getCodetxt" runat="server" Visible="false"></asp:TextBox>
                                                                        <asp:Panel ID="pnlPrint" runat="server">

                                                                            <asp:Image ID="img" ImageUrl='<%# Eval("imgChallanBcode") %>' runat="server"  />


                                                                        </asp:Panel>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-4 col-xs-4">
                                                                    <h6 class="pull-right">Student Copy
																
                                                                    </h6>
                                                                    
                                                                </div>
                                                            </div>
                                                            <div class="no-margin row">
                                                            <%--<div class="col-lg-offset-2 col-xs-offset-4 col-md-offset-4" >--%>
                                                                <asp:Panel ID="Panel3" runat="server">
                                                             <span  class="label label-sm label-primary arrowed arrowed-right">
                                                                Powered By Heaven Technologies | 051-4853801
                                                            </span>
                                                                    </asp:Panel>
                                                                <%--</div>--%>
                                                                </div>
                                                        </div>
                                                       
                                                    </div>
                                                    <div class="col-md-4 col-xs-4">
                                                        <div>
                                                            <div class="pull-left">
                                                                <img class="img-responsive" src="assets/img/sch_logo.jpeg" />
                                                            </div>
                                                            <%--<div class="pull-right">
                                                                <img class="img-responsive" width="50" height="50" src="assets/img/bop.png" />
                                                            </div>--%>
                                                            <div>
                                                                <span style="font-size: 14px; text-align: center; font: bold">
                                                                    <asp:Label ID="Label4" Text='<%# Eval("strSchName") %>' runat="server"></asp:Label></span><br />
                                                                <span style="font-size: 10px; text-align: center; font: bold">
                                                                    <asp:Label ID="Label32" Text='<%# Eval("strAddress") %>' runat="server"></asp:Label></span>
                                                                
                                                                <span class="label label-sm label-primary arrowed arrowed-right">
                                                                    <asp:Label ID="lblaccnum2" Text="" runat="server"></asp:Label></span>
                                                            </div>

                                                            <table style="font-size: 10px" class="no-margin table table-striped">
                                                                <tr>
                                                                    <th><span class="label-holder">
                                                                        <span class="h6">Fee Bill of
                                                                        <u><asp:Label CssClass="h4" Text='<%# Eval("strMonths") %>' runat="server" ID="Label5"></asp:Label></u></span></span>  </th>
                                                                    <td><span class="label-holder">
                                                                        <span class="label label-info arrowed h6">Issue Date
                                                                            <asp:Label ID="Label6" Text='<%# Eval("dtAddDate") %>' runat="server"></asp:Label></span>
                                                                    </span></td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="label label-danger">
                                                                        <span class="h5">Due Date
                                                                            <asp:Label CssClass="h5" ID="Label7" Text='<%# Eval("dtDueDate")+"-"+Eval("strFeeMonth").ToString().Substring(3,2)+"-"+DateTime.Now.Year.ToString() %>' runat="server"></asp:Label></span>
                                                                    </span></th>
                                                                    <th><span class="label label-danger">
                                                                        <span class="h5">Challan # 
                                                                        <asp:Label ID="Label8" Text='<%# Eval("nChallanNum") %>' runat="server"></asp:Label></span></span> </th>

                                                                </tr>
                                                                </table>
                                                            <table style="font-size: 10px" class="no-margin tblstdinfo table table-striped">

                                                                <tr>
                                                                    <th><span class="h6">Admission #</span></th>
                                                                    <td>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="Label9" Text='<%# Eval("bRegisteredNum") %>' runat="server"></asp:Label></b></span></td>
                                                                </tr>
                                                                 
                                                                <tr>
                                                                    <th><span class="h6">Student's Name</span></th>
                                                                    <td>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="Label10" Text='<%# Eval("Name") %>' runat="server"></asp:Label></b></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Father's Name</span></th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="Label11" Text='<%# Eval("FatherName") %>' runat="server"></asp:Label></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><%--<span class="h6">Class</span>--%>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="Label12" Text='<%# Eval("strClass") %>' runat="server"></asp:Label></b></span></th>
                                                                    <th><%--<span class="h6">Section</span>--%>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="Label13" Text='<%# Eval("strSection") %>' runat="server"></asp:Label></b></span></th>

                                                                </tr>

                                                            </table>
                                                            <table style="font-size: 9px" class="no-margin table table-striped">
                                                                <%--<thead style="font-size:9px">--%>

                                                                <tr>
                                                                    <th><span class="h6">Tution Fee</span></th>
                                                                    <td>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="Label15" Text='<%# Eval("strTutionFee") %>' runat="server"></asp:Label></b></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Annual Fund</span></th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="Label16" Text="" runat="server"></asp:Label></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Concession</span></th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="conc2" Text='<%#Eval("strFeeConcession") %>' runat="server"></asp:Label></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Arrears</span>
                                                                        <asp:Label Text="" ID="lblarearmnth2" runat="server" />
                                                                    </th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="lblArrears1" Text="" runat="server"></asp:Label></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Payable before Due Date</span></th>
                                                                    <td>
                                                                        <span class="label label-success arrowed"><b>
                                                                            <asp:Label ID="lblfeeamnt2" Text='<%# Convert.ToInt32(Eval("strFeeAmount"))  %>' runat="server"></asp:Label></b> </span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Late Fee Fine</span></th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="Label21" Text='<%# Eval("nFine") %>' runat="server"></asp:Label></span>
                                                                    </td>
                                                                </tr>

                                                                <%--<tr>
                                                                    <th><span class="h6">Payable After Due Date</span></th>
                                                                    <td>
                                                                        <span class="label label-success arrowed"><b>
                                                                            <asp:Label ID="Label41" Text='<%# Convert.ToInt32(Eval("nFine")) + Convert.ToInt32(Eval("strFeeAmount")) %>' runat="server"></asp:Label></b></span>
                                                                    </td>
                                                                </tr>--%>

                                                                <tr>
                                                                    <td colspan="2">
                                                                        <span class="label-holder">
                                                                            <span class="label label-info arrowed">
                                                                                <asp:Label ID="lbltotfeeinwords2" runat="server"></asp:Label></span></span>
                                                                    </td>
                                                                </tr>
                                                                <%--</thead>--%>
                                                            </table>
                                                            <div class="row">
                                                                <div class="col-xs-12">
                                                                    <asp:GridView ID="gvtermsch" EmptyDataText="No Data Found" ShowHeader="false" class="no-margin table table-striped table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nct_id" EnableViewState="true">
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <%# Container.DataItemIndex+1 %>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nct_id" HeaderText="S.NO" SortExpression="nct_id" />
                                                                            <asp:BoundField DataField="strChallanTerms" SortExpression="strChallanTerms" />
                                                                        </Columns>
                                                                        <RowStyle BorderColor="Black" Font-Size="7" />
                                                                    </asp:GridView>
                                                                </div>
                                                                </div>
                                                            <div class="no-margin row">
                                                                <div class="col-xs-4 col-sm-4">
                                                                    <div id="Div1">

                                                                        <asp:TextBox ID="TextBox1" runat="server" Visible="false"></asp:TextBox>
                                                                        <asp:Panel ID="Panel1" runat="server">

                                                                            <asp:Image ID="Image1" ImageUrl='<%# Eval("imgChallanBcode") %>' runat="server"  />


                                                                        </asp:Panel>
                                                                    </div>
                                                                </div>
                                                                <div class="col-xs-4 col-sm-4">
                                                                    <h6 class="pull-right">School Copy
																
                                                                    </h6>
                                                                    
                                                                </div>
                                                            </div>
                                                            <div class="no-margin row">
                                                            <%--<div class="col-lg-offset-2 col-xs-offset-4 col-md-offset-4" >--%>
                                                                <asp:Panel ID="Panel4" runat="server">
                                                             <span  class="label label-sm label-primary arrowed arrowed-right">
                                                                Powered By Heaven Technologies | 051-4853801
                                                            </span>
                                                                    </asp:Panel>
                                                                <%--</div>--%>
                                                                </div>
                                                        </div>
                                                        
                                                    </div>
                                                    <div class="col-md-4 col-xs-4">
                                                        <div>
                                                            <div class="pull-left">
                                                                <img class="img-responsive" src="assets/img/sch_logo.jpeg" />
                                                            </div>
                                                            <%--<div class="pull-right">
                                                                <img class="img-responsive" width="50" height="50" src="assets/img/bop.png" />
                                                            </div>--%>
                                                            <div>
                                                                <span style="font-size: 14px; text-align: center; font: bold">
                                                                    <asp:Label ID="Label19" Text='<%# Eval("strSchName") %>' runat="server"></asp:Label></span><br />
                                                                <span style="font-size: 10px; text-align: center; font: bold">
                                                                    <asp:Label ID="Label23" Text='<%# Eval("strAddress") %>' runat="server"></asp:Label></span>
                                                                
                                                                <span class="label label-sm label-primary arrowed arrowed-right">
                                                                    <asp:Label ID="lblaccnum3" Text="" runat="server"></asp:Label></span>
                                                            </div>

                                                            <table style="font-size: 10px" class="no-margin table table-striped">
                                                                <tr>
                                                                    <th><span class="label-holder">
                                                                        <span class="h6">Fee Bill of
                                                                       <u> <asp:Label CssClass="h4" Text='<%# Eval("strMonths") %>' runat="server" ID="Label14"></asp:Label></u></span></span>  </th>
                                                                    <td><span class="label-holder">
                                                                        <span class="label label-info arrowed h6">Issue Date
                                                                            <asp:Label ID="Label24" Text='<%# Eval("dtAddDate") %>' runat="server"></asp:Label></span>
                                                                    </span></td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="label label-danger">
                                                                        <span class="h5">Due Date
                                                                        <asp:Label CssClass="h5" ID="Label25" Text='<%# Eval("dtDueDate")+"-"+ Eval("strFeeMonth").ToString().Substring(3,2) +"-"+DateTime.Now.Year.ToString() %>' runat="server"></asp:Label></span>
                                                                    </span></th>
                                                                    <th><span class="label label-danger">
                                                                        <span class="h5">Challan # 
                                                                        <asp:Label ID="Label26" Text='<%# Eval("nChallanNum") %>' runat="server"></asp:Label></span></span> </th>

                                                                </tr>

                                                                </table>
                                                            <table style="font-size: 10px" class="no-margin tblstdinfo table table-striped">
                                                                <tr>
                                                                    <th><span class="h6">Admission #</span> </th>
                                                                    <td>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="Label27" Text='<%# Eval("bRegisteredNum") %>' runat="server"></asp:Label></b></span> </td>
                                                                </tr>
                                                                 
                                                                <tr>
                                                                    <th><span class="h6">Student's Name</span></th>
                                                                    <td>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="Label28" Text='<%# Eval("Name") %>' runat="server"> </asp:Label></b></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Father's Name</span></th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="Label29" Text='<%# Eval("FatherName") %>' runat="server"></asp:Label></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><%--<span class="h6">Class</span>--%>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="Label30" Text='<%# Eval("strClass") %>' runat="server"></asp:Label></b></span></th>
                                                                    <th><%--<span class="h6">Section</span>--%>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="Label31" Text='<%# Eval("strSection") %>' runat="server"></asp:Label></b></span></th>

                                                                </tr>

                                                            </table>
                                                            <table style="font-size: 9px" class="no-margin table table-striped">
                                                                <%--<thead style="font-size:9px; border:1px solid black" >--%>

                                                                <tr >
                                                                    <th><span class="h6">Tution Fee</span></th>
                                                                    <td>
                                                                        <span class="h6"><b>
                                                                            <asp:Label ID="lbltfee2" Text='<%# Eval("strTutionFee") %>' runat="server"></asp:Label></b></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Annual Fund</span></th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="Label35" Text="" runat="server"></asp:Label></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Concession</span></th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="lblcon3" Text='<%#Eval("strFeeConcession") %>' runat="server"></asp:Label></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Arrears</span>
                                                                        <asp:Label Text="" ID="lblarearmnth3" runat="server" />
                                                                    </th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="lblArrears2" Text="" runat="server"></asp:Label></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Payable before Due Date</span></th>
                                                                    <td>
                                                                        <span class="label label-success arrowed"><b>
                                                                            <asp:Label ID="lblfeeamnt3" Text='<%# Convert.ToInt32(Eval("strFeeAmount")) %>' runat="server"></asp:Label></b></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th><span class="h6">Late Fee Fine</span></th>
                                                                    <td>
                                                                        <span class="h6">
                                                                            <asp:Label ID="Label40" Text='<%# Eval("nFine") %>' runat="server"></asp:Label></span>
                                                                    </td>
                                                                </tr>

                                                                <%--<tr>
                                                                    <th><span class="h6">Payable After Due Date</span></th>
                                                                    <td>
                                                                        <span class="label label-success arrowed"><b>
                                                                            <asp:Label ID="Label42" Text='<%# Convert.ToInt32(Eval("nFine")) + Convert.ToInt32(Eval("strFeeAmount")) %>' runat="server"></asp:Label></b></span>
                                                                    </td>
                                                                </tr>--%>

                                                                <tr>
                                                                    <td colspan="2">
                                                                        <span class="label-holder">
                                                                            <span class="label label-info arrowed">
                                                                                <asp:Label ID="lbltotfeeinwords3" runat="server"></asp:Label></span></span>
                                                                    </td>

                                                                </tr>
                                                                <%--</thead>--%>
                                                            </table>
                                                            <div class="row">

                                                                <div class="col-xs-12">
                                                                    <asp:GridView ID="gvtermbnk" EmptyDataText="No Data Found" ShowHeader="false" class="no-margin table table-striped table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nct_id" EnableViewState="true">
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <%# Container.DataItemIndex+1 %>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nct_id" HeaderText="S.NO" SortExpression="nct_id" />
                                                                            <asp:BoundField DataField="strChallanTerms" SortExpression="strChallanTerms" />
                                                                        </Columns>
                                                                        <RowStyle BorderColor="Black" Font-Size="7" />
                                                                    </asp:GridView>
                                                                </div>
                                                                </div>
                                                            <div class="no-margin row">
                                                                <div class="col-xs-4 col-sm-4">
                                                                    <div id="Div2">

                                                                        <asp:TextBox ID="TextBox2" runat="server" Visible="false"></asp:TextBox>
                                                                        <asp:Panel ID="Panel2" runat="server">

                                                                            <asp:Image ID="Image2" ImageUrl='<%# Eval("imgChallanBcode") %>' runat="server" />


                                                                        </asp:Panel>
                                                                    </div>
                                                                </div>
                                                                <div class="col-xs-4 col-sm-4">
                                                                    <h6 class="pull-right">Account Copy
																
                                                                    </h6>
                                                                    
                                                                </div>
                                                            </div>
                                                            <div class="no-margin row">
                                                            <%--<div class="col-lg-offset-2 col-xs-offset-4 col-md-offset-4" >--%>
                                                                <asp:Panel ID="Panel5" runat="server">
                                                             <span  class="label label-sm label-primary arrowed arrowed-right">
                                                                Powered By Heaven Technologies | 051-4853801
                                                            </span>
                                                                    </asp:Panel>
                                                                <%--</div>--%>
                                                                </div>

                                                        </div>
                                                         
                                                    </div>


                                                </div>

                                            </div>
                                               <%--<br />--%>
                                            <asp:Label Text='<%#Eval("nChallanNum") %>' Visible="false" ID="lblchlnum" runat="server" />
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <div class="visible-print clearfix">
                                <div class="table-responsive">
                                    <asp:GridView OnRowDataBound="gvsearchclass_RowDataBound" ID="gvsearchclass" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Exists" ShowFooter="true" ShowHeader="true" class="table table-striped table-bordered table-hover" runat="server" AllowSorting="True" AutoGenerateColumns="False">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.NO">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="bRegisteredNum" SortExpression="bRegisteredNum" HeaderText="Addmission No." />
                                            <asp:BoundField DataField="Name" SortExpression="Name" HeaderText="Student Name" />
                                            <asp:TemplateField HeaderText="Arrears">
                                                <ItemTemplate>
                                                    <asp:Label Text="" ID="lblarears" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="nFine" HeaderText="Late Fee Fine" SortExpression="nFine" />
                                            <asp:BoundField DataField="strFeeConcession" HeaderText="Concession" SortExpression="strFeeConcession" />
                                            <asp:BoundField DataField="strTutionFee" HeaderText="Class Fee" SortExpression="strTutionFee" />
                                            <asp:TemplateField HeaderText="Payable Before Due Date">
                                                <ItemTemplate>
                                                    <asp:Label Text='<%#Eval("strFeeAmount") %>' ID="lblpbddt" runat="server" />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label Text="" ID="lbltotalfeepending" runat="server" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Payable After Due Date">
                                                <ItemTemplate>
                                                    <asp:Label Text="" ID="lblpaddt" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Amount Received">
                                                <ItemTemplate>
                                                    <asp:Label Text='<%#Eval("strFeeAmountReceived") %>' ID="lblamntrcvd" runat="server" />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label Text="" ID="lbltrcvd" runat="server" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                                 </div>
                                <asp:Button class="width-30 pull-right btn btn-sm btn-success" Text="Print" OnClientClick="printDiv('printable1')" ID="btnprint" OnClick="btnprint_Click" runat="server" />
                                <%--<label class="width-30 pull-right btn btn-sm btn-success" onclick="printDiv('printable1')">Print</label>--%>
                           
                            
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
