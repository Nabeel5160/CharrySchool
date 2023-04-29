<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDuplicateChalanForm.aspx.cs" Inherits="SchoolPRO.AdminDuplicateChalanForm" %>

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
    <style>
        .tblstdinfo tr, th, td {
            border: 1px solid black;
        }
    </style>
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
                            
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Duplicate Challan
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Details : </p>
                                                    <form id="Form2">
                                                        <fieldset>


                                                              <label class="block clearfix">
                                                             <Label class="block clearfix">Select Account :</Label>
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
                                                             <Label class="block clearfix">Search Student or Challan # :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                 <asp:TextBox ID="txtsearch" Style="margin-bottom: 10px" runat="server" type="text" class="form-control" AutoPostBack="true" OnTextChanged="txtsearch_TextChanged" placeholder="Search By Addmission Id. . . " />
                                                                <asp:TextBox ID="txtchnm" Style="margin-bottom: 10px" runat="server" type="text" class="form-control" AutoPostBack="true" OnTextChanged="txtsearch_TextChanged" placeholder="Search By Challan #. . . " />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                            <label class="block clearfix">
                                                             <Label class="block clearfix">Student Name:<asp:Label Text="" ID="lblname" runat="server"></asp:Label> Current Fee: <asp:Label Text=""  ID="lblfee" runat="server" /> </Label>
                                                            <%--<span class="block input-icon input-icon-right">
                                                                 <asp:TextBox ID="TextBox3" Style="margin-bottom: 10px" runat="server" type="text" class="form-control" AutoPostBack="true" OnTextChanged="txtsearch_TextChanged" placeholder="Search By Addmission Id. . . " />
                                                                <i class="icon-user"></i>
                                                            </span>--%>
                                                        </label>
                                                             <label class="block clearfix">
                                                             <Label class="block clearfix">Check Your Option:</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:CheckBox  ID="chknewfee" Text="Check for Fee" OnCheckedChanged="chknewfee_CheckedChanged" AutoPostBack="true" runat="server"/>
                                                                <asp:CheckBox ID="chkifconces" Text="Check for Concession" OnCheckedChanged="chkifconces_CheckedChanged" AutoPostBack="true" runat="server" />
                                                            </span>
                                                        </label>
                                                             <label class="block clearfix">
                                                             <Label class="block clearfix">Enter New Fee:</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                 <asp:TextBox ID="txtnewfee" Style="margin-bottom: 10px" runat="server" ReadOnly="true" type="text" class="form-control" placeholder="Enter New Fee.... " />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>


                                                          

                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button CssClass="hidden-print btn btn-success" ID="btnGenerate" Text="Click Here To Generate Chalan" runat="server" OnClick="btnGenerate_Click" />
                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </asp:View>
                            <asp:View ID="View1" runat="server">
                                <div class="container">
                                    <div id="printable1">
                                        <asp:Repeater runat="server" OnItemDataBound="rpt_ItemDataBound" ID="rpt">
                                            <ItemTemplate>


                                                <div class="row">
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
                                                                    <br />
                                                                    <span class="label label-sm label-primary arrowed arrowed-right">
                                                                        <asp:Label ID="lblaccnum1" Text="" runat="server"></asp:Label></span>
                                                                </div>

                                                                <table style="font-size: 10px" class="no-margin tblstdinfo table table-striped">
                                                                    <tr>
                                                                        <th><span class="label-holder">
                                                                        <span class="h6">Fee Bill of
                                                                        <asp:Label CssClass="h3" Text='<%# Eval("strMonths") %>' runat="server" ID="lblfeemonth"></asp:Label></span> </span></th>
                                                                    <td><span class="label-holder">
                                                                            <span class="label label-info arrowed h6">Issue Date
                                                                            <asp:Label ID="txtdate1" Text='<%# Eval("dtAddDate") %>' runat="server"></asp:Label></span>
                                                                        </span></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th><span class="label label-danger">
                                                                            <span class="h5">Due Date 
                                                                                <asp:Label ID="Label22" Text='<%#  Eval("dtDueDate")+"-"+Eval("strFeeMonth").ToString().Substring(3,2)+"-"+DateTime.Now.Year.ToString() %>' runat="server"></asp:Label></span>
                                                                        </span></th>
                                                                        <th><span class="label label-danger">
                                                                            <span class="h5">Challan #
                                                                                <asp:Label ID="txtinv1" Text='<%# Eval("nChallanNum") %>' runat="server"></asp:Label></span> </span></th>

                                                                    </tr>


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
                                                                        <th><span class="h6">Class</span>
                                                                            <span class="h6"><b>
                                                                                <asp:Label ID="txtcls1" Text='<%# Eval("strClass") %>' runat="server"></asp:Label></b></span></th>
                                                                        <th><span class="h6">Section</span>
                                                                            <span class="h6"><b>
                                                                                <asp:Label ID="txtsec1" Text='<%# Eval("strSection") %>' runat="server"></asp:Label></b></span></th>

                                                                    </tr>

                                                                </table>
                                                                <table style="font-size: 9px;" class="no-margin table table-striped">
                                                                    <%--<thead style="font-size:9px">--%>

                                                                    <tr>
                                                                        <th><span class="h6">Fee</span></th>
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
                                                                                <asp:Label ID="lblcon0" Text='<%#Eval("strFeeConcession") %>' runat="server"></asp:Label></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th><span class="h6">Arrears</span></th>
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

                                                                   <%-- <tr>
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
                                                                        <asp:GridView ID="gvtermstd" EmptyDataText="No Data Found" class="table table-striped table-hover" runat="server" AllowPaging="True" ShowHeader="false" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nct_id" EnableViewState="true">
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
                                                                    <div class="clearfix"></div>
                                                                    <div class="col-sm-4">
                                                                        <div id="stdbarcode">

                                                                            <asp:TextBox ID="getCodetxt" runat="server" Visible="false"></asp:TextBox>
                                                                            <asp:Panel ID="pnlPrint" runat="server">

                                                                                <asp:Image ID="img" ImageUrl='<%# Eval("imgChallanBcode") %>' runat="server" Style="height: 43px; width: 130px;" />


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
                                                                    <br />
                                                                    <span class="label label-sm label-primary arrowed arrowed-right">
                                                                        <asp:Label ID="lblaccnum2" Text="" runat="server"></asp:Label></span>
                                                                </div>

                                                                <table style="font-size: 10px" class="no-margin table table-striped">
                                                                    <tr>
                                                                        <th><span class="label-holder">
                                                                            <span class="h6">Fee Bill of
                                                                        <asp:Label CssClass="h3" Text='<%# Eval("strMonths") %>' runat="server" ID="Label5"></asp:Label></span></span>  </th>
                                                                        <td><span class="label-holder">
                                                                            <span class="label label-info arrowed h6">Issue Date
                                                                            <asp:Label ID="Label6" Text='<%# Eval("dtAddDate") %>' runat="server"></asp:Label></span>
                                                                        </span></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th><span class="label label-danger">
                                                                            <span class="h5">Due Date
                                                                                <asp:Label ID="Label7" Text='<%# Eval("dtDueDate")+"-"+Eval("strFeeMonth").ToString().Substring(3,2)+"-"+DateTime.Now.Year.ToString() %>' runat="server"></asp:Label></span>
                                                                        </span></th>
                                                                        <th><span class="label label-danger">
                                                                            <span class="h5">Challan # 
                                                                        <asp:Label ID="Label8" Text='<%# Eval("nChallanNum") %>' runat="server"></asp:Label></span></span> </th>

                                                                    </tr>


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
                                                                        <th><span class="h6">Class</span>
                                                                            <span class="h6"><b>
                                                                                <asp:Label ID="Label12" Text='<%# Eval("strClass") %>' runat="server"></asp:Label></b></span></th>
                                                                        <th><span class="h6">Section</span>
                                                                            <span class="h6"><b>
                                                                                <asp:Label ID="Label13" Text='<%# Eval("strSection") %>' runat="server"></asp:Label></b></span></th>

                                                                    </tr>

                                                                </table>
                                                                <table style="font-size: 9px" class="no-margin table table-striped">
                                                                    <%--<thead style="font-size:9px">--%>

                                                                    <tr>
                                                                        <th><span class="h6">Fee</span></th>
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
                                                                                <asp:Label ID="lblcon1" Text='<%#Eval("strFeeConcession") %>' runat="server"></asp:Label></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th><span class="h6">Arrears</span></th>
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

                                                                   <%-- <tr>
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
                                                                            <RowStyle BorderColor="Black" Font-Size="7" />
                                                                        </asp:GridView>
                                                                    </div>
                                                                    <div class="clearfix"></div>
                                                                    <div class="col-sm-4">
                                                                        <div id="Div1">

                                                                            <asp:TextBox ID="TextBox1" runat="server" Visible="false"></asp:TextBox>
                                                                            <asp:Panel ID="Panel1" runat="server">

                                                                                <asp:Image ID="Image1" ImageUrl='<%# Eval("imgChallanBcode") %>' runat="server" Style="height: 43px; width: 130px;" />


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
                                                                    <br />
                                                                    <span class="label label-sm label-primary arrowed arrowed-right">
                                                                        <asp:Label ID="lblaccnum3" Text="" runat="server"></asp:Label></span>
                                                                </div>

                                                                <table style="font-size: 10px" class="no-margin table table-striped">
                                                                    <tr>
                                                                        <th><span class="label-holder">
                                                                            <span class="h6">Fee Bill of
                                                                        <asp:Label CssClass="h3" Text='<%# Eval("strMonths") %>' runat="server" ID="Label14"></asp:Label></span></span>  </th>
                                                                        <td><span class="label-holder">
                                                                            <span class="label label-info arrowed h6">Issue Date
                                                                            <asp:Label ID="Label24" Text='<%# Eval("dtAddDate") %>' runat="server"></asp:Label></span>
                                                                        </span></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th><span class="label label-danger">
                                                                            <span class="h5">Due Date
                                                                        <asp:Label ID="Label25" Text='<%# Eval("dtDueDate")+"-"+Eval("strFeeMonth").ToString().Substring(3,2)+"-"+DateTime.Now.Year.ToString() %>' runat="server"></asp:Label></span>
                                                                        </span></th>
                                                                        <th><span class="label label-danger">
                                                                            <span class="h5">Challan # 
                                                                        <asp:Label ID="Label26" Text='<%# Eval("nChallanNum") %>' runat="server"></asp:Label></span></span> </th>

                                                                    </tr>


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
                                                                        <th><span class="h6">Class</span>
                                                                            <span class="h6"><b>
                                                                                <asp:Label ID="Label30" Text='<%# Eval("strClass") %>' runat="server"></asp:Label></b></span></th>
                                                                        <th><span class="h6">Section</span>
                                                                            <span class="h6"><b>
                                                                                <asp:Label ID="Label31" Text='<%# Eval("strSection") %>' runat="server"></asp:Label></b></span></th>

                                                                    </tr>

                                                                </table>
                                                                <table style="font-size: 9px" class="no-margin table table-striped">
                                                                    <%--<thead style="font-size:9px; border:1px solid black" >--%>

                                                                    <tr>
                                                                        <th><span class="h6">Fee</span></th>
                                                                        <td>
                                                                            <span class="h6"><b>
                                                                                <asp:Label ID="Label34" Text='<%# Eval("strTutionFee") %>' runat="server"></asp:Label></b></span>
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
                                                                        <th><span class="h6">Arrears</span></th>
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
                                                                        <asp:GridView ID="gvtermbnk" EmptyDataText="No Data Found" ShowHeader="false" class="table table-striped table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nct_id" EnableViewState="true">
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
                                                                    <div class="clearfix"></div>
                                                                    <div class="col-sm-4">
                                                                        <div id="Div2">

                                                                            <asp:TextBox ID="TextBox2" runat="server" Visible="false"></asp:TextBox>
                                                                            <asp:Panel ID="Panel2" runat="server">

                                                                                <asp:Image ID="Image2" ImageUrl='<%# Eval("imgChallanBcode") %>' runat="server" Style="height: 43px; width: 130px;" />


                                                                            </asp:Panel>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-sm-4">
                                                                        <h6 class="pull-right">Account Copy
																
                                                                        </h6>

                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>


                                                    </div>

                                                </div>
                                                <asp:Label Text='<%#Eval("nChallanNum") %>' Visible="false" ID="lblchlnum" runat="server" />
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                    <asp:Button class="width-30 pull-right btn btn-sm btn-success" Text="Print" OnClientClick="printDiv('printable1')" ID="btnprint" runat="server" />
                                    <%--<label class="width-30 pull-right btn btn-sm btn-success" onclick="printDiv('printable1')">Print</label>--%>
                                </div>
                            </asp:View>
                        </asp:MultiView>

                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
