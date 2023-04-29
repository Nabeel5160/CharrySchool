<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherviewSchedule.aspx.cs" Inherits="SchoolPRO.TeacherViewSchedule" %>

<%@ Import Namespace="SchoolPRO" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
        <script language="C#" runat="server">
            
            protected void txtdate_TextChanged(object sender, EventArgs e)
            {

            }
        </script>

        <div class="row-fluid">
            <div class="space-12"></div>
            <div class="col-sm-12">
                <div class="widget-box transparent">
                    <div class="widget-header widget-header-flat">
                        <h4 class="lighter"><i class="icon-star orange"></i>Classes Schedule </h4>
                        <label>Enter Date:</label>
                        <asp:ToolkitScriptManager ID="tool1" runat="server"></asp:ToolkitScriptManager>
                        <asp:TextBox runat="server" ID="txtdate" CssClass="form-control" placeholder="dd-MM-yyyy" OnTextChanged="txtdate_TextChanged" AutoPostBack="true"></asp:TextBox>
                        <%--<asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtdate" runat="server"></asp:CalendarExtender>--%>
                        <asp:CalendarExtender Format="dd-MM-yyyy" TargetControlID="txtdate" ID="CalendarExtender1" runat="server"></asp:CalendarExtender>
                        <div class="widget-toolbar"><a href="#" data-action="collapse"><i class="icon-chevron-up"></i></a></div>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main no-padding">

                            <table class="table table-bordered table-striped">
                                <thead class="thin-border-bottom">
                                    <tr>
                                        <th><i class="icon-caret-right blue"></i>Class </th>
                                        <th><i class="icon-caret-right blue"></i>Section</th>
                                        <th><i class="icon-caret-right blue"></i>Subject</th>
                                        <th class="hidden-480"><i class="icon-caret-right blue"></i>Teacher's Name </th>
                                        <th><i class="icon-caret-right blue"></i>Start Time</th>
                                        <th><i class="icon-caret-right blue"></i>End Time</th>
                                        <th><i class="icon-caret-right blue"></i>Shift</th>
                                        <th><i class="icon-caret-right blue"></i>Period</th>
                                        <th><i class="icon-caret-right blue"></i>Day</th>

                                        <th><i class="icon-caret-right blue"></i>Schedule</th>

                                    </tr>
                                </thead>
                                <%
                                    if (Session["userval"] == null)
                                    {
                                        Response.Redirect("login.aspx");
                                    }
                                %>
                                <%
                                    System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
                                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
                                    System.Data.SqlClient.SqlDataReader dr;
                                %>
                                <%
                                    con.Open();
                                    cmd.Connection = con;
                                    cmd.CommandType = System.Data.CommandType.Text;
                                    cmd.CommandText = "SELECT nshd_id,bisActive from tbl_Schedule where bisActive=1 and nsch_id='" + Session["nschoolid"] + "'";


                                    dr = cmd.ExecuteReader();
                                    dr.Read();
                                    string id = dr["nshd_id"].ToString();
                                    con.Close();
                                    DateTime dt = DateTime.ParseExact(txtdate.Text, "dd-MM-yyyy", System.Globalization.CultureInfo.InvariantCulture);

                                    //string s = dt.ToString("dd/M/yyyy");
                                    DateTime date = new DateTime();
                                    try
                                    {
                                        //date = Convert.ToDateTime(txtdate.Text);
                                        date = dt;
                                    }
                                    catch (Exception)
                                    {
                                        Response.Redirect("Error.aspx");
                                    }
                                    string day = date.Date.DayOfWeek.ToString();
                                    string query = "select c.strClass,s.strSubject,sc.strSection,u.strfname,t.strStartTime,t.strEndTime,t.strShift,t.strStartDate,t.strPeriod,t.strDay,shdl.strtimetable from tbl_TimeTable t inner join tbl_Section sc on t.nsc_id=sc.nsc_id inner join tbl_Schedule shdl on t.nshdule_id=shdl.nshd_id inner join tbl_Class c on t.nc_id=c.nc_id inner join tbl_Subject s on t.nsbj_id=s.nsbj_id inner join tbl_Users u on t.nu_id=u.nu_id where t.nshdule_id='" + id + "'and t.nu_id='" + Session["uid"] + "' and t.nsch_id='" + Session["nschoolid"] + "' and t.bisDeleted='False' and t.strDay='" + day + "'";
                                    cmd.Connection = con;
                                    con.Open();
                                    cmd.CommandType = System.Data.CommandType.Text;
                                    cmd.CommandText = query;
                                    List<enrollment> tempList = null;

                                    using (con)
                                    {
                                        dr = cmd.ExecuteReader();
                                        if (dr.HasRows)
                                        {
                                            tempList = new List<enrollment>();
                                            while (dr.Read())
                                            {
                                                enrollment c = new enrollment();
                                                c.classnm = dr["strClass"].ToString();
                                                c.subject = dr["strSubject"].ToString();
                                                c.section = dr["strSection"].ToString();
                                                c.emname = dr["strfname"].ToString();
                                                c.start_time = dr["strStartTime"].ToString();
                                                c.end_time = dr["strEndTime"].ToString();
                                                c.shift = dr["strShift"].ToString();
                                                c.city = dr["strDay"].ToString();
                                                c.country = dr["strPeriod"].ToString();
                                                c.date = dr["strtimetable"].ToString();
                                                tempList.Add(c);
                                            }
                                            tempList.TrimExcess();
                                            con.Close();
                                            foreach (var c in tempList)
                                            {
                                %>
                                <tbody>
                                    <tr>
                                        <td>
                                            <%lblcn.Text = c.classnm; %><asp:Label ID="lblcn" runat="server" Text=""></asp:Label></td>
                                        <td><%lblsec.Text = c.section; %>
                                            <asp:Label ID="lblsec" runat="server" Text=""></asp:Label></td>
                                        <td><b class="green">
                                            <%lblsnm.Text = c.subject; %><asp:Label ID="lblsnm" runat="server" Text=""></asp:Label></b></td>

                                        <td class="hidden-480"><span class="label label-info arrowed-right arrowed-in">
                                            <%lblumn.Text = c.emname; %><asp:Label ID="lblumn" runat="server" Text=""></asp:Label></span></td>
                                        <td>
                                            <%lblst.Text = c.start_time; %><asp:Label ID="lblst" runat="server" Text=""></asp:Label></td>
                                        <td>
                                            <%lblet.Text = c.end_time; %><asp:Label ID="lblet" runat="server" Text=""></asp:Label></td>
                                        <td>
                                            <%lblshf.Text = c.shift; %><asp:Label ID="lblshf" runat="server" Text=""></asp:Label></td>
                                        <td>
                                            <%lblprd.Text = c.country; %><asp:Label ID="lblprd" runat="server" Text=""></asp:Label></td>

                                        <td>
                                            <%lblday.Text = c.city; %><asp:Label ID="lblday" runat="server" Text=""></asp:Label></td>

                                        <td>
                                            <%lbldt.Text = c.date; %><asp:Label ID="lbldt" runat="server" Text=""></asp:Label></td>

                                    </tr>
                                </tbody>

                                <%}
                                %>
                                <%
                                }
                            }
                                %>
                            </table>
                        </div>
                        <!-- /widget-main -->
                    </div>
                    <!-- /widget-body -->
                </div>
                <!-- /widget-box -->
            </div>
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
</asp:Content>
