<%@ Page Title="" Language="C#" MasterPageFile="~/Student.Master" AutoEventWireup="true" CodeBehind="StudentViewTeacher.aspx.cs" Inherits="SchoolPRO.StudentViewTeacher" %>
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
    <script>
        function printDiv(printable) {
            var printContents = document.getElementById(printable).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lbluval" runat="server" Text="Label" Visible="false"></asp:Label>
    <asp:Label ID="lbluemail" runat="server" Text="Label" Visible="false"></asp:Label>
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
        
        <div class="row-fluid">
            <asp:UpdatePanel ID="upt" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">

                        <asp:View runat="server" ID="v2">
                            <%--<asp:Button ID="btnBack" runat="server" Text="Back" class="width-95 pull-left btn btn-sm btn-success" OnClick="btnBack_Click" />--%>
                            <div class="table-responsive">
                                <asp:GridView ID="gvteacher" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="teacherDs">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="tname" HeaderText="Teacher Name" ReadOnly="True" SortExpression="tname"></asp:BoundField>
                                        <asp:BoundField DataField="strPhone" HeaderText="Teacher Phone" SortExpression="strPhone"></asp:BoundField>
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass"></asp:BoundField>
                                        <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection"></asp:BoundField>
                                        <asp:BoundField DataField="strSubject" HeaderText="Subject" SortExpression="strSubject"></asp:BoundField>
                                        <asp:BoundField DataField="strPeriod" HeaderText="Period" SortExpression="strPeriod"></asp:BoundField>
                                        <asp:BoundField DataField="strDay" HeaderText="Day" SortExpression="strDay"></asp:BoundField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nu_id" SortExpression="ne_id" HeaderText="S.NO" />
                                         <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnratingt" runat="server" OnClick="btnratingt_Click" Text="Rating Teacher" class="width-85 pull-left btn btn-sm btn-success"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnleavereq" runat="server" OnClick="btnleavereq_Click" Text="Leave Request" class="width-85 pull-left btn btn-sm btn-success"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>

                                <asp:SqlDataSource ID="teacherDs" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Users.nu_id,tbl_Users.strfname + ' ' + tbl_Users.strlname AS tname, tbl_Users.strPhone, tbl_Class.strClass, tbl_Section.strSection, tbl_Subject.strSubject,tbl_TimeTable.strPeriod,tbl_TimeTable.strDay FROM tbl_Users INNER JOIN tbl_TimeTable ON tbl_Users.nu_id = tbl_TimeTable.nu_id INNER JOIN tbl_Subject ON tbl_TimeTable.nsbj_id = tbl_Subject.nsbj_id INNER JOIN tbl_Class ON tbl_TimeTable.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_TimeTable.nsc_id = tbl_Section.nsc_id WHERE (tbl_TimeTable.nc_id = @cid) AND (tbl_TimeTable.nsc_id = @scid) And tbl_TimeTable.bisDeleted='False' and tbl_TimeTable.nsch_id=@schid ">
                                    <SelectParameters>
                                        <asp:Parameter Name="cid" DefaultValue="0"></asp:Parameter>
                                        <asp:Parameter Name="scid" DefaultValue="0"></asp:Parameter>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

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
                                                    Add Teacher Rating
                                                </h4>

                                                <div class="space-6"></div>
                                                <p>Enter details according to their Performance: </p>
                                                <form id="freg">
                                                    <fieldset>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList CssClass="input-medium" ID="ddcc" runat="server" DataSourceID="DSTeacher" DataTextField="name" DataValueField="nu_id"></asp:DropDownList>
                                                                <asp:SqlDataSource runat="server" ID="DSTeacher" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nu_id, strfname + ' ' + strlname AS name FROM tbl_Users WHERE (nLevel = 2) AND (bisDeleted = @fbit) AND (nsch_id = @schid) AND (nu_id = @tech)">
                                                                    <SelectParameters>
                                                                        <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                                                        <asp:SessionParameter SessionField="nschoolid" Name="schid" />
                                                                        <asp:SessionParameter SessionField="techid2" DefaultValue="0" Name="tech"></asp:SessionParameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
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
                                                                                        <asp:Rating ID="RatingControl" OnChanged="RatingControl_Changed" AutoPostBack="true" StarCssClass="ratingEmpty" WaitingStarCssClass="ratingSaved" EmptyStarCssClass="ratingEmpty" FilledStarCssClass="ratingFilled" runat="server"></asp:Rating>

                                                                                    </td>
                                                                                </tr>
                                                                            </table>

                                                                        </ContentTemplate>
                                                                    </asp:UpdatePanel>
                                                                </div>
                                                            </span>
                                                        </label>
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

</asp:Content>
