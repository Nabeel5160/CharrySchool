<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageClassTimeTable.aspx.cs" Inherits="SchoolPRO.AdminManageClassTimeTable" %>

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
                <li>Add Time Against Subject ,Periods , Teacher , Day ,Class ,Section and Schdule (Summer or winter)</li>
                           </ul>
                </div>
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
         
        <div class="row-fluid">


            <div class="space-6"></div>
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvtime" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:Button ID="btnViewTimeTable" runat="server" Text="Time Table Report" Cssclass="width-10 pull-left btn btn-sm btn-success" OnClick="btnViewTimeTable_Click" />
                            <asp:Button ID="btnAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btnAdd_Click" />
                            <asp:Button ID="btnInterchangeTeacher" runat="server" Text="Interchange Teachers Class" class="width-10 pull-left btn btn-sm btn-success" OnClick="btnInterchangeTeacher_Click" />
                            <asp:Button ID="btnChangeTeacherTime" runat="server" Text="Change Teachers Class" class="width-10 pull-left btn btn-sm btn-success" OnClick="btnChangeTeacherTime_Click" />
                            <asp:Button ID="btnChangeAllDaystime" runat="server" Text="Change Teachers Class By All Day" class="width-10 pull-left btn btn-sm btn-success" OnClick="btnChangeAllDaystime_Click" />
                            <asp:Button ID="btnChangeByDay" runat="server" Text="Change Teachers Class By One Day" class="width-10 pull-left btn btn-sm btn-success" OnClick="btnChangeByDay_Click" />
                            <div class="space-24"></div>
                            <div class="space-24"></div>
                            <div id="printable" class="table-responsive">
                                <div class="widget-header header-color-blue">
                                    <h5 class="bigger lighter">
                                        <i class="icon-table"></i>
                                        Time Table
                                    </h5>

                                    <div class="widget-toolbar widget-toolbar-light no-border">
                                        <div class="hidden-print icon-print icon-2x" onclick="printDiv('printable')"></div>
                                    </div>
                                </div>
                                
                                <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="ddlTimetable_SelectedIndexChanged" ID="ddlTimetable" runat="server" DataSourceID="TimetableDs" DataTextField="strtimetable" DataValueField="nshd_id" AppendDataBoundItems="true">
                                    <asp:ListItem>---Select Time Table---</asp:ListItem>
                                </asp:DropDownList>
                                
                                <asp:Button ID="btnday" runat="server" Text="Period" class="width-10 pull-left btn btn-sm btn-success" OnClick="btnday_Click"/>
                                <asp:Button ID="btnseccls" runat="server" Text="Day" class="width-10 pull-left btn btn-sm btn-success" OnClick="btnseccls_Click"/>
                                <br />

                                <asp:SqlDataSource runat="server" ID="TimetableDs" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strtimetable], [nshd_id] FROM [tbl_Schedule] WHERE ([bisDeleted] = @bisDeleted) and nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                

                                <asp:GridView ID="gvttable" OnPageIndexChanging="gvttable_PageIndexChanging" CurrentSortDirection="ASC" class="table table-striped table-bordered table-hover" AllowPaging="false" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvttable_RowCommand" EnableViewState="true" runat="server">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nt_id" SortExpression="nt_id" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="hidden-print nav-search-input" Width="210"></asp:TextBox>
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="hidden-print" CommandName="Search" />
                                            </HeaderTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Teacher's Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcname" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                        <asp:BoundField DataField="strSection" SortExpression="strSection" HeaderText="Section" />
                                        <asp:BoundField DataField="strSubject" HeaderText="Subject" SortExpression="strSubject" />
                                        <asp:BoundField DataField="strStartTime" HeaderText="Start Time" SortExpression="strStartTime" />
                                        <asp:BoundField DataField="strEndTime" HeaderText="End Time" SortExpression="strEndTime" />
                                        <asp:BoundField DataField="strShift" HeaderText="Shift" SortExpression="strShift" />
                                        <asp:BoundField DataField="strStartDate" HeaderText="Schedule Date" SortExpression="strStartDate" />
                                        <asp:BoundField DataField="strEndDate" HeaderText="End Date" SortExpression="strEndDate" />
                                        <asp:BoundField DataField="strPeriod" HeaderText="Period" SortExpression="strPeriod" />
                                        <asp:BoundField DataField="strDay" HeaderText="Day" SortExpression="strDay" />
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
                            <div>
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

                                                        <label class="clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddcl" runat="server" DataSourceID="sqlclass" DataTextField="strClass" DataValueField="nc_id" AutoPostBack="true" EnableViewState="true" ViewStateMode="Enabled" OnSelectedIndexChanged="ddcl_SelectedIndexChanged"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddsec" runat="server" DataSourceID="sqlsec" DataTextField="strSection" DataValueField="nsc_id"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddsub" runat="server" DataSourceID="sqlsubject" DataTextField="strSubject" DataValueField="nsbj_id"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddtchr" runat="server" DataSourceID="sqltch" DataTextField="name" DataValueField="nu_id"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" AppendDataBoundItems="true" DataSourceID="sqldate" DataValueField="strDayName" DataTextField="strDayName" ID="ddlDay" runat="server">
                                                                    <asp:ListItem >----Select Day----</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <asp:SqlDataSource runat="server" ID="sqldate" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strDayName] from tbl_Day">
                                    
                                </asp:SqlDataSource>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="ddltimetable11_SelectedIndexChanged" ID="ddltimetable11" runat="server" DataSourceID="TimetableDs" DataTextField="strtimetable" DataValueField="nshd_id" AppendDataBoundItems="true">
                                                                    <asp:ListItem>---Select Time Table---</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </span>
                                                        </label>
                                                        <%-- <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:RadioButton GroupName="SHD" ID="winter" Text="Winter Time Table" runat="server" AutoPostBack="true" OnCheckedChanged="winter_CheckedChanged" />
                                                                <asp:RadioButton GroupName="SHD" ID="Summer" Text="Summer Time Table" runat="server" AutoPostBack="true" OnCheckedChanged="Summer_CheckedChanged" />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>--%>
                                                        <label class="block clearfix">
                                                            <label>Select Period :</label>
                                                            <span class="block input-icon input-icon-right">
                                                                
                                                                <asp:DropDownList AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlperiod_SelectedIndexChanged1" CssClass="input-medium" ID="ddlperiod" runat="server" DataTextField="name" DataValueField="np_id">
                                                                    <asp:ListItem Text="---Please Select Period---"></asp:ListItem>

                                                                </asp:DropDownList>

                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <asp:Label runat="server" ID="test"></asp:Label>

                                                        <label class=" clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtsdt" ReadOnly="true" runat="server" class="form-control" placeholder="Start Time"></asp:TextBox>
                                                                <i class="icon-time"></i>
                                                            </span>
                                                        </label>
                                                        <label class=" clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtenddt" ReadOnly="true" runat="server" class="form-control" placeholder="End Time"></asp:TextBox>
                                                                <i class="icon-time"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddshft" CssClass="input-medium" runat="server">
                                                                    <asp:ListItem Selected="True">Morning</asp:ListItem>
                                                                    <asp:ListItem>Evening</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class=" clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txttdt" ReadOnly="true" runat="server" class="form-control" placeholder="mm-dd-yyyy"></asp:TextBox>
                                                                <i class="icon-calendar"></i>
                                                            </span>
                                                        </label>
                                                        <label class=" clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtedt" ReadOnly="true" runat="server" class="form-control" placeholder="mm-dd-yyyy"></asp:TextBox>
                                                                <i class="icon-calendar"></i>
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
                                                                <asp:DropDownList CssClass="input-medium" ID="ddcl1" runat="server" DataTextField="strClass" DataValueField="nc_id" AutoPostBack="true" EnableViewState="true" ViewStateMode="Enabled" OnSelectedIndexChanged="ddcl_SelectedIndexChanged"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddsec1" runat="server" DataTextField="strSection" DataValueField="nsc_id"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddsb" runat="server" DataTextField="strSubject" DataValueField="nsbj_id"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddumna" runat="server" DataTextField="name" DataValueField="nu_id"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtst" runat="server" class="form-control" placeholder="Start Time"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtet" runat="server" class="form-control" placeholder="End Time"></asp:TextBox>
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
                                                                <asp:TextBox ID="txttdt2" runat="server" class="form-control" placeholder="Today Date"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtedt2" runat="server" class="form-control" placeholder="Today Date"></asp:TextBox>
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
                        <asp:View ID="View4" runat="server">
                            <div class="login-container">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Interchange Teachers Time 
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Interchanging Class Incharges</p>
                                                <form id="Form1">
                                                    <fieldset>
                                                        <p>Select Teacher To Change : </p>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList OnSelectedIndexChanged="ddltimetable1_SelectedIndexChanged" ID="ddltimetable1" CssClass="width-60 input-medium" runat="server" DataTextField="strtimetable" DataValueField="nshd_id" AutoPostBack="true" AppendDataBoundItems="True" DataSourceID="TimetableDs">
                                                                    <asp:ListItem>Select Time Table</asp:ListItem>
                                                                </asp:DropDownList>

                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList OnSelectedIndexChanged="ddltch_SelectedIndexChanged" ID="ddltch" CssClass="width-60 input-medium" runat="server" DataTextField="name" DataValueField="nu_id" AutoPostBack="true" AppendDataBoundItems="True"></asp:DropDownList>
                                                                <asp:SqlDataSource runat="server" ID="sqltchDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Users.strfname + ' ' + tbl_Users.strlname AS name, tbl_Users.nu_id, tbl_Class.strClass, tbl_Section.strSection, tbl_Subject.strSubject, tbl_Schedule.strtimetable, tbl_TimeTable.strPeriod FROM tbl_Users INNER JOIN tbl_TimeTable ON tbl_Users.nu_id = tbl_TimeTable.nu_id INNER JOIN tbl_Section ON tbl_TimeTable.nsc_id = tbl_Section.nsc_id INNER JOIN tbl_Subject ON tbl_TimeTable.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Class ON tbl_TimeTable.nc_id = tbl_Class.nc_id INNER JOIN tbl_Schedule ON tbl_TimeTable.nshdule_id = tbl_Schedule.nshd_id WHERE (tbl_Users.bisDeleted = 0) AND (tbl_Section.bisDeleted = 0) AND (tbl_Subject.bisDeleted = 0) AND (tbl_Class.bisDeleted = 0) AND (tbl_Schedule.bisDeleted = 0) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = @schid) AND (tbl_TimeTable.bisDeleted = 0)">

                                                                    <SelectParameters>

                                                                        <asp:SessionParameter SessionField="nschoolid" Name="schid" DefaultValue="0" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtPeriod" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtDay" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <asp:Label CssClass="hidden" runat="server" ID="nuid1"></asp:Label>
                                                        <div class="space-24"></div>
                                                        <p>Select Teacher To Change with : </p>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList OnSelectedIndexChanged="ddltch2_SelectedIndexChanged" ID="ddltch2" CssClass="input-medium" runat="server" AutoPostBack="true" DataTextField="name" DataValueField="nu_id" AppendDataBoundItems="True">
                                                                </asp:DropDownList>

                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtPeriod2" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtDay2" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <asp:Label CssClass="hidden" runat="server" ID="nuid2"></asp:Label>
                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <%--<asp:Button ID="Button1" runat="server" Text="View" class="width-30 pull-left btn btn-sm " OnClick="btngoback_Click" />--%>

                                                            <asp:Button ID="btnChangeIncharge" runat="server" Text="Change" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnChangeIncharge_Click" />
                                                        </div>
                                                    </fieldset>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:View>
                        <asp:View ID="View5" runat="server">
                            <div class="login-container">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Change Teacher Time
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Change Teacher</p>
                                                <form id="Form3">
                                                    <fieldset>
                                                        <p>Select Class Teacher To Change : </p>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList OnSelectedIndexChanged="ddlTimetable3_SelectedIndexChanged" ID="ddlTimetable3" CssClass="width-60 input-medium" runat="server" DataTextField="strtimetable" DataValueField="nshd_id" AutoPostBack="true" AppendDataBoundItems="True" DataSourceID="TimetableDs">
                                                                    <asp:ListItem>Select Time Table</asp:ListItem>
                                                                </asp:DropDownList>

                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>


                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddltch3" OnSelectedIndexChanged="ddltch3_SelectedIndexChanged" CssClass="input-medium" runat="server" AutoPostBack="true" DataTextField="name" DataValueField="nu_id" AppendDataBoundItems="True">
                                                                </asp:DropDownList>


                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtDay3" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtPeriod3" runat="server"></asp:TextBox>

                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>

                                                        <div class="space-24"></div>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddltch4" CssClass="input-medium" runat="server" DataTextField="name" DataValueField="nu_id" AutoPostBack="true" AppendDataBoundItems="True" OnSelectedIndexChanged="ddltch4_SelectedIndexChanged"></asp:DropDownList>
                                                                <asp:SqlDataSource runat="server" ID="TimeTeacherDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_TimeTable.nt_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS name, tbl_Users.nu_id FROM tbl_Users LEFT OUTER JOIN tbl_TimeTable ON tbl_Users.nu_id = tbl_TimeTable.nu_id WHERE (tbl_Users.bisDeleted = 0) AND (tbl_TimeTable.nu_id IS NULL) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = @schid)">
                                                                    <SelectParameters>
                                                                        <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <div class="clearfix">
                                                            <%--<asp:Button ID="Button1" runat="server" Text="View" class="width-30 pull-left btn btn-sm " OnClick="btngoback_Click" />--%>
                                                            <asp:Label CssClass="hidden" runat="server" ID="nuid3"></asp:Label>
                                                            <asp:Button ID="btnRemoveaandChangeIncharge" runat="server" Text="Change" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnRemoveaandChangeIncharge_Click" />
                                                        </div>
                                                    </fieldset>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:View>
                        <asp:View ID="View6" runat="server">
                            <div class="login-container">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Change Teacher Complete Time 
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Change Teacher</p>
                                                <form id="Form4">
                                                    <fieldset>
                                                        <p>Select Class Teacher To Change : </p>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList OnSelectedIndexChanged="ddltimetable4_SelectedIndexChanged" ID="ddltimetable4" CssClass="width-60 input-medium" runat="server" DataTextField="strtimetable" DataValueField="nshd_id" AutoPostBack="true" AppendDataBoundItems="True" DataSourceID="TimetableDs">
                                                                    <asp:ListItem>Select Time Table</asp:ListItem>
                                                                </asp:DropDownList>

                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>


                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddltch5" OnSelectedIndexChanged="ddltch5_SelectedIndexChanged" CssClass="width-60 input-medium" runat="server" AutoPostBack="true" DataTextField="name" DataValueField="nu_id" AppendDataBoundItems="True">
                                                                </asp:DropDownList>


                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <%--  <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList CssClass="width-60 input-medium" ID="ddlDay5" runat="server" >
                                                                    <asp:ListItem Text="---Select Day---"></asp:ListItem>
                                                                    <asp:ListItem Text="Monday" Value="Monday"></asp:ListItem>
                                                                    <asp:ListItem Text="Tuesday" Value="Tuesday"></asp:ListItem>
                                                                    <asp:ListItem Text="Wednesday" Value="Wednesday"></asp:ListItem>
                                                                    <asp:ListItem Text="Thursday" Value="Thursday"></asp:ListItem>
                                                                    <asp:ListItem Text="Friday" Value="Friday"></asp:ListItem>
                                                                    <asp:ListItem Text="‎Saturday" Value="‎Saturday"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox CssClass="width-60 input-medium" ID="txtPeriod5" runat="server" ></asp:TextBox>

                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>--%>

                                                        <div class="space-24"></div>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddltch6" CssClass="width-60 input-medium" runat="server" DataTextField="name" DataValueField="nu_id" AutoPostBack="true" AppendDataBoundItems="True" OnSelectedIndexChanged="ddltch6_SelectedIndexChanged"></asp:DropDownList>
                                                                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_TimeTable.nt_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS name, tbl_Users.nu_id FROM tbl_Users LEFT OUTER JOIN tbl_TimeTable ON tbl_Users.nu_id = tbl_TimeTable.nu_id WHERE (tbl_Users.bisDeleted = 0) AND (tbl_TimeTable.nu_id IS NULL) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = @schid)">
                                                                    <SelectParameters>
                                                                        <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <div class="clearfix">
                                                            <%--<asp:Button ID="Button1" runat="server" Text="View" class="width-30 pull-left btn btn-sm " OnClick="btngoback_Click" />--%>
                                                            <asp:Label CssClass="hidden" runat="server" ID="nuid5"></asp:Label>
                                                            <asp:Button ID="btnChangeAllDayTime" runat="server" Text="Change" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnChangeAllDayTime_Click" />
                                                        </div>
                                                    </fieldset>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:View>
                        <asp:View ID="View7" runat="server">
                            <div class="login-container">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Change Teacher Time By Selecting Day
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Change Teacher</p>
                                                <form id="Form5">
                                                    <fieldset>
                                                        <p>Select Class Teacher To Change : </p>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList OnSelectedIndexChanged="ddltimetable5_SelectedIndexChanged" ID="ddltimetable5" CssClass="width-60 input-medium" runat="server" DataTextField="strtimetable" DataValueField="nshd_id" AutoPostBack="true" AppendDataBoundItems="True" DataSourceID="TimetableDs">
                                                                    <asp:ListItem>Select Time Table</asp:ListItem>
                                                                </asp:DropDownList>

                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddlDay5" runat="server">
                                                                    <asp:ListItem Text="---Select Day---"></asp:ListItem>
                                                                    <asp:ListItem Text="Monday">Monday</asp:ListItem>
                                                                    <asp:ListItem Text="Tuesday">Tuesday</asp:ListItem>
                                                                    <asp:ListItem Text="Wednesday">Wednesday</asp:ListItem>
                                                                    <asp:ListItem Text="Thursday">Thursday</asp:ListItem>
                                                                    <asp:ListItem Text="Friday">Friday</asp:ListItem>
                                                                    <asp:ListItem Text="‎Saturday">Saturday</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddltch55" OnSelectedIndexChanged="ddltch55_SelectedIndexChanged" CssClass="width-60 input-medium" runat="server" AutoPostBack="true" DataTextField="name" DataValueField="nu_id" AppendDataBoundItems="True">
                                                                </asp:DropDownList>


                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <%--  <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList CssClass="width-60 input-medium" ID="ddlDay5" runat="server" >
                                                                    <asp:ListItem Text="---Select Day---"></asp:ListItem>
                                                                    <asp:ListItem Text="Monday" Value="Monday"></asp:ListItem>
                                                                    <asp:ListItem Text="Tuesday" Value="Tuesday"></asp:ListItem>
                                                                    <asp:ListItem Text="Wednesday" Value="Wednesday"></asp:ListItem>
                                                                    <asp:ListItem Text="Thursday" Value="Thursday"></asp:ListItem>
                                                                    <asp:ListItem Text="Friday" Value="Friday"></asp:ListItem>
                                                                    <asp:ListItem Text="‎Saturday" Value="‎Saturday"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox CssClass="width-60 input-medium" ID="txtPeriod5" runat="server" ></asp:TextBox>

                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>--%>

                                                        <div class="space-24"></div>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddltch66" CssClass="width-60 input-medium" runat="server" DataTextField="name" DataValueField="nu_id" AutoPostBack="true" AppendDataBoundItems="True" OnSelectedIndexChanged="ddltch6_SelectedIndexChanged"></asp:DropDownList>
                                                                <asp:SqlDataSource runat="server" ID="sqltch66" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_TimeTable.nt_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS name, tbl_Users.nu_id FROM tbl_Users LEFT OUTER JOIN tbl_TimeTable ON tbl_Users.nu_id = tbl_TimeTable.nu_id WHERE (tbl_Users.bisDeleted = 0) AND (tbl_TimeTable.nu_id IS NULL) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = @schid)">
                                                                    <SelectParameters>
                                                                        <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <div class="clearfix">
                                                            <%--<asp:Button ID="Button1" runat="server" Text="View" class="width-30 pull-left btn btn-sm " OnClick="btngoback_Click" />--%>
                                                            <asp:Label CssClass="hidden" runat="server" ID="nuid55"></asp:Label>
                                                            <asp:Button ID="btnChangeBySelectDay" runat="server" Text="Change" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnChangeBySelectDay_Click" />
                                                        </div>
                                                    </fieldset>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:View>
                        <asp:View ID="VIWE8" runat="server">

                            <asp:Button ID="btnPeriod_and_Day" runat="server" Text="View By Period and Day" class="width-10 pull-left btn btn-sm btn-success" OnClick="btnPeriod_and_Day_Click" />
                            <asp:Button ID="btn_Tchbyday" runat="server" Text="View By Teacher and Day" class="width-10 pull-left btn btn-sm btn-success" OnClick="btn_Tchbyday_Click" />
                            <asp:Button ID="btn_Day" runat="server" Text="View By Class and Day" class="width-10 pull-left btn btn-sm btn-success" OnClick="btn_Day_Click" />
                            <asp:Button ID="btn_TchDayClass" runat="server" Text="View By Class and Day and Teacher" class="width-10 pull-left btn btn-sm btn-success" OnClick="btn_TchDayClass_Click" />
                            <asp:Button ID="btn_BACK1" runat="server" Text="Back" class="width-10 pull-right btn btn-sm btn-success" OnClick="btn_BACK1_Click" />

                            <div class="space-24"></div>
                            <div class="space-24"></div>

                            </div>
                                <div id="printable1" class="table-responsive">
                                    <div class="widget-header header-color-blue">
                                        <h5 class="bigger lighter">
                                            <i class="icon-table"></i>
                                            Time Table
                                        </h5>

                                        <div class="widget-toolbar widget-toolbar-light no-border">
                                            <div class="hidden-print icon-print icon-2x" onclick="printDiv('printable1')"></div>
                                        </div>
                                    </div>
                                    <asp:DropDownList AutoPostBack="true" ID="dddlTimetable" runat="server" DataSourceID="dddlshudule" DataTextField="strtimetable" DataValueField="nshd_id">
                                        <asp:ListItem Value="0">---Select Time Table---</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="dddlshudule" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strtimetable], [nshd_id] FROM [tbl_Schedule] WHERE ([bisDeleted] = @bisDeleted) and nsch_id=@schid">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                            <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <% 
                                        dddlTimetable.SelectedValue = Session["nshduleid"].ToString();
                                            
                                    %>
                                    <asp:DropDownList AutoPostBack="true" ID="dddlcl" OnSelectedIndexChanged="dddlcl_SelectedIndexChanged" runat="server" DataTextField="strClass" DataValueField="nc_id" AppendDataBoundItems="true" DataSourceID="dddlclDS">
                                        <asp:ListItem Value="0">---Select Class---</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="dddlclDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nc_id], [strClass] FROM [tbl_Class] WHERE (([bisDeleted] = @bisDeleted) AND ([nsch_id] = @nsch_id))">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                            <asp:SessionParameter SessionField="nschoolid" DefaultValue="1" Name="nsch_id" Type="Int32"></asp:SessionParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:DropDownList ID="dddlsec" runat="server" DataTextField="strSection" DataValueField="nsc_id" AppendDataBoundItems="true" DataSourceID="dddlsecDS">
                                        <asp:ListItem Value="0">---Select Class Section---</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="dddlsecDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strSection], [nsc_id] FROM [tbl_Section] WHERE (([bisDeleted] = @bisDeleted) AND ([nsch_id] = @nsch_id) AND ([nc_id] = @nc_id))">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                            <asp:SessionParameter SessionField="nschoolid" DefaultValue="1" Name="nsch_id"></asp:SessionParameter>
                                            <asp:ControlParameter ControlID="dddlcl" PropertyName="SelectedValue" DefaultValue="1" Name="nc_id"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:DropDownList AutoPostBack="true" ID="dddltchr" runat="server" DataTextField="name" DataValueField="nu_id" AppendDataBoundItems="true" DataSourceID="dddltchrDS">
                                        <asp:ListItem Value="0">---Select Teacher Table---</asp:ListItem>
                                    </asp:DropDownList>


                                    <asp:SqlDataSource runat="server" ID="dddltchrDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nu_id], [strfname]+' '+[strlname] as name FROM [tbl_Users] WHERE (([bisDeleted] = @bisDeleted) AND ([nLevel] = @nLevel) AND ([nsch_id] = @nsch_id))">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="False" Name="bisDeleted"></asp:Parameter>
                                            <asp:Parameter DefaultValue="2" Name="nLevel"></asp:Parameter>
                                            <asp:SessionParameter SessionField="nschoolid" DefaultValue="1" Name="nsch_id"></asp:SessionParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:GridView ID="GridView1" class="table table-striped table-bordered table-hover" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" runat="server" DataSourceID="TIMETABLESEARCHDS">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nt_id" SortExpression="nt_id" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="hidden-print nav-search-input" Width="210"></asp:TextBox>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="hidden-print" CommandName="Search" />
                                                </HeaderTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Teacher's Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                            <asp:BoundField DataField="strSection" SortExpression="strSection" HeaderText="Section" />
                                            <asp:BoundField DataField="strSubject" HeaderText="Subject" SortExpression="strSubject" />
                                            <asp:BoundField DataField="strStartTime" HeaderText="Start Time" SortExpression="strStartTime" />
                                            <asp:BoundField DataField="strEndTime" HeaderText="End Time" SortExpression="strEndTime" />
                                            <asp:BoundField DataField="strShift" HeaderText="Shift" SortExpression="strShift" />
                                            <asp:BoundField DataField="strStartDate" HeaderText="Schedule Date" SortExpression="strStartDate" />
                                            <asp:BoundField DataField="strEndDate" HeaderText="End Date" SortExpression="strEndDate" />
                                            <asp:BoundField DataField="strPeriod" HeaderText="Period" SortExpression="strPeriod" />
                                            <asp:BoundField DataField="strDay" HeaderText="Day" SortExpression="strDay" />
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
                                    <asp:SqlDataSource runat="server" ID="TIMETABLESEARCHDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="select t.strPeriod,t.strDay,t.nt_id,c.strClass,sc.strSection,s.strSubject,u.strfname,u.strfname+' '+u.strlname as name,t.strStartTime,t.strEndTime,t.strShift,shdl.strStartDate,shdl.strEndDate,p.strPeriod,shdl.strtimetable from tbl_TimeTable t inner join tbl_Class c on t.nc_id=c.nc_id inner join tbl_Subject s on t.nsbj_id=s.nsbj_id inner join tbl_Users u on t.nu_id=u.nu_id inner join tbl_Section sc on t.nsc_id=sc.nsc_id inner join tbl_Schedule shdl on t.nshdule_id=shdl.nshd_id inner join tbl_Period p on t.np_id=p.np_id where t.bisDeleted='False' and shdl.bisDeleted='False'  and c.bisDeleted='False' and s.bisDeleted='False' and u.bisDeleted='False' and sc.bisDeleted='False' and p.bisDeleted='False' and t.nsch_id=@schid and t.strType='Class' and t.nshdule_id=@shdulid and t.nc_id=@cid and t.nsc_id=@scid and t.nu_id=@tchid Order by strClass,strSection">
                                        <SelectParameters>
                                            <asp:SessionParameter SessionField="nschoolid" DefaultValue="1" Name="schid"></asp:SessionParameter>
                                            <asp:ControlParameter ControlID="dddlTimetable" PropertyName="SelectedValue" DefaultValue="1" Name="shdulid"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="dddlcl" PropertyName="SelectedValue" DefaultValue="1" Name="cid"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="dddlsec" PropertyName="SelectedValue" DefaultValue="1" Name="scid"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="dddltchr" PropertyName="SelectedValue" DefaultValue="0" Name="tchid"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                        </asp:View>
                        <asp:View ID="View9" runat="server">

                            <h4 class="header green lighter bigger">
                                <i class="icon-group blue"></i>
                                Time Table By Teacher and Day
                            </h4>


                            <asp:Button ID="Button1" runat="server" Text="Back" class="width-10 pull-left btn btn-sm btn-success" OnClick="btn_BACK1_Click" />

                            <div class="space-24"></div>
                            <div class="space-24"></div>
                            <div id="printable2" class="table-responsive">
                                <div class="widget-header header-color-blue">
                                    <h5 class="bigger lighter">
                                        <i class="icon-table"></i>
                                        Time Table
                                    </h5>

                                    <div class="widget-toolbar widget-toolbar-light no-border">
                                        <div class="hidden-print icon-print icon-2x" onclick="printDiv('printable2')"></div>
                                    </div>
                                </div>
                                <asp:DropDownList AutoPostBack="true" ID="dddlTimeTable2" runat="server" DataSourceID="dddlTimeTable2DS" DataTextField="strtimetable" DataValueField="nshd_id" AppendDataBoundItems="true">
                                    <asp:ListItem Value="0">---Select Time Table---</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="dddlTimeTable2DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strtimetable], [nshd_id] FROM [tbl_Schedule] WHERE ([bisDeleted] = @bisDeleted) and nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <% 
                                    dddlTimeTable2.SelectedValue = Session["nshduleid"].ToString();
                                            
                                %>
                                <asp:DropDownList AutoPostBack="true" ID="dddltchr2" runat="server" DataTextField="name" DataValueField="nu_id" AppendDataBoundItems="true" DataSourceID="dddltchr2DS">
                                    <asp:ListItem Value="0">---Select Teacher Table---</asp:ListItem>
                                </asp:DropDownList>


                                <asp:SqlDataSource runat="server" ID="dddltchr2DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nu_id], [strfname]+' '+[strlname] as name FROM [tbl_Users] WHERE (([bisDeleted] = @bisDeleted) AND ([nLevel] = @nLevel) AND ([nsch_id] = @nsch_id))">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="bisDeleted"></asp:Parameter>
                                        <asp:Parameter DefaultValue="2" Name="nLevel"></asp:Parameter>
                                        <asp:SessionParameter SessionField="nschoolid" DefaultValue="1" Name="nsch_id"></asp:SessionParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:DropDownList AutoPostBack="true" ID="dddlDay2" runat="server" DataTextField="strDayName" DataValueField="strDayName" AppendDataBoundItems="true" DataSourceID="dddlday2DS">
                                    <asp:ListItem Value="0">---Select Day---</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="dddlday2DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nDay_id], [strDayName] FROM [tbl_Day]"></asp:SqlDataSource>
                                <asp:GridView ID="GridView2" class="table table-striped table-bordered table-hover" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" runat="server" DataSourceID="TIMETABLESEARCHDS2">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nt_id" SortExpression="nt_id" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="hidden-print nav-search-input" Width="210"></asp:TextBox>
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="hidden-print" CommandName="Search" />
                                            </HeaderTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Teacher's Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcname" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                        <asp:BoundField DataField="strSection" SortExpression="strSection" HeaderText="Section" />
                                        <asp:BoundField DataField="strSubject" HeaderText="Subject" SortExpression="strSubject" />
                                        <asp:BoundField DataField="strStartTime" HeaderText="Start Time" SortExpression="strStartTime" />
                                        <asp:BoundField DataField="strEndTime" HeaderText="End Time" SortExpression="strEndTime" />
                                        <asp:BoundField DataField="strShift" HeaderText="Shift" SortExpression="strShift" />
                                        <asp:BoundField DataField="strStartDate" HeaderText="Schedule Date" SortExpression="strStartDate" />
                                        <asp:BoundField DataField="strEndDate" HeaderText="End Date" SortExpression="strEndDate" />
                                        <asp:BoundField DataField="strPeriod" HeaderText="Period" SortExpression="strPeriod" />
                                        <asp:BoundField DataField="strDay" HeaderText="Day" SortExpression="strDay" />
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
                                <asp:SqlDataSource runat="server" ID="TIMETABLESEARCHDS2" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="select t.strPeriod,t.strDay,t.nt_id,c.strClass,sc.strSection,s.strSubject,u.strfname,u.strfname+' '+u.strlname as name,t.strStartTime,t.strEndTime,t.strShift,shdl.strStartDate,shdl.strEndDate,p.strPeriod,shdl.strtimetable from tbl_TimeTable t inner join tbl_Class c on t.nc_id=c.nc_id inner join tbl_Subject s on t.nsbj_id=s.nsbj_id inner join tbl_Users u on t.nu_id=u.nu_id inner join tbl_Section sc on t.nsc_id=sc.nsc_id inner join tbl_Schedule shdl on t.nshdule_id=shdl.nshd_id inner join tbl_Period p on t.np_id=p.np_id where t.bisDeleted='False'  and c.bisDeleted='False' and s.bisDeleted='False' and u.bisDeleted='False' and sc.bisDeleted='False' and p.bisDeleted='False' and shdl.bisDeleted='False' and t.nsch_id=@schid and t.strType='Class' and t.nshdule_id=@shdulid and t.strDay=@day and t.nu_id=@tchid Order by strClass,strSection">
                                    <SelectParameters>
                                        <asp:SessionParameter SessionField="nschoolid" DefaultValue="1" Name="schid"></asp:SessionParameter>
                                        <asp:ControlParameter ControlID="dddlTimetable2" PropertyName="SelectedValue" DefaultValue="1" Name="shdulid"></asp:ControlParameter>
                                        <asp:ControlParameter ControlID="dddlDay2" PropertyName="SelectedValue" DefaultValue="0" Name="day"></asp:ControlParameter>
                                        <asp:ControlParameter ControlID="dddltchr2" PropertyName="SelectedValue" DefaultValue="0" Name="tchid"></asp:ControlParameter>


                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </asp:View>
                        <asp:View ID="View10" runat="server">

                            <h4 class="header green lighter bigger">
                                <i class="icon-group blue"></i>
                                Time Table By Class and Teacher and Day
                            </h4>


                            <asp:Button ID="Button2" runat="server" Text="Back" class="width-10 pull-left btn btn-sm btn-success" OnClick="btn_BACK1_Click" />

                            <div class="space-24"></div>
                            <div class="space-24"></div>
                            <div id="printable3" class="table-responsive">
                                <div class="widget-header header-color-blue">
                                    <h5 class="bigger lighter">
                                        <i class="icon-table"></i>
                                        Time Table
                                    </h5>

                                    <div class="widget-toolbar widget-toolbar-light no-border">
                                        <div class="hidden-print icon-print icon-2x" onclick="printDiv('printable3')"></div>
                                    </div>
                                </div>
                                <asp:DropDownList AutoPostBack="true" ID="dddlTimeTable3" runat="server" DataSourceID="dddlTimeTable3DS" DataTextField="strtimetable" DataValueField="nshd_id" AppendDataBoundItems="true">
                                    <asp:ListItem Value="0">---Select Time Table---</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="dddlTimeTable3DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strtimetable], [nshd_id] FROM [tbl_Schedule] WHERE ([bisDeleted] = @bisDeleted) and nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <% 
                                    dddlTimeTable3.SelectedValue = Session["nshduleid"].ToString();
                                            
                                %>
                                <asp:DropDownList AutoPostBack="true" ID="dddlcl3" OnSelectedIndexChanged="dddlcl_SelectedIndexChanged" runat="server" DataTextField="strClass" DataValueField="nc_id" AppendDataBoundItems="true" DataSourceID="dddlcl3DS">
                                    <asp:ListItem Value="0">---Select Class---</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="dddlcl3DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nc_id], [strClass] FROM [tbl_Class] WHERE (([bisDeleted] = @bisDeleted) AND ([nsch_id] = @nsch_id))">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                        <asp:SessionParameter SessionField="nschoolid" DefaultValue="1" Name="nsch_id" Type="Int32"></asp:SessionParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:DropDownList AutoPostBack="true" ID="dddltchr3" runat="server" DataTextField="name" DataValueField="nu_id" AppendDataBoundItems="true" DataSourceID="dddltchr3DS">
                                    <asp:ListItem Value="0">---Select Teacher Table---</asp:ListItem>
                                </asp:DropDownList>


                                <asp:SqlDataSource runat="server" ID="dddltchr3DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nu_id], [strfname]+' '+[strlname] as name FROM [tbl_Users] WHERE (([bisDeleted] = @bisDeleted) AND ([nLevel] = @nLevel) AND ([nsch_id] = @nsch_id))">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="bisDeleted"></asp:Parameter>
                                        <asp:Parameter DefaultValue="2" Name="nLevel"></asp:Parameter>
                                        <asp:SessionParameter SessionField="nschoolid" DefaultValue="1" Name="nsch_id"></asp:SessionParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:DropDownList AutoPostBack="true" ID="dddlday3" runat="server" DataTextField="strDayName" DataValueField="strDayName" AppendDataBoundItems="true" DataSourceID="dddlday3DS">
                                    <asp:ListItem Value="0">---Select Day---</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="dddlday3DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nDay_id], [strDayName] FROM [tbl_Day]"></asp:SqlDataSource>
                                <asp:GridView ID="GridView3" class="table table-striped table-bordered table-hover" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" runat="server" DataSourceID="TIMETABLESEARCHDS3">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nt_id" SortExpression="nt_id" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="hidden-print nav-search-input" Width="210"></asp:TextBox>
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="hidden-print" CommandName="Search" />
                                            </HeaderTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Teacher's Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcname" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                        <asp:BoundField DataField="strSection" SortExpression="strSection" HeaderText="Section" />
                                        <asp:BoundField DataField="strSubject" HeaderText="Subject" SortExpression="strSubject" />
                                        <asp:BoundField DataField="strStartTime" HeaderText="Start Time" SortExpression="strStartTime" />
                                        <asp:BoundField DataField="strEndTime" HeaderText="End Time" SortExpression="strEndTime" />
                                        <asp:BoundField DataField="strShift" HeaderText="Shift" SortExpression="strShift" />
                                        <asp:BoundField DataField="strStartDate" HeaderText="Schedule Date" SortExpression="strStartDate" />
                                        <asp:BoundField DataField="strEndDate" HeaderText="End Date" SortExpression="strEndDate" />
                                        <asp:BoundField DataField="strPeriod" HeaderText="Period" SortExpression="strPeriod" />
                                        <asp:BoundField DataField="strDay" HeaderText="Day" SortExpression="strDay" />
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
                                <asp:SqlDataSource runat="server" ID="TIMETABLESEARCHDS3" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="select p.strPeriod,t.strDay,t.nt_id,c.strClass,sc.strSection,s.strSubject,u.strfname,u.strfname+' '+u.strlname as name,p.strStartTime,p.strEndTime,t.strShift,shdl.strStartDate,shdl.strEndDate,shdl.strtimetable from tbl_TimeTable t inner join tbl_Class c on t.nc_id=c.nc_id inner join tbl_Subject s on t.nsbj_id=s.nsbj_id inner join tbl_Users u on t.nu_id=u.nu_id inner join tbl_Section sc on t.nsc_id=sc.nsc_id inner join tbl_Schedule shdl on t.nshdule_id=shdl.nshd_id inner join tbl_Period p on t.np_id=p.np_id where t.bisDeleted='False' and c.bisDeleted='False' and s.bisDeleted='False' and u.bisDeleted='False' and sc.bisDeleted='False' and p.bisDeleted='False' and shdl.bisDeleted='False' and t.nsch_id=@schid and t.strType='Class' and t.nshdule_id=@shdulid and t.strDay=@day and t.nu_id=@tchid and t.nc_id=@cid Order by strClass,strSection">
                                    <SelectParameters>
                                        <asp:SessionParameter SessionField="nschoolid" DefaultValue="1" Name="schid"></asp:SessionParameter>
                                        <asp:ControlParameter ControlID="dddlTimetable3" PropertyName="SelectedValue" DefaultValue="1" Name="shdulid"></asp:ControlParameter>
                                        <asp:ControlParameter ControlID="dddlDay3" PropertyName="SelectedValue" DefaultValue="0" Name="day"></asp:ControlParameter>
                                        <asp:ControlParameter ControlID="dddltchr3" PropertyName="SelectedValue" DefaultValue="0" Name="tchid"></asp:ControlParameter>
                                        <asp:ControlParameter ControlID="dddlcl3" PropertyName="SelectedValue" DefaultValue="0" Name="cid"></asp:ControlParameter>

                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </asp:View>
                        <asp:View ID="View11" runat="server">

                            <h4 class="header green lighter bigger">
                                <i class="icon-group blue"></i>
                                Time Table By Class and Day
                            </h4>


                            <asp:Button ID="Button3" runat="server" Text="Back" class="width-10 pull-left btn btn-sm btn-success" OnClick="btn_BACK1_Click" />

                            <div class="space-24"></div>
                            <div class="space-24"></div>
                            <div id="printable4" class="table-responsive">
                                <div class="widget-header header-color-blue">
                                    <h5 class="bigger lighter">
                                        <i class="icon-table"></i>
                                        Time Table
                                    </h5>

                                    <div class="widget-toolbar widget-toolbar-light no-border">
                                        <div class="hidden-print icon-print icon-2x" onclick="printDiv('printable4')"></div>
                                    </div>
                                </div>
                                <asp:DropDownList AutoPostBack="true" ID="dddlTimeTable4" runat="server" DataSourceID="dddlTimeTable4DS" DataTextField="strtimetable" DataValueField="nshd_id" AppendDataBoundItems="true">
                                    <asp:ListItem Value="0">---Select Time Table---</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="dddlTimeTable4DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strtimetable], [nshd_id] FROM [tbl_Schedule] WHERE ([bisDeleted] = @bisDeleted) and nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <% 
                                    dddlTimeTable4.SelectedValue = Session["nshduleid"].ToString();
                                            
                                %>
                                <asp:DropDownList AutoPostBack="true" ID="dddlcl4" OnSelectedIndexChanged="dddlcl_SelectedIndexChanged" runat="server" DataTextField="strClass" DataValueField="nc_id" AppendDataBoundItems="true" DataSourceID="dddlcl4DS">
                                    <asp:ListItem Value="0">---Select Class---</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="dddlcl4DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nc_id], [strClass] FROM [tbl_Class] WHERE (([bisDeleted] = @bisDeleted) AND ([nsch_id] = @nsch_id))">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                        <asp:SessionParameter SessionField="nschoolid" DefaultValue="1" Name="nsch_id" Type="Int32"></asp:SessionParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:DropDownList AutoPostBack="true" ID="dddlday4" runat="server" DataTextField="strDayName" DataValueField="strDayName" AppendDataBoundItems="true" DataSourceID="dddlday4DS">
                                    <asp:ListItem Value="0">---Select Day---</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="dddlday4DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nDay_id], [strDayName] FROM [tbl_Day]"></asp:SqlDataSource>
                                <asp:GridView ID="GridView4" class="table table-striped table-bordered table-hover" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" runat="server" DataSourceID="TIMETABLESEARCHDS4">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nt_id" SortExpression="nt_id" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="hidden-print nav-search-input" Width="210"></asp:TextBox>
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="hidden-print" CommandName="Search" />
                                            </HeaderTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Teacher's Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcname" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                        <asp:BoundField DataField="strSection" SortExpression="strSection" HeaderText="Section" />
                                        <asp:BoundField DataField="strSubject" HeaderText="Subject" SortExpression="strSubject" />
                                        <asp:BoundField DataField="strStartTime" HeaderText="Start Time" SortExpression="strStartTime" />
                                        <asp:BoundField DataField="strEndTime" HeaderText="End Time" SortExpression="strEndTime" />
                                        <asp:BoundField DataField="strShift" HeaderText="Shift" SortExpression="strShift" />
                                        <asp:BoundField DataField="strStartDate" HeaderText="Schedule Date" SortExpression="strStartDate" />
                                        <asp:BoundField DataField="strEndDate" HeaderText="End Date" SortExpression="strEndDate" />
                                        <asp:BoundField DataField="strPeriod" HeaderText="Period" SortExpression="strPeriod" />
                                        <asp:BoundField DataField="strDay" HeaderText="Day" SortExpression="strDay" />
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
                                <asp:SqlDataSource runat="server" ID="TIMETABLESEARCHDS4" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="select t.strDay,t.nt_id,c.strClass,sc.strSection,s.strSubject,u.strfname,u.strfname+' '+u.strlname as name,p.strStartTime,p.strEndTime,t.strShift,shdl.strStartDate,shdl.strEndDate,p.strPeriod,shdl.strtimetable from tbl_TimeTable t inner join tbl_Class c on t.nc_id=c.nc_id inner join tbl_Subject s on t.nsbj_id=s.nsbj_id inner join tbl_Users u on t.nu_id=u.nu_id inner join tbl_Section sc on t.nsc_id=sc.nsc_id inner join tbl_Schedule shdl on t.nshdule_id=shdl.nshd_id inner join tbl_Period p on t.np_id=p.np_id where t.bisDeleted='False' and shdl.bisDeleted='False' and c.bisDeleted='False' and s.bisDeleted='False' and u.bisDeleted='False' and sc.bisDeleted='False' and p.bisDeleted='False' and t.nsch_id=@schid and t.strType='Class' and t.nshdule_id=@shdulid and t.strDay=@day and t.nc_id=@cid Order by strClass,strSection">
                                    <SelectParameters>
                                        <asp:SessionParameter SessionField="nschoolid" DefaultValue="1" Name="schid"></asp:SessionParameter>
                                        <asp:ControlParameter ControlID="dddlTimetable4" PropertyName="SelectedValue" DefaultValue="1" Name="shdulid"></asp:ControlParameter>
                                        <asp:ControlParameter ControlID="dddlDay4" PropertyName="SelectedValue" DefaultValue="0" Name="day"></asp:ControlParameter>

                                        <asp:ControlParameter ControlID="dddlcl4" PropertyName="SelectedValue" DefaultValue="0" Name="cid"></asp:ControlParameter>

                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </asp:View>
                        <asp:View ID="View12" runat="server">

                            <h4 class="header green lighter bigger">
                                <i class="icon-group blue"></i>
                                Time Table By Period and Day
                            </h4>


                            <asp:Button ID="Button4" runat="server" Text="Back" class="width-10 pull-left btn btn-sm btn-success" OnClick="btn_BACK1_Click" />

                            <div class="space-24"></div>
                            <div class="space-24"></div>
                            <div id="printable5" class="table-responsive">
                                <div class="widget-header header-color-blue">
                                    <h5 class="bigger lighter">
                                        <i class="icon-table"></i>
                                        Time Table
                                    </h5>

                                    <div class="widget-toolbar widget-toolbar-light no-border">
                                        <div class="hidden-print icon-print icon-2x" onclick="printDiv('printable5')"></div>
                                    </div>
                                </div>
                                <asp:DropDownList AutoPostBack="true" ValidationGroup="dc" OnSelectedIndexChanged="dddlTimeTable5_SelectedIndexChanged" ID="dddlTimeTable5" runat="server" DataSourceID="dddlTimeTable5DS" DataTextField="strtimetable" DataValueField="nshd_id" AppendDataBoundItems="true">
                                    <asp:ListItem Value="0">---Select Time Table---</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="dddlTimeTable5DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strtimetable], [nshd_id] FROM [tbl_Schedule] WHERE ([bisDeleted] = @bisDeleted) and nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <% 
    // dddlTimeTable5.SelectedValue = Session["nshduleid"].ToString();
                                            
                                %>
                                <asp:DropDownList AutoPostBack="true" ID="dddlperiod5" OnSelectedIndexChanged="dddlcl_SelectedIndexChanged" runat="server" AppendDataBoundItems="true" DataTextField="name" DataValueField="np_id">
                                    <%--<asp:ListItem Value="0">---Select Period---</asp:ListItem>--%>
                                </asp:DropDownList>
                                <%--  <asp:SqlDataSource runat="server" ID="dddlperiod5DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strPeriod] FROM [tbl_Period]">
                                </asp:SqlDataSource>--%>

                                <asp:DropDownList AutoPostBack="true" ID="dddlday5" runat="server" DataTextField="strDayName" DataValueField="strDayName" AppendDataBoundItems="true" DataSourceID="dddlday5DS">
                                    <asp:ListItem Value="0">---Select Day---</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="dddlday5DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nDay_id], [strDayName] FROM [tbl_Day]"></asp:SqlDataSource>
                                <asp:GridView ID="GridView5" class="table table-striped table-bordered table-hover" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" runat="server" DataSourceID="TIMETABLESEARCHDS5">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nt_id" SortExpression="nt_id" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="hidden-print nav-search-input" Width="210"></asp:TextBox>
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="hidden-print" CommandName="Search" />
                                            </HeaderTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Teacher's Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcname" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                        <asp:BoundField DataField="strSection" SortExpression="strSection" HeaderText="Section" />
                                        <asp:BoundField DataField="strSubject" HeaderText="Subject" SortExpression="strSubject" />
                                        <asp:BoundField DataField="strStartTime" HeaderText="Start Time" SortExpression="strStartTime" />
                                        <asp:BoundField DataField="strEndTime" HeaderText="End Time" SortExpression="strEndTime" />
                                        <asp:BoundField DataField="strShift" HeaderText="Shift" SortExpression="strShift" />
                                        <asp:BoundField DataField="strStartDate" HeaderText="Schedule Date" SortExpression="strStartDate" />
                                        <asp:BoundField DataField="strEndDate" HeaderText="End Date" SortExpression="strEndDate" />
                                        <asp:BoundField DataField="strPeriod" HeaderText="Period" SortExpression="strPeriod" />
                                        <asp:BoundField DataField="strDay" HeaderText="Day" SortExpression="strDay" />
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
                                <asp:SqlDataSource runat="server" ID="TIMETABLESEARCHDS5" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT p.strPeriod, t.strDay, t.nt_id, c.strClass, sc.strSection, s.strSubject, u.strfname, u.strfname + ' ' + u.strlname AS name, p.strStartTime, p.strEndTime, t.strShift, shdl.strStartDate, shdl.strEndDate,  shdl.strtimetable FROM tbl_TimeTable AS t INNER JOIN tbl_Class AS c ON t.nc_id = c.nc_id INNER JOIN tbl_Subject AS s ON t.nsbj_id = s.nsbj_id INNER JOIN tbl_Users AS u ON t.nu_id = u.nu_id INNER JOIN tbl_Section AS sc ON t.nsc_id = sc.nsc_id INNER JOIN tbl_Schedule AS shdl ON t.nshdule_id = shdl.nshd_id INNER JOIN tbl_Period AS p ON t.np_id = p.np_id WHERE (t.bisDeleted = 'False') AND (shdl.bisDeleted='False') AND (c.bisDeleted='False') AND (s.bisDeleted='False') AND (u.bisDeleted='False') AND (sc.bisDeleted='False') AND (p.bisDeleted='False') AND (t.nsch_id = @schid) AND (t.strType = 'Class') AND (t.nshdule_id = @shdulid) AND (t.strDay = @day) AND (t.np_id = @period) Order by strClass,strSection">
                                    <SelectParameters>
                                        <asp:SessionParameter SessionField="nschoolid" DefaultValue="1" Name="schid"></asp:SessionParameter>
                                        <asp:ControlParameter ControlID="dddlTimetable5" PropertyName="SelectedValue" DefaultValue="1" Name="shdulid"></asp:ControlParameter>
                                        <asp:ControlParameter ControlID="dddlDay5" PropertyName="SelectedValue" DefaultValue="0" Name="day"></asp:ControlParameter>

                                        <asp:ControlParameter ControlID="dddlperiod5" PropertyName="SelectedValue" DefaultValue="0" Name="period"></asp:ControlParameter>

                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </asp:View>
                        
                    </asp:MultiView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="dddlTimeTable5" EventName="SelectedIndexChanged" />
                </Triggers>
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
    <asp:SqlDataSource ID="sqlsubject" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strSubject],[nsbj_id] FROM [tbl_Subject] WHERE ([nc_id] =@cid) AND bisDeleted='False'  and nsch_id=@schid">
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
    <asp:SqlDataSource ID="sqlsec" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT strSection, nsc_id FROM tbl_Section WHERE (nc_id = @cname) AND (bisDeleted = 'False')  and nsch_id=@schid">
        <SelectParameters>
            <asp:SessionParameter Name="schid" SessionField="nschoolid" />


            <asp:ControlParameter ControlID="ddcl" PropertyName="SelectedValue" Name="cname" Type="String" />

        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlsec1" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strSection],[nsc_id] FROM [tbl_Section] WHERE [nc_id] =@cname  and bisDeleted='False'  and nsch_id=@schid">
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
    <asp:SqlDataSource runat="server" ID="PeriodDs" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT np_id, strPeriod, bisDeleted, nsch_id FROM tbl_Period WHERE (bisDeleted = @bit) AND (nsch_id = @schid)">
        <SelectParameters>
            <asp:Parameter DefaultValue="false" Name="bit"></asp:Parameter>
            <asp:SessionParameter SessionField="nschoolid" DefaultValue="" Name="schid"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqltch1" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="select strfname+' '+strlname as name ,nu_id from tbl_Users where nLevel='2' and bisDeleted='False' and nsch_id=@schid">
        <SelectParameters>
            <asp:SessionParameter Name="schid" SessionField="nschoolid" />

        </SelectParameters>
        <%--<SelectParameters>
            <asp:ControlParameter ControlID="ddcl1" PropertyName="SelectedValue" Name="cnm" Type="String" />

        </SelectParameters>--%>
    </asp:SqlDataSource>

</asp:Content>


