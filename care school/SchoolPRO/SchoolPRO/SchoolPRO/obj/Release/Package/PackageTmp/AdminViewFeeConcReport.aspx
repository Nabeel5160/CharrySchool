<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewFeeConcReport.aspx.cs" Inherits="SchoolPRO.AdminViewFeeConcReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="row-fluid">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">

                        <asp:View ID="View2" runat="server">

                            <div class="">
                                <div class="col-xs-4 col-sm-4">
                                    <label class="block clearfix">
                                        <span class="block input-icon input-icon-right">
                                            <asp:DropDownList CssClass="form-control" AutoPostBack="true" ID="ddlclass" OnSelectedIndexChanged="ddlclass_SelectedIndexChanged" runat="server" AppendDataBoundItems="true" DataSourceID="ddlclassDS" DataTextField="strClass" DataValueField="nc_id">
                                                <asp:ListItem Value="0">--Please Select Class--</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource runat="server" ID="ddlclassDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nc_id, strClass FROM tbl_Class WHERE (bisDeleted = 'False') AND (nsch_id = @schid)">
                                                <SelectParameters>
                                                    <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </span>
                                    </label>
                                </div>
                                <div class="col-xs-4 col-sm-4">
                                    <label class="block clearfix">
                                        <span class="block input-icon input-icon-right">
                                            <asp:DropDownList AutoPostBack="True" CssClass="form-control" ID="ddlsc" runat="server" DataSourceID="ddlscDS" DataTextField="strSection" DataValueField="nsc_id">
                                                <asp:ListItem Value="0">--Please Select Section--</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource runat="server" ID="ddlscDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nsc_id, strSection FROM tbl_Section WHERE (bisDeleted = 'False') AND (nsch_id = @schid) AND (nc_id = @cid)">
                                                <SelectParameters>
                                                    <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                                    <asp:ControlParameter ControlID="ddlclass" PropertyName="SelectedValue" Name="cid"></asp:ControlParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </span>
                                    </label>
                                </div>
                                <div class="clearfix"></div>
                                <div id="printable">
                                    <div class="visible-print ">
                                    <h4 class="center text-center bigger lighter">
                                        <img src="assets/img/sch_logo.jpg" />
                                        Ozone School System
                                    </h4>

                                </div>
                                    <div class="widget-header  header-color-blue">
                                        <h5 class="bigger lighter">
                                            <i class="icon-table"></i>
                                            Concession Fee Report
                                        </h5>

                                        <div class="widget-toolbar widget-toolbar-light no-border">
                                            <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12">
                                        <div class="table-responsive">


                                            <asp:GridView ID="gv_detail_list" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="fEEREPORT">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="bRegisteredNum" HeaderText="Reg #" ReadOnly="True" SortExpression="bRegisteredNum"></asp:BoundField>
                                                    <asp:BoundField DataField="name" HeaderText="Student Name" ReadOnly="True" SortExpression="name"></asp:BoundField>
                                                    <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass"></asp:BoundField>
                                                    <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection"></asp:BoundField>
                                                    <asp:BoundField DataField="strTutionFee" HeaderText="Class Fee" SortExpression="strTutionFee"></asp:BoundField>
                                                    <asp:BoundField DataField="strConcTitle" HeaderText="Concession Title" SortExpression="strConcTitle" ReadOnly="True"></asp:BoundField>
                                                    <asp:BoundField DataField="nConcPer" HeaderText="Concession Amount" SortExpression="nConcPer"></asp:BoundField>
                                                    <asp:BoundField DataField="afterfeeconc" HeaderText="Fee After Conc" SortExpression="afterfeeconc" />
                                                    

                                                </Columns>
                                            </asp:GridView>
                                            <%-- <asp:GridView ID="gv_detail_list" CssClass=" table table-striped table-bordered table-hover" runat="server" DataSourceID="FeereportDS">
                                                    </asp:GridView>
                                                    <asp:SqlDataSource runat="server" ID="FeereportDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_RecieveFee.nChallanNum AS 'Challan #', CAST(tbl_Enrollment.bRegisteredNum AS varchar(MAX)) + ' ' + tbl_Enrollment.strStudentNum AS 'Reg #', tbl_Enrollment.strFname + ' ' + tbl_Enrollment.strLname AS 'Student Name', tbl_Users.strfname + ' ' + tbl_Users.strlname AS 'Guardian Name', tbl_Users.strPhone AS 'Guardian  Phone', tbl_Class.strClass AS Class, tbl_Section.strSection AS Section, tbl_RecieveFee.strFeeAmount AS 'Class Fee', tbl_RecieveFee.strFeeAmountReceived AS 'Recieved Fee', tbl_RecieveFee.strFeeAmountRemaining AS 'Remaining Fee', tbl_RecieveFee.strFeeConcession, tbl_RecieveFee.strFeeMonth FROM tbl_RecieveFee INNER JOIN tbl_Class ON tbl_RecieveFee.nc_id = tbl_Class.nc_id INNER JOIN tbl_Section ON tbl_RecieveFee.nsc_id = tbl_Section.nsc_id INNER JOIN tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id INNER JOIN tbl_Users ON tbl_Enrollment.nu_id = tbl_Users.nu_id WHERE (tbl_RecieveFee.bisDeleted = 'False') AND (tbl_RecieveFee.nsch_id = @schid) AND (DATEPART(mm, tbl_RecieveFee.strFeeMonth) = @month) AND (tbl_RecieveFee.strRecieveType = 'Class') AND (tbl_RecieveFee.nc_id = @cid) AND (tbl_RecieveFee.nsc_id = @sc) AND DATEPART(yyyy, tbl_RecieveFee.strFeeMonth) = DATEPART(yyyy, CONVERT(date,SYSDATETIME())">
                                                        <SelectParameters>
                                                            <asp:SessionParameter SessionField="nschoolid" Name="schid"></asp:SessionParameter>
                                                            <asp:ControlParameter ControlID="ddlmonth" PropertyName="SelectedValue" Name="month"></asp:ControlParameter>
                                                            <asp:ControlParameter ControlID="ddlclass" PropertyName="SelectedValue" Name="cid"></asp:ControlParameter>
                                                            <asp:ControlParameter ControlID="ddlsc" PropertyName="SelectedValue" Name="sc"></asp:ControlParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>--%>

                                            <asp:SqlDataSource runat="server" ID="fEEREPORT" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="select c.strConcTitle,c.nConcPer,e.strFname+''+e.strLname as name,e.bRegisteredNum,cl.strClass,sc.strSection,f.strTutionFee, ( cast(f.strTutionFee as int)-cast(c.nConcPer as int))  as afterfeeconc from tbl_Concession c inner join tbl_ConcessionStudent cn on c.nConc_id=cn.nConc_id inner join tbl_Enrollment e on cn.nStd_id=e.ne_id inner join tbl_Class cl on e.nc_id=cl.nc_id inner join tbl_Section sc on e.nsc_id=sc.nsc_id inner join tbl_Fee f on cl.nc_id=f.nc_id where e.bisDeleted='False' and e.nc_id=@cid and e.nsc_id=@sc">
                                                <SelectParameters>
                                                    <asp:SessionParameter SessionField="nschoolid" Name="schid" />

                                                    <asp:ControlParameter ControlID="ddlclass" PropertyName="SelectedValue" Name="cid" DefaultValue="0"></asp:ControlParameter>
                                                    <asp:ControlParameter ControlID="ddlsc" PropertyName="SelectedValue" Name="sc" DefaultValue="0"></asp:ControlParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
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
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
