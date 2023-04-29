<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherAttendance.aspx.cs" Inherits="SchoolPRO.TeacherAttendance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

                            <div class="col-xs-12">
                                <!-- PAGE CONTENT BEGINS -->

                                <div class="row-fluid">
                                    <h4 class="header green lighter bigger">
                                        <i class="icon-group blue"></i>
                                        Teacher Attendance
                                    </h4>

                                    <div class="space-6"></div>
                                     <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                                    <asp:UpdatePanel ID="upclassview" runat="server">
                                        <ContentTemplate>
                                            <asp:MultiView ID="mvatnd" ActiveViewIndex="0" runat="server">
                                                <asp:View ID="View1" runat="server">
                                                    <asp:Button ID="btngotoAdd" runat="server" Text="Mark Attendance" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                           <div class="table-responsive">
                                               <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true"  DataKeyNames="nta_id" EnableViewState="true">
                                                   <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nta_id" HeaderText="S.NO" SortExpression="nta_id" />
                                                       <asp:BoundField DataField="strfname" SortExpression="strfname" HeaderText="Name" />
                                                       <asp:BoundField DataField="strPresentTime" SortExpression="strPresent Time" HeaderText="Present Time" />
                                                       <asp:BoundField DataField="strLeaveTime" SortExpression="strLeaveTime" HeaderText="Leave Time" />
                                                       <asp:BoundField DataField="bisConfirm" SortExpression="bisConfirm" HeaderText="Confirmation" />
                                                       <asp:BoundField DataField="dtAddDate" SortExpression="dtAddDate" HeaderText="Date" />
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
                                                Manage Attendance
                                            </h4>

                                            <div class="space-6"></div>
                                            <p>Mark your Attendance: </p>
                                    <form id="freg">
                                                <fieldset>
                                                    <label class="block clearfix">
                                                    
                                                        </label>
                                                       <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList CssClass="input-medium" ID="ddstatus" AutoPostBack="true" Enabled="true" runat="server">
                                                                <asp:ListItem Text="Select ..." />
                                                                <asp:ListItem Text="Present" />
                                                                <asp:ListItem Text="Leaving" />
                                                                <asp:ListItem Text="Leave Application" />
                                                            </asp:DropDownList>
                                                            <div class="space-10"></div>
                                                            <asp:FileUpload ID="fulv" runat="server" />
                                                        </span>
                                                    </label>
                                                    
                                                    <div class="space-24"></div>

                                                    <div class="clearfix">
                                                        <asp:Button ID="btnsubmit" runat="server" Text="Submit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnsubmit_Click"/>
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
                                        <Triggers>
                                            <asp:PostBackTrigger ControlID="btnsubmit" />
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

                                    <div class="space-12"></div>

                                    <!-- /.page-content -->
                                </div>
                                <!-- /.main-content -->

                            </div>
        
</asp:Content>
