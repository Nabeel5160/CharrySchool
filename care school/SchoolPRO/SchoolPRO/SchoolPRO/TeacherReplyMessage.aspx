<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherReplyMessage.aspx.cs" Inherits="SchoolPRO.TeacherReplyMessage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upt" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
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
                                                    <fieldset>
                                                        <%-- <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddladduser" class="form-control" runat="server" DataSourceID="teachrDS" DataTextField="strfname" DataValueField="nu_id"></asp:DropDownList>
                                                                <asp:SqlDataSource runat="server" ID="teachrDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strlname], [nu_id], [strfname] FROM [tbl_Users] WHERE (([bisDeleted] = @bisDeleted) AND ([nu_id] = @nu_id))">
                                                                    <SelectParameters>
                                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                        <asp:Parameter DefaultValue="0" Name="nu_id" Type="Int32"></asp:Parameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>--%>
                                                        <label class="block clearfix">

                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtaddMessagetitle" class="form-control" placeholder="Message title" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Message Name" ControlToValidate="txtaddMessagetitle"></asp:RequiredFieldValidator>--%>
                                                            </span>
                                                        </label>
                                                        <p>Enter  Description: </p>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtaddMessagedesc" class="form-control" placeholder="Description" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Description" ControlToValidate="txtaddMessagedesc"></asp:RequiredFieldValidator>--%>
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
    </div>
</asp:Content>
