<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminTransport.aspx.cs" Inherits="SchoolPRO.AdminTransport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
<div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <ul class="ace-thumbnails">
                    <li>
                        <a href="AdminSetRoutes.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Routes</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminManageVehicle.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Vehicles</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminAlloteTransport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Transport Allotment</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <%--<li>
                        <a href="#" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Recieve Transport Fee</span>
                                </span>


                            </div>
                        </a>

                    </li>--%>
                </ul>
            </div>
            <!-- PAGE CONTENT ENDS -->
        </div>
        <!-- /.col -->
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
