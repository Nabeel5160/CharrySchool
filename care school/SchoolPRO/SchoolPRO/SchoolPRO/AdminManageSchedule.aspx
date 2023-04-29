<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageSchedule.aspx.cs" Inherits="SchoolPRO.AdminManageSchedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
                              <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Manage Schedule
                </h4>

                <div class="space-6"></div>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvsdl" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View3" runat="server">
                                
                               <div class="space-30"></div>
                                 <div id="Div1" class="table-responsive">
                                     <asp:Button Text="Add" ID="btngotoadd" OnClick="btngotoadd_Click" runat="server" />
                                    <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Schedule List
												</h5>

												<div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                     <asp:GridView ID="gvschedule" class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataKeyNames="nshd_id" DataSourceID="sqlshudel">
                                         <Columns>
                                             <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                             <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nshd_id" HeaderText="nshd_id" SortExpression="nshd_id" InsertVisible="False" ReadOnly="True" />
                                             <asp:BoundField DataField="strtimetable" HeaderText="Time table Name" SortExpression="strtimetable"></asp:BoundField>
                                             <asp:BoundField DataField="strStartDate" HeaderText="Start Date (DD-MM)" SortExpression="strStartDate"></asp:BoundField>

                                             <asp:BoundField DataField="strEndDate" SortExpression="End Date (DD-MM)" HeaderText="End Date (DD-MM)" />

                                             <asp:CheckBoxField DataField="bisActive" HeaderText=" Active" SortExpression="bisActive"></asp:CheckBoxField>
                                         <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print" >
                                                <ItemTemplate>
                                                    <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnedit_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                           <%-- <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <ItemTemplate>
                                                    <asp:Button ID="btndel" runat="server" Text="Delete" class="width-65 pull-right btn btn-sm btn-success" OnClick="btndel_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                                         </Columns>
                                     </asp:GridView>
                                     <asp:SqlDataSource runat="server" ID="sqlshudel" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nshd_id, strtimetable, strStartDate, strEndDate, bisActive FROM tbl_Schedule WHERE (bisDeleted = 'False') and nsch_id=@schid">
                                     <SelectParameters>
                                         <asp:SessionParameter Name="schid" SessionField="nschoolid" />

                                     </SelectParameters>
                                     </asp:SqlDataSource>
                                     <div class="space-4"></div>

                                </div>
                               <%--
                                    <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print" >
                                                <ItemTemplate>
                                                    <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnedit_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <ItemTemplate>
                                                    <asp:Button ID="btndel" runat="server" Text="Delete" class="width-65 pull-right btn btn-sm btn-success" OnClick="btndel_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                            </asp:View>
                            
                            <asp:View ID="v2" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Schedule
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Details</p>
                                                    <form id="Form2">
                                                        <fieldset>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtaddshdlname" class="form-control" placeholder="Name" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Class Name" ControlToValidate="txtaddshdlname"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                             <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <label>Start Date:</label>
                                                                    <asp:TextBox ID="txtaddshdlstdate" class="form-control" placeholder="DD-MM" MaxLength="5" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator CssClass="red" id="ZipCodeValidator"  runat="server" ErrorMessage="Enter Start Date MM-DD" ControlToValidate="txtaddshdlstdate" ValidationExpression="(\d{6})?"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                             <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <label>End Date:</label>
                                                                    <asp:TextBox ID="txtaddshdleddate" class="form-control" placeholder="DD-MM" MaxLength="5" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator CssClass="red" id="ZipCodeValidator" runat="server" ErrorMessage="Enter End Date(MM-DD)" ControlToValidate="txtaddshdleddate" ValidationExpression="(\d{6})?"></asp:RequiredFieldValidator>--%>
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
                                                                <asp:Button ID="btnEidtclass" runat="server" Text="Update" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnEidtclass_Click" />
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
