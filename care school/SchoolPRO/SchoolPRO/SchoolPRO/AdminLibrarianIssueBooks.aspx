<%@ Page Title="" Language="C#" MasterPageFile="~/Library.Master" AutoEventWireup="true" CodeBehind="AdminLibrarianIssueBooks.aspx.cs" Inherits="SchoolPRO.AdminLibrarianIssueBooks" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Search By Name
            </h4>

            <div class="space-6"></div>
           <%-- <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>--%>
            <asp:ToolkitScriptManager  ID="tool1" runat="server"  ></asp:ToolkitScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="MultiView1" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                            <div class="table-responsive">
                                <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvsearchclass_RowCommand" OnRowUpdating="gvsearchclass_RowUpdating" DataKeyNames="nbs_id" EnableViewState="true">
                                    <Columns><asp:TemplateField >
                                           <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nbs_id" HeaderText="S.NO" SortExpression="nbs_id" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                            </HeaderTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Book Number">
                                            <ItemTemplate>
                                                <%--<asp:Label ID="lblcname" runat="server" Text='<%# Highlight(Eval("c_name").ToString()) %>'></asp:Label>--%>
                                                <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strBookNum") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="strStudentNum" SortExpression="strStudentNum" HeaderText="Student Number" />
                                        <asp:BoundField DataField="dtFromDate" SortExpression="strFromDate" HeaderText="From" />
                                        <asp:BoundField DataField="dtToDate" SortExpression="strToDate" HeaderText="To" />
                                        
                                    </Columns>
                                </asp:GridView>
                                <div class="space-4"></div>

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
                                                    Manage Issue Book
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Enter Class Name: </p>
                                                <form id="freg">
                                                    <fieldset>
                                                        
                                                        
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtebn" class="form-control" placeholder="Search by Book Number" AutoPostBack="true" OnTextChanged="txtebk_TextChanged" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtebn"></asp:RequiredFieldValidator>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtbk" class="form-control" ReadOnly="true" placeholder="Book Name" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtbk"></asp:RequiredFieldValidator>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txteath" class="form-control" ReadOnly="true" placeholder="Author Name" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txteath"></asp:RequiredFieldValidator>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtstnum" class="form-control" placeholder="Search by Student Number" AutoPostBack="true" OnTextChanged="txtstnum_TextChanged" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtstnum"></asp:RequiredFieldValidator>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtfn" class="form-control" ReadOnly="true" placeholder="First Name" runat="server"></asp:TextBox>
                                                                <asp:TextBox ID="txtln" class="form-control" ReadOnly="true" placeholder="Last Name" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                </span>

                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtcl" class="form-control" ReadOnly="true" placeholder="Class" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                 </span>

                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtsec" class="form-control" ReadOnly="true" placeholder="Section" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                                </span>

                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtfrom" class="form-control" TextMode="Date"  placeholder="Section" runat="server"></asp:TextBox>
                                                                  <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtfrom" runat="server"></asp:CalendarExtender>
                                                                <asp:TextBox ID="txtto" class="form-control" TextMode="Date" placeholder="Section" runat="server"></asp:TextBox>
                                                                 <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtto" runat="server"></asp:CalendarExtender>
                                                                 <i class="icon-user"></i>
                                                                </span>

                                                        </label>
                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <asp:Button ID="btnissue" runat="server" Text="Issue" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnissue_Click" />
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

            <div class="space-12"></div>

            <!-- /.page-content -->
        </div>
        <!-- /.main-content -->

    </div>

</asp:Content>

