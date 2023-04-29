<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminUpgradeTeacherDesignation.aspx.cs" Inherits="SchoolPRO.AdminUpgradeTeacherDesignation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Upgrade Teacher Designation
                </h4>

                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="MultiView1" ActiveViewIndex="0" runat="server">
              <%--              <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                               <div class="space-30"></div>
                                 <div id="printable" class="table-responsive">
                                    <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Designation List
												</h5>

												<div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                    <asp:GridView ID="gvDesig" class="table table-striped table-bordered table-hover" runat="server" OnPageIndexChanging="gvDesig_PageIndexChanging" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvDesig_RowCommand" OnRowUpdating="gvDesig_RowUpdating" DataKeyNames="nDesg_id" EnableViewState="true">
                                        <Columns>
                                            <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nDpt_id" HeaderText="S.NO" SortExpression="nc_id" />
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <HeaderTemplate>
                                                    <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                                </HeaderTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Department">
                                                <ItemTemplate>
                                                    <%--<asp:Label ID="lblcname" runat="server" Text='<%# Highlight(Eval("c_name").ToString()) %>'></asp:Label>--%
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strDptName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strDptCode" SortExpression="strDptCode" HeaderText="Code" />
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
                            </asp:View>--%>
                        <%--    <asp:View ID="View2" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Designation
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Designation Name: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtupDesig" class="form-control" placeholder="Designation Name" runat="server"></asp:TextBox>
                                                                    <asp:TextBox ReadOnly="true" ID="txtupDesigCode" runat="server" class="form-control" placeholder="Designation Code"></asp:TextBox>
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

                            </asp:View>--%>
                            <asp:View ID="View3" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Upgrade Designation
                                                    </h4>

                                                    <div class="space-6"></div>
                                                   
                                                    <form id="Form2">
                                                        <fieldset>

                                                            <label class="block clearfix">
                                                                <p> Select Department: </p>
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="ddldpt_SelectedIndexChanged" ID="ddldpt" class="form-control" runat="server" DataSourceID="ddldptDS" DataTextField="name" DataValueField="nDpt_id" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="--Please Select Department--" />

                                                             </asp:DropDownList>
                                                             <asp:SqlDataSource   runat="server" ID="ddldptDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nDpt_id], [strDptName]+' '+[strDptCode] as name FROM [tbl_TeacherDepartment] WHERE (([bisDeleted] = @bisDeleted) AND ([nsch_id] = @nsch_id))">
                                                                 <SelectParameters>
                                                                     <asp:Parameter DefaultValue="False" Name="bisDeleted"></asp:Parameter>
                                                                     <asp:SessionParameter SessionField="nschoolid" DefaultValue="" Name="nsch_id"></asp:SessionParameter>
                                                                 </SelectParameters>
                                                             </asp:SqlDataSource>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                 <p> Select Teacher: </p>
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList OnSelectedIndexChanged="ddltch_SelectedIndexChanged" AutoPostBack="true" ID="ddltch" runat="server" DataTextField="name" class="form-control" AppendDataBoundItems="true" DataValueField="nu_id" >
                                                                    
                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource runat="server" ID="ddltchDs" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Users.nu_id, tbl_Users.strfname + ' ' + tbl_Users.strlname + ' ' + tbl_Designation.strDesgName AS name, tbl_Users.nsch_id FROM tbl_Users LEFT OUTER JOIN tbl_Designation ON tbl_Users.nDesg_id = tbl_Designation.nDesg_id WHERE (tbl_Users.nLevel = '2') AND (tbl_Users.bisDeleted = 'False') AND (tbl_Users.nsch_id = @schid) AND (tbl_Users.nDpt_id = @dptid)">
                                                                        <SelectParameters>
                                                                            <asp:SessionParameter SessionField="nschoolid" DefaultValue="0" Name="schid"></asp:SessionParameter>
                                                                            <asp:ControlParameter ControlID="ddldpt" PropertyName="SelectedValue" DefaultValue="0" Name="dptid"></asp:ControlParameter>
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                    
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                 <p> Select New Designation: </p>
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList AutoPostBack="true" ID="ddldesg" class="form-control" runat="server"  DataTextField="name" DataValueField="nDesg_id" AppendDataBoundItems="true" >
                                                                        

                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nDesg_id, strDesgName + ' ' + strDesgCode AS name FROM tbl_Designation AS desg WHERE (bisDeleted = 'False') AND (nsch_id = @schid) AND (nDesg_id <> (SELECT nDesg_id FROM tbl_Users WHERE (nu_id = @tchid) AND (bisDeleted = 'False') AND (nsch_id = @schid)))">
                                                                        <SelectParameters>
                                                                            <asp:SessionParameter SessionField="nschoolid" DefaultValue="0" Name="schid"></asp:SessionParameter>
                                                                            <asp:ControlParameter ControlID="ddltch" PropertyName="SelectedValue"  Name="tchid"></asp:ControlParameter>
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                </span>
                                                            </label>
                                                           
                                                            <p> Enter Increment Salary in %: </p>
                                                             <div class="block input-icon input-icon-right">
                                                                    <asp:TextBox AutoPostBack="true" OnTextChanged="txtsal_TextChanged" ID="txtsal" class="form-control" placeholder="Enter Increment Salary" runat="server"></asp:TextBox>
                                                                    <i class="icon-pencil"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Increment Salary" ControlToValidate="txtsal"></asp:RequiredFieldValidator>
                                                             </div>
                                                             <div class="space-24"></div>
                                                            <div class="clearfix">
                                                                <asp:Button ID="btnaddclass" runat="server" Text="Upgrade Designation" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddclass_Click" />
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
