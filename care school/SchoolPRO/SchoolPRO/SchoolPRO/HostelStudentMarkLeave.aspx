<%@ Page Title="" Language="C#" MasterPageFile="~/Hostel.Master" AutoEventWireup="true" CodeBehind="HostelStudentMarkLeave.aspx.cs" Inherits="SchoolPRO.HostelStudentMarkLeave" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ToolkitScriptManager runat="server"></asp:ToolkitScriptManager>
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Hostel Student Laeave
            </h4>
            <div class="space-6"></div>
            <asp:UpdatePanel ID="upquiz" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvquiz" ActiveViewIndex="0" runat="server">

                        <asp:View ID="View3" runat="server">
                            <div class="login-container">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Select Leave Date Here
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Select Leave Date: </p>
                                                <asp:Label ID="lbltopic" runat="server"></asp:Label>
                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <asp:TextBox ID="txtfrom" ValidationGroup="add" runat="server" placeholder=" Date From" class="form-control"></asp:TextBox>
                                                        <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtfrom" runat="server"></asp:CalendarExtender>
                                                        <i class="icon-user"></i>
                                                    </span>
                                                </label>
                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <asp:TextBox ID="txtto" ValidationGroup="add" runat="server" placeholder=" Date To" class="form-control"></asp:TextBox>
                                                        <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtto" runat="server"></asp:CalendarExtender>
                                                        <i class="icon-user"></i>
                                                    </span>
                                                </label>
                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <textarea runat="server" id="txtreason" class="form-control" placeholder=" Reason"></textarea>
                                                        <i class="icon-user"></i>
                                                    </span>
                                                </label>

                                                <div class="space-24"></div>

                                                <div class="clearfix">
                                                    <asp:Button ID="btnaddLeave" OnClick="btnaddLeave_Click" runat="server" Text="Leave" class="width-65 pull-right btn btn-sm btn-success" />
                                                </div>
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
