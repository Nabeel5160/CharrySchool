<%@ Page Title="" Language="C#" MasterPageFile="~/Parent.Master" AutoEventWireup="true" CodeBehind="ParentStudentEnrollment.aspx.cs" Inherits="SchoolPRO.ParentStudentEnrollment" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
     <asp:ToolkitScriptManager ID="tool1" runat="server"></asp:ToolkitScriptManager>
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
        <div class="row-fluid">

            <div>
                <div class="position-relative">
                    <div class="no-border">
                        <div class="widget-body">
                            <div class="widget-main">
                                <h4 class="header green lighter bigger">
                                    <i class="icon-group blue"></i>
                                    New Student Registration
                                </h4>

                                <div class="space-6"></div>
                                <p>Enter your details to begin: </p>
                                <form id="sreg">
                                    <fieldset>
                                        <%--<label class="clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:CheckBox ID="chkdnr" Text="Check if Donor's Child" runat="server" Visible="False" />
                                                <i class="icon-angle-down"></i>
                                            </span>
                                        </label>
                                        <label class="clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:DropDownList ID="dddonr" CssClass="input-large" DataSourceID="sqldonor" DataValueField="strfname" DataTextField="strfname" runat="server" Visible="False"></asp:DropDownList>
                                                <i class="icon-angle-down"></i>
                                            </span>
                                        </label>--%>

                                        <br />
                                        <br />
                                        <div class="block input-icon input-icon-right">

                                            <asp:TextBox ID="txtstnic" MaxLength="13" class="form-control" placeholder="Student NIC or Nadara Brith Certificate No." runat="server"></asp:TextBox>
                                            <asp:RegularExpressionValidator CssClass="red" runat="server" ID="RegularExpressionValidator3"
                                                ControlToValidate="txtstnic" ErrorMessage="Range must be in 13 Character long!"
                                                ValidationExpression="(\d{13})?" />
                                            <div class="clearfix"></div>
                                        </div>
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtfn" class="form-control" placeholder="First Name" runat="server"></asp:TextBox>
                                                <i class="icon-user"></i>

                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter First Name" ControlToValidate="txtfn"></asp:RequiredFieldValidator>
                                        </label>

                                        <%--                                        <label class="clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtml" class="form-control" placeholder="Middle Name" runat="server"></asp:TextBox>
                                                <i class="icon-user"></i>
                                                </span> 

                                        </label>--%>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtln" class="form-control" placeholder="Last Name" runat="server"></asp:TextBox>
                                                <i class="icon-user"></i>

                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Last Name" ControlToValidate="txtln"></asp:RequiredFieldValidator>
                                        </label>
                                        <label class="clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtdob" MaxLength="10" class="form-control" placeholder="Date of Birth" runat="server"></asp:TextBox>
                                                <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtdob" runat="server"></asp:CalendarExtender>
                                                <i class="icon-calendar"></i>

                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Date of Birth" ControlToValidate="txtdob"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="birthdatecheck" runat="server" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ForeColor="Red" Font-Bold="true" ControlToValidate="txtdob" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>
                                        </label>
                                        <br />
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:DropDownList ID="ddcl" runat="server" DataSourceID="sqlclass" DataTextField="strClass" DataValueField="nc_id"></asp:DropDownList>
                                                <i class="icon-angle-down"></i>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:DropDownList ID="ddshft" runat="server">
                                                    <asp:ListItem>Select Your Shift</asp:ListItem>
                                                    <asp:ListItem Selected="True">Morning</asp:ListItem>
                                                    <asp:ListItem>Evening</asp:ListItem>
                                                </asp:DropDownList>
                                                <i class="icon-user"></i>
                                            </span>
                                        </label>


                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:DropDownList ID="ddsex" runat="server">
                                                    <asp:ListItem>Select Gender</asp:ListItem>
                                                    <asp:ListItem>Male</asp:ListItem>
                                                    <asp:ListItem>Female</asp:ListItem>
                                                </asp:DropDownList>
                                            </span>
                                        </label>


                                        <br />
                                        <br />
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtbplace" class="form-control" placeholder="Birth Place" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Birth Place" ControlToValidate="txtbplace"></asp:RequiredFieldValidator>

                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtnt" class="form-control" placeholder="Nationailty" runat="server"></asp:TextBox>
                                                <i class="icon-flag"></i>
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter Nationality" ControlToValidate="txtnt"></asp:RequiredFieldValidator>

                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtlng" class="form-control" placeholder="Mother Language" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please Enter Mother Language" ControlToValidate="txtlng"></asp:RequiredFieldValidator>

                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtrelg" class="form-control" placeholder="Religion" runat="server"></asp:TextBox>
                                                <i class="icon-user"></i>
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Enter Religion" ControlToValidate="txtrelg"></asp:RequiredFieldValidator>

                                        </label>
                                        <br />
                                        <br />
                                        <label class="block clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtphadrs" class="form-control" placeholder="Physical Address" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Enter Physical Address" ControlToValidate="txtphadrs"></asp:RequiredFieldValidator>

                                        </label>
                                        <label class="block clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtpradrs" class="form-control" placeholder="Permanent Address" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Enter Permanent Address" ControlToValidate="txtpradrs"></asp:RequiredFieldValidator>

                                        </label>
                                        <br />
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtcity" class="form-control" placeholder="City" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Enter City" ControlToValidate="txtcity"></asp:RequiredFieldValidator>

                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtstate" class="form-control" placeholder="State" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="Enter Sate" ControlToValidate="txtstate"></asp:RequiredFieldValidator>

                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtcntry" class="form-control" placeholder="Country" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="Enter Country" ControlToValidate="txtcntry"></asp:RequiredFieldValidator>

                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtpcode" class="form-control" placeholder="Postal Code" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="Enter Postal Code" ControlToValidate="txtpcode"></asp:RequiredFieldValidator>

                                        </label>
                                        <br />
                                        <br />
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtphn" class="form-control" placeholder="Phone" runat="server"></asp:TextBox>
                                                <i class="icon-mobile-phone"></i>
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="Enter Phone No" ControlToValidate="txtphn"></asp:RequiredFieldValidator>

                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtmobile" class="form-control" placeholder="Mobile" runat="server"></asp:TextBox>
                                                <i class="icon-mobile-phone"></i>
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage="Enter Mobile No." ControlToValidate="txtmobile"></asp:RequiredFieldValidator>

                                        </label>
                                        <br />
                                        <br />
                                        <label class=" clearfix">
                                            <span class=" input-icon input-icon-right">
                                                <asp:TextBox ID="txtem" CssClass="input-large" TextMode="Email" class="form-control" placeholder="Email" runat="server"></asp:TextBox>
                                                <i class="icon-envelope"></i>
                                            </span>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter Email" ControlToValidate="txtem" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>

                                        </label>

                                        <label class="clearfix">
                                            <span class=" input-icon input-icon-right">
                                                <asp:TextBox ID="txtpwd" CssClass="input-large" TextMode="Password" class="form-control" placeholder="Password" runat="server"></asp:TextBox>
                                                <i class="icon-lock"></i>
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ErrorMessage="Enter Password" ControlToValidate="txtpwd"></asp:RequiredFieldValidator>

                                        </label>

                                        <br />
                                        <br />

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:FileUpload ID="fstimg" runat="server" />
                                                <i class="icon-picture"></i>
                                            </span>
                                        </label>



                                        <label class="block">
                                            <asp:CheckBox ID="chqacpt" class="ace" runat="server" />
                                            <span class="lbl">I accept the
															<a href="#">User Agreement</a>
                                            </span>
                                        </label>

                                        <div class="space-24"></div>

                                        <div class="clearfix">
                                            <asp:Label ID="btnreset" runat="server" ForeColor="Red" Text="You Can See Your Child When Admin Confirm The Student:" class="width-30 pull-left" />
                                            <asp:Button ID="btnsreg" runat="server" Text="Enroll" class="width-30 pull-right btn btn-sm btn-success" OnClick="btnsreg_Click" />
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- PAGE CONTENT ENDS -->
    </div>
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
    <!-- /.col -->

    <asp:Label ID="lbluserval" runat="server" Text=""></asp:Label>
    <asp:SqlDataSource ID="sqlbrnch" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strBranchCode] FROM [tbl_School] Where bisDeleted=0"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlclass" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strClass],nc_id FROM [tbl_Class] Where nsch_id=@schid and bisDeleted=0">
        <SelectParameters>
            <asp:SessionParameter Name="schid" SessionField="nschoolid" />
        </SelectParameters>
    </asp:SqlDataSource>
    <%--<asp:SqlDataSource ID="sqldonor" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strfname] FROM [tbl_Users] where strRelation='Donor'"></asp:SqlDataSource>--%>
</asp:Content>

