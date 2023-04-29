<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageMessage.aspx.cs" Inherits="SchoolPRO.AdminManageMessage" %>
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
													Messages List
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
                                     <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nMsg_id" DataSourceID="Event">
                                         <Columns>
                                             <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                             <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nMsg_id" HeaderText="nMsg_id" SortExpression="nMsg_id" ReadOnly="True" />
                                             <asp:BoundField DataField="strMsgTitle" HeaderText="Msg Title" SortExpression="strMsgTitle"></asp:BoundField>
                                             <asp:BoundField DataField="strMsgDesc" HeaderText="Msg Desc" SortExpression="strMsgDesc"></asp:BoundField>
                                             <asp:BoundField DataField="SenderUserName" HeaderText="Sender User Name" SortExpression="SenderUserName" ReadOnly="True"></asp:BoundField>

                                             <asp:BoundField DataField="RcvrUserName" SortExpression="Rcvr User Name" HeaderText="RcvrUserName" ReadOnly="True" />

                                             <asp:BoundField DataField="SenderStudentName" HeaderText="Sender Student Name" ReadOnly="True" SortExpression="SenderStudentName"></asp:BoundField>
                                             <asp:BoundField DataField="RcvrStudentName" HeaderText="Rcvr Student Name" ReadOnly="True" SortExpression="RcvrStudentName"></asp:BoundField>
                                             <asp:CheckBoxField DataField="bisRead" HeaderText="bisRead" SortExpression="bisRead"></asp:CheckBoxField>
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
                                     <%--            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print" >
                                                <ItemTemplate>
                                                    <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnedit_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <ItemTemplate>
                                                    <asp:Button ID="btndel" runat="server" Text="Delete" class="width-65 pull-right btn btn-sm btn-success" OnClick="btndel_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>                         --%>
                                     <asp:SqlDataSource runat="server" ID="Event" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Message.nMsg_id, tbl_Message.strMsgTitle, tbl_Message.strMsgDesc, tbl_Users.strfname + ' ' + tbl_Users.strlname AS SenderUserName, tbl_Users_1.strfname + ' ' + tbl_Users_1.strlname AS RcvrUserName, tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS SenderStudentName, tbl_Enrollment_1.strFname + ' ' + tbl_Enrollment_1.strLname AS RcvrStudentName, tbl_Message.bisRead FROM tbl_Message INNER JOIN tbl_Users ON tbl_Message.nU_sndr_id = tbl_Users.nu_id INNER JOIN tbl_Users AS tbl_Users_1 ON tbl_Message.nU_rcv_id = tbl_Users.nu_id INNER JOIN tbl_Enrollment ON tbl_Message.nE_rcv_id = tbl_Enrollment.ne_id INNER JOIN tbl_Enrollment AS tbl_Enrollment_1 ON tbl_Message.nE_sndr_id = tbl_Enrollment.ne_id WHERE (tbl_Message.bisDeleted = 'False') and tbl_Message.nsch_id=@schid">
                                     <SelectParameters>
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
                                                         Messages
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p </p>
                                                    <form id="freg4">
                                                        <fieldset>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtupMessagetitle" class="form-control" placeholder="Message title" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3up" runat="server" ErrorMessage="Enter Event Name" ControlToValidate="txtupeventtitle"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtupMessagedesc" class="form-control" placeholder="Description" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4up" runat="server" ErrorMessage="Enter Description" ControlToValidate="txtupeventdesc"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                             <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="txtupstdate" class="form-control" runat="server"></asp:DropDownList>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1up" runat="server" ErrorMessage="Enter Start Date" ControlToValidate="txtupstdate"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            
                                                           
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnupMessage" runat="server" Text="Update" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnupMessage_Click" />
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
                                                        Manage Messages
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Event Name: </p>
                                                    <form id="Form2">
                                                        <fieldset>

                                                            <label class="block clearfix">

                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtaddMessagetitle" class="form-control" placeholder="Message title" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Message Name" ControlToValidate="txtaddMessagetitle"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <p>Enter Event Description: </p>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtaddMessagedesc" class="form-control" placeholder="Description" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Description" ControlToValidate="txtaddMessagedesc"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <p>Select User to Send  : </p>
                                                             <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddladduser" class="form-control" runat="server"></asp:DropDownList>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage=" ControlToValidate="ddladduser"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                           
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnaddMessage" runat="server" Text="Add Message" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddMessage_Click" />
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
