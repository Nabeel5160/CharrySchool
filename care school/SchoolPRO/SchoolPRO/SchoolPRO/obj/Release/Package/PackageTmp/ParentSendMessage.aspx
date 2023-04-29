<%@ Page Title="" Language="C#" MasterPageFile="~/Parent.Master" AutoEventWireup="true" CodeBehind="ParentSendMessage.aspx.cs" Inherits="SchoolPRO.ParentSendMessage" %>
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
                                                    Send Message
                                                </h4>

                                                <%--<div class="space-6"></div>--%>
                                                 <form id="freg">
                                                    <fieldset>


                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:CheckBox runat="server" ID="chkstd" Text="Message Send To Student"/>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>


                                                         <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txttitle" placeholder="Message Tittle" CssClass="form-actions" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtDiscreption" placeholder="Message Discription" CssClass="form-actions" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <asp:Button ID="btnsend" runat="server" Text="Send" class="width-65 pull-left btn btn-sm btn-success"/>

                                                        </fieldset>


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
