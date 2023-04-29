 <%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherRateStudents.aspx.cs" Inherits="SchoolPRO.TeacherRateStudents" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .ratingEmpty {
            background-image: url(assets/images/ratingStarEmpty.gif);
            height: 18px;
            width: 18px;
        }

        .ratingFilled {
            background-image: url(assets/images/ratingStarFilled.gif);
            height: 18px;
            width: 18px;
        }

        .ratingSaved {
            background-image: url(assets/images/ratingStarSaved.gif);
            height: 18px;
            width: 18px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScript" runat="server" />

    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Search By Name
            </h4>
            <div class="space-6"></div>
            <asp:UpdatePanel ID="upquiz" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvquiz" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="hidden width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                            <div class="table-responsive">
                                <asp:GridView ID="gvsearchsub" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" OnRowCommand="gvsearchsub_RowCommand" DataKeyNames="nrtng_id" EnableViewState="true">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nrtng_id" HeaderText="S.NO" SortExpression="nrtng" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:TextBox ID="txtcc" placeholder="Search..." runat="server" class="nav-search-input" Width="210"></asp:TextBox>
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CommandName="Search" />
                                            </HeaderTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcname" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strLname" SortExpression="strLname" HeaderText="Last Name" />
                                        <asp:BoundField DataField="strSubject" SortExpression="strSubject" HeaderText="Subject" />
                                        <asp:BoundField DataField="strPoints" SortExpression="strPoints" HeaderText="Obt Points" />
                                        <asp:BoundField DataField="strOutOf" SortExpression="strOutOf" HeaderText="Total Points" />
                                        <asp:BoundField DataField="strRemarks" SortExpression="strRemarks" HeaderText="Remarks" />

<%--                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnedit" runat="server" Text="Edit" class="width-85 pull-left btn btn-sm btn-success" OnClick="btnedit_Click" />
                                            </ItemTemplate>
                                        <%--</asp:TemplateField>--%>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btndel" runat="server" Text="Delete" class="width-85 pull-left btn btn-sm btn-success" OnClick="btndel_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <div class="space-4"></div>

                            </div>
                        </asp:View>
                        <asp:View ID="View2" runat="server">

                            <div class="col-xs-8 col-sm-6 widget-container-span">

                                <div class="login-container">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Add Student Rating
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Enter details according to their Performance: </p>
                                                <form id="freg">
                                                    <fieldset>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtrnum" placeholder="Student Num" CssClass="hidden form-actions" runat="server"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter Student Num" ControlToValidate="txtrnum" runat="server" />
                                                                <asp:RegularExpressionValidator ForeColor="Red" Font-Bold="true" ID="RegularExpressionValidator1" runat="server" ErrorMessage="Only Digits(0-9)" ControlToValidate="txtrnum" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtstname" placeholder="Student Name" ReadOnly="true" CssClass="form-actions" runat="server"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" Font-Bold="true" ErrorMessage="Student Name" ControlToValidate="txtstname" runat="server" />
                                                                <asp:RegularExpressionValidator ForeColor="Red" Font-Bold="true" ID="RegularExpressionValidator2" runat="server" ErrorMessage="You Can only Enter Alphabets" ControlToValidate="txtstname" ValidationExpression="[0-9a-zA-Z-_. ()]+"></asp:RegularExpressionValidator>
                                                            </span>
                                                        </label>

                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddcc" runat="server" DataSourceID="sqlsub" DataTextField="strSubject" DataValueField="nsbj_id"></asp:DropDownList>

                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtoutof" placeholder="Rate Out of" CssClass="hidden form-actions" runat="server"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" Font-Bold="true" ErrorMessage="Rate Out of" ControlToValidate="txtoutof" runat="server" />
                                                                <asp:RegularExpressionValidator ForeColor="Red" Font-Bold="true" ID="RegularExpressionValidator3" runat="server" ErrorMessage="Only Digits(0-9)" ControlToValidate="txtoutof" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <div>
                                                                    <asp:UpdatePanel ID="pnlRating" runat="server">
                                                                        <ContentTemplate>
                                                                            <table>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Rating ID="RatingControl" OnChanged="RatingControlChanged" AutoPostBack="true" StarCssClass="ratingEmpty" WaitingStarCssClass="ratingSaved" EmptyStarCssClass="ratingEmpty" FilledStarCssClass="ratingFilled" runat="server"></asp:Rating>

                                                                                    </td>
                                                                                </tr>
                                                                            </table>

                                                                        </ContentTemplate>
                                                                    </asp:UpdatePanel>
                                                                </div>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtrate" placeholder="Rate" CssClass="hidden form-actions" runat="server"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter Rate" ControlToValidate="txtrate" runat="server" />
                                                                <asp:RegularExpressionValidator ForeColor="Red" Font-Bold="true" ID="RegularExpressionValidator4" runat="server" ErrorMessage="Only Digits(0-9)" ControlToValidate="txtrate" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtremarks" TextMode="MultiLine" placeholder="Remarks" CssClass="hidden form-actions" runat="server"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter Remarks" ControlToValidate="txtremarks" runat="server" />
                                                                
                                                            </span>
                                                        </label>
                                                        <div class="space-24"></div>

                                                        <div class="clearfix">
                                                            <asp:Button ID="btnrate" runat="server" Text="Add" class="hidden width-65 pull-right btn btn-sm btn-success" OnClick="btnrate_Click" />
                                                        </div>
                                                    </fieldset>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 widget-container-span">
                                <div class="widget-box">
                                    <div class="widget-header header-color-blue">
                                        <h5 class="bigger lighter">
                                            <i class="icon-table"></i>
                                            Rating
                                        </h5>


                                    </div>

                                    <div class="widget-body">
                                        <div class="widget-main no-padding">
                                            <table class="table table-striped table-bordered table-hover">
                                                <thead class="thin-border-bottom">
                                                    <tr>
                                                        <th>
                                                            <i class="icon-animated-bell"></i>
                                                            Excellent
                                                        </th>
                                                        <th>
                                                            <i class="icon-animated-bell"></i>
                                                            Good
                                                        </th>
                                                        <th>
                                                            <i class="icon-animated-bell"></i>
                                                            Fair
                                                        </th>
                                                        <th>
                                                            <i class="icon-animated-bell"></i>
                                                            Average
                                                        </th>
                                                        <th>
                                                            <i class="icon-animated-bell"></i>
                                                            Poor
                                                        </th>
                                                    </tr>
                                                </thead>

                                                <tbody>
                                                    <tr>
                                                        <td class="">5 Star</td>

                                                        <td>4 Star
                                                        </td>

                                                        <td>3 Star
                                                        </td>
                                                        <td>2 Star
                                                        </td>
                                                        <td>1 Star
                                                        </td>
                                                    </tr>


                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /span -->
                            <asp:SqlDataSource ID="sqlsub" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT sb.strSubject, sb.nsbj_id FROM tbl_TeacherSubject AS t INNER JOIN tbl_Subject AS sb ON t.nsbj_id = sb.nsbj_id WHERE (t.nu_id = @uid) AND (t.bisDeleted = 'False') AND (t.nsch_id = @schid) AND (t.nc_id = @cid)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="uid" SessionField="uid" />
                                    <asp:SessionParameter SessionField="nschoolid" Name="schid" />
                                    <asp:SessionParameter SessionField="nncciidd" Name="cid"></asp:SessionParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </asp:View>
                        <asp:View ID="View3" runat="server">
                            <div class="login-container">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Update here
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Enter details according to their Performance: </p>
                                                <form id="Form2">
                                                    <fieldset>
                                                        <p>Topic: </p>
                                                        <asp:Label ID="lbltopic" runat="server"></asp:Label>
                                                        <%--<label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtenum" placeholder="Student Num" CssClass="form-actions" runat="server" AutoPostBack="true" OnTextChanged="txtenum_TextChanged"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>--%>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtename" placeholder="Student Name" ReadOnly="true" CssClass="form-actions" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddesub" runat="server" DataSourceID="sqlsub" DataTextField="strSubject" DataValueField="nsbj_id"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txteout" placeholder="Rate Out of" CssClass="form-actions" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txterate" placeholder="Rate" CssClass="form-actions" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txterem" TextMode="MultiLine" placeholder="Remarks" CssClass="form-actions" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
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
</asp:Content>
