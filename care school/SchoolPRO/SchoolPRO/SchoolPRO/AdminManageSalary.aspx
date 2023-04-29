<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageSalary.aspx.cs" Inherits="SchoolPRO.AdminManageSalary" %>
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Search By Name
                </h4>

                <div class="space-6"></div>
                <%--<asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>--%>
                 <asp:ToolkitScriptManager ID="tool1" runat="server"></asp:ToolkitScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvsal" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <%--<asp:Button ID="btngotoAdd" runat="server" Text="Add Loan" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />--%>
                                <asp:Button ID="btnsal" class="width-15 pull-left btn btn-sm btn-success" runat="server" Text="Add Salary" OnClick="btnsal_Click" />
                                <div class="table-responsive">
                                    <asp:GridView ID="gvsal" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" DataKeyNames="nsal_id" EnableViewState="true">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nsal_id" HeaderText="S.NO" SortExpression="nsal_id" />
                                            <asp:TemplateField HeaderText="Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strSalary" SortExpression="strSalary" HeaderText="Salary" />
                                            <asp:BoundField DataField="strBonus" SortExpression="strBonus" HeaderText="Bonus" />
                                            <asp:BoundField DataField="dtAddDate" SortExpression="dtAddDate" HeaderText="Add Date" />
                                            <%--<asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnedit_Click" /></ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btndel" runat="server" Text="Delete" class="width-65 pull-right btn btn-sm btn-success" OnClick="btndel_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                        </Columns>
                                    </asp:GridView>
                                    <div class="space-4"></div>

                                </div>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Teacher Salary
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Salaries: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddacnum" CssClass="form-control" DataValueField="strAccNum" DataTextField="name" DataSourceID="sqlacnum" runat="server"></asp:DropDownList>
                                                                    <i class="icon-user"></i>
                                                            </label>
                                                            <%--<label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddenm" CssClass="form-control" DataValueField="strlname" DataTextField="strlname" DataSourceID="sqlemp" AutoPostBack="true" runat="server" ></asp:DropDownList>
                                                            <i class="icon-user"></i>
                                                            
                                                        </span>
                                                    </label>--%>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddenm" CssClass="form-control" runat="server" DataSourceID="empDS" DataTextField="name" DataValueField="nu_id" AppendDataBoundItems="true">
                                                                        <asp:ListItem>--Select Employee--</asp:ListItem>
                                                                    </asp:DropDownList>

                                                                    <%--<asp:SqlDataSource runat="server" ID="empDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nu_id], [strfname]+' '+[strlname] as name FROM [tbl_Users] WHERE (([bisDeleted] = @bisDeleted) AND ([nLevel] <> @nLevel) and ([nLevel] <> @nLevel2) and  and nsch_id=@schid)">
                                                                <SelectParameters>
                                                                    <asp:Parameter DefaultValue="false" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                    <asp:Parameter DefaultValue="2" Name="nLevel" Type="Int32"></asp:Parameter>
                                                                    <asp:Parameter DefaultValue="10" Name="nLevel2" Type="Int32"></asp:Parameter>
                                                                    <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>--%>
                                                                    <asp:SqlDataSource runat="server" ID="empDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nu_id], [strfname]+' '+[strlname] as name FROM [tbl_Users] WHERE (([bisDeleted] = @bisDeleted) AND ([nLevel] = @nLevel)  and nsch_id=@schid)">
                                                                        <SelectParameters>
                                                                            <asp:Parameter DefaultValue="false" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                            <asp:Parameter DefaultValue="2" Name="nLevel" Type="Int32"></asp:Parameter>
                                                                            <%--<asp:Parameter DefaultValue="10" Name="nLevel2" Type="Int32"></asp:Parameter>--%>
                                                                            <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                    <i class="icon-user"></i>

                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtfrm" class="form-control" runat="server"></asp:TextBox>
                                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtfrm" runat="server"></asp:CalendarExtender>
                                                                    <asp:TextBox ID="txtto" class="form-control" AutoPostBack="true" OnTextChanged="txtto_TextChanged" runat="server"></asp:TextBox>
                                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtTo" runat="server"></asp:CalendarExtender>
                                                                    </span>
                                                                </label>


                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">Present:
                                                                    <asp:Label ID="lblp" runat="server" Text="0"></asp:Label>&nbsp;
                        Abscent:
                                                                    <asp:Label ID="lbla" runat="server" Text="0"></asp:Label>&nbsp;
                        Late:
                                                                    <asp:Label ID="lbllate" runat="server" Text="0"></asp:Label>&nbsp;
                       Half Leave:
                                                                    <asp:Label ID="lblhalflv" runat="server" Text="0"></asp:Label>
                                                                    &nbsp;
                       Full Leave:
                                                                    <asp:Label ID="lblfullv" runat="server" Text="0"></asp:Label>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtamnt" ReadOnly="true" runat="server" class="form-control" placeholder="Total Salary"></asp:TextBox>

                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtfine" runat="server" class="form-control" placeholder="Fine" AutoPostBack="true" OnTextChanged="txtfine_TextChanged"></asp:TextBox>

                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtsalary" runat="server" class="form-control" placeholder="Paid Salary"></asp:TextBox>

                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:CheckBox ID="chkbn" Text="Check if you are giving Bonus" class="form-control" AutoPostBack="true" Enabled="true" runat="server" />
                                                                    <asp:TextBox ID="txtbns" runat="server" class="form-control" placeholder="Bonus"></asp:TextBox>
                                                                </span>
                                                            </label>

                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:LinkButton ID="lblgoback" class="flip-link to-recover grey" runat="server" OnClick="lblgoback_Click">View Added Salary</asp:LinkButton>
                                                                <asp:Button ID="btnAddexp" runat="server" Text="Add Salary" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnAddexp_Click" />
                                                            </div>
                                                            </span>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%--<asp:SqlDataSource ID="sqlemp" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strlname] FROM [tbl_Users] WHERE (([bisDeleted] = @bisDeleted) AND ([nLevel] = @nLevel) OR ([nLevel] = @nLevel2)) and nsch_id=@schid">
                                                    <SelectParameters>
                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean" />
                                                        <asp:Parameter DefaultValue="2" Name="nLevel" Type="Int32"></asp:Parameter>
                                                        <asp:Parameter DefaultValue="10" Name="nLevel2" Type="Int32"></asp:Parameter>
                                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>--%>
                                <%--<asp:SqlDataSource ID="sqlacnum" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strAccNum] FROM [tbl_Bank] WHERE ([bisDeleted] = @bisDeleted) and strAccTitle='School Acc' and nsch_id=@schid">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean" />
                                                <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>--%>
                                <asp:SqlDataSource ID="sqlacnum" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strAccNum],[strAccTitle]+'-'+[strAccNum] as name FROM [tbl_Bank] WHERE ([bisDeleted] = @bisDeleted)  and nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean" />
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
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
                                                                <span class="invoice-info-label">Pay Invoice :</span>
                                                                <span class="red">#<asp:Label runat="server" ID="txtempInvc"></asp:Label></span>

                                                                <br />
                                                                <span class="invoice-info-label">Date    :</span>
                                                                <span class="blue">
                                                                    <asp:Label runat="server" ID="date"></asp:Label></span>
                                                                <br />
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
                                                                                <b>Employee Info</b>
                                                                            </div>
                                                                        </div>

                                                                        <div class="row">
                                                                            <ul class="list-unstyled spaced">
                                                                                <li>
                                                                                    <i class="ace-icon fa fa-caret-right blue"></i>
                                                                                    Name&nbsp;&nbsp;&nbsp;&nbsp; :
                                                                                    <asp:Label runat="server" ID="txtempName"></asp:Label>
                                                                                    <%--<% Response.Write(txtnm.Text); %>--%>
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
                                                                                <th>Total Salary</th>
                                                                                <th>Total Absents</th>
                                                                                <th>Total Presents</th>
                                                                                <th>Total Full Leaves</th>
                                                                                <th>Total Half Leaves</th>

                                                                                <th>Fine</th>
                                                                                <th>Bonus</th>
                                                                            </tr>
                                                                        </thead>

                                                                        <tbody>
                                                                            <tr>
                                                                                <td class="center">1</td>

                                                                                <td>
                                                                                    <asp:Label runat="server" ID="txtempsal"></asp:Label><%--<% Response.Write(txtfee.Text); %>--%>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Label runat="server" ID="txtempAbsnt"></asp:Label>
                                                                                    <%--<% Response.Write(txtFine.Text); %>--%>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Label runat="server" ID="txtempprsnt"></asp:Label>
                                                                                    <%--<% Response.Write(txtfeecons.Text); %>--%></td>

                                                                                <td>
                                                                                    <asp:Label runat="server" ID="txtempfulleaves"></asp:Label>
                                                                                    <%--<% Response.Write(txtRemnfee.Text); %>--%></td>
                                                                                <td>
                                                                                    <asp:Label runat="server" ID="txtemphalfleaves"></asp:Label>
                                                                                    <%--<% Response.Write(txtRemnfee.Text); %>--%></td>
                                                                                <td>
                                                                                    <asp:Label runat="server" ID="txtempfine"></asp:Label>
                                                                                    <%--<% Response.Write(txtTotfee.Text); %>--%></td>
                                                                                <td>
                                                                                    <asp:Label runat="server" ID="txtempBonus"></asp:Label>
                                                                                    <%--<% Response.Write(txtRcvfee.Text); %>--%></td>



                                                                            </tr>


                                                                        </tbody>
                                                                    </table>
                                                                </div>

                                                                <div class="hr hr8 hr-double hr-dotted"></div>

                                                                <div class="row">
                                                                    <div class="col-sm-5 pull-right">
                                                                        <h4 class="pull-right">Total Salary Paid :
																<span class="red">
                                                                    <td>
                                                                        <asp:Label runat="server" ID="txtemptotsal"></asp:Label>
                                                                </span>
                                                                        </h4>
                                                                    </div>
                                                                    <%--<div class="col-sm-7 pull-left"> Extra Information </div>--%>
                                                                </div>

                                                                <div class="space-6"></div>
                                                                <div class="well">
                                                                    Powered By LENOX TECHNOLOGIES , LENOX SCHOOL SOLUTION | www.lenox.com
                                                                    0333-9957111 |  0319-97062989.....
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
                                        <asp:Button runat="server" ID="btBack" CssClass="width-30 pull-Left btn btn-sm btn-success " OnClick="btBack_Click" Text="Go Back"></asp:Button>
                                    </div>
                                    <!-- /.row -->
                                </div>
                                <!-- /.page-content-area -->
                                </div>

                            </asp:View>
                            <%--<asp:View ID="View3" runat="server">
                                                    <div class="login-container">
                            <div class="position-relative">
                                <div class="no-border">
                                    <div class="widget-body">
									<div class="widget-main">
                                            <h4 class="header green lighter bigger">
                                                <i class="icon-group blue"></i>
                                                Manage Class
                                            </h4>

                                            <div class="space-6"></div>
                                            <p>Enter Class Name: </p>
                                    <form id="Form2">
                                                <fieldset>
                                                    
                                                       <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtaddclass" class="form-control" placeholder="Class Name" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Class Name" ControlToValidate="txtaddclass"></asp:RequiredFieldValidator>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtnos" class="form-control" placeholder="Total Seats" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtnos"></asp:RequiredFieldValidator>
                                                        </span>
                                                    </label>
                                                    <div class="space-24"></div>

                                                    <div class="clearfix">
                                                        <asp:Button ID="btnaddclass" runat="server" Text="Add Class" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddclass_Click"/>
                                                    </div>
                                                    </fieldset>
                                        </form>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                                        </div>
                                                </asp:View>--%>
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

                <div class="space-12"></div>

                <!-- /.page-content -->
            </div>
            <!-- /.main-content -->

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
