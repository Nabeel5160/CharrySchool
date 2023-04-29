<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminSendMgsToAdmin.aspx.cs" Inherits="SchoolPRO.AdminSendMgsToAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="col-xs-12">
        <h3 class="header smaller lighter blue">View Attendane Report</h3>
        <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="upt" runat="server">
            <ContentTemplate>
                <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">
                    <asp:View ID="View1" runat="server">
                        <div class="table-responsive">
                            <asp:GridView ID="gvstnm" class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataKeyNames="nu_id" DataSourceID="sqladmn">

                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nu_id" HeaderText="nu_id" ReadOnly="True" InsertVisible="False" SortExpression="nu_id"></asp:BoundField>
                                    <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name"></asp:BoundField>
                                    <asp:BoundField DataField="Education" HeaderText="Education" SortExpression="Education"></asp:BoundField>
                                    <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address"></asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnview" runat="server" class="width-65 pull-left btn btn-sm btn-success" Text="Send Message" OnClick="btnview_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource runat="server" ID="sqladmn" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nu_id, strfname + ' ' + strlname AS Name, strEducation AS Education, strAddress AS Address FROM tbl_Users WHERE (bisDeleted = @fbit) AND (nsch_id=@schid) AND (nLevel = 1)">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                    <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                </SelectParameters>
                            </asp:SqlDataSource>
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
                                                Manage Messages
                                            </h4>

                                            <div class="space-6"></div>
                                            <p>Enter  Title: </p>
                                            <form id="Form2">
                                                <label class="block clearfix">

                                                    <span class="block input-icon input-icon-right">
                                                        <asp:TextBox ID="txtaddMessagetitle" class="form-control" placeholder="Message title" runat="server"></asp:TextBox>
                                                        <i class="icon-user"></i>
                                                    </span>
                                                </label>
                                                <p>Enter  Description: </p>
                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <asp:TextBox ID="txtaddMessagedesc" class="form-control" placeholder="Description" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                        <i class="icon-user"></i>
                                                    </span>
                                                </label>
                                                <div class="space-24"></div>

                                                <div class="clearfix">
                                                    <asp:Button ID="btnaddMessage" runat="server" Text="Add Message" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddMessage_Click" />
                                                </div>
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

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
