<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageExamTimeTable.aspx.cs" Inherits="SchoolPRO.AdminManageExamTimeTable" %>
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
    <div class="col-lg-12">
                    <h5 style="color:red">Instruction</h5>
            <ul>
                <li>Add Exam Time Against Subject , Timing and Day </li>
            
            </ul>
                </div>
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
          
        <div class="row-fluid">


            <div class="space-6"></div>
          <%--  <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>--%>
             <asp:ToolkitScriptManager  ID="tool1" runat="server"  ></asp:ToolkitScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvtime" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:Button ID="btnAdd" runat="server" Text="Add" class="width-35 pull-left btn btn-sm btn-success" OnClick="btnAdd_Click" />

                            <div id="printable" class="table-responsive">
                                <div class="space-20"></div>
                                <div class="space-20"></div>
                                 <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Exam Time Table
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="hidden-print icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                <asp:GridView ID="gvttable" class="table table-striped table-bordered table-hover" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvttable_RowCommand" EnableViewState="true" runat="server">
                                    <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                             <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nt_id" SortExpression="nt_id" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:TextBox CssClass="hidden-print" ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                <asp:Button CssClass="hidden-print" ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                            </HeaderTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                        <asp:BoundField DataField="strSubject" HeaderText="Subject" SortExpression="strSubject" />
                                        <asp:BoundField DataField="strStartTime" HeaderText="Start Time" SortExpression="strStartTime" />
                                        <asp:BoundField DataField="strEndTime" HeaderText="End Time" SortExpression="strEndTime" />
                                        <asp:BoundField DataField="strShift" HeaderText="Shift" SortExpression="strShift" />
                                         
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnedit" runat="server" Text="Edit" class="hidden-print width-100 pull-left btn btn-sm btn-success" OnClick="btnedit_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btndel" runat="server" Text="Delete" class="hidden-print width-100 pull-left btn btn-sm btn-success" OnClick="btndel_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
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
                                                    Manage Time Table
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Enter details of Time Table according to their Classes: </p>
                                                <form id="freg">
                                                    <fieldset>
                                                        <label>
                                                             <asp:DropDownList AutoPostBack="true" ID="ddlTimetable" runat="server" DataSourceID="TimetableDs" DataTextField="strtimetable" DataValueField="nshd_id" AppendDataBoundItems="true"><asp:ListItem>---Select Time Table---</asp:ListItem></asp:DropDownList>
                            <asp:SqlDataSource runat="server" ID="TimetableDs" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strtimetable], [nshd_id] FROM [tbl_Schedule] WHERE ([bisDeleted] = @bisDeleted) and nsch_id=@schid">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                    <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddcl" runat="server" DataSourceID="sqlclass" DataTextField="strClass" DataValueField="nc_id" AutoPostBack="true" EnableViewState="true" ViewStateMode="Enabled" OnSelectedIndexChanged="ddcl_SelectedIndexChanged"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddsub" runat="server" DataSourceID="sqlsubject" DataTextField="strSubject" DataValueField="nsbj_id" AutoPostBack="true" EnableViewState="true" ViewStateMode="Enabled"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtsdt" runat="server" TextMode="Time" class="form-control" placeholder="Start Time"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtenddt" runat="server" TextMode="Time" class="form-control" placeholder="End Time"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddshft" runat="server">
                                                                    <asp:ListItem>Morning</asp:ListItem>
                                                                    <asp:ListItem>Evening</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txttdt" runat="server" class="form-control" placeholder="Today Date"></asp:TextBox>
                                                                <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txttdt" runat="server"></asp:CalendarExtender>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <asp:Button ID="btnreset" runat="server" Text="Reset" class="width-30 pull-left btn btn-sm " />
                                                            <asp:Button ID="btnttable" runat="server" Text="Add Time Table" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnttable_Click" />
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
                                                    Manage Time-Table
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Enter details of Classes: </p>
                                                <form id="Form2">
                                                    <fieldset>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddcl1" runat="server" DataSourceID="sqlclass" DataTextField="strClass" DataValueField="nc_id" AutoPostBack="true" EnableViewState="true" ViewStateMode="Enabled" OnSelectedIndexChanged="ddcl_SelectedIndexChanged"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddsb" runat="server" DataSourceID="sqlsubject1" DataTextField="strSubject" DataValueField="nsbj_id" AutoPostBack="true" EnableViewState="true" ViewStateMode="Enabled"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtst" runat="server" TextMode="Time" class="form-control" placeholder="Start Time"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtet" runat="server" TextMode="Time" class="form-control" placeholder="End Time"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddsh" runat="server">
                                                                    <asp:ListItem>Morning</asp:ListItem>
                                                                    <asp:ListItem>Evening</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txt2dt" runat="server" TextMode="Date" class="form-control" placeholder="Today Date"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <div class="space-24"></div>

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
    <!-- /.col -->
    <div class="space-12"></div>

   <asp:SqlDataSource ID="sqlclass" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strClass],[nc_id] FROM [tbl_Class] where bisDeleted='False' and nsch_id=@schid">
        <SelectParameters>
<asp:SessionParameter Name="schid" SessionField="nschoolid" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlsubject" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strSubject],[nsbj_id] FROM [tbl_Subject] WHERE ([nc_id] =@cid) AND bisDeleted='False' and nsch_id=@schid">
        <SelectParameters>
<asp:SessionParameter Name="schid" SessionField="nschoolid" />
        
            <asp:ControlParameter ControlID="ddcl" PropertyName="SelectedValue" Name="cid" />

        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlsubject1" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strSubject],[nsbj_id] FROM [tbl_Subject] WHERE [nc_id] = @cname and bisDeleted='False' and nsch_id=@schid">
        <SelectParameters>
<asp:SessionParameter Name="schid" SessionField="nschoolid" />
       
            <asp:ControlParameter ControlID="ddcl1" PropertyName="SelectedValue" Name="cname" Type="String" />

        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlsec" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT strSection, nsc_id FROM tbl_Section WHERE (nc_id = @cname) AND (bisDeleted = 'False') and nsch_id=@schid">
        <SelectParameters>
<asp:SessionParameter Name="schid" SessionField="nschoolid" />
        
            <asp:ControlParameter ControlID="ddcl" PropertyName="SelectedValue" Name="cname" Type="String" />

        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlsec1" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strSection],[nsc_id] FROM [tbl_Section] WHERE [nc_id] =@cname  and bisDeleted='False' and nsch_id=@schid">
        <SelectParameters>
<asp:SessionParameter Name="schid" SessionField="nschoolid" />
       
            <asp:ControlParameter ControlID="ddcl1" PropertyName="SelectedValue" Name="cname" Type="String" />

        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqltch" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT strfname + ' ' + strlname AS name, nu_id FROM tbl_Users WHERE (nLevel = '2') AND (bisDeleted = 'False') and nsch_id=@schid">
        <SelectParameters>
<asp:SessionParameter Name="schid" SessionField="nschoolid" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqltch1" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="select strfname+' '+strlname as name ,nu_id from tbl_Users where nLevel='2' and bisDeleted='False' and nsch_id=@schid">
        <SelectParameters>
<asp:SessionParameter Name="schid" SessionField="nschoolid" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

