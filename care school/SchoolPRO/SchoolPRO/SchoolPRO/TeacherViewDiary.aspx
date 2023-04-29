<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherViewDiary.aspx.cs" Inherits="SchoolPRO.TeacherViewDiary" %>
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
                Student Task
            </h4>
            <div class="space-6"></div>
            <asp:UpdatePanel ID="upquiz" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvquiz" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:Button ID="btncompose" runat="server" Text="Compose Diary" class="width-10 pull-left btn btn-sm btn-success" OnClick="btncompose_Click" />
                            <div class="table-responsive">
                                <asp:GridView ID="gvsearchsub" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" DataKeyNames="nntf_id" EnableViewState="true">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nntf_id" HeaderText="S.NO" SortExpression="n_id" />
                                       
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                        <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                        <asp:BoundField DataField="strSubject" HeaderText="Subject" SortExpression="strSubject" />                                        
                                        <asp:BoundField DataField="strTitle" SortExpression="strTitle" HeaderText="Title" />
                                        <asp:BoundField DataField="strDesc" SortExpression="strDesc" HeaderText="Topic" />
                                        <asp:BoundField DataField="dtDate" SortExpression="dtDate" HeaderText="Due Date" />
                                        <asp:BoundField DataField="strTime" SortExpression="strTime" HeaderText="Time" />
                                        <asp:BoundField DataField="dt" SortExpression="dt" HeaderText="Assign Date" />
                                        
                                    </Columns>
                                </asp:GridView>
                                <div class="space-4"></div>
                                <div class="row">
                                    <div class="col-xs-10">
                                        <asp:TextBox runat="server" TextMode="MultiLine" ID="txtdiary" Columns="50" Height="200" Rows="100" />
                                    </div>
                                    <asp:Button Text="Send Diary" class="width-10 pull-left btn btn-sm btn-success" ID="btnsend" OnClick="btnsend_Click" runat="server" />
                                </div>
                            </div>
                            <asp:Label Text="" ID="lblcl" Visible="false" runat="server" />
                            <asp:Label Text="" ID="lblsc" Visible="false" runat="server" />
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
