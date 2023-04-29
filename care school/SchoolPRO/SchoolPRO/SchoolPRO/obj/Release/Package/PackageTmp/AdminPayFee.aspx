<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminPayFee.aspx.cs" Inherits="SchoolPRO.AdminPayFee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <div class="form-search">
                <span class="input-icon">
                    <p>Receive Student Fee</p>

                </span>
            </div>
            <div class="space-10"></div>
            <%--<div class="clearfix"><asp:Button ID="btnsrch" runat="server" class="width-20 pull-left btn btn-sm " Text="Search" /></div>--%>
            <asp:ScriptManager ID="sc" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upregst" runat="server">
                <ContentTemplate>
                    <asp:MultiView ActiveViewIndex="0" ID="mvsub" runat="server">
                        <asp:View ID="View1" runat="server">
                            <div class="col-lg-4">
                            <asp:Button ID="btngo" runat="server" Text="Receive Challan Fee" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngo_Click" />
                                </div>
                            <div class="space-10"></div>
                            <div class="col-md-5">
                                            <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input pull-right" Width="210" OnTextChanged="txtcc_TextChanged" AutoPostBack="true"></asp:TextBox>
                                        </div>
                            <asp:GridView ID="gvfee" CssClass="table table-responsive table-hover" OnPageIndexChanging="gvfee_PageIndexChanging"  runat="server" AllowSorting="true" AllowPaging="true" DataKeyNames="nfr_id" AutoGenerateColumns="false" EnableViewState="true">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nfr_id" SortExpression="nfr_id" HeaderText="S.NO" />
                                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ne_id" SortExpression="ne_id" HeaderText="S.NO" />
                                    <asp:TemplateField HeaderText="Challan Number">
                                        <ItemTemplate>
                                        
                                            <asp:Label ID="lblcname" runat="server" Text='<%# Eval("nChallanNum") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="strname" SortExpression="strTutionFee" HeaderText="Name" />
                                    <asp:BoundField DataField="strClass" SortExpression="strClass" HeaderText="Class" />
                                    <asp:BoundField DataField="strSection" SortExpression="strSection" HeaderText="Section" />
                                    <asp:BoundField DataField="strFeeAmount" SortExpression="strFeeAmount" HeaderText="Fee" />

                                    <asp:BoundField DataField="dtAddDate" SortExpression="dtAddDate" HeaderText="Receive Date" />
                                    <asp:BoundField DataField="paid" SortExpression="paid" HeaderText="Paid Status" />
                                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ne_id" SortExpression="ne_id" HeaderText="S.NO" />
                                    <%-- <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnedit" runat="server" class="width-65 pull-left btn btn-sm btn-success" Text="Edit" OnClick="btnedit_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <%--<asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="Paid" runat="server" class=" width-90 pull-left btn btn-sm btn-success" Text="Paid" OnClick="Paid_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                </Columns>
                            </asp:GridView>
                        </asp:View>

                        <asp:View runat="server">
                            <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Recieve Challan Forms from Bank
                                                    </h4>
                                                    <div class="col-lg-4">
                                                        <asp:Button ID="btngobck" runat="server" Text="Go Back" class="width-65 pull-right btn btn-sm btn-success" OnClick="btngobck_Click" />
                                                    </div>
                                                    <div class="space-6"></div>
                                                    <p>Enter/Scan Challan Form Barcode: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <asp:Label Text="" ID="lblnotify" runat="server" />
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddacnum" DataTextField="name" DataValueField="strAccNum" DataSourceID="sqlacnum" class="form-control" runat="server"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                                <asp:SqlDataSource ID="sqlacnum" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strAccNum],[strAccTitle]+'-'+[strAccNum] as name FROM [tbl_Bank] WHERE ([bisDeleted] = @bisDeleted)  and nsch_id=@nschid">
                                                                    <SelectParameters>
                                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean" />
                                                                        <asp:SessionParameter Name="nschid" SessionField="nschoolid" />
                                                                        <asp:SessionParameter Name="uid" SessionField="uid" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                    <asp:TextBox ID="txtdtrcv" class="form-control" placeholder="" TextMode="Date" runat="server"></asp:TextBox>
                                                                    <asp:TextBox ID="txtbcode" runat="server" class="form-control" placeholder="Challan Number" OnTextChanged="txtbcode_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <%--<div class="clearfix">
                                                                <asp:Button ID="btnupdate" runat="server" Text="Update" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnupdate_Click" />
                                                            </div>--%>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
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
        </div>
        <!-- PAGE CONTENT ENDS -->
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
