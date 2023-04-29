<%@ Page Title="" Language="C#" MasterPageFile="~/Parent.Master" AutoEventWireup="true" CodeBehind="ParentDashBoard.aspx.cs" Inherits="SchoolPRO.ParentDashBoard" %>
<%@ Import Namespace="SchoolPRO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" />    
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <ul class="ace-thumbnails">

                <li>
                    <a href="ParentStudentEnrollment.aspx" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/muser.jpg" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Admissions</span>
                            </span>
                        </div>
                    </a>


                </li>
                <li>
                    <a href="ParentViewChildren.aspx" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/student_details_logo.png" width="200" height="150" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Student Detail</span>
                            </span>
                        </div>
                    </a>


                </li>

                <li>
                    <a href="ParentViewAttendance.aspx" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/1add.jpg" width="200" height="150" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Attendance</span>
                            </span>
                        </div>
                    </a>


                </li>

                <li>
                    <a href="ParentViewResult.aspx" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/1add.jpg" width="200" height="150" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Student Result</span>
                            </span>
                        </div>
                    </a>


                </li>

                <li>
                    <a href="ParentViewEvent.aspx" data-rel="colorbox">
                        <img alt="150x150" src="assets/images/gallery/news_icon.jpg" />
                        <div class="tags">
                            <span class="label-holder">
                                <span class="label label-info arrowed">Events and News</span>
                            </span>
                        </div>
                    </a>


                </li>
            </ul>
        </div>
        <!-- PAGE CONTENT ENDS -->
        <div class="clearfix"></div>
        <div class="space-12"></div>
        <div class="row">
            <div class="col-sm-6">
                <div class="widget-box transparent" id="recent-box">
                    <div class="widget-header">
                        <h4 class="lighter smaller"><i class="icon-rss orange"></i>RECENT </h4>
                        <div class="widget-toolbar no-border">
                            <ul class="nav nav-tabs" id="recent-tab">
                                <li class="active"><a data-toggle="tab" href="#task-tab">Daily Dairy</a> </li>
                                <li><a data-toggle="tab" href="#member-tab">Daily Attendance</a> </li>
                                <li><a data-toggle="tab" href="#fee-tab1">See Fee Status </a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main padding-4">
                            <div class="tab-content padding-8 overflow-visible">
                                <!-- member-tab -->
                                <div id="task-tab" class="tab-pane active">

                                    <div class="table-responsive">
                                        <asp:GridView ID="gridViewMaster" runat="server" AllowPaging="True"
                                            AutoGenerateColumns="False" DataKeyNames="nc_id"
                                            DataSourceID="sqldd" class="table table-striped table-bordered table-hover" GridLines="None"
                                            OnRowDataBound="gridViewMaster_RowDataBound">
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
                                                                <div id='nc_id-<%# Eval("nc_id") %>' style="display: none; position: relative; left: 25px;">
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
                                            SelectCommand="SELECT tbl_Class.nc_id,tbl_Class.strClass, tbl_School.strSchName, tbl_Enrollment.strFname FROM tbl_Class INNER JOIN tbl_Enrollment ON tbl_Class.nc_id = tbl_Enrollment.nc_id INNER JOIN tbl_School ON tbl_Class.nsch_id = tbl_School.nsch_id WHERE (tbl_Enrollment.nu_id = @uid) and tbl_Enrollment.bisDeleted='False'" OnSelecting="sqldd_Selecting">
                                            <SelectParameters>
                                                <asp:SessionParameter Name="uid" SessionField="uid" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                </div>
                                <div id="member-tab" class="tab-pane">
                                    <div class="clearfix">
                                        <table class="table table-bordered table-striped">
                                            <thead class="thin-border-bottom">
                                                <tr>
                                                    <th><i class="icon-caret-right blue"></i>Student Num </th>
                                                    <th><i class="icon-caret-right blue"></i>Name </th>
                                                    <th><i class="icon-caret-right blue"></i>Class </th>
                                                    <th class="hidden-480"><i class="icon-caret-right blue"></i>Status </th>
                                                    <th class="hidden-480"><i class="icon-caret-right blue"></i>Date </th>
                                                    
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
                                  <%
                                                System.Data.SqlClient.SqlConnection con2 = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
                                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
                                    System.Data.SqlClient.SqlDataReader dr;
                                                %>
                                            <%
                                                 
               /// SqlConnection con2 = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
                                                string query = "SELECT tbl_RecieveFee.strFeeAmount,tbl_Enrollment.ne_id, tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS fullname, tbl_Enrollment.strStudentNum, tbl_RecieveFee.strFeeAmountReceived, tbl_RecieveFee.strFeeAmountRemaining, tbl_RecieveFee.dtAddDate,tbl_RecieveFee.dtPaidDate as dt, tbl_Enrollment.nu_id FROM tbl_RecieveFee INNER JOIN tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Users ON tbl_Enrollment.nu_id = tbl_Users.nu_id WHERE SUBSTRING(tbl_RecieveFee.dtAddDate,4,2)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2) and SUBSTRING(tbl_RecieveFee.dtAddDate,7,4)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,4)  AND (tbl_RecieveFee.nsch_id = @nschid1) AND (tbl_Enrollment.nu_id = @nuid1)  and  tbl_RecieveFee.bisPaid = 'True'";
                cmd.Connection = con2;
                con2.Open();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = query;
                cmd.Parameters.AddWithValue("@nschid1", Session["nschoolid"]);
                cmd.Parameters.AddWithValue("@nuid1", Session["uid"]);
                List<enrollment> tempList = null;

                using (con2)
                {
                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                       tempList = new List<enrollment>();
                        while (dr.Read())
                        {
                            enrollment c = new enrollment();
                            c.id = dr["ne_id"].ToString();
                           c.stnum = dr["strStudentNum"].ToString();
                            c.vnum = dr["fullname"].ToString();
                            c.fee = dr["strFeeAmount"].ToString();
                            c.amount = dr["strFeeAmountReceived"].ToString();
                            
                            c.efee = dr["strFeeAmountRemaining"].ToString();
                            c.date = dr["dtAddDate"].ToString();
                            c.dob = dr["dt"].ToString();
                            tempList.Add(c);
                        }
                        tempList.TrimExcess();
                        con2.Close();
                       
                                                 %>

                                <div id="fee-tab1" class="tab-pane">
                                    <div class="clearfix">
                                        <table class="table table-bordered table-striped">
                                            <thead class="thin-border-bottom">
                                                <tr>
                                                    <th><i class="icon-caret-right blue"></i>Student Num </th>
                                                    <th><i class="icon-caret-right blue"></i>Name </th>
                                                    <th><i class="icon-caret-right blue"></i>Fee </th>
                                                    <th ><i class="icon-caret-right blue"></i>Receive Fee </th>
                                                    <th ><i class="icon-caret-right blue"></i>Remaining Fee </th>
                                                    <th ><i class="icon-caret-right blue"></i>Challan Given Date </th>
                                                    <th ><i class="icon-caret-right blue"></i>Submit Fee Date </th>
                                                    <th class="hidden-480"><i class="icon-caret-right blue"></i>View Fee History </th>
                                                </tr>
                                            </thead>
                                            <%  foreach (var c in tempList)
                                                 {
                                                        %>
                                            <tbody>
                                                 
                                                <tr>
                                                    <td>
                                                       <%  lblstnum1.Text = c.stnum; %>   <asp:Label ID="lblstnum1" runat="server" Text=""></asp:Label></td>
                                                    <td><b class="green">
                                                       <% lblnm.Text = c.vnum;  %> <asp:Label ID="lblnm" runat="server" Text=""></asp:Label>
                                                    </b></td>
                                                    <td><b class="green">
                                                      <% lblfee.Text = c.fee; %>  <asp:Label ID="lblfee" runat="server" Text=""></asp:Label></b></td>
                                                    <td ><span class="label label-info arrowed-right arrowed-in">
                                                      <% lblRcvFee.Text = c.amount; %>  <asp:Label ID="lblRcvFee" runat="server" Text=""></asp:Label></span></td>
                                                    <td ><span class="label label-info arrowed-right arrowed-in">
                                                       <% lblRemnFee.Text = c.efee; %> <asp:Label ID="lblRemnFee" runat="server" Text=""></asp:Label></span></td>
                                                    <td ><span class="label label-info arrowed-right arrowed-in">
                                                      <% lbldate.Text = c.date; %>  <asp:Label ID="lbldate" runat="server" Text=""></asp:Label></span></td>
                                                      <td ><span class="label label-info arrowed-right arrowed-in">
                                                      <% lbldt22.Text = c.dob; %>  <asp:Label ID="lbldt22" runat="server" Text=""></asp:Label></span></td>
                                                    <td >
                                                        <a href="ParentViewFeeHistory.aspx?neid=<% =c.id %>" class="btn-default btn btn-success" >Fee History</a>
                                                        <%--<form name="myform" action="ParentViewFeeHistory.aspx" method="get">
                                                            <input runat="server" name="stroll" type="hidden" value="<% lblstnum1.Text %>" />
                                                            <input runat="server" name="neid" type="hidden" value="<% c.id %>" />
                                                            <input runat="server" class="btn-success" type="submit" value="Fee History" />
                                                        </form>--%>
                                                        </td>
                                                </tr>
                                                 
                                            </tbody>
                                            <%
                                                   
                                                                       //lblnm.Text=c.vnum; 
                           // lblfee.Text =c.fee;
                            //lblRcvFee.Text =c.amount;

                           // lblRemnFee.Text=c.efee;
                           // lbldate.Text = c.date;
                            } %>
                                        </table>
                                    </div>

                                    <div class="hr hr-double hr8"></div>
                                </div>

                                 <% 
                                            } 
                                            }%>
                                <%--<div id="fee-tab"class="tab-pane">
                                    <div class="clearfix">
                                        <div class="table-responsive table table-bordered table-striped">
                                            <asp:GridView runat="server" ID="gvfee" AllowPaging="true" DataSourceID="feeDS" AutoGenerateColumns="False" AllowSorting="True">
                                                <Columns>
                                                    <asp:BoundField DataField="strFeeAmount" HeaderText="strFeeAmount" SortExpression="strFeeAmount"></asp:BoundField>
                                                    <asp:BoundField DataField="fullname" HeaderText="fullname" ReadOnly="True" SortExpression="fullname"></asp:BoundField>
                                                    <asp:BoundField DataField="strStudentNum" HeaderText="strStudentNum" SortExpression="strStudentNum"></asp:BoundField>
                                                    <asp:BoundField DataField="strFeeAmountReceived" HeaderText="strFeeAmountReceived" SortExpression="strFeeAmountReceived"></asp:BoundField>
                                                    <asp:BoundField DataField="strFeeAmountRemaining" HeaderText="strFeeAmountRemaining" SortExpression="strFeeAmountRemaining"></asp:BoundField>
                                                    <asp:BoundField DataField="dtAddDate" HeaderText="dtAddDate" SortExpression="dtAddDate"></asp:BoundField>
                                                    <asp:BoundField DataField="nu_id" HeaderText="nu_id" SortExpression="nu_id"></asp:BoundField>
                                                </Columns>
                                            </asp:GridView>

                                            <asp:SqlDataSource runat="server" ID="feeDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_RecieveFee.strFeeAmount, tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS fullname, tbl_Enrollment.strStudentNum, tbl_RecieveFee.strFeeAmountReceived, tbl_RecieveFee.strFeeAmountRemaining, tbl_RecieveFee.dtAddDate, tbl_Enrollment.nu_id FROM tbl_RecieveFee INNER JOIN tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Users ON tbl_Enrollment.nu_id = tbl_Users.nu_id WHERE (DATEPART(m, tbl_RecieveFee.dtAddDate) = DATEPART(m, CONVERT (date, SYSDATETIME()))) AND (tbl_RecieveFee.nsch_id = @nschid) AND (tbl_RecieveFee.strFeeAmountRemaining = 0 OR tbl_RecieveFee.strFeeAmountRemaining > 0) AND (tbl_Enrollment.nu_id = @nuid)">
                                                <SelectParameters>
                                                    <asp:SessionParameter SessionField="nschoolid" Name="nschid"></asp:SessionParameter>
                                                    <asp:SessionParameter SessionField="uid" Name="nuid"></asp:SessionParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </div>
                                        </div>
                                </div>--%>
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
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
            <div class="col-sm-6">
                <div class="widget-box ">
                    <div class="widget-header">
                        <h4 class="lighter smaller"><i class="icon-comment blue"></i>Conversation </h4>
                    </div>
                    <div class="widget-body ">
                        <div class="widget-main no-padding ">
                            <div class=" overflow-scroll" style="height:350px">
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
                                </div>
                            <%--<form>--%>
                                <div class="form-actions">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtmsg" placeholder="Type your message here ..." class="form-control" runat="server"></asp:TextBox>

                                        <span class="input-group-btn">
                                            <asp:Button class="btn btn-sm btn-info no-radius" ID="btnsend" runat="server" Text="Send" OnClick="btnsend_Click" />
                                            <i class="icon-share-alt"></i>
                                        </span>
                                    </div>
                                </div>
                            <%--</form>--%>
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
            <!-- /span -->
        </div>
        <!-- /row -->

    </div>
</asp:Content>

