<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NotAllowed.aspx.cs" Inherits="SchoolPRO.NotAllowed" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Warning</title>
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
    <script>
        function goBack() {
            window.history.back()
        }
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div Align="Center" class="has-warning" style="font-size:40px; color:red;">Warning..</div>
        <div class="jumbotron">
                    <h1>You Are Not Allowed To access This Page 
                    </h1>
                    <p>---Please Contact 
                        Administration....For More Help</p>
                    <p><a href="#<%//Response.Write( Request.QueryString["msg"]); %>" onclick="goBack()" class="btn btn-primary btn-lg" role="button">For more »</a>
                    </p>
                </div>
     
        
       <%-- <a href="<%Response.Write( Request.QueryString["msg"]); %>">
            Click  here </a>--%>
    
    </div>
    </form>
</body>
</html>