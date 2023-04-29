<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewRemainFeeStudents.aspx.cs" Inherits="SchoolPRO.AdminViewRemainFeeStudents" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
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
                Students With Paid Fees
            </h4>

            <div class="space-6"></div>
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvatnd" ActiveViewIndex="0" runat="server">
                        <asp:View runat="server">
                            <div class="table-responsive">
                                <asp:GridView ID="gvbyclass" class="table table-striped table-bordered table-hover" AutoGenerateColumns="false" DataSourceID="sqlbyclass" runat="server">
                                    <Columns>
                                        <asp:TemplateField>
                                            <FooterTemplate>
                                                <asp:Label ID="Label5" runat="server" Text="Total Amount: "></asp:Label>
                                                <asp:Label ID="lbltotal" runat="server" Text="0"></asp:Label>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nc_id" HeaderText="S.NO" SortExpression="nc_id" >
                                        <HeaderStyle CssClass="hidden" />
                                        <ItemStyle CssClass="hidden" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                        <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnvful" runat="server" Text="View Detail" class="width-65 pull-left btn btn-sm btn-success" OnClick="btnvful_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nsc_id" HeaderText="S.NO" SortExpression="nsc_id" >
                                        <HeaderStyle CssClass="hidden" />
                                        <ItemStyle CssClass="hidden" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sqlbyclass" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Class.nc_id, tbl_Class.strClass, tbl_Section.strSection,tbl_Section.nsc_id FROM tbl_Class INNER JOIN tbl_Section ON tbl_Class.nc_id = tbl_Section.nc_id WHERE (tbl_Class.bisDeleted = 'False') and (tbl_Section.bisDeleted = 'False') and tbl_Class.nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </asp:View>
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
                                        Students With Paid Fee And With Some Remaining Dues
                                    </h5>

                                    <div class="widget-toolbar widget-toolbar-light no-border">
                                        <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                    </div>
                                </div>
                                <br />
                                <asp:Button Text="Go Back" class="width-25 pull-left btn btn-sm btn-success" runat="server" ID="btngobck" OnClick="btngobck_Click" />
                                <div class="space-12"></div>
                                <br />
                                <div class="form-group">

                                    <label class="text-center">Select Date :</label>

                                    <label class=" clearfix">
                                        <div class="space-12"></div>
                                        <asp:TextBox AutoPostBack="true" ID="txtadmsndate" class="form-control col-lg-6" placeholder=" Date" runat="server" MaxLength="10" onkeyup="return ismaxlength(this,10)" OnTextChanged="txtadmsndate_TextChanged1"></asp:TextBox>
                                        <%--<asp:Button CssClass="hidden-print btn btn-success col-lg-6" Style="float:right" ID="btnSearch" Text="Click Here To Search" runat="server" />--%>
                                        <asp:CalendarExtender Format="dd-MM-yyyy" ID="calendrdate" TargetControlID="txtadmsndate" runat="server"></asp:CalendarExtender>

                                        <%--<asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator21" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression="^[\s\S]{10,10}$" ControlToValidate="txtadmsndate"></asp:RequiredFieldValidator>--%>
                                        <label id='lblCaption' style="font-family: Tahoma; font-size: 1em; font-weight: bold" cssclass="red"></label>


                                    </label>
                                    <asp:RegularExpressionValidator ID="RegularExpressiossnValidator5" runat="server" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ForeColor="Red" Font-Bold="true" ControlToValidate="txtadmsndate" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>
                                </div>


                                <br />
                                <asp:GridView ID="gvclass" class="table table-striped table-bordered table-hover" runat="server" AllowSorting="True" AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="strStudentNum" SortExpression="strStudentNum" HeaderText="Roll no" />

                                        <asp:BoundField DataField="fullname" SortExpression="fullnamee" HeaderText="Student Name" />
                                        <asp:BoundField DataField="strFeeAmount" HeaderText="Fee" SortExpression="Fee " />

                                        <%--<asp:BoundField DataField="strPresentTime" SortExpression="PresentTime" HeaderText="Present Time" />--%>
                                        <%--<asp:BoundField DataField="strLeaveTime" SortExpression="LeaveTime" HeaderText="Leave Time" />--%>

                                        <asp:BoundField DataField="strFeeAmountReceived" SortExpression="strFeeAmountReceived" HeaderText="Recvied Fee" />
                                        <asp:BoundField DataField="strFeeAmountRemaining" SortExpression="strFeeAmountRemaining" HeaderText="Remaining Fee" />
                                        <%--<asp:BoundField DataField="strLeaveDoc" SortExpression="LeaveDoc" HeaderText="LeaveDoc" />--%>
                                        <asp:BoundField DataField="dtAddDate" SortExpression="dtAddDate" HeaderText="Date" />
                                        <%--<asp:BoundField DataField="bisConfirm" SortExpression="Confirm" HeaderText="Confirmation" />--%>
                                        <%--<asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button Text="Confirm" ID="btncnfrm" runat="server" class="width-85 pull-left btn btn-sm btn-success" OnClick="btnsubmit_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                    </Columns>
                                </asp:GridView>
                                <%--<asp:SqlDataSource runat="server" ID="studentFeeDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_RecieveFee.strFeeAmount, tbl_Enrollment.strFname+' '+tbl_Enrollment.strLname as fullname, tbl_Enrollment.strStudentNum, tbl_RecieveFee.strFeeAmountReceived, tbl_RecieveFee.strFeeAmountRemaining, tbl_RecieveFee.dtAddDate FROM tbl_RecieveFee INNER JOIN tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id WHERE (SUBSTRING(tbl_RecieveFee.dtAddDate ,4,2) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2)) AND (tbl_RecieveFee.nsch_id = @nschid) AND (tbl_RecieveFee.strFeeAmountRemaining > 0)">
                                     <SelectParameters>
                                        <asp:SessionParameter Name="nschid" SessionField="nschoolid"  Type="Int32"/>
                                        
                                    </SelectParameters>

                                </asp:SqlDataSource>--%>
                                <div class="space-4"></div>
                                <div class="row text-right">
                                    <div class="badge col-lg-4">
                                        <asp:Label ID="Label1" runat="server" Text="Total Amount:"></asp:Label>
                                        <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label>
                                    </div>
                                    <div class="badge col-lg-4">
                                        <asp:Label ID="Label2" runat="server" Text="Total Received Amount:"></asp:Label>
                                        <asp:Label ID="lblrecfee" runat="server" Text="0"></asp:Label>
                                    </div>
                                    <div class="badge col-lg-4">
                                        <asp:Label ID="Label4" runat="server" Text="Total Remaining Amount:"></asp:Label>
                                        <asp:Label ID="lblremainfee" runat="server" Text="0"></asp:Label>
                                    </div>
                                </div>
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
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
