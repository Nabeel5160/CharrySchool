<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageUsers.aspx.cs" Inherits="SchoolPRO.AdminManageUsers" %>

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
                        <a href="AdminAddTeacher.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Teachers</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminManageP-C.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Parents & Children</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminManageEmployees.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Employees</span>
                                </span>


                            </div>
                        </a>

                    </li>
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

