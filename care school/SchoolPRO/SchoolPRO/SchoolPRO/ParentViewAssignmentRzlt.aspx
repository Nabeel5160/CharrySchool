<%@ Page Title="" Language="C#" MasterPageFile="~/Parent.Master" AutoEventWireup="true" CodeBehind="ParentViewAssignmentRzlt.aspx.cs" Inherits="SchoolPRO.ParentViewAssignmentRzlt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" ID="sc" />
    <div class="col-xs-12">
        
        <asp:UpdatePanel ID="upmarks" runat="server">
            <ContentTemplate>
                <asp:MultiView ID="mvmarks" ActiveViewIndex="0" runat="server">
                    <asp:View ID="View1" runat="server">
        <div class="table-responsive">
            <asp:GridView ID="gvstnm" class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sqlstview">
                <Columns>
                    <asp:BoundField DataField="ne_id" HeaderText="S.NO" SortExpression="ne_id" />
                    <asp:BoundField DataField="strStudentNum" HeaderText="Student Num" SortExpression="strStudentNum" />
                    <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                    <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strLname" />
                    <asp:BoundField DataField="strClass" HeaderText="Class Name" SortExpression="strClass" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnview" runat="server" class="width-65 pull-left btn btn-sm btn-success" Text="View Result" OnClick="btnview_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sqlstview" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Enrollment.ne_id,tbl_Enrollment.strStudentNum, tbl_Enrollment.strFname, tbl_Enrollment.strLname, tbl_Class.strClass FROM tbl_Class INNER JOIN tbl_Enrollment ON tbl_Class.nc_id = tbl_Enrollment.nc_id INNER JOIN tbl_Users ON tbl_Enrollment.nu_id = tbl_Users.nu_id WHERE (tbl_Enrollment.nu_id =@uid) and tbl_Enrollment.bisDeleted='False' and tbl_Enrollment.nsch_id=@schid">
                <SelectParameters>
                    <asp:SessionParameter Name="uid" SessionField="uid" />
                    <asp:SessionParameter SessionField="nschoolid" Name="schid" />
                </SelectParameters>
            </asp:SqlDataSource>


        </div>
                        </asp:View>
                    <asp:View ID="View2" runat="server">
                        <div class="table-responsive">
                            <asp:GridView ID="gvshowmarks" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="sqlmarks">
                                <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"  DataField="nr_id" HeaderText="S.NO" SortExpression="nr_id" />
                                    <asp:BoundField DataField="strStudentNum" HeaderText="Student Number" SortExpression="strStudentNum" />
                                    <asp:BoundField DataField="strTotalMarks" HeaderText="Total Marks" SortExpression="strTotalMarks" />
                                    <asp:BoundField DataField="strObtMarks" SortExpression="Obt. Marks" HeaderText="strObtMarks" />
                                    <asp:BoundField DataField="strRemarks" SortExpression="Remarks" HeaderText="strRemarks" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sqlmarks" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT ex.nr_id,e.strStudentNum, e.strFname, e.strLname,ex.strTotalMarks, ex.strObtMarks, ex.strRemarks FROM tbl_Enrollment AS e INNER JOIN tbl_Result AS ex ON e.ne_id = ex.ne_id WHERE e.ne_id=@eid and ex.strType='Assignment' and ex.nsch_id=@schid">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="neid" Name="eid" />
                                    <asp:SessionParameter SessionField="nschoolid" Name="schid" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Button ID="gottoback" class="width-35 pull-right btn btn-sm btn-primary" runat="server" Text="Go Back" OnClick="gottoback_Click" />
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
        <!-- /.modal-content -->
    </div>
</asp:Content>
