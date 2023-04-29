<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDirectFeeChallanForm.aspx.cs" Inherits="SchoolPRO.AdminDirectFeeChallanForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="col-md-4">
                    <div>
                        <h3 class="widget-title grey lighter"><i class="ace-icon fa fa-leaf green"></i>
                            <asp:Label ID="txtschool1" Text="Schoollllllllll sd" runat="server"></asp:Label>
                        </h3>

                        <table>
                            <tr>
                                <td class="invoice-info-label">Challan #..</td>
                                <td><span class="red">
                                    <asp:Label ID="txtinv1" runat="server"></asp:Label></span></td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Date.......</td>
                                <td><span class="blue">
                                    <asp:Label ID="txtdate1" runat="server"></asp:Label>
                                </span></td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Due Date...</td>
                                <td><span class="blue">
                                    <asp:Label ID="txtduedate1" runat="server"></asp:Label>
                                </span></td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Reg #....</td>
                                <td>
                                    <asp:Label ID="txtreg1" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Name.....</td>
                                <td>
                                    <asp:Label ID="txtname1" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Class....</td>
                                <td>
                                    <asp:Label ID="txtcls1" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Section..</td>
                                <td>
                                    <asp:Label ID="txtsec1" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                        <table class="table table-striped table-bordered">
                            <thead>

                                <tr>
                                    <th>Fee</th>
                                    <td>
                                        <asp:Label ID="txtstFee1" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Months</th>
                                    <td>
                                        <asp:Label ID="txtmonths1" runat="server" Text="Novmenber ,April,jan,june"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Late Fee Fine</th>
                                    <td>
                                        <asp:Label ID="txtstFine1" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Concession</th>
                                    <td>
                                        <asp:Label ID="txtstConc1" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Remaining Fee</th>
                                    <td>
                                        <asp:Label ID="txtstRemainingFee1" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Total Fee</th>
                                    <td>
                                        <asp:Label ID="txtstTOTFee1" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Recived Fee</th>
                                    <td>
                                        <asp:Label ID="txtstRcvFee1" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </thead>

                        </table>
                        <div class="row">
                            <div class="col-sm-5 pull-right">
                                <h4 class="pull-right">Total Fee Recived :
																<span class="red">
                                                                    <td>
                                                                        <asp:Label runat="server" Text="000" ID="txtstTOTRcvfee1"></asp:Label>
                                                                </span>
                                </h4>
                            </div>
                            <div class="col-sm-5">
                                <h6 class="pull-right">Student Copy
																
                                </h6>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div>
                        <h3 class="widget-title grey lighter"><i class="ace-icon fa fa-leaf green"></i>
                            <asp:Label ID="txtschool2" Text="Schoollllllllll sd" runat="server"></asp:Label>
                        </h3>

                        <table>
                            <tr>
                                <td class="invoice-info-label">Challan #..</td>
                                <td><span class="red">
                                    <asp:Label ID="txtinv2" runat="server"></asp:Label></span></td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Date.......</td>
                                <td><span class="blue">
                                    <asp:Label ID="txtdate2" runat="server"></asp:Label>
                                </span></td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Due Date...</td>
                                <td><span class="blue">
                                    <asp:Label ID="txtduedate2" runat="server"></asp:Label>
                                </span></td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Reg #....</td>
                                <td>
                                    <asp:Label ID="txtreg2" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Name.....</td>
                                <td>
                                    <asp:Label ID="txtname2" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Class....</td>
                                <td>
                                    <asp:Label ID="txtcls2" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Section..</td>
                                <td>
                                    <asp:Label ID="txtsec2" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                        <table class="table table-striped table-bordered">
                            <thead>

                                <tr>
                                    <th>Fee</th>
                                    <td>
                                        <asp:Label ID="txtstFee2" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Months</th>
                                    <td>
                                        <asp:Label ID="txtmonths2" runat="server" Text="Novmenber ,April,jan,june"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Late Fee Fine</th>
                                    <td>
                                        <asp:Label ID="txtstFine2" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Concession</th>
                                    <td>
                                        <asp:Label ID="txtstConc2" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Remaining Fee</th>
                                    <td>
                                        <asp:Label ID="txtstRemainingFee2" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Total Fee</th>
                                    <td>
                                        <asp:Label ID="txtstTOTFee2" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Recived Fee</th>
                                    <td>
                                        <asp:Label ID="txtstRcvFee2" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </thead>

                        </table>
                        <div class="row">
                            <div class="col-sm-5 pull-right">
                                <h4 class="pull-right">Total Fee Recived :
																<span class="red">
                                                                    <td>
                                                                        <asp:Label runat="server" Text="000" ID="txtstTOTRcvfee2"></asp:Label>
                                                                </span>
                                </h4>
                            </div>
                            <div class="col-sm-5">
                                <h6 class="pull-right">School Copy
																
                                </h6>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div>
                        <h3 class="widget-title grey lighter"><i class="ace-icon fa fa-leaf green"></i>
                            <asp:Label ID="txtschool3" Text="Schoollllllllll sd" runat="server"></asp:Label>
                        </h3>

                        <table>
                            <tr>
                                <td class="invoice-info-label">Challan #..</td>
                                <td><span class="red">
                                    <asp:Label ID="txtinv3" runat="server"></asp:Label></span></td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Date.......</td>
                                <td><span class="blue">
                                    <asp:Label ID="txtdate3" runat="server"></asp:Label>
                                </span></td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Due Date...</td>
                                <td><span class="blue">
                                    <asp:Label ID="txtduedate3" runat="server"></asp:Label>
                                </span></td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Reg #....</td>
                                <td>
                                    <asp:Label ID="txtreg3" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Name.....</td>
                                <td>
                                    <asp:Label ID="txtname3" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Class....</td>
                                <td>
                                    <asp:Label ID="txtcls3" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="invoice-info-label">Section..</td>
                                <td>
                                    <asp:Label ID="txtsec3" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                        <table class="table table-striped table-bordered">
                            <thead>

                                <tr>
                                    <th>Fee</th>
                                    <td>
                                        <asp:Label ID="txtstFee3" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Months</th>
                                    <td>
                                        <asp:Label ID="txtmonths3" runat="server" Text="Novmenber ,April,jan,june"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Late Fee Fine</th>
                                    <td>
                                        <asp:Label ID="txtstFine3" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Concession</th>
                                    <td>
                                        <asp:Label ID="txtstConc3" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Remaining Fee</th>
                                    <td>
                                        <asp:Label ID="txtstRemainingFee3" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Total Fee</th>
                                    <td>
                                        <asp:Label ID="txtstTOTFee3" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Recived Fee</th>
                                    <td>
                                        <asp:Label ID="txtstRcvFee3" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </thead>

                        </table>
                        <div class="row">
                            <div class="col-sm-5 pull-right">
                                <h4 class="pull-right">Total Fee Recived :
																<span class="red">
                                                                    <td>
                                                                        <asp:Label runat="server" Text="000" ID="txtstTOTRcvfee3"></asp:Label>
                                                                </span>
                                </h4>
                            </div>
                            <div class="col-sm-5">
                                <h6 class="pull-right">Bank Copy
																
                                </h6>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
