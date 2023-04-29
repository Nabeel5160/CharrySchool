<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewAllMsgReport.aspx.cs" Inherits="SchoolPRO.AdminViewAllMsgReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <div class="row-fluid">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <div class="col-md-4">
                                    <asp:Button ID="btnview_full" class=" btn btn-sm btn-success" runat="server" Text="View Non-Sent Messages" OnClick="btnview_full_Click" />
                                </div>
                                  <div class="clearfix"></div>
                                <div class="clearfix"></div>
                                 <div class="col-xs-12 col-sm-12 widget-container-span">
                                        <div class="widget-box" id="Div1">
                                        <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Message Send Report
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                              
                                             <div class="widget-body">
												<div class="widget-main no-padding">
                                <asp:GridView ID="gvstlist" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sqlstlist">
                                    <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nSmsID" HeaderText="S.NO" SortExpression="nSmsID" />
                                        <asp:BoundField DataField="strNumber" HeaderText="Number" SortExpression="strNumber" />
                                        <asp:BoundField DataField="strMessage" HeaderText="Message" SortExpression="strMessage" />
                                        <asp:BoundField DataField="dtAddDate" HeaderText="Add Date" SortExpression="dtAddDate" />
                                        <asp:BoundField DataField="bIsSent" HeaderText="Message Status" SortExpression="bIsSent" />
                                        <asp:BoundField DataField="dtSendDate" HeaderText="Send Date" SortExpression="dtSendDate" />
                                        
                                    </Columns>
                                </asp:GridView>
                                                    </div>
                                                 </div>
                                            </div>
                                     </div>
                                <asp:SqlDataSource ID="sqlstlist" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="select  nSmsID,strNumber,strMessage,dtAddDate,dtSendDate,bIsSent from tbl_SendSMS where bIsSent='True' and nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                        
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <div class="col-md-4">
                                    <asp:Button ID="btngoback" runat="server" class=" btn btn-sm btn-success" Text="View Sent Messages" OnClick="btngoback_Click" />
                                </div>
                                <div class="clearfix"></div>
                                <div class="clearfix"></div>
                                <div class="col-xs-12 col-sm-12 widget-container-span">
                                    <div class="widget-box" id="printable">
                                        <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Message Non-Send Report
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                        <div class="widget-body">
												<div class="widget-main no-padding">

                                                    

                                 <asp:GridView ID="gv_detail_list" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sql_detail_list">
                                    <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nSmsID" HeaderText="S.NO" SortExpression="nSmsID" />
                                        <asp:BoundField DataField="strNumber" HeaderText="Number" SortExpression="strNumber" />
                                        <asp:BoundField DataField="strMessage" HeaderText="Message" SortExpression="strMessage" />
                                        <asp:BoundField DataField="dtAddDate" HeaderText="Add Date" SortExpression="dtAddDate" />
                                        <asp:BoundField DataField="bIsSent" HeaderText="Message Status" SortExpression="bIsSent" />
                                        <asp:BoundField DataField="dtSendDate" HeaderText="Send Date" SortExpression="dtSendDate" />
                                        
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sql_detail_list" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="select  nSmsID,strNumber,strMessage,dtAddDate,dtSendDate,bIsSent from tbl_SendSMS where bIsSent='False' and nsch_id=@schid">
                                   <SelectParameters>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                        
                                    </SelectParameters>
                                </asp:SqlDataSource>
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
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
