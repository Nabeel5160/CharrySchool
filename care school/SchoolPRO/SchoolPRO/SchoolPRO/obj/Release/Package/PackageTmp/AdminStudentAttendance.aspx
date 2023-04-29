<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminStudentAttendance.aspx.cs" Inherits="SchoolPRO.AdminStudentAttendance" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .modalBackground {
            background-color: white;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .modalPopup h2 {
            color: white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-12">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <asp:UpdatePanel ID="upt" runat="server">
            <ContentTemplate>
                <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">
                    <asp:View ID="View1" runat="server">
                        <div class="table-responsive">
                            <asp:Label Text="" Visible="false" ID="lblcid" runat="server" />
                            <asp:Label Text="" Visible="false" ID="lblscid" runat="server" />
                            
                            <!-- /.table-responsive -->

                            <asp:GridView ID="gvbyclass" class="table table-striped table-bordered table-hover" AutoGenerateColumns="false" runat="server">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nc_id" HeaderText="S.NO" SortExpression="nc_id" />
                                    <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                    <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnvful" runat="server" Text="Take Attendance" class="width-65 pull-left btn btn-sm btn-success" OnClick="btnvful_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nsc_id" HeaderText="S.NO" SortExpression="nsc_id" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </asp:View>
                    <asp:View ID="View2" runat="server">
                        <div class="col-xs-3">

                        
                        <asp:TextBox runat="server" ID="txtattdt" CssClass="form-control" />
                       <cc1:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender3" TargetControlID="txtattdt" runat="server"></cc1:CalendarExtender>
                        <asp:RequiredFieldValidator ValidationGroup="up" ForeColor="Red" Font-Bold="true" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression="^[\s\S]{10,10}$" ControlToValidate="txtattdt"></asp:RequiredFieldValidator>
                         <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ValidationGroup="up" ForeColor="Red" Font-Bold="true" runat="server" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ControlToValidate="txtattdt" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>
                        </div><div class="col-xs-3">
                            <asp:CheckBox Text="Check for sending SMS to Absenties" ID="chkabs" OnCheckedChanged="chkabs_CheckedChanged" AutoPostBack="true" runat="server" />
                        </div>
                        <div class="col-xs-3">
                            <asp:DropDownList AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="ddsmstemp_SelectedIndexChanged" Visible="false" ID="ddsmstemp" runat="server" DataTextField="strSMSTitle" DataValueField="nstmp_id"></asp:DropDownList>
                             <%--<asp:DropDownList AutoPostBack="true" AppendDataBoundItems="true" CssClass="chosen-select"  ID="ddlsubjects" runat="server" ></asp:DropDownList>--%>
                        </div>
                        <div class="col-xs-3">
                            <asp:TextBox Visible="false" runat="server" TextMode="MultiLine" ID="txtmsg"  />
                        </div>
                        <div class="clearfix"></div>
                        <div class="table-responsive">
            <asp:GridView ID="gvattnd" OnRowDataBound="gvattnd_RowDataBound" class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False"  DataKeyNames="ne_id">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ne_id" SortExpression="S.No" HeaderText="ne_id" InsertVisible="False" ReadOnly="True" />
                    <asp:BoundField DataField="bRegisteredNum" HeaderText="Admn. Number" SortExpression="bRegisteredNum" />
                    <asp:BoundField DataField="StdName" HeaderText="Student Name" SortExpression="StdName" />
                    <asp:BoundField DataField="fname" HeaderText="Father Name" SortExpression="fname" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddst" runat="server">
                                <asp:ListItem>Present</asp:ListItem>
                                <asp:ListItem>Absent</asp:ListItem>
                                <asp:ListItem>Leave</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Remarks">
                        <ItemTemplate>
                            <asp:TextBox ID="txtrem" placeholder="Remarks" runat="server"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
             </div>
            <asp:Button ID="btnsubmitattend" UseSubmitBehavior="false" ValidationGroup="up" class="width-35 pull-right btn btn-sm btn-primary" runat="server" Text="Submit Attendance" OnClick="btnsubmitattend_Click" />
       
                        <cc1:ModalPopupExtender ID="mp1" ValidateRequestMode="Enabled"  runat="server" PopupControlID="pnl1" TargetControlID="btnsubmitattend"
                            CancelControlID="btnClose" BackgroundCssClass="modalBackground">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="pnl1" runat="server" CssClass="modalPopup" align="center" Style="display: none">
                            <img src="assets/images/loader.gif" />
                            <br />
                            <asp:HiddenField ID="btnClose" runat="server" />
                        </asp:Panel>
                        <cc1:ModalPopupExtender ID="mpok" runat="server" PopupControlID="pnlok" TargetControlID="HiddenField2"
                            CancelControlID="lbok" BackgroundCssClass="modalBackground">
                        </cc1:ModalPopupExtender>
                        <asp:HiddenField ID="HiddenField2" runat="server" />
                        <asp:Panel ID="pnlok" runat="server" CssClass="modalPopup" align="center" Style="display: none">
                           <h1>Attendance Successfully Submited..</h1>
                            <br />
                            <asp:LinkButton Text="Ok" ID="lbok" OnClick="lbok_Click" CssClass="btn btn-sm" runat="server" />
                        </asp:Panel>
                    </asp:View>
                </asp:MultiView>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdateProgress ID="UpdateProgress1" DisplayAfter="10" runat="server">
            <ProgressTemplate>
                <div class="loading" align="center">
                    Loading. Please wait.<br />
                    <br />
                    <img src="dist/images/loader.gif" alt="" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
