<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SchoolPRO.Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title>Login Page - School Admin</title>

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
     <style>
        .modalBackground {
            background-color: white;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .modalPopup h2 {
            color: white;
        }
    </style>
</head>
<body  class="login-layout" >
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <div class="main-container">
            <div class="main-content">
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <div class="login-container">
                            <div class="center">
                                <h1>

                                    <span class="red">LENOX School</span><br />
                                    <span class="white">SCHOOL SOLUTION</span>
                                </h1>
                                <h4 class="blue">&copy; LENOX</h4>
                            </div>

                            <div class="space-6"></div>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                            <div class="position-relative">
                                <div id="login-box" class="login-box visible widget-box no-border">
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <h4 class="header blue lighter bigger">
                                                <i class="icon-coffee green"></i>
                                                Please Enter Your Information
                                                <asp:Label ID="lbltest" runat="server"></asp:Label>
                                            </h4>

                                            <div class="space-6"></div>

                                            <form action="">
                                                <fieldset>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtem" runat="server" class="form-control" placeholder="Enter Your Email"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter Email" ControlToValidate="txtem" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                            <i class="icon-envelope"></i>
                                                        </span>
                                                    </label>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtpwd" runat="server" TextMode="Password" class="form-control" placeholder="Enter Your Password"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Password" ControlToValidate="txtpwd"></asp:RequiredFieldValidator>
                                                            <i class="icon-lock"></i>
                                                        </span>
                                                    </label>

                                                    <div class="space"></div>

                                                    <div class="clearfix">
                                                        <%--<label class="inline">
                                                            <input type="checkbox" class="ace" />
                                                            <span class="lbl">Remember Me</span>
                                                        </label>--%>
                                                        <asp:Button ID="btnlogin" UseSubmitBehavior="false" runat="server" Text="Log In" class="width-35 pull-right btn btn-sm btn-primary" OnClick="btnlogin_Click"/>
                                                        
                                                    </div>

                                                    <div class="space-4"></div>
                                                </fieldset>
                                            </form>
                                             <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="pnl1" TargetControlID="btnlogin"
                            CancelControlID="btnClose" BackgroundCssClass="modalBackground">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="pnl1" runat="server" CssClass="modalPopup" align="center" Style="display: none">
                            <img src="assets/images/loader.gif" />
                            <br />
                            <asp:HiddenField ID="btnClose" runat="server" />
                        </asp:Panel>
                                            <div class="social-or-login center">
                                                <span class="bigger-110">Find Us</span>
                                            </div>

                                            <div class="social-login center">
                                                <a href="#" target="_blank" class="btn btn-primary">
                                                    <i class="icon-facebook"></i>
                                                </a>

                                                <a href="#" target="_blank" class="btn btn-info">
                                                    <i class="icon-twitter"></i>
                                                </a>

                                                <a href="#" target="_blank" class="btn btn-danger">
                                                    <i class="icon-google-plus"></i>
                                                </a>
                                            </div>
                                        </div>
                                        <!-- /widget-main -->

                                        <div class="toolbar clearfix">
                                            <div>
                                                <a href="forgotpassword.aspx"  class="forgot-password-link">
                                                    <i class="icon-arrow-left"></i>
                                                    I forgot my password
                                                </a>
                                            </div>

                                            <div>
                                                <a href="Parent-Registration.aspx" class="user-signup-link">I want to register
													<i class="icon-arrow-right"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /widget-body -->
                                </div>
                                <!-- /login-box -->

                                

                                
                            </div>
                            <!-- /position-relative -->
                                    </ContentTemplate>
                            </asp:UpdatePanel>
                            <%--<asp:UpdateProgress DynamicLayout="true" runat="server">
                                <ProgressTemplate>
                                    <div class="progress progress-striped pos-rel">
													<div class="progress-bar progress-bar-success" style="width: 25%;"></div>
												</div>

                                </ProgressTemplate>
                            </asp:UpdateProgress>--%>
                        </div>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
        </div>
        <!-- /.main-container -->

        <!-- basic scripts -->

        <!--[if !IE]> -->

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

        <script type="text/javascript">
            function show_box(id) {
                jQuery('.widget-box.visible').removeClass('visible');
                jQuery('#' + id).addClass('visible');
            }
        </script>
    </form>
</body>
</html>
