<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDashBoard.aspx.cs" Inherits="SchoolPRO.AdminDashBoard" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" />
    <div class="page-header">
        <h1>Dashboard
								<small>
                                    <i class="ace-icon fa fa-angle-double-right"></i>
                                    overview &amp; stats
                                </small>
        </h1>
    </div>
    <!-- /.page-header -->
    <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
        <div class="row">
            <div class="col-xs-8 col-lg-8 col-sm-8 col-md-8">
                <ul class="ace-thumbnails">
                    <li>
                        <a href="AdminManageSettings.aspx" data-rel="colorbox">

                            <img src="assets/images/settings-xxl.png" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Settings</span>
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
                        <a href="AdminViewStudentDetail.aspx" data-rel="colorbox">
                            <img src="assets/images/emp_add.png" alt="150x150" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">View Students</span>
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
                        <a href="PromoteStudent.aspx" data-rel="colorbox">
                            <img src="assets/images/icon-transfer-lightblue.png" alt="150x150" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Promote Students</span>
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
                        <a href="AdminAttendance.aspx" data-rel="colorbox">

                            <img src="assets/images/attendance_icon.jpg" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Attendance</span>
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
                        <a href="AdminFinance.aspx" data-rel="colorbox">
                            <img src="assets/images/payroll.png" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">Manage Finance</span>
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
                        <a href="AdminManageReports.aspx" data-rel="colorbox">
                            <img src="assets/images/report.png" width="200" height="150" />
                            <div class="tags">
                                <span class="label-holder">
                                    <span class="label label-info arrowed">View Reports</span>
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
            <div class="col-xs-4 col-md-4 col-sm-4 col-lg-4">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Chart ID="Chart2" runat="server" BorderlineWidth="0"  
         BorderlineColor="64, 0, 64">  
        <Titles>  
            <asp:Title ShadowOffset="10" Name="Items" />  
        </Titles>  
        <Legends>  
            <asp:Legend Alignment="Center" Docking="Bottom" IsTextAutoFit="False" Name="Default"  
                LegendStyle="Row" />  
        </Legends>  
        <Series>  
            <asp:Series Name="Default" />  
        </Series>  
        <ChartAreas>  
            <asp:ChartArea Name="ChartArea1" BorderWidth="0" />  
        </ChartAreas>  
    </asp:Chart>  


                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
            </div>
            <div class="hr hr3 hr-dotted"></div>
        <div class="row">
            <div class="col-xs-12 col-lg-12 col-sm-12 col-md-12">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <asp:Chart Width="1024" ID="Chart1" CssClass="table table-bordered table-hover table-responsive" class="col-lg-12 col-xs-12 col-sm-12 col-md-12" runat="server">
                        <Titles>
                            <asp:Title Text="Total Unpaid Fee"></asp:Title>
                        </Titles>
                        <Series>
                            <asp:Series IsValueShownAsLabel="true" Name="Series1" ChartType="Bar"></asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisX Interval="1" IsStartedFromZero="True" Title="----Classes----"
                                    TitleFont="Segoe UI, 8pt, style=Bold" IsLabelAutoFit="false" LineColor="Gray"
                                    Minimum="0" Maximum="15">
                                    <MajorGrid LineColor="LightGray" />
                                    <LabelStyle Font="Segoe UI, 10pt" />
                                </AxisX>
                                <AxisY Title="---Total Unpaid----"
                                    TitleFont="Microsoft Sans Serif, 10pt, style=Bold">
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>

                </ContentTemplate>
            </asp:UpdatePanel>
                </div>
        </div>
    <div class="hr hr3 hr-dotted"></div>
        </div>


<%--    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Class.nc_id, tbl_Class.strClass, CAST(tbl_Class.strNOSeats AS INT) AS seat, tbl_Class.nu_id, tbl_Class.nsch_id, tbl_Class.dtAddDate, tbl_Class.dtDeleteDate, tbl_Class.bisDeleted, tbl_Section.strSection FROM tbl_Class INNER JOIN tbl_Section ON tbl_Class.nc_id = tbl_Section.nc_id"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT nc_id, strClass, CAST(strNOSeats AS INT) AS seat, nu_id, nsch_id, dtAddDate, dtDeleteDate, bisDeleted FROM tbl_Class"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT nc_id, strClass, CAST(strNOSeats AS INT) AS seat, nu_id, nsch_id, dtAddDate, dtDeleteDate, bisDeleted FROM tbl_Class"></asp:SqlDataSource>

    <div class="row">
        <div class="widget-header widget-header-flat widget-header-small">
            <h5 class="widget-title">
                <i class="ace-icon fa fa-signal"></i>
                Attendance Status
            </h5>

            <div class="widget-toolbar no-border">
                <div class="inline dropdown-hover">
                    <button class="btn btn-minier btn-primary">
                        Today
						<i class="ace-icon fa fa-angle-down icon-on-right bigger-110"></i>
                    </button>
                </div>
            </div>
        </div>


        <div class="widget-main">


            <div class="hr hr8 hr-double"></div>

            <div class="clearfix">
                <div class="col-lg-6 col-xs-6">
                    <span class="widget-title">
                        <i class="ace-icon fa fa-signal"></i>
                        &nbsp; Total Absent Students 
                    </span>
                    <h4 class="bigger pull-right">
                        <asp:Label ID="txttotabsnt" runat="server" Text="0"></asp:Label>
                        <a href="AdminViewAbsentStudent.aspx">See Them
                        </a></h4>
                </div>
                <div class="col-lg-6 col-xs-6">
                    <span class="widget-title">
                        <i class="ace-icon fa fa-signal"></i>
                        &nbsp; Total Present Students
                    </span>
                    <h4 class="bigger pull-right">
                        <label>
                            <asp:Label ID="txttotprsnts" runat="server" Text="0"></asp:Label></label></h4>
                </div>
            </div>
        </div>
        <!-- /.widget-main -->

    </div>--%>

</asp:Content>

