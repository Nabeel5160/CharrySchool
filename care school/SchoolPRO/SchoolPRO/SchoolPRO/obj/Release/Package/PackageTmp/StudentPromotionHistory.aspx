<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="StudentPromotionHistory.aspx.cs" Inherits="SchoolPRO.StudendPromotionHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            
            <div class="row-fluid">

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">

                            <asp:View ID="View2" runat="server">
                                <div class="col-xs-12 col-sm-12 widget-container-span">
                                    <div class="widget-box">
                                        <div class="widget-header header-color-blue">
                                            <h5 class=" bigger lighter">
                                                <i class="icon-table"></i>
                                                Student Promotion History
                                            </h5>

                                            <div class="widget-toolbar widget-toolbar-light no-border">
                                                <div class="hidden-print icon-print icon-2x" onclick="printDiv('printable')"></div>
                                            </div>
                                        </div>

                                        <div class="widget-body">
                                            <div class="widget-main no-padding">
                                                <div class="clearfix"></div>
                                                <div class="space-24"></div>
                                                <div class="col-md-5 ">
                                                    <asp:TextBox ID="txtsearch" Style="margin-bottom: 10px" runat="server" type="text" class="form-control" placeholder="Search By Addmission Id. . . " />
                                                </div>
                                                <div>
                                                    <asp:Button CssClass="hidden-print btn btn-success" ID="btnPromote" Text="Click Here To Promote" runat="server" OnClick="btnPromote_Click" />
                                                </div>
                                                <br />

                                                <asp:GridView ID="gv_students" AutoGenerateColumns="False" CssClass=" table table-striped table-bordered table-hover" runat="server">
                                                    <Columns>
                                                        <asp:BoundField DataField="ne_id" HeaderText="Addmission No." />
                                                        <asp:BoundField DataField="sName" HeaderText="Student Name" />
                                                        <asp:BoundField DataField="PClass" HeaderText="Previous Class" />
                                                        <asp:BoundField DataField="PSection" HeaderText="Previous Section" />
                                                        <asp:BoundField DataField="NClass" HeaderText="Next Class" />
                                                        <asp:BoundField DataField="NSection" HeaderText="Next Section" />
                                                        <asp:BoundField DataField="Pdate" HeaderText="Promotion Date" />
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </asp:View>
                        </asp:MultiView>

                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
