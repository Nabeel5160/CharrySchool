<%@ Page Title="" Language="C#" MasterPageFile="~/Student.Master" AutoEventWireup="true" CodeBehind="StudentViewResult.aspx.cs" Inherits="SchoolPRO.StudentViewResult" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
     <div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->

								<div class="row-fluid">
									<ul class="ace-thumbnails">
										
										
                                        <li>
											<a href="StudentView_First_Rzlt.aspx" data-rel="colorbox">
												<img alt="150x150" src="assets/images/gallery/muser.jpg" />
												<div class="tags">
													<span class="label-holder">
														<span class="label label-info arrowed">View First Term Exam Marks</span>
													</span>
												</div>
											</a>

											
										</li>
                                        <li>
											<a href="StudentView_Second_Rzlt.aspx" data-rel="colorbox">
												<img alt="150x150" src="assets/images/gallery/muser.jpg" />
												<div class="tags">
													<span class="label-holder">
														<span class="label label-info arrowed">View Second Term Exam Marks</span>
													</span>
												</div>
											</a>

											
										</li>
                                        <li>
											<a href="StudentViewExamRzlt.aspx" data-rel="colorbox">
												<img alt="150x150" src="assets/images/gallery/muser.jpg" />
												<div class="tags">
													<span class="label-holder">
														<span class="label label-info arrowed">View Final Exam Marks</span>
													</span>
												</div>
											</a>

											
										</li>
                                        <li>
											<a href="StudentViewQuizRzlt.aspx" data-rel="colorbox">
												<img alt="150x150" src="assets/images/gallery/student_details_logo.png" width="200" height="150" />
												<div class="tags">
													<span class="label-holder">
														<span class="label label-info arrowed">View Quiz Result</span>
													</span>
												</div>
											</a>

											
										</li>
                                        
                                        <li>
											<a href="StudentViewAssignmentRzlt.aspx" data-rel="colorbox">
												<img alt="150x150" src="assets/images/gallery/1add.jpg" width="200" height="150"/>
												<div class="tags">
													<span class="label-holder">
														<span class="label label-info arrowed">View Assignment Result</span>
													</span>
												</div>
											</a>

											
										</li>

									</ul>
								</div><!-- PAGE CONTENT ENDS -->
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
