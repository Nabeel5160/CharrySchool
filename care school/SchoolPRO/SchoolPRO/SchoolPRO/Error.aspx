<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="SchoolPRO.Error" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ERROR</title>
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
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div Align="Center" class="has-warning" style="font-size:20px; color:red;">SOME THING WENT WRONG</div>
     <div class="error-container">
       
    <p class="has-error"  id="P1" runat="server"> An ERROR Has Occurred Please Check...ThankYou <br />
        <%--<%
            string msg = Request.QueryString["msg"];
            //Response.Write(msg);
         %>--%>
        
        <a href="<%Response.Write( Request.QueryString["msg"]); %>">
            Click  here </a>
         </p>
    </div>
    </div>
    </form>
</body>
</html>
