<%@ Page Title="" Language="C#" MasterPageFile="~/Parent.Master" AutoEventWireup="true" CodeBehind="ParentsViewRating.aspx.cs" Inherits="SchoolPRO.ParentsViewRating" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="upquiz" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvquiz" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:ScriptManager runat="server" ID="scr" />
                            <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="hidden width-10 pull-left btn btn-sm btn-success"/>
                            <div class="table-responsive">
                                <asp:GridView ID="gvrparantsrate" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nPRateT_id" DataSourceID="DSPRT">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nPRateT_id" HeaderText="nPRateT_id" ReadOnly="True" InsertVisible="False" SortExpression="nPRateT_id"></asp:BoundField>
                                        <asp:BoundField DataField="Teacher Name" HeaderText="Teacher Name" ReadOnly="True" SortExpression="Teacher Name"></asp:BoundField>
                                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks"></asp:BoundField>
                                        <asp:BoundField DataField="Points" HeaderText="Points" SortExpression="Points"></asp:BoundField>
                                        <asp:BoundField DataField="Out Of" HeaderText="Out Of" SortExpression="Out Of"></asp:BoundField> 
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btndel" OnClick="btndel_Click" runat="server" Text="Delete" class="width-85 pull-left btn btn-sm btn-success"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="DSPRT" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_ParantRateTeacher.nPRateT_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS 'Teacher Name', tbl_ParantRateTeacher.strRemarks AS 'Remarks', tbl_ParantRateTeacher.strPoints AS 'Points', tbl_ParantRateTeacher.strOutOf AS 'Out Of' FROM tbl_ParantRateTeacher INNER JOIN tbl_Users ON tbl_ParantRateTeacher.nTeach_id = tbl_Users.nu_id WHERE (tbl_ParantRateTeacher.bisDeleted = @fbit) AND (tbl_Users.bisDeleted = @fbit) AND (tbl_ParantRateTeacher.nsch_id=@schid)">
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
</asp:Content>
