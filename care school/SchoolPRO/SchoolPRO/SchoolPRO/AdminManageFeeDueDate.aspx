<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageFeeDueDate.aspx.cs" Inherits="SchoolPRO.AdminManageFeeDueDate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <div class="form-search">
                    <span class="input-icon">
                        <p>Add Class Fee Fine After Due Date</p>

                    </span>
                </div>
                <div class="space-10"></div>
                <%--<div class="clearfix"><asp:Button ID="btnsrch" runat="server" class="width-20 pull-left btn btn-sm " Text="Search" /></div>--%>
                <asp:ScriptManager ID="sc" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upregst" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ActiveViewIndex="0" ID="mvfeeDueDate" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngo" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngo_Click" />
                                <div class="space-10"></div>
                                <asp:GridView ID="gvfee" CssClass="table table-responsive table-hover" runat="server" AllowSorting="true" AllowPaging="true" OnPageIndexChanging="gvfee_PageIndexChanging" DataKeyNames="nfee_id" AutoGenerateColumns="false" EnableViewState="true">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nfee_id" SortExpression="nfee_id" HeaderText="S.NO" />
                                        <asp:BoundField DataField="strTutionFee" SortExpression="strTutionFee" HeaderText="Tuition Fee" />
                                        <asp:BoundField DataField="date" SortExpression="dtDueDate" HeaderText="Due Date" />
                                        <asp:BoundField DataField="fine" SortExpression="strClass" HeaderText="Fine" />
                                        <asp:BoundField DataField="strClass" SortExpression="strClass" HeaderText="Class" />

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnedit" runat="server" class="width-10 pull-left btn btn-sm btn-success" Text="Edit" OnClick="btnedit_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btndel" runat="server" class="width-10 pull-left btn btn-sm btn-success" Text="Delete Fine" OnClick="btndel_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Fee Fine After Due Date
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter details of Fee Fine After Due Date For All Classes </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">

                                                                    <asp:RadioButton AutoPostBack="true" GroupName="FeeDue" Text="Add Due Date To All Classes" ID="radioAllClass" runat="server" OnCheckedChanged="radioAllClass_CheckedChanged" />
                                                                    <br />
                                                                    <asp:RadioButton AutoPostBack="true" GroupName="FeeDue" Text="Add Due Date To Class" ID="radioOneClass" runat="server" OnCheckedChanged="radioOneClass_CheckedChanged" />


                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>


                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddcl" Visible="false" runat="server" DataSourceID="sqlcl" DataTextField="strClass" DataValueField="nc_id"></asp:DropDownList>
                                                                    <i class="icon-dropbox"></i>
                                                                </span>

                                                            </label>
                                                            <label class="clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtfine" placeholder="Fine after Due date (Rs\-)" runat="server"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator CssClass="red" ErrorMessage="Only Digits.." ValidationExpression="^\d+$" ControlToValidate="txtfine" runat="server" />
                                                                    <i class="icon-dollar"></i>

                                                                </span>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Fine if any otherWise Enter 0Rs\- " ControlToValidate="txtfine"></asp:RequiredFieldValidator>

                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="dd_date" runat="server" AutoPostBack="True">
                                                                        <asp:ListItem Text="Select Date " Value="-1"></asp:ListItem>
                                                                        <asp:ListItem Text="1">1</asp:ListItem>
                                                                        <asp:ListItem Text="2">2</asp:ListItem>
                                                                        <asp:ListItem Text="3">3</asp:ListItem>
                                                                        <asp:ListItem Text="4">4</asp:ListItem>
                                                                        <asp:ListItem Text="5">5</asp:ListItem>
                                                                        <asp:ListItem Text="6">6</asp:ListItem>
                                                                        <asp:ListItem Text="7">7</asp:ListItem>
                                                                        <asp:ListItem Text="8">8</asp:ListItem>
                                                                        <asp:ListItem Text="9">9</asp:ListItem>
                                                                        <asp:ListItem Text="10">10</asp:ListItem>
                                                                        <asp:ListItem Text="11">11</asp:ListItem>
                                                                        <asp:ListItem Text="12">12</asp:ListItem>
                                                                        <asp:ListItem Text="13">13</asp:ListItem>
                                                                        <asp:ListItem Text="14">14</asp:ListItem>
                                                                        <asp:ListItem Text="15">15</asp:ListItem>
                                                                        <asp:ListItem Text="16">16</asp:ListItem>
                                                                        <asp:ListItem Text="17">17</asp:ListItem>
                                                                        <asp:ListItem Text="18">18</asp:ListItem>
                                                                        <asp:ListItem Text="19">19</asp:ListItem>
                                                                        <asp:ListItem Text="20">20</asp:ListItem>
                                                                        <asp:ListItem Text="21">21</asp:ListItem>
                                                                        <asp:ListItem Text="22">22</asp:ListItem>
                                                                        <asp:ListItem Text="23">23</asp:ListItem>
                                                                        <asp:ListItem Text="24">24</asp:ListItem>
                                                                        <asp:ListItem Text="25">25</asp:ListItem>
                                                                        <asp:ListItem Text="26">26</asp:ListItem>
                                                                        <asp:ListItem Text="27">27</asp:ListItem>
                                                                        <asp:ListItem Text="28">28</asp:ListItem>
                                                                        <asp:ListItem Text="29">29</asp:ListItem>
                                                                        <asp:ListItem Text="30">30</asp:ListItem>
                                                                        <asp:ListItem Text="31">31</asp:ListItem>

                                                                    </asp:DropDownList>


                                                                </span>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldVaidator3" runat="server" ErrorMessage="Enter Date" ControlToValidate="dd_date"></asp:RequiredFieldValidator>

                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnfeeDueDate" runat="server" Text="Add Fine" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnfeeDueDate_Click" />
                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </asp:View>
                            <asp:View ID="View3" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Fees Fine After Due Date
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter details of Fees Fine After Due Date according to their Classes: </p>
                                                    <form id="Form2">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <%--  <asp:DropDownList ID="ddcl2"  runat="server" DataSourceID="sqlcl" DataTextField="strClass" DataValueField="nc_id"></asp:DropDownList>--%>
                                                                    <asp:TextBox ID="ddcl2" runat="server"></asp:TextBox>
                                                                    <i class="icon-dropbox"></i>
                                                                </span>
                                                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strClass],nc_id FROM [tbl_Class] where bisDeleted='False' and nsch_id=@schid">
                                                                    <SelectParameters>
                                                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                            </label>
                                                            <label class="clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtfine2" placeholder="Fine after Due date (Rs\-)" runat="server"></asp:TextBox>
                                                                    <i class="icon-dollar"></i>

                                                                </span>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Fine if any otherWise Enter 0Rs\- " ControlToValidate="txtfine2"></asp:RequiredFieldValidator>

                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="dd_date2" runat="server" AutoPostBack="True">
                                                                        <asp:ListItem Text="Select Date " Value="-1"></asp:ListItem>
                                                                        <asp:ListItem Text="1">1</asp:ListItem>
                                                                        <asp:ListItem Text="2">2</asp:ListItem>
                                                                        <asp:ListItem Text="3">3</asp:ListItem>
                                                                        <asp:ListItem Text="4">4</asp:ListItem>
                                                                        <asp:ListItem Text="5">5</asp:ListItem>
                                                                        <asp:ListItem Text="6">6</asp:ListItem>
                                                                        <asp:ListItem Text="7">7</asp:ListItem>
                                                                        <asp:ListItem Text="8">8</asp:ListItem>
                                                                        <asp:ListItem Text="9">9</asp:ListItem>
                                                                        <asp:ListItem Text="10">10</asp:ListItem>
                                                                        <asp:ListItem Text="11">11</asp:ListItem>
                                                                        <asp:ListItem Text="12">12</asp:ListItem>
                                                                        <asp:ListItem Text="13">13</asp:ListItem>
                                                                        <asp:ListItem Text="14">14</asp:ListItem>
                                                                        <asp:ListItem Text="15">15</asp:ListItem>
                                                                        <asp:ListItem Text="16">16</asp:ListItem>
                                                                        <asp:ListItem Text="17">17</asp:ListItem>
                                                                        <asp:ListItem Text="18">18</asp:ListItem>
                                                                        <asp:ListItem Text="19">19</asp:ListItem>
                                                                        <asp:ListItem Text="20">20</asp:ListItem>
                                                                        <asp:ListItem Text="21">21</asp:ListItem>
                                                                        <asp:ListItem Text="22">22</asp:ListItem>
                                                                        <asp:ListItem Text="23">23</asp:ListItem>
                                                                        <asp:ListItem Text="24">24</asp:ListItem>
                                                                        <asp:ListItem Text="25">25</asp:ListItem>
                                                                        <asp:ListItem Text="26">26</asp:ListItem>
                                                                        <asp:ListItem Text="27">27</asp:ListItem>
                                                                        <asp:ListItem Text="28">28</asp:ListItem>
                                                                        <asp:ListItem Text="29">29</asp:ListItem>
                                                                        <asp:ListItem Text="30">30</asp:ListItem>
                                                                        <asp:ListItem Text="31">31</asp:ListItem>

                                                                    </asp:DropDownList>


                                                                </span>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Date" ControlToValidate="dd_date2"></asp:RequiredFieldValidator>

                                                            </label>

                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnupdate" runat="server" Text="Update" class="width-30 pull-left btn btn-sm " OnClick="btnupdate_Click" />

                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <asp:SqlDataSource ID="sqlcl1" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strClass],nc_id FROM [tbl_Class] where bisDeleted='False' and nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

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
            <asp:SqlDataSource ID="sqlcl" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strClass],nc_id FROM [tbl_Class] where bisDeleted='False' and nsch_id=@schid">
                <SelectParameters>
                    <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                </SelectParameters>
            </asp:SqlDataSource>
            <!-- PAGE CONTENT ENDS -->
        </div>
    </div>
</asp:Content>

