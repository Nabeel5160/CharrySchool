<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/admin.Master" AutoEventWireup="true" CodeBehind="ManageGroups.aspx.cs" Inherits="SchoolPRO.SuperAdmin.ManageGroups" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            background-color: black;
            z-index: 99;
            opacity: 0.8;
            filter: alpha(opacity=80);
            -moz-opacity: 0.8;
            min-height: 100%;
            width: 100%;
        }

        .loading {
            font-family: Arial;
            font-size: 10pt;
            border: 5px solid #67CFF5;
            width: 200px;
            height: 100px;
            display: none;
            position: fixed;
            background-color: White;
            z-index: 999;
        }
    </style>
    <script src="js/plugins/morris/jquery.min.js"></script>
    <script type="text/javascript">
        function ShowProgress() {
            setTimeout(function () {
                var modal = $('<div />');
                modal.addClass("modal");
                $('body').append(modal);
                var loading = $(".loading");
                loading.show();
                var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                loading.css({ top: top, left: left });
            }, 200);
        }
        $('form').live("submit", function () {
            ShowProgress();
        });

    </script>
    <script type="text/javascript">
        $("[id*=chkHeader]").live("click", function () {
            var chkHeader = $(this);
            var grid = $(this).closest("table");
            $("input[type=checkbox]", grid).each(function () {
                if (chkHeader.is(":checked")) {
                    $(this).attr("checked", "checked");
                    $("td", $(this).closest("tr")).addClass("selected");
                } else {
                    $(this).removeAttr("checked");
                    $("td", $(this).closest("tr")).removeClass("selected");
                }
            });
        });
        $("[id*=chkRow]").live("click", function () {
            var grid = $(this).closest("table");
            var chkHeader = $("[id*=chkHeader]", grid);
            if (!$(this).is(":checked")) {
                $("td", $(this).closest("tr")).removeClass("selected");
                chkHeader.removeAttr("checked");
            } else {
                $("td", $(this).closest("tr")).addClass("selected");
                if ($("[id*=chkRow]", grid).length == $("[id*=chkRow]:checked", grid).length) {
                    chkHeader.attr("checked", "checked");
                }
            }
        });
    </script>
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="page-header">
                    <i class="page-header"></i>
                    Manage Groups
                </h4>
                <%--<ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-dashboard"></i> Dashboard
                            </li>
                        </ol>--%>
                <div class="space-6"></div>
                <div class="space-6"></div>
                <div class="space-6"></div>
                <div class="space-6"></div>
                <div class="space-6"></div>
                <%--<asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>--%>
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

                                        </h5>

                                        <div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                            <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                        </div>
                                    </div>
                                    <%--  --%>
                                    <asp:GridView ID="gvsearchclass" EmptyDataText="No Data Found" class="table table-striped table-bordered table-hover" runat="server" DataSourceID="Pages" AutoGenerateColumns="false" DataKeyNames="nGid">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nGid" HeaderText="nGid" ReadOnly="True" InsertVisible="False" SortExpression="nGid"></asp:BoundField>

                                            <asp:BoundField DataField="strGname" HeaderText="Name" SortExpression="strGname" />
                                            <asp:BoundField DataField="nGcode" SortExpression="nGcode" HeaderText="Code" />
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnedit" runat="server" Text="View Pages" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnedit_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
                                                <ItemTemplate>
                                                    <asp:Button ID="btndel" runat="server" Text="Delete" class="width-65 pull-right btn btn-sm btn-success" OnClick="btndel_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>
                                    <%-- --%>
                                    <asp:SqlDataSource runat="server" ID="Pages" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nGid], [strGname], [nGcode] FROM [tbl_Group] WHERE ([bisDeleted] = @bisDeleted)">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
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
                                                        Manage Group
                                                    </h4>
                                                    <div class="space-6"></div>
                                                    <div class="space-6"></div>

                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                            </label>
                                                            <div class="form-group">
                                                                <label class="block clearfix">
                                                                    <span class="block input-icon input-icon-right">
                                                                        <asp:TextBox ID="txtGroupname" class="form-control" placeholder="Group Name" runat="server"></asp:TextBox>
                                                                        <i class="icon-user"></i>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Group Name" ControlToValidate="txtGroupname"></asp:RequiredFieldValidator>
                                                                        <asp:TextBox ID="txtGroupcode" runat="server" class="form-control" placeholder="Group Code"></asp:TextBox>
                                                                    </span>
                                                                </label>

                                                                <asp:Button ID="btn_Add2" runat="server" Text="Add" class="width-65 btn btn-sm btn-success" OnClick="btnAdd_Click" />

                                                            </div>
                                                            <div class="space-24"></div>
                                                            <asp:GridView EmptyDataText="No Data Found" class="table table-striped table-bordered table-hover" runat="server" ID="gvpagess" AutoGenerateColumns="False" DataKeyNames="nPid" DataSourceID="SqlDataSource1">

                                                                <Columns>
                                                                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nPid" HeaderText="" ReadOnly="True" InsertVisible="False" SortExpression="nPid"></asp:BoundField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <asp:CheckBox ID="chkHeader" OnCheckedChanged="chkHeader_CheckedChanged" AutoPostBack="true" runat="server" />
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox ID="chkRow" runat="server" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>

                                                                    <asp:BoundField DataField="strPname" HeaderText="Page Name" SortExpression="strPname"></asp:BoundField>
                                                                    <asp:BoundField DataField="nPcode" HeaderText="Page Code" SortExpression="nPcode"></asp:BoundField>

                                                                </Columns>
                                                            </asp:GridView>

                                                            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nPid], [strPname], [nPcode] FROM [tbl_Page]"></asp:SqlDataSource>
                                                            
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
                                                        Update Group
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Group Name: </p>
                                                    <form id="Form2">
                                                        <fieldset>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtupGroupname" class="form-control" placeholder="Group Name" runat="server"></asp:TextBox>

                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtupGroupcode" class="form-control" placeholder="Group Code" runat="server"></asp:TextBox>

                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnupdatepage" runat="server" Text="Update" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnupdatepage_Click" />
                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </asp:View>
                            <asp:View ID="View4" runat="server">

                                <div class="space-30"></div>
                                <div id="Div1" class="table-responsive">
                                    <div class="widget-header header-color-blue">
                                        <h5 class="bigger lighter">
                                            <i class="icon-table"></i>

                                        </h5>

                                        <div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                            <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                        </div>
                                    </div>
                                    <%--  --%>
                                    <asp:Label Text="text" runat="server" ID="gid" Visible="false" />
                                    <asp:GridView ID="gvpages" EmptyDataText="No Data Found" class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="false" DataSourceID="DS">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strPname" HeaderText="Page Name" SortExpression="strPname"></asp:BoundField>

                                            <asp:BoundField DataField="nPcode" HeaderText="Page Code" SortExpression="nPcode" />

                                        </Columns>
                                    </asp:GridView>
                                    <%-- --%>

                                    <asp:SqlDataSource runat="server" ID="DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Page.strPname, tbl_Page.nPcode FROM tbl_Page INNER JOIN tbl_PageGroup ON tbl_Page.nPid = tbl_PageGroup.nPid WHERE (tbl_PageGroup.nGid = @gid)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="gid" Name="gid" DefaultValue="0" Type="String" />
                                            <%--<asp:Parameter Name="gid" DefaultValue="0" ></asp:Parameter>--%>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <div class="space-4"></div>

                                </div>
                            </asp:View>

                        </asp:MultiView>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <div class="loading" align="center">
                            Loading. Please wait.<br />
                            <br />
                            <img src="loader.gif" alt="" />
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
