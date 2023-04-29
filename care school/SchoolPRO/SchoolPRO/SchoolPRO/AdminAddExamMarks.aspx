<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAddExamMarks.aspx.cs" Inherits="SchoolPRO.AdminAddExamMarks" %>
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
    <asp:ScriptManager runat="server" ID="sc" />
    <div class="col-xs-12">
        
        <asp:UpdatePanel ID="upmarks" runat="server">
            <ContentTemplate>
                <asp:MultiView ID="mvmarks" ActiveViewIndex="0" runat="server">
                    <asp:View ID="View1" runat="server">
                        <div class="table-responsive">
                            <asp:Label Text="" ID="lblcid" Visible="false" runat="server" />
                            <asp:Label Text="" ID="lblscid" Visible="false" runat="server" />
                            <asp:Label Text="" ID="lblcours" Visible="false" runat="server" />
                            <asp:GridView ID="gvaddmarks" class="table table-striped table-bordered table-hover" ShowHeader="true" EmptyDataText="No Record Found" runat="server" AutoGenerateColumns="False" >
                                <Columns>
                                    <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                    <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                    <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                    <asp:TemplateField HeaderText="Add Marks">
                                        <ItemTemplate>
                                            <asp:Button ID="btnAddMarks" runat="server" Text="Add Marks" CssClass="width-55 pull-left btn btn-sm btn-primary" OnClick="btnAddMarks_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="View Marks">
                                        <ItemTemplate>
                                            <asp:Button ID="btnviewMarks" runat="server" Text="View Marks" CssClass="width-55 pull-left btn btn-sm btn-primary" OnClick="btnviewMarks_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nc_id" SortExpression="nc_id" HeaderText="S.NO" />
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nsc_id" SortExpression="nsc_id" HeaderText="S.NO" />
                                     
                                            
                                </Columns>
                            </asp:GridView>

                        </div>
                    </asp:View>

                    <asp:View ID="View2" runat="server">
                        <div class="table-responsive">
                            <%--<asp:CheckBox ID="chqex" Text="Check if Adding Exam Marks" runat="server" />--%>
                            <%--<asp:DropDownList ID="ddexams" runat="server" OnSelectedIndexChanged="ddexams_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Text="<---Select Type of Exam--->" Value="--"></asp:ListItem>
                                <asp:ListItem Text="Quiz" Value="Quiz"></asp:ListItem>
                                <asp:ListItem Text="1st Term Exam" Value="1st Term Exam"></asp:ListItem>
                                <asp:ListItem Text="2nd Term Exam" Value="2nd Term Exam"></asp:ListItem>
                                <asp:ListItem Text="Final Exam" Value="Final Exam"></asp:ListItem>
                                
                                
                            </asp:DropDownList>--%>
                            <asp:DropDownList ID="ddsubj" runat="server" AppendDataBoundItems="true" DataTextField="strSubject" DataValueField="nsbj_id" OnSelectedIndexChanged="ddsubj_SelectedIndexChanged" AutoPostBack="true">
                               
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddexams" runat="server" AppendDataBoundItems="true"  DataTextField="strExamName" DataValueField="nExam_id" OnSelectedIndexChanged="ddexams_SelectedIndexChanged" AutoPostBack="true">
                               
                            </asp:DropDownList>
                            
                            <asp:TextBox ID="txttmrks" placeholder="Total Marks" runat="server"></asp:TextBox>

                            <div class="space-12"></div>
                            <asp:GridView ID="gvstdmarks" class="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="bRegisteredNum" HeaderText="Admn. Number" SortExpression="bRegisteredNum" />
                                    <asp:BoundField DataField="stdname" HeaderText="Student Name" SortExpression="stdname" />
                                    <asp:BoundField DataField="fname" HeaderText="Father Name" SortExpression="fname" />
                                    <asp:TemplateField HeaderText="Marks">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtmarks" placeholder="Obt. Marks" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField  HeaderText="Remarks">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrem" placeholder="Remarks" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" DataField="ne_id" HeaderText="S.No" SortExpression="neid" />
                                </Columns>
                            </asp:GridView>
                           
                            <asp:Button ID="btnsubmitattend" UseSubmitBehavior="false" class="width-35 pull-right btn btn-sm btn-primary" runat="server" Text="Submit Marks" OnClick="btnsubmitattend_Click" />
                        </div>
                        <!-- /.table-responsive -->
                        <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="pnl1" TargetControlID="btnsubmitattend"
                            CancelControlID="btnClose" BackgroundCssClass="modalBackground">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="pnl1" runat="server" CssClass="modalPopup" align="center" Style="display: none">
                            <img src="assets/images/loader.gif" />
                            <br />
                            <asp:HiddenField ID="btnClose" runat="server" />
                        </asp:Panel>
                        <cc1:ModalPopupExtender ID="mperror" runat="server" PopupControlID="pnlerror" TargetControlID="HiddenField1"
                            CancelControlID="close" BackgroundCssClass="modalBackground">
                        </cc1:ModalPopupExtender>
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                        <asp:Panel ID="pnlerror" runat="server" CssClass="modalPopup" align="center" Style="display: none">
                           <h1>Something Goes Wrong !!!</h1>
                            <br />
                            <asp:LinkButton Text="Close" ID="lblwrong" runat="server" />
                        </asp:Panel>
                        <cc1:ModalPopupExtender ID="mpok" runat="server" PopupControlID="pnlok" TargetControlID="HiddenField2"
                            CancelControlID="lbok" BackgroundCssClass="modalBackground">
                        </cc1:ModalPopupExtender>
                        <asp:HiddenField ID="HiddenField2" runat="server" />
                        <asp:Panel ID="pnlok" runat="server" CssClass="modalPopup" align="center" Style="display: none">
                           <h1>Marks Successfully Submited..</h1>
                            <br />
                            <asp:LinkButton Text="Ok" ID="lbok" OnClick="lbok_Click" runat="server" />
                        </asp:Panel>
                    </asp:View>

                    <asp:View ID="View3" runat="server">
                        <asp:DropDownList ID="ddsubjshw" runat="server" AppendDataBoundItems="true" DataTextField="strSubject" DataValueField="nsbj_id" OnSelectedIndexChanged="ddsubjshw_SelectedIndexChanged" AutoPostBack="true">
                               
                            </asp:DropDownList>
                        <div class="table-responsive">
                            <asp:GridView ID="gvshowmarks" class="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False" >
                                <Columns>
                                    
                                    <asp:TemplateField>
                                       <ItemTemplate>
                                           <%# Container.DataItemIndex + 1 %>
                                       </ItemTemplate>
                                   </asp:TemplateField>
                                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nr_id" HeaderText="S.NO" SortExpression="nr_id" />
                                    <asp:BoundField DataField="bRegisteredNum" HeaderText="Admn. Number" SortExpression="bRegisteredNum" />
                                    <asp:BoundField DataField="studentname" HeaderText="Student Name" SortExpression="studentname" />
                                    <asp:BoundField DataField="fathernm" HeaderText="Father Name" SortExpression="fathernm" />
                                    <asp:BoundField DataField="strTotalMarks" HeaderText="Total Marks" SortExpression="strTotalMarks" />
                                    <asp:BoundField DataField="strObtMarks" SortExpression="Obt. Marks" HeaderText="strObtMarks" />
                                    <asp:BoundField DataField="strRemarks" SortExpression="Remarks" HeaderText="strRemarks" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btned" CssClass="btn btn-primary" runat="server" Text="Edit" OnClick="btned_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btndel" CssClass="btn btn-primary" runat="server" Text="Delete" OnClick="btndel_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                </Columns>
                            </asp:GridView>
                            
                            <asp:Button ID="gottoback" class="width-35 pull-right btn btn-sm btn-primary" runat="server" Text="Go Back" OnClick="gottoback_Click" />
                        </div>
                    </asp:View>

                    <asp:View ID="View4" runat="server">
                        <div class="login-container">
                            <div class="position-relative">
                                <div class="no-border">
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <h4 class="header green lighter bigger">
                                                <i class="icon-group blue"></i>
                                                Marks
                                            </h4>

                                            <div class="space-6"></div>
                                            <p>Edit marks: </p>
                                            <form id="freg">
                                                <fieldset>

                                                     <label class="block clearfix">
                                                         <div class="control-label">TOTAL MARKS</div>
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txttol" ReadOnly="true" placeholder="Total Marks" CssClass="form-actions" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                   

                                                    <label class="block clearfix">
                                                        <div class="control-label">OBT MARKS</div>
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox AutoPostBack="true" OnTextChanged="txteditmarks_TextChanged" ID="txteditmarks" placeholder="Marks" CssClass="form-actions" runat="server"></asp:TextBox>
                                                           <%-- <asp:RegularExpressionValidator ValidationGroup="up" CssClass="red" ErrorMessage="ONLY DIGITS" ControlToValidate="txteditmarks" runat="server" ValidationExpression="^[0-9]+$" />--%>
                                                             <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <div class="control-label">REMARKS</div>
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtremarks" placeholder="ReMarks" CssClass="form-actions" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <div class="space-24"></div>

                                                    <div class="clearfix">
                                                        <asp:Button ID="btnupdate" ValidationGroup="up" runat="server" Text="Update" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnupdate_Click" />
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
    <asp:UpdateProgress ID="UpdateProgress1" DisplayAfter="10" runat="server">
                    <ProgressTemplate>
                        <div class="loading" align="center">
                            Loading. Please wait.<br />
                            <br />
                            <img src="assets/images/loader.gif" alt="" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
    </div>
    <!-- /span -->


    <div class="hr hr-18 dotted hr-double"></div>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
