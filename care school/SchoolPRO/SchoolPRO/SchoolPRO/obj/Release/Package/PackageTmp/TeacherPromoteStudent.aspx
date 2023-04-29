<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherPromoteStudent.aspx.cs" Inherits="SchoolPRO.TeacherPromoteStudent" %>

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

                            <asp:GridView ID="GridView1" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                                <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nc_id" HeaderText="S.NO" SortExpression="nc_id" />
                                    <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                    <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnview" runat="server" CssClass="width-55 pull-left btn btn-sm btn-primary" Text="View Result" OnClick="btnview_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>


                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Class.nc_id,tbl_Class.strClass, tbl_Section.strSection FROM tbl_ClassIncharge INNER JOIN tbl_Users ON tbl_ClassIncharge.nu_id = tbl_Users.nu_id INNER JOIN tbl_Class ON tbl_ClassIncharge.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_ClassIncharge.nsc_id = tbl_Section.nsc_id WHERE (tbl_ClassIncharge.nu_id = @uid) AND (tbl_ClassIncharge.bisDeleted = 'False') AND (tbl_ClassIncharge.nsch_id = @schid)">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="uid" Name="uid" />
                                    <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </asp:View>

                    <asp:View ID="View2" runat="server">
                        <div class="table-responsive">
                            
                            <asp:GridView ID="gvrzlt" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
                                <Columns>
                                    <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ne_id" HeaderText="S.NO" SortExpression="ne_id" />
                                    <asp:BoundField DataField="strStudentNum" HeaderText="Student Number" SortExpression="strStudentNum" />
                                    <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                                    <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strLname" />
                                    <asp:BoundField DataField="strSubject" SortExpression="Subject" HeaderText="strSubject" />
                                    <asp:BoundField DataField="strTotalMarks" SortExpression="Total Marks" HeaderText="strTotalMarks" />
                                    <asp:BoundField DataField="strObtMarks" SortExpression="Obt. Marks" HeaderText="strObtMarks" />
                                </Columns>
                            </asp:GridView>
                            <table>
                                <tr>
                                    <td>
                                        Total Marks
                                    </td>
                                    <td>
                                        <asp:Label ID="lbltmarks" runat="server" Text="Label"></asp:Label>
                                    </td>
                                    <td>
                                        Total Obt. Marks
                                    </td>
                                    <td>
                                        <asp:Label ID="lblobtmarks" runat="server" Text="Label"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Enrollment.strStudentNum,tbl_Enrollment.ne_id, tbl_Enrollment.strFname, tbl_Enrollment.strLname, tbl_Subject.strSubject, tbl_Result.strTotalMarks, tbl_Result.strObtMarks FROM tbl_Result INNER JOIN tbl_Enrollment ON tbl_Result.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Subject ON tbl_Result.nsbj_id = tbl_Subject.nsbj_id WHERE (tbl_Enrollment.nc_id = @cid) AND (tbl_Enrollment.nsc_id = (SELECT nsc_id FROM tbl_Section WHERE (strSection = @section) and nc_id=@cid and bisDeleted='False' and nsch_id=@schid)) and tbl_Result.bisDeleted='False' and tbl_Result.nsch_id=@schid">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="cid" Name="cid" />
                                    <asp:SessionParameter SessionField="section" Name="section" />
                                     <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    <asp:SessionParameter Name="schid1" SessionField="nschoolid" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Button ID="btnsubmitattend" class="width-35 pull-right btn btn-sm btn-primary" runat="server" Text="Submit Marks" OnClick="btnsubmitattend_Click" />
                        </div>
                        <!-- /.table-responsive -->
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
</asp:Content>
