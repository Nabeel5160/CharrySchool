<%@ Page Title="" Language="C#" MasterPageFile="~/Parent.Master" AutoEventWireup="true" CodeBehind="ParentsRegistrationNumber.aspx.cs" Inherits="SchoolPRO.ParentsRegistrationNumber" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <script>
          function printDiv(printable) {
              var printContents = document.getElementById(printable).innerHTML;
              var originalContents = document.body.innerHTML;

              document.body.innerHTML = printContents;

              window.print();

              document.body.innerHTML = originalContents;
          }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div id="printable" class=" col-lg-12 col-sm-offset-3">

                <h1  runat="server" id="ltxt123" > Registration Number of your child is:  <asp:Label ID="regno" Font-Bold="true" ForeColor="#ff3300" runat="server" /></h1>
                <div class="h4">Show This Print to School Administration </div>
                <div id="s" onclick="printDiv('printable')" class="hidden-print btn btn-primary" >Print</div>     
            </div>
        </div>
    </div>
</asp:Content>
