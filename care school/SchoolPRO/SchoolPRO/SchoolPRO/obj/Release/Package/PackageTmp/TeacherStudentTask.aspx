<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherStudentTask.aspx.cs" Inherits="SchoolPRO.TeacherStudentTask" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ToolkitScriptManager runat="server"></asp:ToolkitScriptManager>
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Student Task
            </h4>
            <div class="space-6"></div>
            <asp:UpdatePanel ID="upquiz" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvquiz" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                            <div class="table-responsive">
                                <asp:GridView ID="gvsearchsub" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvsearchsub_RowCommand" DataKeyNames="nntf_id" EnableViewState="true">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nntf_id" HeaderText="S.NO" SortExpression="n_id" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                            </HeaderTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                        <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                        <asp:TemplateField HeaderText="Subject">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strSubject") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="strTitle" SortExpression="strTitle" HeaderText="Title" />
                                        <asp:BoundField DataField="strDesc" SortExpression="strDesc" HeaderText="Topic" />
                                        <asp:BoundField DataField="dtDate" SortExpression="dtDate" HeaderText="Due Date" />
                                        <asp:BoundField DataField="strTime" SortExpression="strTime" HeaderText="Time" />
                                        <asp:BoundField DataField="dt" SortExpression="dt" HeaderText="Assign Date" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-85 pull-left btn btn-sm btn-success" OnClick="btnedit_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btndel" runat="server" Text="Delete" class="width-85 pull-left btn btn-sm btn-success" OnClick="btndel_Click" />
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
                                                    Add Quiz|Assignments|Home-Work
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Enter details according to their Classes and Subjects: </p>
                                                <form id="freg">
                                                    <fieldset>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddcl" CssClass="input-medium" runat="server" DataSourceID="sqlClass" AutoPostBack="true" ViewStateMode="Enabled" DataTextField="strClass" DataValueField="id"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddsec" CssClass="input-medium" runat="server" DataSourceID="sqlsec" DataTextField="strSection" DataValueField="id"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddsub" runat="server" DataSourceID="sqlsub" DataTextField="name" DataValueField="id"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txttitle" placeholder="Quiz|Assignment|Home-Work..." CssClass="form-actions" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtQuizTopic" TextMode="MultiLine" placeholder="Task..." CssClass="form-actions" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtdate" placeholder="dd-MM-yyyy" CssClass="form-actions" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtdate" runat="server"></asp:CalendarExtender>
                                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator21" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression="^[\s\S]{10,10}$" ControlToValidate="txtdate"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressiossnValidator5" runat="server" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ForeColor="Red" Font-Bold="true" ControlToValidate="txtdate" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>

                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txttime" TextMode="Time" CssClass="form-actions" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:FileUpload ID="fudoc" runat="server" />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <asp:Button ID="btnaddQuiz" runat="server" Text="Add" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddQuiz_Click" />
                                                        </div>
                                                    </fieldset>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <asp:SqlDataSource ID="sqlClass" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT DISTINCT tbl_Users.strfname + ' ' + tbl_Users.strlname AS teachername, tbl_Class.strClass, tbl_TimeTable.nc_id AS id FROM tbl_TimeTable INNER JOIN tbl_Users ON tbl_TimeTable.nu_id = tbl_Users.nu_id INNER JOIN tbl_Class ON tbl_TimeTable.nc_id = tbl_Class.nc_id WHERE (tbl_Users.nsch_id = @schid) AND (tbl_Users.bisDeleted = @fbit) AND (tbl_TimeTable.nsch_id = @schid) AND (tbl_TimeTable.bisDeleted = @fbit) AND (tbl_Class.nsch_id = @schid) AND (tbl_Class.bisDeleted = @fbit) AND (tbl_TimeTable.nu_id = @id)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                    <asp:SessionParameter Name="id" SessionField="uid" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="sqlsec" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT DISTINCT tbl_Users.strfname + ' ' + tbl_Users.strmname AS tname, tbl_Class.strClass, tbl_Section.strSection,tbl_Section.nsc_id as id FROM tbl_TimeTable INNER JOIN tbl_Class ON tbl_TimeTable.nc_id = tbl_Class.nc_id INNER JOIN tbl_Users ON tbl_TimeTable.nu_id = tbl_Users.nu_id INNER JOIN tbl_Section ON tbl_TimeTable.nsc_id = tbl_Section.nsc_id WHERE (tbl_Users.nsch_id = @schid) AND (tbl_Users.bisDeleted = @fbit) AND (tbl_TimeTable.nsch_id = @schid) AND (tbl_TimeTable.bisDeleted = @fbit) AND (tbl_Class.nsch_id = @schid) AND (tbl_Class.bisDeleted = @fbit) AND (tbl_TimeTable.nu_id = @id) AND (tbl_Section.bisDeleted = @fbit) AND (tbl_TimeTable.nc_id = @cid)">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="nschoolid" DefaultValue="0" Name="schid"></asp:SessionParameter>
                                    <asp:Parameter DefaultValue="false" Name="fbit"></asp:Parameter>
                                    <asp:SessionParameter SessionField="uid" DefaultValue="0" Name="id"></asp:SessionParameter>
                                    <asp:ControlParameter ControlID="ddcl" PropertyName="SelectedValue" Name="cid"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <%--    <asp:SqlDataSource ID="sqlcc" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strCourseCode] FROM [tbl_Subject] WHERE ([nc_id] = (select nc_id from tbl_Class where strClass=@cname and bisDeleted=0 and nsch_id=@schid))and bisDeleted=0 and nsch_id=@schid">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddcl" PropertyName="SelectedValue" Name="cname" Type="String" />
                                    <asp:SessionParameter SessionField="nschoolid" DefaultValue="0" Name="schid"></asp:SessionParameter>

                                </SelectParameters>
                            </asp:SqlDataSource>--%>
                            <asp:SqlDataSource ID="sqlsub" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT DISTINCT tbl_Subject.strSubject AS name, tbl_Subject.nsbj_id AS id FROM tbl_TimeTable INNER JOIN tbl_Subject ON tbl_TimeTable.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Class ON tbl_TimeTable.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_TimeTable.nsc_id = tbl_Section.nsc_id INNER JOIN tbl_Users ON tbl_TimeTable.nu_id = tbl_Users.nu_id WHERE (tbl_Users.nsch_id = @schid) AND (tbl_Users.bisDeleted = @fbit) AND (tbl_TimeTable.nsch_id = @schid) AND (tbl_TimeTable.bisDeleted = @fbit) AND (tbl_Class.nsch_id = @schid) AND (tbl_Class.bisDeleted = @fbit) AND (tbl_TimeTable.nu_id = @id) AND (tbl_Section.bisDeleted = @fbit) AND (tbl_TimeTable.nc_id = @cid) AND (tbl_TimeTable.nsc_id = @scid)">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                    <asp:Parameter DefaultValue="false" Name="fbit"></asp:Parameter>
                                    <asp:SessionParameter SessionField="uid" DefaultValue="" Name="id"></asp:SessionParameter>
                                    <asp:ControlParameter ControlID="ddcl" PropertyName="SelectedValue" DefaultValue="0" Name="cid"></asp:ControlParameter>
                                    <asp:ControlParameter ControlID="ddsec" PropertyName="SelectedValue" DefaultValue="0" Name="scid"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </asp:View>
                        <asp:View ID="View3" runat="server">
                            <div class="login-container">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Update here
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Enter details according to their Classes and Subjects: </p>
                                                <form id="Form2">
                                                    <fieldset>
                                                        <p>Topic: </p>
                                                        <asp:Label ID="lbltopic" runat="server"></asp:Label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtecl" ReadOnly="true" CssClass="input-medium" runat="server" />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtesec" ReadOnly="true" CssClass="input-medium" runat="server" />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtesub" ReadOnly="true" CssClass="input-medium" runat="server" />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtetsk" placeholder="Quiz|Assignment|Home-Work..." CssClass="form-actions" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtedsc" TextMode="MultiLine" placeholder="Task..." CssClass="form-actions" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtedt" CssClass="form-actions" placeholder="dd-MM-yyyy" runat="server"></asp:TextBox>
                                                                <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtedt" runat="server"></asp:CalendarExtender>
                                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression="^[\s\S]{10,10}$" ControlToValidate="txtedt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ForeColor="Red" Font-Bold="true" ControlToValidate="txtedt" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>

                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtetim" TextMode="Time" CssClass="form-actions" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>

                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <asp:Button ID="btnupdateQuiz" runat="server" Text="Update" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnupdateQuiz_Click" />

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
</asp:Content>

