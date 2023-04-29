<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageReports.aspx.cs" Inherits="SchoolPRO.AdminManageReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-sm-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <div class="label label-important arrowed lab">Student Reports</div>
                <ul class="ace-thumbnails">
                    
                    <li>
                        <a href="AdminStudentListReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Student List Report</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminClassStrengthReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Class Strength Report</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    
                    <li>
                        <a href="AdminStudentAttendanceReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Student Attendance Report</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminStudentRateReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Students Rating Report</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li class="dropdown">
                        <a href="AdminReportConfirmAdmissionSTD.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">View Partial Confirmed Admissions</span>
                                </span>

                            </div>
                        </a>
                    </li>
                    <li class="dropdown">
                        <a href="StudentPromotionHistory.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">View Student Promotion History</span>
                                </span>

                            </div>
                        </a>
                    </li>
                    </ul>
                <div class="clearfix"></div>
                <div class="space-6"></div>
                <div class="label label-important arrowed">Fee Reports</div>
                <ul class="ace-thumbnails">
                    <li>
                        <a href="AdminFeeSlipsReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Fee Slips Generated Report</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminClassFeeReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Class Fee Report</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminViewPaidFeeStudents.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="bolder label label-info arrowed">Paid Fee(Current Month) </span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminViewDeflauterStudents.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Fee Defaulter Report</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    
                    <li>
                        <a href="AdminViewRemainFeeStudents.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="bolder label label-info arrowed">Remaining Fee STD(Current Month)  </span>
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
                        <a href="AdminViewSubmittedFeeReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Students Fee Report</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminViewFeeConcReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Fee Concession Report</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li class="dropdown">
                        <a href="AdminViewClassFeeReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">View Class and Section Fee Report</span>
                                </span>

                            </div>
                        </a>
                    </li>
                    <li class="dropdown">
                        <a href="AdminViewDetailFeeReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">View Detail Class and Section Fee Report</span>
                                </span>

                            </div>
                        </a>
                    </li>
                    <li class="dropdown">
                        <a href="AdminViewAdmissionFeeReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">View Class Admission Fee Report</span>
                                </span>

                            </div>
                        </a>
                    </li>

                </ul>
                <div class="clearfix"></div>
                <div class="space-6"></div>
                <div class="label label-important arrowed">Finance Reports</div>
                <ul class="ace-thumbnails">
                    <li class="dropdown">
                        <a href="AdminViewSalaryReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">View Salary Report</span>
                                </span>

                            </div>
                        </a>
                    </li>

                    <li class="dropdown">
                        <a href="AdminViewTeacherSalary.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">View Teacher Salary by Invoice</span>
                                </span>
                                
                            </div>
                        </a>
                    </li>
                    
                    <li>
                        <a href="AdminBankReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Bank Amount Report</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminExpenseReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Expense Report</span>
                                </span>
                            </div>
                        </a>

                    </li>
                    <li class="dropdown">
                        <a href="AdminViewTeacherSalaryFeeReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">View Teacher Salary Report</span>
                                </span>

                            </div>
                        </a>
                    </li>
                    <li class="dropdown">
                        <a href="AdminSummaryReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">View Summary</span>
                                </span>

                            </div>
                        </a>
                    </li>
                    </ul>
                <div class="clearfix"></div>
                <div class="space-6"></div>
                <div class="label label-important arrowed">Result Reports</div>
                <ul class="ace-thumbnails">
                    <li class="dropdown">
                        <a href="AdminViewClassResultReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">View Class Result Report</span>
                                </span>

                            </div>
                        </a>
                    </li>
                    </ul>
                <div class="clearfix"></div>
                <div class="space-6"></div>
                <div class="label label-important arrowed">Messages Reports</div>
                <ul class="ace-thumbnails">
                    <li class="dropdown">
                        <a href="AdminViewAllMsgReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">View Message Sent Report</span>
                                </span>

                            </div>
                        </a>
                    </li>
                    </ul>
                
                <div class="clearfix"></div>
                <div class="space-6"></div>
                <div class="label label-important arrowed">Staff Reports</div>
                <ul class="ace-thumbnails">
                    <li>
                        <a href="AdminTeacherReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Class Incharge Report</span>
                                </span>


                            </div>
                        </a>

                    </li>
                    <li>
                        <a href="AdminEmployeeReport.aspx" data-rel="colorbox">
                            <img alt="150x150" src="assets/images/gallery/pic.png" width="205" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Employee Report</span>
                                </span>


                            </div>
                        </a>

                    </li>
                </ul>
            </div>
        </div>
        <div class="col-xs-8 col-lg-8 col-sm-8">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">

                </div>
            </div>
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
