<%@ Page Title="" Language="C#" MasterPageFile="~/Parent.Master" AutoEventWireup="true" CodeBehind="ParentViewAttendance.aspx.cs" Inherits="SchoolPRO.ParentViewAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-12">
        <h3 class="header smaller lighter blue">View Attendane Report</h3>


        <div class="table-responsive">
            <asp:GridView ID="gvstnm" class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sqlstview">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ne_id" HeaderText="S.NO" SortExpression="ne_id" />
                    <asp:BoundField DataField="strStudentNum" HeaderText="Student Num" SortExpression="strStudentNum" />
                    <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                    <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strLname" />
                    <asp:BoundField DataField="strClass" HeaderText="Class Name" SortExpression="strClass" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnview" runat="server" class="width-65 pull-left btn btn-sm btn-success" Text="View Attendance" OnClick="btnview_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sqlstview" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Enrollment.ne_id,tbl_Enrollment.strStudentNum, tbl_Enrollment.strFname, tbl_Enrollment.strLname, tbl_Class.strClass FROM tbl_Class INNER JOIN tbl_Enrollment ON tbl_Class.nc_id = tbl_Enrollment.nc_id INNER JOIN tbl_Users ON tbl_Enrollment.nu_id = tbl_Users.nu_id WHERE (tbl_Enrollment.nu_id=@uid) and tbl_Enrollment.bisDeleted='False' and ex.nsch_id=@schid">
                <SelectParameters>
                    <asp:SessionParameter SessionField="neid" Name="eid" />
                    <asp:SessionParameter SessionField="nschoolid" Name="schid" />
                </SelectParameters>
            </asp:SqlDataSource>


        </div>
        <!-- /.modal-content -->
    </div>

</asp:Content>

