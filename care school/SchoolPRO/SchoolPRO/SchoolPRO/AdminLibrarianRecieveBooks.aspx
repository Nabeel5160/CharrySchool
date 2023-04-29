<%@ Page Title="" Language="C#" MasterPageFile="~/Library.Master" AutoEventWireup="true" CodeBehind="AdminLibrarianRecieveBooks.aspx.cs" Inherits="SchoolPRO.AdminLibrarianRecieveBooks" %>
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
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="MultiView1" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <div class="table-responsive">
                                <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvsearchclass_RowCommand" OnRowUpdating="gvsearchclass_RowUpdating" DataKeyNames="nbs_id" EnableViewState="true">
                                    <Columns><asp:TemplateField >
                                           <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nbs_id" HeaderText="S.NO" SortExpression="nbs_id" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                            </HeaderTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Book Number">
                                            <ItemTemplate>
                                                <%--<asp:Label ID="lblcname" runat="server" Text='<%# Highlight(Eval("c_name").ToString()) %>'></asp:Label>--%>
                                                <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strBookNum") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="strStudentNum" SortExpression="strStudentNum" HeaderText="Student Number" />
                                        <asp:BoundField DataField="dtFromDate" SortExpression="strFromDate" HeaderText="From" />
                                        <asp:BoundField DataField="dtToDate" SortExpression="strToDate" HeaderText="To" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnrcv" runat="server" Text="Recieve" class="width-80 pull-left btn btn-sm btn-success" OnClick="btnrcv_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
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
