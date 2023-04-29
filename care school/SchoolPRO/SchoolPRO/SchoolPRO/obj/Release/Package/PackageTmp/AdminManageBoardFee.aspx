<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageBoardFee.aspx.cs" Inherits="SchoolPRO.AdminManageBoardFee" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Manage Board fee
                </h4>

                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="MultiView1" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                               <div class="space-30"></div>
                                 <div id="printable" class="table-responsive">
                                    <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Board fee List
												</h5>

												<div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                    <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" OnPageIndexChanging="gvsearchclass_PageIndexChanging" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvsearchclass_RowCommand" OnRowUpdating="gvsearchclass_RowUpdating" DataKeyNames="nBFee_id" EnableViewState="true" OnSelectedIndexChanged="gvsearchclass_SelectedIndexChanged">
                                        <Columns>
                                            <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nBFee_id" HeaderText="S.NO" SortExpression="nBFee_id" />
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <HeaderTemplate>
                                                    <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                                </HeaderTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Class">
                                                <ItemTemplate>
                                                    <%--<asp:Label ID="lblcname" runat="server" Text='<%# Highlight(Eval("c_name").ToString()) %>'></asp:Label>--%>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strClass") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:BoundField DataField="strRegBoardFee" SortExpression="strRegBoardFee" HeaderText="Board Registeration Fee" />
                                            <asp:BoundField DataField="strBoardFee" SortExpression="strBoardFee" HeaderText="Board Fee" />
                                             <asp:BoundField DataField="strBoardCode" SortExpression="strBoardCode" HeaderText="Board Fee Code" />
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print" >
                                                <ItemTemplate>
                                                    <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnedit_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <ItemTemplate>
                                                    <asp:Button ID="btndel" runat="server" Text="Delete" class="width-65 pull-right btn btn-sm btn-success" OnClick="btndel_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
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
                                                        Manage Board Fee
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Board Fee: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    
                                                                    <label>Class Board Fee :</label>
                                                                    <asp:TextBox ID="txteaddbfee" class="form-control"  placeholder="Fee" runat="server"></asp:TextBox>
                                                                     <label>Class Board Registeration  Fee Code:</label>
                                                                    <asp:TextBox ID="txteaddbregfee" class="form-control" placeholder="Fee" runat="server"></asp:TextBox> 
                                                                    <label>Class Board Fee Code :</label>
                                                                    <asp:TextBox ID="txtebcode" runat="server" ReadOnly="true" class="form-control"  placeholder="Code"></asp:TextBox>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnupdate" runat="server" Text="Update" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnupdate_Click" />
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
                                                        Manage Board Fee
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Board Fee: </p>
                                                    <form id="Form2">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddlcls" CssClass="form-control" runat="server" DataSourceID="ddlclass" AppendDataBoundItems="true" DataTextField="strClass" DataValueField="nc_id">
                                                                        <asp:ListItem Text="--Please Select Class--" />
                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource runat="server" ID="ddlclass" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nc_id, strClass FROM tbl_Class WHERE (bisDeleted = 'False') AND (nsch_id = @schid)">
                                                                        <SelectParameters>
                                                                            <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                </span>
                                                            </label>
                                                             <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtaddbregfee" class="form-control" placeholder="Class Board Registeration Fee" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                     <asp:RegularExpressionValidator ID="RegularExpressionValidatdsor3" CssClass="red" ErrorMessage="Enter Fee(0-9)" ControlToValidate="txtaddbregfee" ValidationExpression="^\d+$" runat="server" />
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Class Board Registeration fee" ControlToValidate="txtaddbregfee"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtaddbfee" class="form-control" placeholder="Class Board Fee" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="red" ErrorMessage="Enter Fee(0-9)" ControlToValidate="txtaddbfee" ValidationExpression="^\d+$" runat="server" />
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Class Board fee" ControlToValidate="txtaddbfee"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtbcode" class="form-control" placeholder="Enter Code" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Code" ControlToValidate="txtbcode"></asp:RequiredFieldValidator>
                                                                         <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="red" ErrorMessage="Enter Code(0-9)" ControlToValidate="txtbcode" ValidationExpression="^\d+$" runat="server" />
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnaddclass" runat="server" Text="Add Fee" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnaddclass_Click" />
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
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
