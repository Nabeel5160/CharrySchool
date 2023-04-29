<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminTransferAmount.aspx.cs" Inherits="SchoolPRO.AdminTransferAmount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Transfer Amounts
                </h4>

                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvbnk" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngotoAdd" runat="server" Text="View Bank" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                <asp:Button ID="btntransfer" runat="server" Text="Transfer" class="width-10 pull-left btn btn-sm btn-success" OnClick="btntransfer_Click" />
                                <div class="table-responsive">
                                    <asp:GridView ID="gvuser" class="table table-striped table-bordered table-hover" AllowPaging="False" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" DataKeyNames="nmt_id" EnableViewState="true" runat="server" OnRowCommand="gvuser_RowCommand">
                                        <Columns>
                                            <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nmt_id" HeaderText="S.NO" SortExpression="nmt_id" />
                                            <asp:BoundField DataField="nFromAcc" SortExpression="nFromAcc" HeaderText="From Account" />
                                            <asp:BoundField DataField="nToAcc" SortExpression="nToAcc" HeaderText="To Account" />
                                            <asp:BoundField DataField="strAmount" SortExpression="strAmount" HeaderText="Amount" />
                                            <asp:BoundField DataField="strReason" SortExpression="strReason" HeaderText="Reason" />
                                            <asp:BoundField DataField="dtAddDate" SortExpression="dtAddDate" HeaderText="Transfer Date" />

                                        </Columns>
                                    </asp:GridView>
                                    <div class="space-4"></div>

                                </div>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Transfer Amount
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Bank Name: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">From:
                        <asp:DropDownList ID="ddfrom" AutoPostBack="true" class="form-control" DataSourceID="sqlacc" DataValueField="strAccNum" DataTextField="name" runat="server"></asp:DropDownList>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Class Name" ControlToValidate="txtcupdate"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">To:
                        <asp:DropDownList ID="ddto" class="form-control" DataValueField="strAccNum" DataTextField="name" runat="server" DataSourceID="ddlacctoDS"></asp:DropDownList>
                                                                    <asp:SqlDataSource runat="server" ID="ddlacctoDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT strAccNum, strAccTitle + ' ' + strAccNum AS name FROM tbl_Bank WHERE (bisDeleted = @fbit) AND (nsch_id = @schid) AND (strAccNum <> @acc)">
                                                                        <SelectParameters>
                                                                            <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                                                            <asp:SessionParameter SessionField="nschoolid" DefaultValue="0" Name="schid"></asp:SessionParameter>
                                                                            <asp:ControlParameter ControlID="ddfrom" PropertyName="SelectedValue" DefaultValue="0" Name="acc"></asp:ControlParameter>
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Total Seats" ControlToValidate="txtenos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtamount" runat="server" class="form-control" placeholder="Amount"></asp:TextBox>

                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter Total Seats" ControlToValidate="txtenos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtrzn" runat="server" class="form-control" placeholder="Reason"></asp:TextBox>

                                                                    <i class="icon-user"></i>
                                                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Total Seats" ControlToValidate="txtenos"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>

                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnadd" runat="server" Text="Add" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnadd_Click" />
                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <asp:SqlDataSource ID="sqlacc" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strAccNum],[strAccTitle]+'-'+[strAccNum] as name FROM [tbl_Bank] WHERE ([bisDeleted] = @bisDeleted)  and nsch_id=@nschid">
                                         <SelectParameters>
                                             <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                             <asp:SessionParameter Name="nschid" SessionField="nschoolid" />
                                         </SelectParameters>
                                </asp:SqlDataSource>
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
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
