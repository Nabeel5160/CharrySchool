<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageSection.aspx.cs" Inherits="SchoolPRO.AdminManageSection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function printDiv(printable) {
            var printContents = document.getElementById(printable).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
       
    </script>
    <script>
        function ismaxlength(objTxtCtrl, nLength) {
            //if (objTxtCtrl.getAttribute && objTxtCtrl.value.length > nLength)
            //    objTxtCtrl.value = objTxtCtrl.value.substring(0, nLength)

            //if (document.all)
            //    document.getElementById('lblCaption').innerText = objTxtCtrl.value.length + ' Out Of ' + nLength;
            //else
            //    document.getElementById('lblCaption').textContent = objTxtCtrl.value.length + ' Out Of ' + nLength;
            document.getElementById('lblCaption').style.display = "none";
            document.getElementById('lblCaption').innerText = "You Are Exceeding the Size Limit";


            if (objTxtCtrl.value.length > nLength) {
                document.getElementById('lblCaption').style.display = "block";
                document.getElementById('lblCaption').style.color = "red";
                objTxtCtrl.value = objTxtCtrl.value.substring(0, nLength);
            }
            else
                document.getElementById('lblCaption').style.display = "none";

        }
        $(function () {
            $("#ContentPlaceHolder1_gvsearchsub").dataTable();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
             <div class="col-lg-12">
                    <h5 style="color:red">Instruction</h5>
            <ul>
                <li>Add Section Name and Select the Class of which you want to make the section </li>
            </ul>
                </div>
            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    Manage Section
                </h4>
                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upsub" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvsub" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                <div class="space-30"></div>
                                <div id="printable" class="table-responsive">
                                    <div class="widget-header header-color-blue">
                                        <h5 class="bigger lighter">
                                            <i class="icon-table"></i>
                                            Class Sections List
                                        </h5>

                                        <div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                            <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                        </div>
                                    </div>
                                    <asp:GridView ID="gvsearchsub" EmptyDataText="No Record Exist" class="table table-striped table-bordered table-hover" runat="server" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" DataKeyNames="nsc_id" EnableViewState="true" >
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nsc_id" HeaderText="S.NO" SortExpression="nsc_id" />
                                            <asp:BoundField DataField="strSection" SortExpression="strSection" HeaderText="Section" />
                                            <asp:BoundField DataField="strClass" SortExpression="strClass" HeaderText="Class" />
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nc_id" HeaderText="S.NO" SortExpression="nc_id" />
                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print">
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
                                                        Manage Section
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter details of Section according to their Classes: </p>
                                                    <form id="freg">
                                                        <fieldset>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddcl" runat="server" DataSourceID="sqlclass" DataTextField="strClass" DataValueField="nc_id"></asp:DropDownList>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtsec" class="form-control" placeholder="Section" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" ErrorMessage="Enter Section" ControlToValidate="txtsec"></asp:RequiredFieldValidator>

                                                                </span>
                                                            </label>

                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnsub" runat="server" Text="Add Section" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnsub_Click" />
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
                                                        Manage Section
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter details of Subject according to their Classes: </p>
                                                    <form id="Form2">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList Enabled="false" ID="ddecl" runat="server" DataSourceID="sqlclass" DataTextField="strClass" DataValueField="nc_id"></asp:DropDownList>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtsbj" class="form-control" placeholder="Section" runat="server"></asp:TextBox>

                                                                </span>
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
            <!-- PAGE CONTENT ENDS -->
        </div>
        <!-- /.col -->
    </div>

    <asp:SqlDataSource ID="sqlclass" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strClass],[nc_id] FROM [tbl_Class] where bisDeleted='False' and nsch_id=@nschid">
        <SelectParameters>
            <asp:SessionParameter Name="nschid" SessionField="nschoolid" />
        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>
