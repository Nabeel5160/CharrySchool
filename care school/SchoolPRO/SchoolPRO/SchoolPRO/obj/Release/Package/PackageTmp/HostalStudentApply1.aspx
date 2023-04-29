<%@ Page Title="" Language="C#" MasterPageFile="~/Hostel.Master" AutoEventWireup="true" CodeBehind="HostalStudentApply1.aspx.cs" Inherits="SchoolPRO.HostalStudentApply1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <%--<asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>--%>
                <asp:ToolkitScriptManager ID="tool1" runat="server"></asp:ToolkitScriptManager>
                <asp:UpdatePanel ID="upt" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">

                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                <div class="table-responsive">
                                    <asp:GridView ID="gvdep" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="DSStdReg">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name"></asp:BoundField>
                                            <asp:BoundField DataField="Phone #" HeaderText="Phone #" SortExpression="Phone #"></asp:BoundField>
                                            <asp:BoundField DataField="Shift" HeaderText="Shift" SortExpression="Shift"></asp:BoundField>
                                            <asp:BoundField DataField="Admission #" HeaderText="Admission #" SortExpression="Admission #"></asp:BoundField>
                                            <asp:BoundField DataField="Intrest" HeaderText="Intrest" SortExpression="Intrest"></asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource runat="server" ID="DSStdReg" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_ManageHostalStudent.strFname + ' ' + tbl_ManageHostalStudent.strLname AS 'Name', tbl_ManageHostalStudent.strPhone AS 'Phone #', tbl_ManageHostalStudent.strShift AS 'Shift', tbl_ManageHostalStudent.strAdmissionNumber AS 'Admission #', tbl_Enrollment.strInterest AS 'Intrest' FROM tbl_ManageHostalStudent INNER JOIN tbl_Enrollment ON tbl_ManageHostalStudent.ne_id = tbl_Enrollment.ne_id WHERE (tbl_ManageHostalStudent.bisDeleted = @fbit) AND (tbl_Enrollment.bisDeleted = @fbit)">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <div class="space-4"></div>
                                </div>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <div>
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="col-lg-offset-3 col col-lg-6" style="background: #f2f2f2;">

                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Student Registration
                                                    </h4>
                                                    <div class="space-6"></div>
                                                    <p>Enter details to begin: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <div class="form-group">
                                                                <div class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtregno" class="form-control" AutoPostBack="true" placeholder="Registration Number" OnTextChanged="txtregno_TextChanged" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter First name" ControlToValidate="txtfn"></asp:RequiredFieldValidator>
                                                                </div>
                                                                <div class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtfn" class="form-control" placeholder="First Name" ReadOnly="true" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter First name" ControlToValidate="txtfn"></asp:RequiredFieldValidator>
                                                                </div>
                                                                <div class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtln" class="form-control" placeholder="Last Name" ReadOnly="true" Text="" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </div>
                                                                <br />
                                                                <div class="block input-icon input-icon-right">
                                                                    <i class="icon-time"></i>
                                                                    <asp:TextBox ID="txtdob" class="form-control" placeholder="Date of Birth (dd-MM-yyyy)" ReadOnly="true" runat="server" MaxLength="10"></asp:TextBox>
                                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtdob" runat="server"></asp:CalendarExtender>
                                                                    <%--<label id='lblCaption' style="font-family: Tahoma; font-size: 1em; font-weight: bold" cssclass="red"></label>--%>


                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Date of Birth" ControlToValidate="txtdob"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="birthdatecheck" runat="server" ValidationGroup="loan" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ForeColor="Red" Font-Bold="true" ControlToValidate="txtdob" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtad" class="form-control" placeholder="Admission Number" ReadOnly="true" runat="server"></asp:TextBox>
                                                                    <i class="icon-pencil"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Admission Number" ControlToValidate="txtad"></asp:RequiredFieldValidator>
                                                                </div>

                                                                <div class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtadrs" class="form-control" placeholder="Address" ReadOnly="true" runat="server"></asp:TextBox>
                                                                    <i class="icon-home"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Address" ControlToValidate="txtadrs"></asp:RequiredFieldValidator>
                                                                </div>
                                                                <div class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtnic" class="form-control" placeholder="NIC" ReadOnly="true" runat="server"></asp:TextBox>
                                                                    <i class="icon-home"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter Address" ControlToValidate="txtnic"></asp:RequiredFieldValidator>
                                                                </div>
                                                                <div class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtshft" class="form-control" placeholder="Shift" ReadOnly="true" runat="server"></asp:TextBox>
                                                                    <i class="icon-home"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator8" runat="server" ErrorMessage="Enter Address" ControlToValidate="txtshft"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtcity" class="form-control" placeholder="City" ReadOnly="true" runat="server"></asp:TextBox>
                                                                    <i class="icon-home"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator7" runat="server" ErrorMessage="Enter City" ControlToValidate="txtcity"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtcntry" class="form-control" placeholder="Country" ReadOnly="true" runat="server"></asp:TextBox>
                                                                    <i class="icon-home"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator9" runat="server" ErrorMessage="Enter Country" ControlToValidate="txtcntry"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtphn" class="form-control" placeholder="Phone" ReadOnly="true" runat="server"></asp:TextBox>
                                                                    <i class="icon-mobile-phone"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator11" runat="server" ErrorMessage="Enter Phone" ControlToValidate="txtphn"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtem" TextMode="Email" class="form-control" ReadOnly="true" placeholder="Email" runat="server"></asp:TextBox>
                                                                    <i class="icon-envelope"></i>
                                                                    <asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter Email" ControlToValidate="txtem" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btntreg" runat="server" Text="Register" class="width-40 pull-right btn btn-sm btn-success" OnClick="btntreg_Click" />
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
        </div>
    </div>
</asp:Content>
