<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminSendMsgz.aspx.cs" Inherits="SchoolPRO.AdminSendMsgz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
     <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <div class="row-fluid">
                <ul class="ace-thumbnails">
                    <li>
                        <a href="AdminSendMgsToTeacher.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Send SMS To Teacher</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminSendMgsToAdmin.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Send SMS To Admin</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminSendSMSClass.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Send SMS by Class</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminSendSMSToAbscent.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Send SMS to Abscenties</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminSendSMSAll.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Send SMS to All</span>
                                </span>


                            </div>
                        </a>

                    </li>

                    
                </ul>
            </div>
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
    <!-- /.row -->
</asp:Content>

