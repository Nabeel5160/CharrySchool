<%@ Page Title="" Language="C#" MasterPageFile="~/Library.Master" AutoEventWireup="true" CodeBehind="AdminLibraryDashboard.aspx.cs" Inherits="SchoolPRO.AdminLibraryDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <ul class="ace-thumbnails">
                <li>
                    <a href="AdminLibrarianBooks.aspx" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/timetable.jpg" width="200" height="150" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Manage Books</span>
                            </span>


                        </div>
                    </a>

                    <div class="tools tools-top">
                        <a href="#">
                            <i class="icon-pencil"></i>
                        </a>
                    </div>
                </li>
                <li>
                    <a href="AdminLibrarianIssueBooks.aspx" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/1add.jpg" width="200" height="150" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Issue Books</span>
                            </span>


                        </div>
                    </a>

                    <div class="tools tools-top">
                        <a href="#">
                            <i class="icon-pencil"></i>
                        </a>
                    </div>
                </li>
                <li>
                    <a href="AdminLibrarianRecieveBooks.aspx" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/1add.jpg" width="200" height="150" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Recieve Books</span>
                            </span>


                        </div>
                    </a>

                    <div class="tools tools-top">
                        <a href="#">
                            <i class="icon-pencil"></i>
                        </a>
                    </div>
                </li>
                  <li>
                    <a href="AdminLibrarianRecieveBooksReport.aspx" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/1add.jpg" width="200" height="150" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Recieve Books</span>
                            </span>


                        </div>
                    </a>

                    <div class="tools tools-top">
                        <a href="#">
                            <i class="icon-pencil"></i>
                        </a>
                    </div>
                </li>

                <li>
                    <a href="#" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/blog-icon.jpg" width="200" height="150" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Blog</span>
                            </span>


                        </div>
                    </a>

                    <div class="tools tools-top">
                        <a href="#">
                            <i class="icon-pencil"></i>
                        </a>
                    </div>
                </li>


            </ul>
        </div>
        <!-- PAGE CONTENT ENDS -->
    </div>
</asp:Content>
