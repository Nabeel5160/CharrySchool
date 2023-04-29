<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResultNotAnnonced.aspx.cs" Inherits="SchoolPRO.ResultNotAnnonced" %>

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
        <div Align="Center" class="has-warning" style="font-size:40px; color:red;">Result Status</div>
        <div class="jumbotron">
                    <h1>Result Not Annonced ... Please Wait For the Date... 
                    </h1>
            <% 
                string id = Request.QueryString["id"];
                string msg = Request.QueryString["msg"];

                if (id == "1")
                {
                %>
             <h3>---Result Date Not Given Yet ... Sorry
                        </h3>
             
                <%
                }
                if (id == "2")
                {
                 %>
             <h3>---Result Date Has Not Been Passed... Sorry
                        </h3>
                 <%
                }
                if (id == "3")
                {
                 %>
                    <h3>---Result Will be Annoced on  <%
                                                          if (Session["stdt"] != null)
                                                              Response.Write(Session["stdt"].ToString());
                                                          else
                                                              Response.Write("No Date Yet....");
                                                               %>
                        </h3>
                 <%

                }
                
                
                
                 %>
                   
                       <p> Administration....For More Help</p>
                    <p><a href="#<%//Response.Write( Request.QueryString["msg"]); %>" onclick="goBack()" class="btn btn-primary btn-lg" role="button">For more »</a>
                    </p>
                </div>
     
        
       <%-- <a href="<%Response.Write( Request.QueryString["msg"]); %>">
            Click  here </a>--%>
    
    </div>
    </form>
</body>
</html>
