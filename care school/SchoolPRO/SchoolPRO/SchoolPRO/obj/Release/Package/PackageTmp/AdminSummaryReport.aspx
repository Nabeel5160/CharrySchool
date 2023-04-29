<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminSummaryReport.aspx.cs" Inherits="SchoolPRO.AdminSummaryReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
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
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
           <asp:ToolkitScriptManager  ID="toolscpt"  runat="server"  ></asp:ToolkitScriptManager>
            <div class="row-fluid">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View2" runat="server">
                                <div class="clearfix"></div>
                                <div class="clearfix"></div>
                                <div class="col-xs-12 col-sm-12 widget-container-span">
                                    <div class="widget-box" id="printable">
                                        <div class="widget-header header-color-blue">
                                            <h5 class="bigger lighter">
                                                <i class="icon-table"></i>
                                                Summary 
                                            </h5>
                                            <div class="widget-toolbar widget-toolbar-light no-border">
                                                <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                            </div>
                                        </div>
                                        <div class="widget-body">
                                            <div class="widget-main no-padding">
                                                <div class="col-lg-10">
                                                    
                 <div>
                                     <h3 class="widget-title grey lighter"><i class="ace-icon fa fa-leaf green"></i>
                                                    <asp:Label ID="txtschool1" Text="Schoollllllllll sd" runat="server"></asp:Label>
                                                </h3>
                                   <div class="space-12"></div>
                                    <table class="col-lg-10">
                                        <tr><td class="col-md-5"> <p>From Date :</p>
                                                                    <asp:TextBox ID="txtfrom" AutoPostBack="true" OnTextChanged="txtdob_TextChanged" class="form-control" placeholder="From Date :(dd-MM-yyyy)" runat="server" MaxLength="10" ></asp:TextBox>
                                                                    <asp:CalendarExtender  Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtfrom" runat="server"></asp:CalendarExtender>

                                            </td>
                                            <td class="col-md-5"><p>To Date :</p>
                                                                    <asp:TextBox ID="txtto" AutoPostBack="true" OnTextChanged="txtto_TextChanged" class="form-control" placeholder="To Date :(dd-MM-yyyy)" runat="server" MaxLength="10"></asp:TextBox>
                                                                    <asp:CalendarExtender  Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtto" runat="server"></asp:CalendarExtender>
</td>
                                        </tr>
                                         <tr><td class="col-md-5"></td></tr>
                                         <tr><td class="col-md-5"></td></tr>
                                         <tr><td class="col-md-5"></td></tr>
                                        <tr>
                                            <td class="col-md-5"><h4> Student Fee To Be Paid This Month  </h4> </td ><td class="col-md-5"><span class="red"> <h4><asp:Label ID="txttotfeetopay" Text="0" runat="server"></asp:Label></h4></span></td></tr><tr>
                                            <td class="col-md-5"><h4>Total Concession </h4>  </td><td class="col-md-5"><span class="blue">
                                                  <h4>  <asp:Label ID="txttotConces" Text="0" runat="server"></asp:Label></h4>
                                                    </span></td></tr><tr>
                                            <td class="col-md-5"><h4> Total Student Fee Received This Month </h4> </td><td class="col-md-5"><span class="blue">
                                                   <h4> <asp:Label ID="txttotfeeRecv" Text="0" runat="server"></asp:Label></h4>
                                                    </span></td></tr>
                                         <tr>
                                             <td class="col-md-5"><h4> Total Salary   </h4>  </td><td class="col-md-5"> <h4> <asp:Label ID="txttotSalary" Text="0" runat="server"></asp:Label> </h4></td></tr>
                                        <tr>
                                             <td class="col-md-5"><h4> Total Salary Paid  </h4>  </td><td class="col-md-5"> <h4> <asp:Label ID="txttotSalaryPaid" Text="0" runat="server"></asp:Label> </h4></td></tr>
                                        <tr>
                                             <td class="col-md-5"><h4> Total Salary Payable  </h4>  </td><td class="col-md-5"> <h4> <asp:Label ID="txttotSalaryPaYble" Text="0" runat="server"></asp:Label> </h4></td></tr>
                                        <tr>
                                             <td class="col-md-5"><h4> Total Expense </h4>  </td><td class="col-md-5"> <h4> <asp:Label ID="txttotExpnse" Text="0" runat="server"></asp:Label> </h4></td></tr>
                                            
                                    </table>
                                   
                                </div>
          
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
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
