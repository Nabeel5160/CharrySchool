<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherDashBoard.aspx.cs" Inherits="SchoolPRO.TeacherDashBoard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />  
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <ul class="ace-thumbnails">
                <li>
                    <a href="TeacherviewSchedule.aspx" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/timetable.jpg" width="200" height="150" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Time Table</span>
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
                    <a href="TeacherStudentAttendance.aspx" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/1add.jpg" width="200" height="150" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Attendance</span>
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
                    <a href="TeacherAddExamMarks.aspx" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/1add.jpg" width="200" height="150" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Result</span>
                            </span>


                        </div>
                    </a>

                    <div class="tools tools-top">
                        <a href="#">
                            <i class="icon-pencil"></i>
                        </a>
                    </div>
                </li>
              <%--  <li>
                    <a href="#" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/1add.jpg" width="200" height="150" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Parents Meeting</span>
                            </span>


                        </div>
                    </a>

                    <div class="tools tools-top">
                        <a href="#">
                            <i class="icon-pencil"></i>
                        </a>
                    </div>
                </li>--%>
                <li>
                    <a href="TeacherStudentTask.aspx" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/1add.jpg" width="200" height="150" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Quiz|Assignment|Home-Work</span>
                            </span>


                        </div>
                    </a>

                    <div class="tools tools-top">
                        <a href="#">
                            <i class="icon-pencil"></i>
                        </a>
                    </div>
                </li>
                <%--<li>
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
                </li>--%>


            </ul>
        </div>
        <!-- PAGE CONTENT ENDS -->
    </div>
    <div class="clearfix">
    </div>
    <div class="space-12"></div>
    <div class="hidden row">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
        <div class="col-sm-8">

            <div class="widget-box ">
                <div class="widget-header">
                    <h4 class="lighter smaller"><i class="icon-comment blue"></i>Conversation </h4>
                </div>
                <div class="widget-body">
                    <div class="widget-main no-padding overflow-scroll" style="height:350px">
                        <asp:Repeater ID="RepDetails" runat="server">
                            <ItemTemplate>
                                <div class="dialogs">
                                    <div class="itemdiv dialogdiv">
                                        <div class="user">
                                            <asp:Image ID="img" ImageUrl='<%#Eval("strImage") %>' runat="server" />
                                        </div>
                                        <div class="body">
                                            <div class="time">
                                                <i class="icon-time"></i><span class="green">
                                                    <asp:Label ID="lbltime" runat="server" Text='<%#Eval("dtAddDate") %>'></asp:Label></span>
                                            </div>
                                            <div class="name">
                                                <a href="#">
                                                    <asp:Label ID="lblfn" runat="server" Text='<%#Eval("strfname") %>'></asp:Label>
                                                </a><span class="label label-info arrowed arrowed-in-right">
                                                    <%--<asp:Label ID="lbldesg" runat="server" Text='<%#Eval("desg") %>'></asp:Label>--%>
                                                </span>
                                            </div>
                                            <div class="text">
                                                <asp:Label ID="lblmsg" runat="server" Text='<%#Eval("strMessage") %>'></asp:Label>
                                            </div>
                                            <div class="tools"><a href="#" class="btn btn-minier btn-info"><i class="icon-only icon-share-alt"></i></a></div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <form>
                            <div class="form-actions">
                                <div class="input-group">
                                    <asp:TextBox ID="txtmsg" placeholder="Type your message here ..." class="form-control" runat="server"></asp:TextBox>

                                    <span class="input-group-btn">
                                        <asp:Button class="btn btn-sm btn-info no-radius" ID="btnsend" runat="server" Text="Send" OnClick="btnsend_Click" />
                                        <i class="icon-share-alt"></i>
                                    </span>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- /widget-main -->
                </div>
                <!-- /widget-body -->
            </div>

            <!-- /widget-box -->
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
    </div>
</asp:Content>
