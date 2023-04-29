<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminStudentFee.aspx.cs" Inherits="SchoolPRO.AdminStudentFee" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
<div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <ul class="ace-thumbnails">
                    <li>
                        <a href="AdminDirectRecievingFee.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Direct Recieving</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminIssueClassFeeChallan.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Issue Class Fee Challans</span>
                                </span>


                            </div>
                        </a>

                    </li>
                   <%-- <li>
                        <a href="#" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Bank Recieving</span>
                                </span>


                            </div>
                        </a>

                    </li>--%>
                    <li>
                        <a href="AdminDirectRecvAdmissionFee.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Direct Recieve Admission Fee</span>
                                </span>


                            </div>
                        </a>

                    </li>
                     <li>
                        <a href="AdminDirectRecvBoardFee.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Direct Recieve Board Fee</span>
                                </span>


                            </div>
                        </a>

                    </li>
                     <li>
                        <a href="AdminPayFee.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Paid Fees</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminPayAdmissionFee.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Admission Paid Fees</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminPayBoardFee.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Board Paid Fees</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminDuplicateChalanForm.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/user_profile_logo.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Duplicate chalan form</span>
                                </span>


                            </div>
                        </a>

                    </li>

                </ul>
            </div>
            <!-- PAGE CONTENT ENDS -->
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
        <!-- /.col -->
    
</asp:Content><asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
