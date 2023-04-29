<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminSendSMSAll.aspx.cs" Inherits="SchoolPRO.AdminSendSMSAll" %>

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
                        <asp:TextBox ID="txtmsg" TextMode="MultiLine" Columns="50" runat="server"></asp:TextBox>
                        <div class="space-12"></div>
                        <asp:GridView ID="gvsubst" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="false" AutoGenerateColumns="False" DataSourceID="sqlst">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkok" AutoPostBack="true" OnCheckedChanged="chkok_CheckedChanged" runat="server" />
                                    </HeaderTemplate>

                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkselect" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nu_id" SortExpression="nc_id" HeaderText="S.NO" />
                                <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                                <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strLname" />
                                <asp:BoundField DataField="strfname" SortExpression="strfname" HeaderText="Gaurdian Name" />
                                <asp:BoundField DataField="strCell" SortExpression="strCell" HeaderText="Cell Num" />
                            </Columns>
                        </asp:GridView>


                        <asp:SqlDataSource ID="sqlst" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT u.nu_id, u.strfname,e.strFname,e.strLname,u.strCell from tbl_Enrollment e inner join tbl_Users u on e.nu_id=u.nu_id where e.nsch_id=@schid and e.bisDeleted='False'">
                            <SelectParameters>
                                <asp:SessionParameter Name="schid" SessionField="nschoolid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Button ID="btnsubmitattend" class="width-35 pull-right btn btn-sm btn-primary" runat="server" Text="Submit" OnClick="btnsubmitattend_Click" />

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
