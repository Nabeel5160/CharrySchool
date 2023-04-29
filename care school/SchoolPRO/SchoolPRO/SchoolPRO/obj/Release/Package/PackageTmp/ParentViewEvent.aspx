<%@ Page Title="" Language="C#" MasterPageFile="~/Parent.Master" AutoEventWireup="true" CodeBehind="ParentViewEvent.aspx.cs" Inherits="SchoolPRO.ParentViewEvent" %>

<%@ Import Namespace="SchoolPRO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function printDiv(printable) {
            var printContents = document.getElementById(printable).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<div class="page-content-area">
        <div class="row">
            <div id="printable" class="col-xs-12">
                <!-- PAGE CONTENT BEGINS -->
                <div class="space-6"></div>

                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <div class="widget-box transparent">
                            <div class="widget-header widget-header-large">
                                <h3 class="widget-title grey lighter">
                                    <i class="ace-icon fa fa-leaf green"></i>
                                    <asp:Label ID="txtSchool" runat="server"></asp:Label>
                                </h3>
                            </div>
                            <%
                                System.Data.SqlClient.SqlConnection con2 = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
                                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
                                System.Data.SqlClient.SqlDataReader dr;

                                string query = "SELECT nevent_id,strtitle,strDesc,dtStartDate,dtEndDate from tbl_Event where bisActive=1 and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";// and nsch_id='"+Session["nschoolid"]+"'";
                                cmd.Connection = con2;
                                con2.Open();
                                cmd.CommandType = System.Data.CommandType.Text;
                                cmd.CommandText = query;

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
                                            c.id = dr["nevent_id"].ToString();
                                            c.stnum = dr["strtitle"].ToString();
                                            c.vnum = dr["strDesc"].ToString();
                                            c.fee = dr["dtStartDate"].ToString();
                                            c.amount = dr["dtEndDate"].ToString();


                                            tempList.Add(c);
                                        }
                                        tempList.TrimExcess();
                                        con2.Close();

                                    }
                                }        %>
                            <div class="widget-body">
                                <div class="widget-main padding-24">


                                    <% 
                                        try
                                        {
                                            foreach (var c in tempList)
                                            {
                                    %>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="row">
                                                <div class="col-xs-11 label label-lg label-info arrowed-in arrowed-right">
                                                    <b><%txtEventTitle2.Text = c.stnum; %>
                                                        <asp:Label runat="server" ID="txtEventTitle2"></asp:Label></b>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <ul class="list-unstyled spaced">
                                                    <li>
                                                        <%txtEventTitle.Text = c.stnum; %>
                                                        <i class="ace-icon fa fa-caret-right blue"></i>
                                                        Event Title&nbsp;&nbsp;&nbsp;&nbsp; :
                                                        <asp:Label runat="server" ID="txtEventTitle"></asp:Label>
                                                    </li>

                                                    <li><%txtEventDesc.Text = c.vnum; %>
                                                        <i class="ace-icon fa fa-caret-right blue"></i>
                                                        Event Description&nbsp;&nbsp; :
                                                        <asp:Label runat="server" ID="txtEventDesc"></asp:Label>
                                                    </li>

                                                    <li><%txtEventstDate.Text = c.fee; %>
                                                        <i class="ace-icon fa fa-caret-right blue"></i>
                                                        Event Start Date&nbsp;&nbsp;&nbsp;&nbsp; :
                                                        <asp:Label runat="server" ID="txtEventstDate"></asp:Label></li>
                                                    <li><%txtEventEndDate.Text = c.amount; %>
                                                        <i class="ace-icon fa fa-caret-right blue"></i>
                                                        Event End Date&nbsp;  :<asp:Label runat="server" ID="txtEventEndDate"></asp:Label></li>

                                                </ul>
                                            </div>
                                        </div>
                                        <!-- /.col -->
                                    </div>
                                    <!-- /.row -->
                                    <%}
                                                         }
                                                         catch (Exception ex)
                                                         {
                                                             Response.Redirect("Error.aspx");
                                                         }
                                    %>
                                    <div class="space"></div>
                                    <div class="row">
                                        <%--<div class="col-xs-11 label label-lg label-info arrowed-in arrowed-right">
																	<b><asp:Label runat="server" ID="txtterm"  Text="Term"></asp:Label></b>
									<%--							</div>--%>
    <%-- </div>
                                    <div>--%>

    <%-- <asp:GridView CssClass="table table-striped table-bordered table-hover" runat="server" ID="gvresult" AutoGenerateColumns="false" >
                                                                <Columns>
                                                                    <asp:BoundField HeaderText="S.No" DataField="nc_id" />
                                                                    <asp:BoundField HeaderText="Subject Code" DataField="Name" />
                                                                    <asp:BoundField HeaderText="Subject Name" DataField="Class" />
                                                                    <asp:BoundField HeaderText="Total Marks" DataField="Section" />
                                                                    <asp:BoundField HeaderText="Obtain Marks" DataField="Roll_Number" />
                                                                    <asp:BoundField HeaderText="Percentage" DataField="S_No" />
                                                                    <asp:BoundField HeaderText="Status" DataField="status" />
                                                                </Columns>

                                                            </asp:GridView>--%>


    <%--<div class="hr hr8 hr-double hr-dotted"></div>--%>

    <%--<div class="row">
														<div class="col-sm-5 pull-right">
															<h4 class="pull-right">
																Obt/Total :
																<span class="red"><td><asp:Label runat="server" ID="txttotobtmarks"></asp:Label></span>
                                                                <span>/</span>
                                                                <span class="red"><td><asp:Label runat="server" ID="txttotAllsubmarks"></asp:Label></span>
															</h4>
														</div>
                                                        <div class="col-sm-5 pull-right">
															<h4 class="pull-right">
																Status :
																<span class="red"><td><asp:Label runat="server" ID="txtPercentage"></asp:Label></span>
                                                            </h4>
														</div>
														<%--<div class="col-sm-7 pull-left"> Extra Information </div>-
													</div>--%>

    <%--<div class="space-6"></div>
                                        <div class="well">
                                            <div class="align-center">--%>
    <%--Powered By AT-Teachsoul , Farmecole School Management Sys | www.farmecole.com
                                                                    0321-9883140 --%>
    <%--</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>--%>

    <!-- PAGE CONTENT ENDS -->
    <%--</div>--%>
    <!-- /.col -->
    <%--<label class="hidden-print width-30 pull-right btn btn-sm btn-success" onclick="printDiv('printable')">Print</label>--%>
    <%--</div>--%>
    <!-- /.row -->
    <%--</div>--%>
    <!-- /.page-content-area -->
    <%--</div>--%>











    <div class="col-xs-12">
        <div class="row">
            <div class="col-xs-12">
                <!-- PAGE CONTENT BEGINS -->

                <div class="row-fluid">
                    <h4 class="header green lighter bigger">
                        <i class="icon-group blue"></i>
                        Manage Events
                    </h4>
                    <div class="space-6"></div>
                    <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                    <asp:UpdatePanel ID="upsub" runat="server">
                        <ContentTemplate>
                            <asp:MultiView ID="mvsub" ActiveViewIndex="0" runat="server">
                                <asp:View ID="View1" runat="server">
                                    <div class="space-30"></div>
                                    <div id="Div1" class="table-responsive">
                                        <div class="widget-header header-color-blue">
                                            <h5 class="bigger lighter">
                                                <i class="icon-table"></i>
                                                Events List
                                            </h5>
                                        </div>
                                    </div>
                                    <asp:GridView ID="gvsearchsub" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nevent_id" DataSourceID="DsPEvents">
                                        <Columns>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nevent_id" HeaderText="nevent_id" ReadOnly="True" InsertVisible="False" SortExpression="nevent_id"></asp:BoundField>
                                            <asp:BoundField DataField="Event Title" HeaderText="Event Title" SortExpression="Event Title"></asp:BoundField>
                                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
                                            <asp:BoundField DataField="Start Date" HeaderText="Start Date" SortExpression="Start Date"></asp:BoundField>
                                            <asp:BoundField DataField="End Date" HeaderText="End Date" SortExpression="End Date"></asp:BoundField>
                                            <asp:CheckBoxField DataField="bisDeleted" HeaderText="bisDeleted" SortExpression="bisDeleted"></asp:CheckBoxField>
                                        </Columns>
                                        <Columns>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource runat="server" ID="DsPEvents" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nevent_id, strtitle AS 'Event Title', strDesc AS 'Description', dtStartDate AS 'Start Date', dtEndDate AS 'End Date', bisDeleted FROM tbl_Event WHERE (bisActive = @tbit) AND (bisDeleted = @fbit) AND (nsch_id=@sec)">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="True" Name="tbit"></asp:Parameter>
                                            <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                            <asp:SessionParameter Name="sec" SessionField="nschoolid" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <div class="space-4"></div>

                                    </div>
                                </asp:View>
                            </asp:MultiView>
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
            </div>
        </div>
    </div>
</asp:Content>
