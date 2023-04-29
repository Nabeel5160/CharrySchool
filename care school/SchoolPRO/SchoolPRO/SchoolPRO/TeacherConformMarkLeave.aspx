<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherConformMarkLeave.aspx.cs" Inherits="SchoolPRO.TeacherConformMarkLeave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
        <asp:ScriptManager runat="server" ID="scr" />
        <div class="row-fluid">
            <asp:UpdatePanel ID="upt" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">

                        <asp:View runat="server" ID="v2">
                            <%--<asp:Button ID="btnBack" runat="server" Text="Back" class="width-95 pull-left btn btn-sm btn-success" OnClick="btnBack_Click" />--%>
                            <div class="table-responsive">
                                <asp:GridView ID="gvteacher" OnRowDataBound="gvteacher_RowDataBound" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="nLeav_id" DataSourceID="DSTcsml">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nLeav_id" HeaderText="nLeav_id" ReadOnly="True" InsertVisible="False" SortExpression="nLeav_id"></asp:BoundField>
                                        <asp:BoundField DataField="Student Name" HeaderText="Student Name" ReadOnly="True" SortExpression="Student Name"></asp:BoundField>
                                        <asp:BoundField DataField="Shift" HeaderText="Shift" SortExpression="Shift"></asp:BoundField>
                                        <asp:BoundField DataField="Nationality" HeaderText="Nationality" SortExpression="Nationality"></asp:BoundField>
                                        <asp:BoundField DataField="Religion" HeaderText="Religion" SortExpression="Religion"></asp:BoundField>
                                        <asp:BoundField DataField="City" HeaderText="City" SortExpression="City"></asp:BoundField>
                                        <asp:BoundField DataField="Leave Date" HeaderText="Leave Date" SortExpression="Leave Date"></asp:BoundField>

                                    </Columns>
                                </asp:GridView>

                                <asp:SqlDataSource runat="server" ID="DSTcsml" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Leave.nLeav_id, tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS 'Student Name', tbl_Enrollment.strShift AS 'Shift', tbl_Enrollment.strNationality AS 'Nationality', tbl_Enrollment.strReligion AS 'Religion', tbl_Enrollment.strCity AS 'City', tbl_Leave.Date AS 'Leave Date' FROM tbl_Enrollment INNER JOIN tbl_Leave ON tbl_Enrollment.ne_id = tbl_Leave.nu_id WHERE (tbl_Enrollment.bisDeleted = @fbit) AND (tbl_Leave.bisDeleted = @fbit) AND (tbl_Leave.nLevel = 3)">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
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
