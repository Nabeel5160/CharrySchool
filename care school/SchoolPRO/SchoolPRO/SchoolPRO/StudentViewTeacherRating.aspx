<%@ Page Title="" Language="C#" MasterPageFile="~/Student.Master" AutoEventWireup="true" CodeBehind="StudentViewTeacherRating.aspx.cs" Inherits="SchoolPRO.StudentViewTeacherRating" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
            <asp:UpdatePanel ID="upquiz" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvquiz" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="hidden width-10 pull-left btn btn-sm btn-success" />
                            <div class="table-responsive">
                                <asp:GridView ID="gvrteachrate" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nSRateT_id" DataSourceID="DSTeachViewrate">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nSRateT_id" HeaderText="nSRateT_id" ReadOnly="True" InsertVisible="False" SortExpression="nSRateT_id"></asp:BoundField>
                                        <asp:BoundField DataField="Teacher Name" HeaderText="Teacher Name" ReadOnly="True" SortExpression="Teacher Name"></asp:BoundField>
                                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks"></asp:BoundField>
                                        <asp:BoundField DataField="Points" HeaderText="Points" SortExpression="Points"></asp:BoundField>
                                        <asp:BoundField DataField="Out Of" HeaderText="Out Of" SortExpression="Out Of"></asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btndel" runat="server" OnClick="btndel_Click" Text="Delete" class="width-85 pull-left btn btn-sm btn-success" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>

                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="DSTeachViewrate" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_StudentRateTeacher.nSRateT_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS 'Teacher Name', tbl_StudentRateTeacher.strRemarks AS 'Remarks', tbl_StudentRateTeacher.strPoints AS 'Points', tbl_StudentRateTeacher.strOutOf AS 'Out Of' FROM tbl_StudentRateTeacher INNER JOIN tbl_Users ON tbl_StudentRateTeacher.nTeach_id = tbl_Users.nu_id WHERE (tbl_StudentRateTeacher.bisDeleted = @fbit) AND (tbl_Users.bisDeleted = @fbit) AND (tbl_StudentRateTeacher.nsch_id=@schid)">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                        <asp:SessionParameter SessionField="nschoolid" Name="schid" />
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
</asp:Content>
