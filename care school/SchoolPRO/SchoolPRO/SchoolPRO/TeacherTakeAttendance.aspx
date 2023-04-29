<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherTakeAttendance.aspx.cs" Inherits="SchoolPRO.TeacherTakeAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
     <div class="col-xs-12">

        <div class="table-responsive">
            <asp:GridView ID="gvattnd" OnRowDataBound="gvattnd_RowDataBound" class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sqlattnd" DataKeyNames="ne_id">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ne_id" SortExpression="S.No" HeaderText="ne_id" InsertVisible="False" ReadOnly="True" />
                    <asp:BoundField DataField="strStudentNum" HeaderText="Student Number" SortExpression="strStudentNum" />
                    <asp:BoundField DataField="strFname" HeaderText="Fisrt Name" SortExpression="strFname" />
                    <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strMname" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddst" runat="server">
                                <asp:ListItem>Present</asp:ListItem>
                                <asp:ListItem>Absent</asp:ListItem>
                                <asp:ListItem>Leave</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Remarks">
                        <ItemTemplate>
                            <asp:TextBox ID="txtrem" placeholder="Remarks" runat="server"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT ne_id, strStudentNum, strFname, strMname FROM tbl_Enrollment WHERE (nc_id = @cid) AND (strStudentNum IS NOT NULL) AND (nsch_id = @sn) AND (bisDeleted = 'False') AND (nsc_id =(Select nsc_id from tbl_Section where nc_id=@cid and strSection=@scid and bisDeleted='False'))">--%>
            <asp:SqlDataSource ID="sqlattnd" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT ne_id, strStudentNum, strFname, strLname FROM tbl_Enrollment WHERE (nc_id = @cid) and nsc_id=@scid AND (strStudentNum IS NOT NULL) AND (nsch_id = @sn) AND (bisDeleted = 'False')">
                <SelectParameters>
                    <asp:SessionParameter SessionField="cid" Name="cid" />
                    <asp:SessionParameter SessionField="nschoolid" Name="sn" />
                    <asp:SessionParameter SessionField="sec" Name="scid"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Button ID="btnsubmitattend" class="width-35 pull-right btn btn-sm btn-primary" runat="server" Text="Submit Attendance" OnClick="btnsubmitattend_Click" />
        </div>
        <!-- /.table-responsive -->
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

