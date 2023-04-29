<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminStrucOffStudent.aspx.cs" Inherits="SchoolPRO.AdminStrucOffStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>   
     <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
        <asp:ScriptManager runat="server" />
        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Struck Off Student
            </h4>

            <div class="space-6"></div>

            <asp:TextBox ID="txtsrch" runat="server" AutoPostBack="true" placeholder="student number.." Enabled="true" EnableViewState="true"></asp:TextBox>
            <div class="space-12"></div>
            <div class="table-responsive">
                <asp:GridView ID="gvstrcoff" DataSourceID="sqlsrch" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" DataKeyNames="ne_id" EnableViewState="true">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <%# Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ne_id" HeaderText="S.NO" SortExpression="ne_id" />
                        <asp:BoundField DataField="strStudentNum" SortExpression="strStudentNum" HeaderText="Student Number" />
                        <asp:BoundField DataField="strFname" SortExpression="strFname" HeaderText="Name" />
                        <asp:BoundField DataField="strlname" SortExpression="strlname" HeaderText="Guardian Name" />
                        <asp:BoundField DataField="strClass" SortExpression="strClass" HeaderText="Class" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:TextBox ID="txtrzn" runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button Text="Struc Off" ID="btncnfrm" runat="server" class="width-85 pull-left btn btn-sm btn-success" OnClick="btncnfrm_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <div class="space-4"></div>
                <asp:SqlDataSource ID="sqlsrch" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT e.ne_id,e.strStudentNum,u.strlname,e.strFname,c.strClass FROM tbl_Enrollment e inner join tbl_Users u on e.nu_id=u.nu_id inner join tbl_Class c on e.nc_id=c.nc_id WHERE e.strStudentNum=@stnum and e.bisDeleted='False'and e.nsch_id=@schid">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtsrch" Name="stnum" Type="String" />
                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>

            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <img src="" alt="Processing" />
                </ProgressTemplate>
            </asp:UpdateProgress>

            <div class="space-12"></div>

            <!-- /.page-content -->
        </div>
        <!-- /.main-content -->

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
