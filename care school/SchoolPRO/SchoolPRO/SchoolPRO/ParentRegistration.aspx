<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ParentRegistration.aspx.cs" Inherits="SchoolPRO.ParentRegistration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Registration - School Admin</title>

    <meta name="description" content="User login page" />
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

    <!--[if lte IE 8]>
		  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
		<![endif]-->

    <!-- inline styles related to this page -->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

    <!--[if lt IE 9]>
		<script src="assets/js/html5shiv.js"></script>
		<script src="assets/js/respond.min.js"></script>
		<![endif]-->
    <style type="text/css">
        .BarIndicatorweak {
            color: Red;
            background-color: Red;
        }

        .BarIndicatoraverage {
            color: Blue;
            background-color: Blue;
        }

        .BarIndicatorgood {
            color: Green;
            background-color: Green;
        }

        .BarBorder {
            border-style: solid;
            border-width: 1px;
            padding: 2px 2px 2px 2px;
            width: 200px;
            vertical-align: middle;
        }
    </style>
</head>
<body class="login-layout">
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="main-container">
            <div class="main-content">
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <div>
                            <div class="center">
                                <h1>

                                    <span class="red">School</span>
                                    <span class="white">Registration</span>
                                </h1>
                                <h4 class="blue">&copy;<a href="www.at-techsoul.com"> AT TECHSOUL</a></h4>
                            </div>
                            <div class="space-6"></div>
                            <div class="position-relative">
                                <div class="no-border">
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                            <h4 class="header green lighter bigger">
                                                <i class="icon-group blue"></i>
                                                Gaurdian Registration
                                            </h4>

                                            <div class="space-6"></div>
                                            <p>Enter your details to begin: </p>
                                            <form id="freg">
                                                <fieldset>
                                                    <label class="clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddbrnch" CssClass="input-large" runat="server" DataSourceID="schoolDs" DataTextField="name" DataValueField="nsch_id" AppendDataBoundItems="true">
                                                                <asp:ListItem>--Select School--</asp:ListItem>
                                                            </asp:DropDownList>
                                                            <asp:SqlDataSource runat="server" ID="schoolDs" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nsch_id], [strSchName]+' '+[strBranchCode] as name FROM [tbl_School] WHERE ([bisDeleted] = @bisDeleted)">
                                                                <SelectParameters>
                                                                    <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <i class="icon-angle-down"></i>
                                                        </span>
                                                    </label>
                                                    <label class="clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtnic" class="form-control" AutoPostBack="true" placeholder="Enter NIC Number " runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredTXTNIC" runat="server" ErrorMessage="Enter NIC PLease" ForeColor="Red" ControlToValidate="txtnic"></asp:RequiredFieldValidator>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddgaurd" runat="server" Width="265px">
                                                                <asp:ListItem>I am</asp:ListItem>
                                                                <asp:ListItem>Father</asp:ListItem>
                                                                <asp:ListItem>Mother</asp:ListItem>
                                                                <asp:ListItem>Gaurdian</asp:ListItem>
                                                                <asp:ListItem>Donor</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </span>
                                                    </label>

                                                    <label class="clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtfn" class="form-control" placeholder="First Name" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter First Name" ControlToValidate="txtfn"></asp:RequiredFieldValidator>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>

                                                    <%--<label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtml" class="form-control" placeholder="Middle Name" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>--%>

                                                    <label class="clearfix">
                                                        <span class="block input-icon input-icon-right">

                                                            <asp:TextBox ID="txtln" class="form-control" placeholder="Last Name" runat="server"></asp:TextBox>

                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Last Name" ControlToValidate="txtln"></asp:RequiredFieldValidator><i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <div class="clearfix"></div>
                                                    <label class="clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtedu" class="form-control" placeholder="Education" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Education" ControlToValidate="txtedu"></asp:RequiredFieldValidator>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>

                                                    <label class=" clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtocc" class="form-control" placeholder="Occupation" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Enter Occupation" ControlToValidate="txtocc"></asp:RequiredFieldValidator>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>

                                                    <label class=" clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtinc" class="form-control" placeholder="Income" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Enter Father's Income" ControlToValidate="txtinc"></asp:RequiredFieldValidator>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <div class="clearfix"></div>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtadrs" class="form-control" placeholder="Address" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="Enter Your Address" ControlToValidate="txtadrs"></asp:RequiredFieldValidator>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <div class="clearfix"></div>
                                                    <label class=" clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtem" TextMode="Email" class="form-control" placeholder="Email" runat="server"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter Your Complete Email" ControlToValidate="txtem" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                            <i class="icon-envelope"></i>
                                                        </span>
                                                    </label>

                                                    <label class=" clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtpwd" TextMode="Password" class="form-control" placeholder="Password" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Password" ControlToValidate="txtpwd" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            <i class="icon-lock"></i>
                                                        </span>
                                                    </label>

                                                    <label class=" clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtrepass" TextMode="Password" class="form-control" placeholder="Repeat Password" runat="server" ControlToValidate="txtrepass"></asp:TextBox>
                                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Password Does not match" ControlToValidate="txtrepass" ControlToCompare="txtpwd" ForeColor="Red"></asp:CompareValidator>
                                                            <i class="icon-retweet"></i>
                                                        </span>
                                                    </label>
                                                    <div class="clearfix"></div>
                                                    <label class=" clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtcity" class="form-control" placeholder="City" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please Enter your City" ControlToValidate="txtcity"></asp:RequiredFieldValidator>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>

                                                    <label class=" clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtstate" class="form-control" placeholder="State" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Enter Your State" ControlToValidate="txtstate"></asp:RequiredFieldValidator>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>

                                                    <label class=" clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtcntry" class="form-control" placeholder="Country" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Please Enter your country" ControlToValidate="txtcntry"></asp:RequiredFieldValidator>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>

                                                    <label class=" clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtpcode" class="form-control" placeholder="Postal Code" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Enter your Postal Code" ControlToValidate="txtpcode"></asp:RequiredFieldValidator>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <div class="clearfix"></div>
                                                    <label class=" clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtphn" class="form-control" placeholder="Phone" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="Enter your Phone No" ControlToValidate="txtphn"></asp:RequiredFieldValidator>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>

                                                    <label class=" clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtmobile" class="form-control" placeholder="Mobile" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="Please Enter Your Mobile No" ControlToValidate="txtmobile"></asp:RequiredFieldValidator>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class=" clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:FileUpload ID="fstimg" runat="server" />
                                                            <i class="icon-picture"></i>
                                                        </span>
                                                    </label>
                                                    <label class="hidden block">
                                                        <asp:CheckBox ID="chqacpt" class="ace" runat="server" />
                                                        <span class="lbl">I accept the
															<a href="#">User Agreement</a>
                                                        </span>
                                                    </label>

                                                    <div class="space-24"></div>

                                                    <div class="clearfix">
                                                        <asp:Button ID="btnreset" runat="server" Text="Reset" class="width-30 pull-left btn btn-sm " OnClick="btnreset_Click" />

                                                        <asp:Button ID="btnreg" runat="server" Text="Register" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnreg_Click" />
                                                    </div>
                                                </fieldset>
                                            </form>
                                        </div>

                                        <div class="toolbar center">
                                            <a href="Default.aspx" class="back-to-login-link">
                                                <i class="icon-arrow-left"></i>
                                                Back to login
                                            </a>
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
                                    <!-- /widget-body -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="assets/js/jquery-2.0.3.min.js"></script>

        <!-- <![endif]-->

        <!--[if IE]>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<![endif]-->

        <!--[if !IE]> -->

        <script type="text/javascript">
            window.jQuery || document.write("<script src='assets/js/jquery-2.0.3.min.js'>" + "<" + "/script>");
        </script>

        <!-- <![endif]-->

        <!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

        <script type="text/javascript">
            if ("ontouchend" in document) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>" + "<" + "/script>");
        </script>

        <!-- inline scripts related to this page -->

        <%--<script type="text/javascript">
            function show_box(id) {
                jQuery('.widget-box.visible').removeClass('visible');
                jQuery('#' + id).addClass('visible');
            }
        </script>--%>
    </form>

</body>
</html>
