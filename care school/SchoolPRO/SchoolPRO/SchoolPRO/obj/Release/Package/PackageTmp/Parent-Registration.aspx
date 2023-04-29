<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Parent-Registration.aspx.cs" Inherits="SchoolPRO.Parent_Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title>Admin Dashboard - School Admin</title>
    <meta name="description" content="overview &amp; stats" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- basic styles -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="assets/css/font-awesome.min.css" />
    <!--[if IE 7]>
		  <link rel="stylesheet" href="assets/css/font-awesome-ie7.min.css" />
		<![endif]-->
    <!-- page specific plugin styles -->
    <!-- fonts -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" />
    <!-- ace styles -->
    <link rel="stylesheet" href="assets/css/ace.min.css" />
    <link rel="stylesheet" href="assets/css/ace-rtl.min.css" />
    <link rel="stylesheet" href="assets/css/ace-skins.min.css" />


    <!--[if lte IE 8]>
		  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
		<![endif]-->
    <!-- inline styles related to this page -->
    <!-- ace settings handler -->


    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
		<script src="assets/js/html5shiv.js"></script>
		<script src="assets/js/respond.min.js"></script>
		<![endif]-->
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" />
        <div class="container">

            <div class="row">
                <div class="col-xs-12">
                    <asp:Label ID="lblSection" Visible="false" runat="server"></asp:Label>
                    <!-- PAGE CONTENT BEGINS -->
                    <div class="row-fluid">

                        <div>
                            <div class="position-relative">
                                <div class="no-border">
                                    <%--<div class="widget-body">--%>
                                    <div class="widget-main">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                        <div class="col-lg-offset-3 col col-lg-6" style="background: #f2f2f2;">
                                            <h4 class="header green lighter bigger">
                                                <i class="icon-group blue"></i>
                                                Parent Registration
                                            </h4>

                                            <div class="space-6"></div>





                                            <div class="form-group">



                                                <div class="block input-icon input-icon-right">
                                                    <asp:DropDownList ID="ddbrnch" Width="530px" CssClass="input-large" runat="server" DataSourceID="schoolDs" DataTextField="name" DataValueField="nsch_id" AppendDataBoundItems="true">
                                                        <asp:ListItem>--Select School--</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource runat="server" ID="schoolDs" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nsch_id], [strSchName]+' '+[strBranchCode] as name FROM [tbl_School] WHERE ([bisDeleted] = @bisDeleted)">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                    <div class="space-6"></div>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtnic" class="form-control" MaxLength="13" AutoPostBack="true" placeholder="Enter NIC Number " runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredTXTNIC" runat="server" ErrorMessage="Enter NIC PLease" ForeColor="Red" ControlToValidate="txtnic"></asp:RequiredFieldValidator>
                                                    <i class="icon-user"></i>
                                                    <div class="clearfix"></div>
                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage="Please enter only alphanumeric." ValidationExpression="^[A-Za-zÀ-ú]"></asp:RequiredFieldValidator><i class="icon-user"></i>--%>
                                                </div>

                                                <div class="block input-icon input-icon-right">
                                                    <asp:DropDownList ID="ddgaurd" runat="server" Width="530px">
                                                        <asp:ListItem>I am</asp:ListItem>
                                                        <asp:ListItem>Father</asp:ListItem>
                                                        <asp:ListItem>Mother</asp:ListItem>
                                                        <asp:ListItem>Gaurdian</asp:ListItem>
                                                        <asp:ListItem>Donor</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <div class="space-6"></div>
                                                    <div class="clearfix"></div>

                                                </div>







                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtfn" class="form-control" placeholder="First Name" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter First Name" ControlToValidate="txtfn"></asp:RequiredFieldValidator>
                                                    <i class="icon-user"></i>
                                                    <div class="clearfix"></div>

                                                </div>



                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtln" class="form-control" placeholder="Last Name" runat="server"></asp:TextBox>

                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Last Name" ControlToValidate="txtln"></asp:RequiredFieldValidator><i class="icon-user"></i>

                                                    <i class="icon-user"></i>
                                                    <div class="clearfix"></div>

                                                </div>




                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtedu" class="form-control" placeholder="Education" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Education" ControlToValidate="txtedu"></asp:RequiredFieldValidator>

                                                    <i class="icon-user"></i>
                                                    <div class="clearfix"></div>

                                                </div>



                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtocc" class="form-control" placeholder="Occupation" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Enter Occupation" ControlToValidate="txtocc"></asp:RequiredFieldValidator>

                                                    <i class="icon-user"></i>
                                                    <div class="clearfix"></div>

                                                </div>



                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtinc" class="form-control" placeholder="Income" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Enter Father's Income" ControlToValidate="txtinc"></asp:RequiredFieldValidator>

                                                    <i class="icon-user"></i>
                                                    <div class="clearfix"></div>

                                                </div>


                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtadrs" class="form-control" placeholder="Address" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="Enter Your Address" ControlToValidate="txtadrs"></asp:RequiredFieldValidator>

                                                    <i class="icon-user"></i>
                                                    <div class="clearfix"></div>

                                                </div>



                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtem" TextMode="Email" class="form-control" placeholder="Email" runat="server"></asp:TextBox>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter Your Complete Email" ControlToValidate="txtem" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>

                                                    <i class="icon-user"></i>
                                                    <div class="clearfix"></div>

                                                </div>




                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtpwd" TextMode="Password" class="form-control" placeholder="Password" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Password" ControlToValidate="txtpwd" ForeColor="Red"></asp:RequiredFieldValidator>

                                                    <i class="icon-lock"></i>
                                                    <div class="clearfix"></div>

                                                </div>



                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtrepass" TextMode="Password" class="form-control" placeholder="Repeat Password" runat="server" ControlToValidate="txtrepass"></asp:TextBox>
                                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Password Does not match" ControlToValidate="txtrepass" ControlToCompare="txtpwd" ForeColor="Red"></asp:CompareValidator>

                                                    <i class="icon-lock"></i>
                                                    <div class="clearfix"></div>

                                                </div>


                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtphn" class="form-control" placeholder="Phone" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="Enter your Phone No" ControlToValidate="txtphn"></asp:RequiredFieldValidator>

                                                    <i class="icon-phone"></i>
                                                    <div class="clearfix"></div>

                                                </div>


                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtmobile" class="form-control" placeholder="Mobile" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="Please Enter Your Mobile No" ControlToValidate="txtmobile"></asp:RequiredFieldValidator>

                                                    <i class="icon-mobile"></i>
                                                    <div class="clearfix"></div>

                                                </div>





                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtpcode" class="form-control" placeholder="Postal Code" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="Enter your Postal Code" ControlToValidate="txtpcode"></asp:RequiredFieldValidator>

                                                    <i class="icon-desktop"></i>
                                                    <div class="clearfix"></div>

                                                </div>






                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtcity" class="form-control" placeholder="City" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please Enter your City" ControlToValidate="txtcity"></asp:RequiredFieldValidator>

                                                    <i class="icon-lock"></i>
                                                    <div class="clearfix"></div>

                                                </div>




                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtstate" class="form-control" placeholder="State" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Enter Your State" ControlToValidate="txtstate"></asp:RequiredFieldValidator>

                                                    <i class="icon-lock"></i>
                                                    <div class="clearfix"></div>

                                                </div>




                                                <div class="block input-icon input-icon-right">
                                                    <asp:TextBox ID="txtcntry" class="form-control" placeholder="Country" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Please Enter your country" ControlToValidate="txtcntry"></asp:RequiredFieldValidator>

                                                    <i class="icon-lock"></i>
                                                    <div class="clearfix"></div>

                                                </div>




                                                <div class="block input-icon input-icon-right">
                                                    <asp:FileUpload ID="fstimg" runat="server" />
                                                    <i class="icon-picture"></i>
                                                    <div class="clearfix"></div>

                                                </div>




                                            </div>


                                            <div class="space-24"></div>

                                            <div class="clearfix">
                                                <%--<asp:Button ID="btnreset" runat="server" Text="Reset" class="width-30 pull-left btn btn-sm " OnClick="btnreset_Click" />--%>

                                                <asp:Button ID="btnreset" runat="server" Text="Reset" class="width-30 pull-left btn btn-sm " OnClick="btnreset_Click" />

                                                <asp:Button ID="btnreg" runat="server" Text="Register" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnreg_Click" />

                                            </div>

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
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>




            </div>
        </div>


        <script src="assets/js/ace-extra.min.js"></script>


        <script src="assets/js/loader.js"></script>
        <link rel="stylesheet" href="assets/css/loader.css" />
    </form>

</body>
</html>
