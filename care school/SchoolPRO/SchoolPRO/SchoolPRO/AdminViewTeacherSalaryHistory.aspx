<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewTeacherSalaryHistory.aspx.cs" Inherits="SchoolPRO.AdminViewTeacherSalaryHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <div class="row-fluid">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <div class="col-xs-12 col-sm-12 widget-container-span">
                                    <div class="widget-box" id="printable">
                                        <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Teacher Salary 
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                        <div class="widget-body">
												<div class="clearfix"></div>
                                                    <div class="space-4"></div>
                                                    <div class="col-lg-3">
                                                         <label>Select Teacher</label>
                                                         <asp:DropDownList ID="ddltchr" runat="server" AutoPostBack="true" DataSourceID="TeacherDS" DataTextField="name" DataValueField="nu_id" ></asp:DropDownList>
                                                         <asp:SqlDataSource runat="server" ID="TeacherDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nu_id], [strfname]+' '+[strfname] as name FROM [tbl_Users] WHERE (([bisDeleted] = @bisDeleted) AND ([nLevel] = @nLevel) and nsch_id=@schid) ">
                                                             <SelectParameters>
                                                                 <asp:SessionParameter DefaultValue="0" Name="schid" SessionField="nschoolid" />
                                                                 <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                 <asp:Parameter DefaultValue="2" Name="nLevel" Type="Int32"></asp:Parameter>
                                                             </SelectParameters>
                                                         </asp:SqlDataSource>
                                                        <%--<asp:TextBox ID="txtfrom" placeholder="" runat="server"></asp:TextBox>--%>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <%--<asp:TextBox ID="txtto" AutoPostBack="true" runat="server"></asp:TextBox>--%>
                                                    
                                                    </div>
                                                     <div class="col-lg-3">
                                                        
                                                     </div>
                                                    <div class="clearfix"></div>
                                                    <div class="space-4"></div>
                                        </div>
                                        <div class="table-responsive">
                                            <asp:GridView runat="server" ID="gvtchrhistory" class="table table-striped table-bordered table-hover" DataSourceID="TeacherSalaryDS" AutoGenerateColumns="False" DataKeyNames="nsal_id" AllowSorting="true" AllowPaging="true">
                                                <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nsal_id" HeaderText="nsal_id" ReadOnly="True" InsertVisible="False" SortExpression="nsal_id"></asp:BoundField>
                                                    <asp:BoundField DataField="strfname" HeaderText="Name" SortExpression="strfname"></asp:BoundField>
                                                    <asp:BoundField DataField="strSalary" HeaderText="Salary" SortExpression="strSalary"></asp:BoundField>
                                                    <asp:BoundField DataField="strBonus" HeaderText="Bonus" SortExpression="strBonus"></asp:BoundField>
                                                    <asp:BoundField DataField="strFine" HeaderText="Fine" SortExpression="strFine"></asp:BoundField>
                                                     <asp:BoundField DataField="absnt" HeaderText="Absents" SortExpression="absnt"></asp:BoundField>
                                                     <asp:BoundField DataField="prsnt" HeaderText="Presents" SortExpression="prsnt"></asp:BoundField>
                                                     <asp:BoundField DataField="fullLeave" HeaderText="Full Leaves" SortExpression="fullLeave"></asp:BoundField>
                                                     <asp:BoundField DataField="halfLeave" HeaderText="Half Leaves" SortExpression="halfLeave"></asp:BoundField>
                                                     <asp:BoundField DataField="dtAddDate" HeaderText="Date" SortExpression="dtAddDate"></asp:BoundField>
                                                    

                                                </Columns>
                                            </asp:GridView>

                                            <asp:SqlDataSource runat="server" ID="TeacherSalaryDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Salary.nsal_id, tbl_Salary.strSalary, tbl_Salary.strBonus, tbl_Salary.strFine, tbl_Salary.dtAddDate, tbl_Users.strfname, (SELECT COUNT(strStatus) AS Expr1 FROM tbl_TeacherAttendance WHERE (nu_id = tbl_Salary.nu_id) AND (strStatus = 'Present') AND (nsch_id = @schid1)) AS prsnt, (SELECT COUNT(strStatus) AS Expr2 FROM tbl_TeacherAttendance AS tbl_TeacherAttendance_1 WHERE (nu_id = tbl_Salary.nu_id) AND (strStatus = 'Abscent') AND (nsch_id = @schid2)) AS absnt, (SELECT COUNT(strStatus) AS Expr3 FROM tbl_TeacherAttendance AS tbl_TeacherAttendance_2 WHERE (nu_id = tbl_Salary.nu_id) AND (strStatus = 'Full Leave Application') AND (nsch_id = @schid3)) AS fullLeave, (SELECT COUNT(strStatus) AS Expr4 FROM tbl_TeacherAttendance AS tbl_TeacherAttendance_3 WHERE (nu_id = tbl_Salary.nu_id) AND (strStatus = 'Half Leave Application') AND (nsch_id = @schid4)) AS halfLeave FROM tbl_Salary INNER JOIN tbl_Users ON tbl_Salary.nu_id = tbl_Users.nu_id WHERE (tbl_Salary.bisDeleted = @bisDeleted) AND (tbl_Users.nLevel = '2') AND (tbl_Salary.nu_id = @nu_id) AND (tbl_Salary.nsch_id = @schid5)">
                                                <SelectParameters>
                                                    <asp:SessionParameter SessionField="nschoolid" Name="schid1"></asp:SessionParameter>
                                                    <asp:SessionParameter SessionField="nschoolid" Name="schid2"></asp:SessionParameter>
                                                    <asp:SessionParameter SessionField="nschoolid" Name="schid3"></asp:SessionParameter>
                                                    <asp:SessionParameter SessionField="nschoolid" Name="schid4"></asp:SessionParameter>
                                                    <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                    <asp:ControlParameter ControlID="ddltchr" PropertyName="SelectedValue" DefaultValue="0" Name="nu_id" Type="Int32"></asp:ControlParameter>
                                                    <asp:SessionParameter SessionField="nschoolid" Name="schid5"></asp:SessionParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource runat="server" ID="SqlDataSource1"></asp:SqlDataSource>
                                        </div>

                                    </div>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
