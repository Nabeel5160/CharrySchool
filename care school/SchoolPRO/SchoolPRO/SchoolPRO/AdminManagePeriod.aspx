<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManagePeriod.aspx.cs" Inherits="SchoolPRO.AdminManagePeriod" %>

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
           <div class="col-lg-12">
                    <h5 style="color:red">Instruction</h5>
            <ul>
                <li>Add Periods 1 ,2 3.... Their Start Time and Ending time(Mon - Sat)</li>
                <li>Add Periods 1,2,3...... Their Start Time and Ending time(Firday)</li>
            </ul>
                </div>
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Manage School Periods
                </h4>

                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="MultiView1" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                               <div class="space-30"></div>
                                 <div id="printable" class="table-responsive">
                                    <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													School Periods List
												</h5>

												<div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                    <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" OnPageIndexChanging="gvsearchclass_PageIndexChanging" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvsearchclass_RowCommand" OnRowUpdating="gvsearchclass_RowUpdating" DataKeyNames="np_id" EnableViewState="true" OnSelectedIndexChanged="gvsearchclass_SelectedIndexChanged">
                                        <Columns>
                                            <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="np_id" HeaderText="S.NO" SortExpression="np_id" />
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <HeaderTemplate>
                                                    <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                                </HeaderTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Period Name">
                                                <ItemTemplate>
                                                    <%--<asp:Label ID="lblcname" runat="server" Text='<%# Highlight(Eval("c_name").ToString()) %>'></asp:Label>--%>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strPeriod") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField  DataField="strPeriodCode" HeaderText="Period Code" SortExpression="strPeriodCode" />
                                            <asp:BoundField  DataField="strStartTime" HeaderText="Period Start Time" SortExpression="strStartTime" />
                                            <asp:BoundField  DataField="strEndTime" HeaderText="Period End Time" SortExpression="strEndTime" />
                                            <asp:BoundField  DataField="shdul" HeaderText="Period Schdule" SortExpression="shdul" />
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print" >
                                                <ItemTemplate>
                                                    <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnedit_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <ItemTemplate>
                                                    <asp:Button ID="btndel" runat="server" Text="Delete" class="width-65 pull-right btn btn-sm btn-success" OnClick="btndel_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
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
                                                        Manage School Periods
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter School Periods: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                              <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txteaddprd" class="form-control" placeholder="Period Name(1,2...)" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator300" runat="server" ErrorMessage="Enter Period Name(1,2...)" ControlToValidate="txtaddprd"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                             <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txteaddprdcode" ReadOnly="true" class="form-control" placeholder="Period Code(1,2...)" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator001" ErrorMessage="Enter Period Code (digits only)" ValidationExpression="^\d+$" ControlToValidate="txtaddprdcode" runat="server" />
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator3003" runat="server" ErrorMessage="Enter Period Code(1,2...)" ControlToValidate="txtaddprdcode"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txteaddprdst_time" TextMode="Time" class="form-control" placeholder="Period Start Time" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                   
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator002" runat="server" ErrorMessage="Enter Period Start Time" ControlToValidate="txtaddprdst_time"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txteaddprdend_time" TextMode="Time" class="form-control" placeholder="Period End Time" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator004" runat="server" ErrorMessage="Enter Period End Time" ControlToValidate="txtaddprdend_time"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnupdate" runat="server" Text="Update" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnupdate_Click" />
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
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage School Periods
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter School Periods: </p>
                                                    <form id="Form2">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                  <asp:DropDownList AutoPostBack="true"  ID="ddlTimetable" runat="server" DataSourceID="TimetableDs" DataTextField="strtimetable" DataValueField="nshd_id" AppendDataBoundItems="true"><asp:ListItem>---Select Time Table---</asp:ListItem></asp:DropDownList>
                            <asp:SqlDataSource runat="server" ID="TimetableDs" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strtimetable], [nshd_id] FROM [tbl_Schedule] WHERE ([bisDeleted] = @bisDeleted) and nsch_id=@schid">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                    <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtaddprd" class="form-control" placeholder="Period Name(1,2...)" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Period Name(1,2...)" ControlToValidate="txtaddprd"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                             <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtaddprdcode" class="form-control" placeholder="Period Code(1,2...)" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator1" ErrorMessage="Enter Period Code (digits only)" ValidationExpression="^\d+$" ControlToValidate="txtaddprdcode" runat="server" />
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator33" runat="server" ErrorMessage="Enter Period Code(1,2...)" ControlToValidate="txtaddprdcode"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtaddprdst_time" TextMode="Time" class="form-control" placeholder="Period Start Time" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                   
                                                                    <asp:RequiredFieldValidator  ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Period Start Time" ControlToValidate="txtaddprdst_time"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                           
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtaddprdend_time" TextMode="Time" class="form-control" placeholder="Period End Time" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                  
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Period End Time" ControlToValidate="txtaddprdend_time"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnaddclass" runat="server" Text="Add Period " class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddclass_Click" />
                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
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

                <div class="space-12"></div>

                <!-- /.page-content -->
            </div>
            <!-- /.main-content -->

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
