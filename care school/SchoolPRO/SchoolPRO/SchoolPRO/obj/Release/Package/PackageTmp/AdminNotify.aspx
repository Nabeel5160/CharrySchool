<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminNotify.aspx.cs" Inherits="SchoolPRO.AdminNotify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
     <asp:ScriptManager runat="server" />
    <div class="col-xs-12">
        <%--<asp:Timer ID="tRefresh" runat="server" OnTick="tRefresh_Tick" Interval="6000"></asp:Timer>--%>
        <div class="table-responsive">
            <asp:TextBox ID="txtmsg" TextMode="MultiLine" Columns="50" runat="server"></asp:TextBox>
            <div class="space-12"></div>
            <asp:GridView ID="gvattnd" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="false" AutoGenerateColumns="False" DataSourceID="sqlattnd">
                <Columns>
                    
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:CheckBox ID="chkok" AutoPostBack="true" OnCheckedChanged="chkok_CheckedChanged" runat="server" />
                         </HeaderTemplate>
                    
                        <ItemTemplate>
                            <asp:CheckBox ID="chkselect" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ne_id" SortExpression="ne_id" HeaderText="S.NO" />
                    <asp:BoundField DataField="strStudentNum" HeaderText="Student Number" SortExpression="Student Number" />
                    <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="First Name" />
                    <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strlname" />
                    <asp:BoundField DataField="fname" HeaderText="Gardian First Name" SortExpression="strfname" />
                    <asp:BoundField DataField="lname" HeaderText="Gardian Last Name" SortExpression="strlname" />
                    <asp:BoundField DataField="strPhone" HeaderText="Phone Num" SortExpression="strPhone" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sqlattnd" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT e.ne_id,e.strStudentNum, e.strFname, e.strLname,u.strfname as fname,u.strlname as lname,u.strPhone FROM tbl_Enrollment e inner join tbl_Users u on e.nu_id=u.nu_id WHERE (e.nc_id = @cid) AND (e.strStudentNum IS NOT NULL) and e.nsch_id=@sn and e.bisDeleted='False'">
                <SelectParameters>
                    <asp:SessionParameter SessionField="cid" Name="cid" />
                    <asp:SessionParameter SessionField="nschoolid" Name="sn" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Button ID="btnsubmitattend" class="width-35 pull-right btn btn-sm btn-primary" runat="server" Text="Submit" OnClick="btnsubmitattend_Click" />
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
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
