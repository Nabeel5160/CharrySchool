<%@ Page Title="" Language="C#" MasterPageFile="~/Student.Master" AutoEventWireup="true" CodeBehind="StudentRateTeacher.aspx.cs" Inherits="SchoolPRO.StudentRateTeacher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Teacher Evaluation
            </h4>

            <div class="space-6"></div>
            <label class="block clearfix">
                <span class="block input-icon input-icon-right">
                    <asp:DropDownList CssClass="input-medium" ID="ddcc" runat="server" DataSourceID="DSTeacher" DataTextField="name" DataValueField="nu_id"></asp:DropDownList>
                    <asp:SqlDataSource runat="server" ID="DSTeacher" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nu_id, strfname + ' ' + strlname AS name FROM tbl_Users WHERE (nLevel = 2) AND (bisDeleted = @fbit) AND (nsch_id = @schid) AND (nu_id = @tech)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                            <asp:SessionParameter SessionField="nschoolid" Name="schid" />
                            <asp:SessionParameter SessionField="techid2" DefaultValue="0" Name="tech"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </span>
            </label>
            
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvdata" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <div class="panel panel-blue" style="background: #FFF;">
                                <div class="panel-body">

                                    <%--<div class="col-xs-15 pre-scrollable table-responsive">--%>
                                    <div class="table-responsive">
                                        <asp:GridView runat="server" ID="ratgrid" CssClass="table table-bordered table-striped table-hover" ShowFooter="true" AllowSorting="true" AutoGenerateColumns="false">
                                            <EmptyDataTemplate>
                                                <table>
                                                    <tr>
                                                        <td>No Data Found.
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EmptyDataTemplate>
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Rating Element" HeaderStyle-ForeColor="Tomato" HeaderText="Rating Element" />
                                                <asp:TemplateField HeaderText="Select" HeaderStyle-ForeColor="Tomato">
                                                    <ItemTemplate>
                                                        <asp:RadioButtonList CssClass="btn btn-success" RepeatDirection="Horizontal" ID="BTNRAD" runat="server">
                                                            <asp:ListItem Text="Satisfactory">1</asp:ListItem>
                                                            <asp:ListItem Text="Needs Of Improve">2</asp:ListItem>
                                                            <asp:ListItem Text="UnSatisfactory">3</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <%--</div>--%>
                                    </div>
                                </div>
                                <hr />
                                <div class="form-actions text-right pal">
                                    <asp:Button ID="btnADDForm" Text="Submit" ValidationGroup="add" CssClass="btn btn-success" runat="server" />
                                </div>
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

            <div class="space-12"></div>

            <!-- /.page-content -->
        </div>
        <!-- /.main-content -->

    </div>

</asp:Content>
