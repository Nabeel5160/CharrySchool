<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminEnrollStudents.aspx.cs" Inherits="SchoolPRO.AdminEnrollStudents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <asp:ScriptManager runat="server" />
            <asp:UpdatePanel runat="server">
                <ContentTemplate>   
                    <asp:MultiView ActiveViewIndex="0" ID="mvreg" runat="server">
                        <asp:View runat="server">

                        
            <div class="login-container">
                            
                            <div class="position-relative">
                                <div class="no-border">
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <h4 class="header green lighter bigger">
                                                <i class="icon-group blue"></i>
                                                Gaurdian Registration
                                            </h4>

                                            <div class="space-6"></div>
                                            <p>Enter your details to begin: </p>

                                            <form id="freg">
                                                <fieldset>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddgaurd" runat="server" Width="265px">
                                                                <asp:ListItem>I am</asp:ListItem>
                                                                <asp:ListItem>Father</asp:ListItem>
                                                                <asp:ListItem>Mother</asp:ListItem>
                                                                <asp:ListItem>Gaurdian</asp:ListItem>
                                                            </asp:DropDownList>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtfn" class="form-control" placeholder="First Name" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter First Name" ControlToValidate="txtfn"></asp:RequiredFieldValidator>
                                                            
                                                        </span>
                                                    </label>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            
                                                            <asp:TextBox ID="txtln" class="form-control" placeholder="Last Name" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Last Name" ControlToValidate="txtln"></asp:RequiredFieldValidator>
                                                        </span>
                                                    </label>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtedu" class="form-control" placeholder="Education" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Education" ControlToValidate="txtedu"></asp:RequiredFieldValidator>
                                                            
                                                        </span>
                                                    </label>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtocc" class="form-control" placeholder="Occupation" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Enter Occupation" ControlToValidate="txtocc"></asp:RequiredFieldValidator>
                                                            
                                                        </span>
                                                    </label>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtinc" class="form-control" placeholder="Income" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Enter Father's Income" ControlToValidate="txtinc"></asp:RequiredFieldValidator>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtadrs" class="form-control" placeholder="Address" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtem" TextMode="Email" class="form-control" placeholder="Email" runat="server"></asp:TextBox>
                                                            <i class="icon-envelope"></i>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter Your Complete Email" ControlToValidate="txtem" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                            
                                                        </span>
                                                    </label>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtpwd" TextMode="Password" class="form-control" placeholder="Password" runat="server"></asp:TextBox>
                                                            <i class="icon-lock"></i>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Password" ControlToValidate="txtpwd"></asp:RequiredFieldValidator>
                                                            
                                                        </span>
                                                    </label>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtrepass" TextMode="Password" class="form-control" placeholder="Repeat Password" runat="server" ControlToValidate="txtrepass"></asp:TextBox>
                                                            <i class="icon-retweet"></i>
                                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Password Does not match" ControlToValidate="txtrepass" ControlToCompare="txtpwd"></asp:CompareValidator>
                                                            
                                                        </span>
                                                    </label>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtcity" class="form-control" placeholder="City" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please Enter your City" ControlToValidate="txtcity"></asp:RequiredFieldValidator>
                                                            
                                                        </span>
                                                    </label>
                                                    
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtstate" class="form-control" placeholder="State" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Enter Your State" ControlToValidate="txtstate"></asp:RequiredFieldValidator>
                                                            
                                                        </span>
                                                    </label>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtcntry" class="form-control" placeholder="Country" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Please Enter your country" ControlToValidate="txtcntry"></asp:RequiredFieldValidator>
                                                            
                                                        </span>
                                                    </label>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtphn" class="form-control" placeholder="Phone" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="Enter your Phone No" ControlToValidate="txtphn"></asp:RequiredFieldValidator>
                                                            
                                                        </span>
                                                    </label>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtmobile" class="form-control" placeholder="Mobile" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="Please Enter Your Mobile No" ControlToValidate="txtmobile"></asp:RequiredFieldValidator>
                                                            
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
                                                        <asp:Button ID="btnreg" runat="server" Text="Register" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnreg_Click" />
                                                    </div>
                                                </fieldset>
                                            </form>
                                        </div>
                                        
                                    </div>
                                    <!-- /widget-body -->
                                </div>
                            </div>
                        </div>
                            </asp:View>
                        <asp:View runat="server">
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

                                        <label class="clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:DropDownList ID="ddbrnch" CssClass="input-large" DataSourceID="sqlbrnch" DataValueField="strBranchCode" DataTextField="strBranchCode" runat="server"></asp:DropDownList>
                                                <i class="icon-angle-down"></i>
                                            </span>
                                        </label>
                                        <br />
                                        <br />
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="TextBox1" class="form-control" placeholder="First Name" runat="server"></asp:TextBox>
                                                <i class="icon-user"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Enter First Name" ControlToValidate="txtfn"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>

                                        <label class="clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtml" class="form-control" placeholder="Middle Name" runat="server"></asp:TextBox>
                                                <i class="icon-user"></i>
                                                </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="TextBox2" class="form-control" placeholder="Last Name" runat="server"></asp:TextBox>
                                                <i class="icon-user"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="Enter Last Name" ControlToValidate="txtln"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>
                                        <br />
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
                                                    <asp:ListItem>Morning</asp:ListItem>
                                                    <asp:ListItem>Evening</asp:ListItem>
                                                </asp:DropDownList>
                                                <i class="icon-user"></i>
                                            </span>
                                        </label>

                                        <label class="clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtdob" class="form-control" TextMode="Date" placeholder="Date of Birth" runat="server"></asp:TextBox>
                                                <i class="icon-calendar"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="Enter Date of Birth" ControlToValidate="txtdob"></asp:RequiredFieldValidator>
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
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage="Enter Birth Place" ControlToValidate="txtbplace"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtnt" class="form-control" placeholder="Nationailty" runat="server"></asp:TextBox>
                                                <i class="icon-flag"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ErrorMessage="Enter Nationality" ControlToValidate="txtnt"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtlng" class="form-control" placeholder="Mother Language" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ErrorMessage="Please Enter Mother Language" ControlToValidate="txtlng"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtrelg" class="form-control" placeholder="Religion" runat="server"></asp:TextBox>
                                                <i class="icon-user"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ErrorMessage="Enter Religion" ControlToValidate="txtrelg"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>
                                        <br />
                                        <br />
                                        <label class="block clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtphadrs" class="form-control" placeholder="Physical Address" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ErrorMessage="Enter Physical Address" ControlToValidate="txtphadrs"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>
                                        <label class="block clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtpradrs" class="form-control" placeholder="Permanent Address" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ErrorMessage="Enter Permanent Address" ControlToValidate="txtpradrs"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>
                                        <br />
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="TextBox3" class="form-control" placeholder="City" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ErrorMessage="Enter City" ControlToValidate="txtcity"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="TextBox4" class="form-control" placeholder="State" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ErrorMessage="Enter Sate" ControlToValidate="txtstate"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="TextBox5" class="form-control" placeholder="Country" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" ErrorMessage="Enter Country" ControlToValidate="txtcntry"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtpcode" class="form-control" placeholder="Postal Code" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" ErrorMessage="Enter Postal Code" ControlToValidate="txtpcode"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>
                                        <br />
                                        <br />
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="TextBox6" class="form-control" placeholder="Phone" runat="server"></asp:TextBox>
                                                <i class="icon-mobile-phone"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" ErrorMessage="Enter Phone No" ControlToValidate="txtphn"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="TextBox7" class="form-control" placeholder="Mobile" runat="server"></asp:TextBox>
                                                <i class="icon-mobile-phone"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" ErrorMessage="Enter Mobile No." ControlToValidate="txtmobile"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>
                                        <br />
                                        <br />
                                        <label class=" clearfix">
                                            <span class=" input-icon input-icon-right">
                                                <asp:TextBox ID="TextBox8" CssClass="input-large" TextMode="Email" class="form-control" placeholder="Email" runat="server"></asp:TextBox>
                                                <i class="icon-envelope"></i>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Enter Email" ControlToValidate="txtem" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                </span>
                                        </label>

                                        <label class="clearfix">
                                            <span class=" input-icon input-icon-right">
                                                <asp:TextBox ID="TextBox9" CssClass="input-large" TextMode="Password" class="form-control" placeholder="Password" runat="server"></asp:TextBox>
                                                <i class="icon-lock"></i>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" ErrorMessage="Enter Password" ControlToValidate="txtpwd"></asp:RequiredFieldValidator>
                                            </span>
                                        </label>

                                        <br />
                                        <br />

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:FileUpload ID="fstimg" runat="server" />
                                                <i class="icon-picture"></i>
                                            </span>
                                        </label>


                                        <div class="space-24"></div>

                                        <div class="clearfix">
                                            <asp:Button ID="btnreset" runat="server" Text="Reset" class="width-30 pull-left btn btn-sm " OnClick="btnreset_Click" />
                                            <asp:Button ID="btnsreg" runat="server" Text="Enroll" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnsreg_Click" />
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
</asp:Content>
