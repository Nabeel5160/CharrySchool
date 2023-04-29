<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageEvent.aspx.cs" Inherits="SchoolPRO.AdminManageEvent" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    
                </h4>

                <div class="space-6"></div>
               <%-- <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>--%>
                 <asp:ToolkitScriptManager  ID="tool1" runat="server"  ></asp:ToolkitScriptManager>
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
													Events List
												</h5>

												<div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                    <%-- <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>--%>
                                     <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server"  AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nevent_id"  DataSourceID="Event">
                                         <Columns>
                                             <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                             <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nevent_id" HeaderText="nevent_id" SortExpression="nevent_id" InsertVisible="False" ReadOnly="True" />
                                             <asp:BoundField DataField="strtitle" HeaderText="Event Title" SortExpression="strtitle"></asp:BoundField>
                                             <asp:BoundField DataField="strDesc" HeaderText="Event Description" SortExpression="strtitle"></asp:BoundField>
                                             <%--<asp:BoundField DataField="dtStartDate" HeaderText="Event Start Date" SortExpression="dtStartDate"></asp:BoundField>--%>

                                             <asp:BoundField DataField="dtEndDate" SortExpression= "Event EndDate" HeaderText="End Date" />

                                             <asp:CheckBoxField DataField="bisActive" HeaderText="Active" SortExpression="bisActive"></asp:CheckBoxField>
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
                                     <%--                                     --%>
                                     <asp:SqlDataSource runat="server" ID="Event" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nevent_id],[strDesc], [strtitle], [dtStartDate], [dtEndDate], [bisActive] FROM [tbl_Event] WHERE ([bisDeleted] = @bisDeleted) and nsch_id=@schid">
                                         <SelectParameters>
                                             <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                             <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                         </SelectParameters>
                                     </asp:SqlDataSource>
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
                                                        Manage Events
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p </p>
                                                    <form id="freg4">
                                                        <fieldset>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtupventtitle" class="form-control" placeholder="Event title" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3up" runat="server" ErrorMessage="Enter Event Name" ControlToValidate="txtupeventtitle"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtupeventdesc" class="form-control" placeholder="Description" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4up" runat="server" ErrorMessage="Enter Description" ControlToValidate="txtupeventdesc"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                             <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtupstdate" class="form-control" placeholder="Start Date"  runat="server"></asp:TextBox>
                                                                     <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtupstdate" runat="server"></asp:CalendarExtender>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1up" runat="server" ErrorMessage="Enter Start Date" ControlToValidate="txtupstdate"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                             <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtupeddate" class="form-control" placeholder="End Date" AutoPostBack="true" OnTextChanged="txtupeddate_TextChanged" runat="server"></asp:TextBox>
                                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtupeddate" runat="server"></asp:CalendarExtender>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2up" runat="server" ErrorMessage="Enter End Date" ControlToValidate="txtupeddate"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:CheckBox ID="chkboxactive" class="form-control" Text="Active" runat="server"></asp:CheckBox>
                                                                    <i class="icon-user"></i>
                                                                   
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnupevent" runat="server" Text="Add Event" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnupevent_Click" />
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
                                                        Manage Events
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Event Name: </p>
                                                    <form id="Form2">
                                                        <fieldset>

                                                            <label class="block clearfix">

                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtaddeventtitle" class="form-control" placeholder="Event title" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Event Name" ControlToValidate="txtaddeventtitle"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <p>Enter Event Description: </p>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtaddeventdesc" class="form-control" placeholder="Description" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Description" ControlToValidate="txtaddeventdesc"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <p>Enter Event Start Date : </p>
                                                             <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtstdate" class="form-control" placeholder="Start Date"  runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                   <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender3" TargetControlID="txtstdate" runat="server"></asp:CalendarExtender>     
                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator21" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression = "^[\s\S]{10,10}$" ControlToValidate="txtstdate"></asp:RequiredFieldValidator>                                         
<asp:RegularExpressionValidator ID="RegularExpressiossnValidator5" runat="server"  ErrorMessage="Please enter date in dd-mm-yyyy format" Tooltip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ForeColor="Red" Font-Bold="true"   ControlToValidate="txtstdate" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>      



                                                                </span>
                                                            </label>
                                                            <p>Enter Event End Date : </p>
                                                             <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txteddate" class="form-control" placeholder="End Date"  OnTextChanged="txteddate_TextChanged"  AutoPostBack="true" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                   <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender4" TargetControlID="txteddate" runat="server"></asp:CalendarExtender>     
                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression = "^[\s\S]{10,10}$" ControlToValidate="txteddate"></asp:RequiredFieldValidator>                                         
<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"  ErrorMessage="Please enter date in dd-mm-yyyy format" Tooltip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ForeColor="Red" Font-Bold="true"   ControlToValidate="txteddate" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>      

                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnaddevent" runat="server" Text="Add Event" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddevent_Click" />
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
