<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageLoans.aspx.cs" Inherits="SchoolPRO.AdminManageLoans" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="row">
                            <div class="col-xs-12">
                                <!-- PAGE CONTENT BEGINS -->

                                <div class="row-fluid">
                                    <h4 class="header green lighter bigger">
                                        <i class="icon-group blue"></i>
                                        Search By Name
                                    </h4>

                                    <div class="space-6"></div>
                                     <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                                    <asp:UpdatePanel ID="upclassview" runat="server">
                                        <ContentTemplate>
                                            <asp:MultiView ID="mvloan" ActiveViewIndex="0" runat="server">
                                                <asp:View ID="View1" runat="server">
                                                    <asp:Button ID="btngotoAdd" runat="server" Text="Add Loan" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                                    <%--<asp:Button ID="btnsal" class="width-15 pull-left btn btn-sm btn-success" runat="server" Text="Add Salary" OnClick="btnsal_Click" />--%>
                                           <div class="table-responsive">
                                               <asp:GridView ID="gvloan" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" DataKeyNames="nln_id" EnableViewState="true">
                                                   <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                             <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nln_id" HeaderText="S.NO" SortExpression="nsal_id" />
                                                    <asp:BoundField DataField="name" SortExpression="name" HeaderText="Employee Name" />
                                                    <asp:BoundField DataField="strLoanType" SortExpression="strLoanType" HeaderText="Loan Type" />
                                                    <asp:BoundField DataField="strLoanAmount" SortExpression="strLoanAmount" HeaderText="Loan Amount" />
                                                    <asp:BoundField DataField="strDuration" SortExpression="strDuration" HeaderText="Duration" />
                                                    <asp:BoundField DataField="strRetAmount" SortExpression="strRetAmount" HeaderText="Return Amount" />
                                                    <asp:BoundField DataField="dtAddDate" SortExpression="dtAddDate" HeaderText="Add Date" />
                                                    <%--<asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnedit_Click" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Button ID="btndel" runat="server" Text="Delete" class="width-65 pull-right btn btn-sm btn-success" OnClick="btndel_Click" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
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
                                                Manage Loans
                                            </h4>

                                            <div class="space-6"></div>
                                            <p>Enter Detail about Loan: </p>
                                    <form id="freg">
                                                <fieldset>
                                                    <label class="block clearfix">
                                                    
                                                        </label>
                                                       <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddenm" CssClass="form-control" DataValueField="nu_id" DataTextField="name" DataSourceID="sqlemp" AutoPostBack="true" runat="server" ></asp:DropDownList>
                                                            <i class="icon-user"></i>
                                                            
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddloan" AutoPostBack="true" CssClass="form-control" runat="server">
                                                                <asp:ListItem Text="Select Loan Type" />
                                                    <asp:ListItem>LTA</asp:ListItem>
                                                    <asp:ListItem>STA</asp:ListItem>
                                                </asp:DropDownList>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtsal" class="form-control" placeholder="Salary" runat="server"></asp:TextBox>
                                            
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtlamnt" runat="server" class="form-control" placeholder="LTA Amount"></asp:TextBox>
                                            
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtltime" CssClass="form-control" placeholder="Duration" runat="server"></asp:TextBox>
                                            
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtintrst" CssClass="form-control" placeholder="Monthly Return" runat="server"></asp:TextBox>
                                            
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                           <asp:TextBox ID="txtsamnt" CssClass="form-control" placeholder="STA Amount" runat="server"></asp:TextBox>
                                            
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtstime" CssClass="form-control" placeholder="Duration" runat="server"></asp:TextBox>
                                            
                                                        </span>
                                                    </label>
                                                    
                                                    <div class="space-24"></div>

                                                    <div class="clearfix">
                                                        <asp:LinkButton ID="lblgoback" class="flip-link to-recover grey" runat="server" OnClick="lblgoback_Click">View Added Loans</asp:LinkButton>
                                                        <asp:Button ID="btnAddexp" runat="server" Text="Add Loan" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnAddexp_Click"/>
                                                    </div>
                                                    </fieldset>
                                        </form>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                                        </div>
                                                <asp:SqlDataSource ID="sqlemp" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT  [strfname]+' '+[strlname] as name,nu_id FROM [tbl_Users] WHERE ([bisDeleted] = @bisDeleted) and nLevel<>'1010010'  and nsch_id=@schid">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean" />
                                                <asp:SessionParameter SessionField="nschoolid" Name="schid" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                            </asp:View>
                                                <%--<asp:View ID="View3" runat="server">
                                                    <div class="login-container">
                            <div class="position-relative">
                                <div class="no-border">
                                    <div class="widget-body">
									<div class="widget-main">
                                            <h4 class="header green lighter bigger">
                                                <i class="icon-group blue"></i>
                                                Manage Class
                                            </h4>

                                            <div class="space-6"></div>
                                            <p>Enter Class Name: </p>
                                    <form id="Form2">
                                                <fieldset>
                                                    
                                                       <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtaddclass" class="form-control" placeholder="Class Name" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Class Name" ControlToValidate="txtaddclass"></asp:RequiredFieldValidator>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtnos" class="form-control" placeholder="Total Seats" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Total Enter" ControlToValidate="txtnos"></asp:RequiredFieldValidator>
                                                        </span>
                                                    </label>
                                                    <div class="space-24"></div>

                                                    <div class="clearfix">
                                                        <asp:Button ID="btnaddclass" runat="server" Text="Add Class" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddclass_Click"/>
                                                    </div>
                                                    </fieldset>
                                        </form>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                                        </div>
                                                </asp:View>--%>
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
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
