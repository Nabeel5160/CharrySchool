<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageSettings.aspx.cs" Inherits="SchoolPRO.AdminManageSettings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <div class="label label-important arrowed lab">Startup Management</div>
                <ul class="ace-thumbnails">
                    <li>
                        <a href="AdminManageClass.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Classes</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminManageSection.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Sections</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminManageSubjects.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Subjects</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminManageExpenseType.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Expense Types</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    
                    
                </ul>
                <div class="clearfix"></div>
                <div class="space-6"></div>
                <div class="label label-important arrowed">Fee Management</div>
                <ul class="ace-thumbnails">
                    <li>
                        <a href="AdminManageFee.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Fee</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminManageConcession.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Concession</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminManageFeeDueDate.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Fee Due Dates</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminChallanTerms.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Challan Terms & Conditions</span>
                                </span>


                            </div>
                        </a>

                    </li>
                </ul>
                <div class="clearfix"></div>
                <div class="space-6"></div>
                <div class="label label-important arrowed">Exam Management</div>
                <ul class="ace-thumbnails">
                    <li>
                        <a href="AdminSetPercentage.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Exam Passing Percentage</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminManageExamType.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Exam Type</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminManageQuizType.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Quiz Type</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminManageResultDecalaration.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Exam Result Declaration Date</span>
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
    <asp:UpdateProgress ID="UpdateProgress1" DisplayAfter="10" runat="server">
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
