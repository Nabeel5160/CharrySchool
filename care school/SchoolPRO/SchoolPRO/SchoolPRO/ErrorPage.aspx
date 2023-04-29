<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorPage.aspx.cs" Inherits="SchoolPRO.ErrorPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Error</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       
    <p runat="server">  <%
            string msg = Request.QueryString["msg"];
            Response.Write(msg);
         %>
         An ERROR Has Occurred Please Check...ThankYou</p>
    </div>
    </form>
</body>
</html>
