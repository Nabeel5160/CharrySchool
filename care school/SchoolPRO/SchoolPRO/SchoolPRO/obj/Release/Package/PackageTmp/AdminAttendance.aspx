<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAttendance.aspx.cs" Inherits="SchoolPRO.AdminAttendance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <ul class="ace-thumbnails">
                    <li>
                        <a href="AdminConfirmAttendance.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Teachers Attendance Confirmation</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    
                    <li>
                        <a href="AdminConfrimEmployeeAttendance.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Teacher Attendance Report</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminStudentAttendanceReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Student Attendance Report</span>
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
</asp:Content><asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
