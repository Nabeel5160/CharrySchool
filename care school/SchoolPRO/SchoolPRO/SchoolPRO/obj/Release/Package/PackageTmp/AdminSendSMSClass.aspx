<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminSendSMSClass.aspx.cs" Inherits="SchoolPRO.AdminSendSMSClass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upt" runat="server">
        <ContentTemplate>
            <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">
                <asp:View ID="View1" runat="server">
                    <div class="table-responsive">

                        <!-- /.table-responsive -->

                        <asp:GridView ID="gvsubst" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="sqlst">
                            <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"  DataField="nc_id" SortExpression="nc_id" HeaderText="S.NO" />
                               
                                 <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                <asp:TemplateField HeaderText="Attendance">
                                    <ItemTemplate>
                                        <asp:Button ID="btndattnd" runat="server" Text="Select Class" CssClass="width-55 pull-left btn btn-sm btn-primary" OnClick="btndattnd_Click" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>


                        <asp:SqlDataSource ID="sqlst" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT c.nc_id,c.strClass, sc.strSection from tbl_Section sc inner join tbl_Class c on sc.nc_id=c.nc_id where c.bisDeleted='False' and sc.bisDeleted='False' and c.nsch_id=@schid">
                            <SelectParameters>
                                <asp:SessionParameter Name="schid" SessionField="nschoolid" Type="Int32" />
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
