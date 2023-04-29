<%@ Page Title="" Language="C#" MasterPageFile="~/Parent.Master" AutoEventWireup="true" CodeBehind="ParentViewFeeHistory.aspx.cs" Inherits="SchoolPRO.ParentViewFeeHistory" %>
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
     <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Search By Name
            </h4>

            <div class="space-6"></div>
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvatnd" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <%--<asp:Button ID="btngotoAdd" runat="server" Text="Mark Attendance" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                            <asp:Label ID="Label1" Text="From :" runat="server" CssClass="label" ></asp:Label>
                            <asp:TextBox ID="txtFrom" placeholder="yyyy-MM-dd"    runat="server" class="width-10"  >
                            </asp:TextBox>

                            <asp:Label ID="Label2" CssClass="label"  Text="To :" runat="server" ></asp:Label>
                            <asp:TextBox ID="txtTo" runat="server" placeholder="yyyy-MM-dd"  class="width-10"  AutoPostBack="true" OnTextChanged="txtTo_TextChanged"></asp:TextBox>
                           &nbsp;
                            <div class="clearfix"></div>

                            <asp:Button Text="Leave" ID="btnleave" runat="server" class="width-20 pull-right btn btn-sm btn-success" OnClick="btnsubmit_Click" />
                                --%>
                               <div class="space-22"></div>
                            <div id="printable" class="table-responsive">
                                <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Student Fee History
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server"  AllowSorting="True" AutoGenerateColumns="False" DataSourceID="stFeeHistoryDS">
                                    <Columns>
                                        <asp:BoundField DataField="strStudentNum" SortExpression="strStudentNum" HeaderText="Roll No." />
                                        <asp:BoundField DataField="fullname" SortExpression="fullname" HeaderText="Name" ReadOnly="True" />
                                        <%--<asp:BoundField DataField="strPresentTime" SortExpression="PresentTime" HeaderText="Present Time" />--%>
                                        <%--<asp:BoundField DataField="strLeaveTime" SortExpression="LeaveTime" HeaderText="Leave Time" />--%>
                                        
                                        <asp:BoundField DataField="strFeeAmount" HeaderText="Fee" SortExpression="strFeeAmount" />
                                        <asp:BoundField DataField="strFeeAmountReceived" SortExpression="strFeeAmountReceived" HeaderText="Fee Received" />
                                        <asp:BoundField DataField="strFeeAmountRemaining" SortExpression="strFeeAmountRemaining" HeaderText="Fee Remaining" />
                                        <%--<asp:BoundField DataField="strLeaveDoc" SortExpression="LeaveDoc" HeaderText="LeaveDoc" />--%>
                                        <asp:BoundField DataField="dtAddDate" SortExpression="dtAddDate" HeaderText="Paid Date" />
                                        <%--<asp:BoundField DataField="bisConfirm" SortExpression="Confirm" HeaderText="Confirmation" />--%>
                                        <%--<asp:BoundField DataField="nu_id" SortExpression="nu_id" HeaderText="nu_id" />--%>
                                        <%--<asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button Text="Confirm" ID="btncnfrm" runat="server" class="width-85 pull-left btn btn-sm btn-success" OnClick="btnsubmit_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="stFeeHistoryDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_RecieveFee.strFeeAmount, tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS fullname, tbl_Enrollment.strStudentNum, tbl_RecieveFee.strFeeAmountReceived, tbl_RecieveFee.strFeeAmountRemaining, tbl_RecieveFee.dtAddDate, tbl_Enrollment.nu_id FROM tbl_RecieveFee INNER JOIN tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Users ON tbl_Enrollment.nu_id = tbl_Users.nu_id WHERE (tbl_RecieveFee.nsch_id = @nschid) AND (tbl_RecieveFee.strFeeAmountRemaining = 0 OR tbl_RecieveFee.strFeeAmountRemaining > 0) AND (tbl_Enrollment.ne_id = @neid)">
                                    <SelectParameters>
                                        <asp:SessionParameter SessionField="nschoolid" Name="nschid"></asp:SessionParameter>
                                        <asp:QueryStringParameter QueryStringField="neid" Name="neid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <div class="space-4"></div>
                                
                            </div>
                            <%--<lable ID="btnprint" runat="server" class="width-10 pull-left btn btn-sm btn-success" onclick="printDiv('printable')">
                                Print Attendance

                            </lable>--%>
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

            <div class="space-12"></div>

            <!-- /.page-content -->
        </div>
        <!-- /.main-content -->

    </div>



</asp:Content>
