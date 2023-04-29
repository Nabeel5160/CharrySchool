<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageExpenseType.aspx.cs" Inherits="SchoolPRO.AdminManageExpenseType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Manage Expense Type
                </h4>

                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvetyp" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">

                                <div class="col-xs-3">
                                    <asp:Button ID="btnadetyp" class="width-65 pull-left btn btn-block btn-primary btn-rad" runat="server" Text="Add Expense Type" OnClick="btnadetyp_Click" />
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group input-group">
                                        <%--<input type="text" id="txtsrc" />--%>
                                        <asp:TextBox ID="txtsrc" runat="server" type="text" class="form-control" onkeyup="return KeyUp(this, '#ContentPlaceHolder1_gvetyp');" placeholder="Search. . . " />
                                        

                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="table-responsive">
                                    <asp:GridView ID="gvetyp" class="table table-striped table-bordered table-hover" AllowPaging="False" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" DataKeyNames="next_id" EnableViewState="true" runat="server">
                                        <Columns>
                                            <asp:BoundField DataField="next_id" SortExpression="next_id" HeaderText="S.NO" />
                                            <asp:BoundField DataField="strExpenseType" SortExpression="strExpenseType" HeaderText="Expense Type" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-65 pull-right btn btn-block btn-danger btn-rad" OnClick="btnedit_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button ID="btndel" runat="server" OnClick="btndel_Click" Text="Delete" class="width-65 pull-right btn btn-block btn-danger btn-rad" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>

                                </div>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <div class="row">
                                    <div class="col-md-2 col-sm-2 col-xs-2 col-lg-2">

                                    </div>
                                    <div class="center col-md-6 col-sm-6 col-xs-6 col-lg-6">
                                        
                                        <div class="block-flat">
                                            <div class="header">
                                                <h3>Expense Type</h3>
                                            </div>
                                            <div class="content">
                                                <form action="#" style="border-radius: 0px;">
                                                    <div class="form-group">

                                                        <asp:Label ID="Label1" runat="server" class="col-sm-3 control-label">Expense Type</asp:Label>
                                                        <div class="col-lg-6">
                                                            <%--<input type="text" class="form-control">--%>
                                                            <asp:TextBox ID="txtetp" runat="server" class="form-control" placeholder="Expense Type Name"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-actions clearfix">
                                                        <div class="pull-right">
                                                            <asp:LinkButton ID="lblgoback" class="flip-link to-recover grey" runat="server" OnClick="lblgoback_Click">View Added Expense</asp:LinkButton>

                                                        </div>
                                                        <asp:Button ID="btnsubmit" UseSubmitBehavior="false" class="btn btn-block btn-success btn-rad" OnClick="btnsubmit_Click" runat="server" Text="Add" />
                                                    </div>
                                                </form>
                                               

                                            </div>
                                        </div>

                                    </div>
                                </div>

                            </asp:View>
                            <asp:View ID="View3" runat="server">
                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="block-flat">
                                            <div class="header">
                                                <h3>Expense</h3>
                                            </div>
                                            <div class="content">
                                                <form action="#" style="border-radius: 0px;">
                                                    <div class="form-group">

                                                        <asp:Label ID="Label2" runat="server" class="col-sm-3 control-label">Expense Type</asp:Label>
                                                        <div class="col-lg-6">
                                                            <%--<input type="text" class="form-control">--%>
                                                            <asp:TextBox ID="txtbn" runat="server" class="form-control" placeholder="Expense Type Name"></asp:TextBox>
                                                        </div>
                                                    </div>





                                                    <div class="form-actions clearfix">
                                                        <div class="pull-right">
                                                            <asp:LinkButton ID="LinkButton1" class="flip-link to-recover grey" runat="server" OnClick="LinkButton1_Click">View Added Expense</asp:LinkButton>

                                                        </div>
                                                        <asp:Button ID="BtnUpdate" class="btn btn-block btn-danger btn-rad" OnClick="BtnUpdate_Click" runat="server" Text="Update" />
                                                    </div>
                                                </form>


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

                <div class="space-12"></div>

                <!-- /.page-content -->
            </div>
            <!-- /.main-content -->

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
