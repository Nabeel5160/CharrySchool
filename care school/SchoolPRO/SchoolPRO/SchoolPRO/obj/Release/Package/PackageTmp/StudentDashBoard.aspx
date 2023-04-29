<%@ Page Title="" Language="C#" MasterPageFile="~/Student.Master" AutoEventWireup="true" CodeBehind="StudentDashBoard.aspx.cs" Inherits="SchoolPRO.StudentDashBoard" %>
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
											<a href="StudentViewDetail.aspx" data-rel="colorbox">
												<img alt="150x150" src="assets/images/gallery/student_details_logo.png" width="200" height="150" />
												<div class="tags">
													<span class="label-holder">
														<span class="label label-info arrowed">Student Detail</span>
													</span>
												</div>
											</a>

											
										</li>
                                        
                                        <li>
											<a href="StudentViewAttendance.aspx" data-rel="colorbox">
												<img alt="150x150" src="assets/images/gallery/1add.jpg" width="200" height="150"/>
												<div class="tags">
													<span class="label-holder">
														<span class="label label-info arrowed">Attendance</span>
													</span>
												</div>
											</a>

											
										</li>

                                        <li>
											<a href="StudentViewResult.aspx" data-rel="colorbox">
												<img alt="150x150" src="assets/images/gallery/1add.jpg" width="200" height="150"/>
												<div class="tags">
													<span class="label-holder">
														<span class="label label-info arrowed">Student Result</span>
													</span>
												</div>
											</a>

											
										</li>

                                        <li>
											<a href="StudentEventView.aspx" data-rel="colorbox">
												<img alt="150x150" src="assets/images/gallery/news_icon.jpg" />
												<div class="tags">
													<span class="label-holder">
														<span class="label label-info arrowed">Events and News</span>
													</span>
												</div>
											</a>

											
										</li>
									</ul>
								</div><!-- PAGE CONTENT ENDS -->
                                <div class="clearfix"></div>
                                <div class="space-12"></div>
                                <div class="row">
									<div class="col-sm-12">
                <div class="widget-box transparent" id="recent-box">
                  <div class="widget-header">
                    <h4 class="lighter smaller"> <i class="icon-rss orange"></i> RECENT </h4>
                    <div class="widget-toolbar no-border">
                      <ul class="nav nav-tabs" id="recent-tab">
                        <li class="active"> <a data-toggle="tab" href="#task-tab">Daily Dairy</a> </li>
                        <li> <a data-toggle="tab" href="#member-tab">Daily Attendance</a> </li>
                        </ul>
                    </div>
                  </div>
                  <div class="widget-body">
                    <div class="widget-main padding-4">
                      <div class="tab-content padding-8 overflow-visible">
                        <div id="task-tab" class="tab-pane active">
                          
                            <div class="table-responsive">
                            <asp:GridView ID="gridViewMaster" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" DataKeyNames="nc_id" 
            DataSourceID="sqldd" class="table table-striped table-bordered table-hover" GridLines="None" 
            onrowdatabound="gridViewMaster_RowDataBound">
            <Columns>
            <asp:TemplateField>
                        <ItemTemplate>
                            <a href="javascript:showNestedGridView('nc_id-<%# Eval("nc_id") %>');">
                                <img id='imagec_id-<%# Eval("nc_id") %>' alt="Click to show/hide orders" border="0" src="assets/img/arrowup.png" />
                            </a>
                        </ItemTemplate>
                       </asp:TemplateField>
                <asp:BoundField DataField="strFname" SortExpression="strFname" HeaderText="FirstName" />
                <asp:BoundField DataField="strClass" HeaderText="Class" ReadOnly="True" 
                    SortExpression="strClass" />
                <asp:BoundField DataField="strSchName" HeaderText="School Name" 
                    SortExpression="strSchName" />
                    <asp:TemplateField>
                    <ItemTemplate>
                      <tr>
                                <td colspan="100%">
                                   <div id='nc_id-<%# Eval("nc_id") %>' style="display:none;position:relative;left:25px;" >
                         <asp:GridView ID="nestedGridView" class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" 
                            DataKeyNames="nsbj_id">
                             
                            <Columns>
                                
                                <asp:BoundField DataField="strSubject" SortExpression="strSubject" HeaderText="Subject" />
                                <asp:BoundField DataField="strDesc" HeaderText="Topic" 
                                    SortExpression="strDesc" />
                                    <asp:BoundField DataField="strTime" HeaderText="Time" 
                                    SortExpression="strTime" />
                                <asp:BoundField DataField="dtDate" SortExpression="dtDate" HeaderText="Date" />
                            </Columns>
                             
                        </asp:GridView>
                        </div>
                                </td>
                            </tr>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            
        </asp:GridView>
        <asp:SqlDataSource ID="sqldd" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SchoolPro %>" 
            SelectCommand="SELECT tbl_Class.nc_id,tbl_Class.strClass, tbl_School.strSchName, tbl_Enrollment.strFname FROM tbl_Class INNER JOIN tbl_Enrollment ON tbl_Class.nc_id = tbl_Enrollment.nc_id INNER JOIN tbl_School ON tbl_Class.nsch_id = tbl_School.nsch_id WHERE (tbl_Enrollment.ne_id = @eid) and tbl_Enrollment.bisDeleted='False'">
            <SelectParameters>
                <asp:SessionParameter Name="eid" SessionField="eid" />
            </SelectParameters>
        </asp:SqlDataSource>
</div>
                        </div>
                        <div id="member-tab" class="tab-pane">
                          <div class="clearfix">
                            <table class="table table-bordered table-striped">
                        <thead class="thin-border-bottom">
                          <tr>
                            <th> <i class="icon-caret-right blue"></i> Student Num </th>
                            <th> <i class="icon-caret-right blue"></i> Name </th>
                              <th> <i class="icon-caret-right blue"></i> Class </th>
                            <th class="hidden-480"> <i class="icon-caret-right blue"></i> Status </th>
                              <th class="hidden-480"> <i class="icon-caret-right blue"></i> Date </th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td>
                                <asp:Label ID="lblstnum" runat="server" Text=""></asp:Label></td>
                            <td><b class="green">
                                <asp:Label ID="lblfnm" runat="server" Text=""></asp:Label>&nbsp;
                                <asp:Label ID="lblmnm" runat="server" Text=""></asp:Label>
                                </b></td>
                              <td><b class="green">
                                <asp:Label ID="lblcl" runat="server" Text=""></asp:Label></b></td>
                            <td class="hidden-480"><span class="label label-info arrowed-right arrowed-in">
                                <asp:Label ID="lblst" runat="server" Text=""></asp:Label></span></td>
                              <td class="hidden-480"><span class="label label-info arrowed-right arrowed-in">
                                <asp:Label ID="lbldt" runat="server" Text=""></asp:Label></span></td>
                          </tr>
                          </tbody>
                      </table>
                          </div>
                          
                          <div class="hr hr-double hr8"></div>
                        </div>
                        <!-- member-tab -->
                        
                      </div>
                    </div>
                    <!-- /widget-main -->
                  </div>
                  <!-- /widget-body -->
                </div>
                <!-- /widget-box -->
              </div>
              <!-- /span -->
              
              <!-- /span -->
            </div>
            <!-- /row -->

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
