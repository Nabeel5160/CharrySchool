<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgotpassword.aspx.cs" Inherits="SchoolPRO.forgotpassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Forgot Password - School</title>

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
    <form id="form1" runat="server">
    <div class="main-container">
            <div class="main-content">
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <div class="login-container">
                            <div class="center">
                                <h1>

                                    <span class="red">School</span>
                                    <span class="white">Login</span>
                                </h1>
                                <h4 class="blue">&copy; AT TECHSOUL</h4>
                            </div>

                            <div class="space-6"></div>

                            <div class="position-relative">
                                <div id="login-box" class="login-box visible widget-box no-border">
                                    <div>
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header red lighter bigger">
												<i class="icon-key"></i>
												Retrieve Password
											</h4>

											<div class="space-6"></div>
											<p>
												Enter your email and to receive instructions
											</p>

											<form>
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtem" class="form-control" placeholder="Email" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator13" runat="server" ErrorMessage="Enter Email" ControlToValidate="txtem"></asp:RequiredFieldValidator>
                                                            <i class="icon-envelope"></i>
														</span>
													</label>

													<div class="clearfix">
                                                        <asp:Button ID="btnforgot" class="width-35 pull-right btn btn-sm btn-danger" runat="server" Text="Send Me!" OnClick="btnforgot_Click" />
															<i class="icon-lightbulb"></i>
															
													</div>
												</fieldset>
											</form>
										</div><!-- /widget-main -->

										<div class="toolbar center">
                                            <div>
											<a href="Default.aspx" class="back-to-login-link">
												Back to login
												<i class="icon-arrow-right"></i>
											</a>
                                                </div>
										</div>
									</div><!-- /widget-body -->
								</div><!-- /forgot-box -->

                                    <!-- /widget-body -->
                                </div>
                                <!-- /login-box -->

                                

                                
                            </div>
                            <!-- /position-relative -->
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
