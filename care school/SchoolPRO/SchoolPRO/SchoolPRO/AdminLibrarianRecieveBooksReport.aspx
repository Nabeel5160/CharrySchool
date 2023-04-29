<%@ Page Title="" Language="C#" MasterPageFile="~/Library.Master" AutoEventWireup="true" CodeBehind="AdminLibrarianRecieveBooksReport.aspx.cs" Inherits="SchoolPRO.AdminLibrarianRecieveBooksReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Recived Books 
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
													 Recived Books 
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="studentFeeDS">
                                    <Columns>
                                        <asp:BoundField DataField="strBook" SortExpression="strBook" HeaderText="Book name" />

                                        <asp:BoundField DataField="strAuthorName" SortExpression="strAuthorName" HeaderText="Author Name" />
                                         <asp:BoundField DataField="regnum" HeaderText="Student Reg #" ReadOnly="True" SortExpression="regnum"></asp:BoundField>
                                        <asp:BoundField DataField="name" HeaderText="Student Name" SortExpression="Student Name" />

                                       
                                        <asp:BoundField DataField="dtFromDate" SortExpression="dtFromDate" HeaderText="From Date" />
                                        <%--<asp:BoundField DataField="strLeaveDoc" SortExpression="LeaveDoc" HeaderText="LeaveDoc" />--%>
                                        <asp:BoundField DataField="dtToDate" SortExpression="dtToDate" HeaderText="To Date" />
                                       
                                        <asp:BoundField DataField="dtRecvDate" HeaderText="Recive Date" SortExpression="dtRecvDate"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="studentFeeDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Book.strBook, tbl_Book.strAuthorName, tbl_Enrollment.strFname+' '+tbl_Enrollment.strLname as name, tbl_BookStatus.dtFromDate, tbl_BookStatus.dtToDate, tbl_BookStatus.bisStatus, CAST(tbl_Enrollment.bRegisteredNum AS varchar(20)) + ' ' + tbl_Enrollment.strStudentNum AS regnum, tbl_BookStatus.dtRecvDate FROM tbl_BookStatus INNER JOIN tbl_Book ON tbl_BookStatus.nbk_id = tbl_Book.nbk_id INNER JOIN tbl_Enrollment ON tbl_BookStatus.ne_id = tbl_Enrollment.ne_id WHERE (tbl_BookStatus.bisStatus = 'True')">

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
