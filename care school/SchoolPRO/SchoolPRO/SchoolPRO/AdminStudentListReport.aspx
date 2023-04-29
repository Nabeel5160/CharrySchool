<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminStudentListReport.aspx.cs" Inherits="SchoolPRO.AdminStudentListReport" %>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <asp:ScriptManager runat="server" />
            <div class="row-fluid">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">
                            <asp:View runat="server">
                                <asp:GridView ID="gvstlist" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataKeyNames="nc_id" DataSourceID="sqlstlist">
                                    <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nc_id" HeaderText="S.NO" SortExpression="nc_id" />
                                        <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                        <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnview" runat="server" CssClass="btn btn-sm btn-success"  Text="View" OnClick="btnview_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sqlstlist" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Class.nc_id, tbl_Class.strClass, tbl_Section.strSection FROM tbl_Class INNER JOIN tbl_Section ON tbl_Class.nc_id = tbl_Section.nc_id WHERE (tbl_Class.nsch_id = @sch_id) and tbl_Class.bisDeleted=0">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="sch_id" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:View>
                            <asp:View runat="server">
                                <div class="col-xs-12 col-sm-12 widget-container-span">
                                    <div class="widget-box" id="printable">
                                         <%--<div  class="col-xs-2 col-sm-2">
                                             <asp:Image ImageUrl="~/assets/img/sch_logo.jpg" ID="imgschlogo" runat="server" />
                                             </div>--%>
                                        <div  class="col-lg-offset-2 col-xs-offset-2 col-sm-offset-2">
                                            <h1  class="bigger lighter">
                                                <asp:Label Text="" id="lblschname" runat="server" /><br />
                                                <asp:Label Text="" ID="lblschadrs" runat="server" />
                                                </h1>
                                        </div>
                                        <div class="clearfix"></div>
                                        <div class="widget-header header-color-blue">
												<h5 class="bigger lighter">
													<i class="icon-table"></i>
													Students List Report
												</h5>

												<div class="widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x hidden-print" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                        <div class="space-12"></div>
                                        <div class="clearfix"></div>
                                        <div class="widget-body">
                                            
												<div class="widget-main no-padding">
                                                    <div class="widget-header header-color-blue">
                                                    <h5 class="bigger lighter">
                                                Gender: Male (<u><asp:Label Text="" ID="lblmalecount" runat="server" /></u>)
                                                </h5>
                                                        </div>
                                                    <asp:GridView ID="gvmalelist" OnRowDataBound="gvmalelist_RowDataBound" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sqlmalelist">
                                    <Columns>
                                        <asp:BoundField DataField="bRegisteredNum" HeaderText="Admn #" SortExpression="bRegisteredNum" />
                                        <asp:BoundField DataField="stname" HeaderText="Student Name" SortExpression="stname" />
                                        <asp:BoundField DataField="gname" HeaderText="Gaurdian Name" SortExpression="gname" />
                                        <asp:BoundField DataField="strCell" HeaderText="Cell #" SortExpression="strCell" />
                                        <asp:BoundField DataField="strDOB" HeaderText="DOB" SortExpression="strDOB" />
                                        
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sqlmalelist" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="select e.strDOB,e.bRegisteredNum,e.strFname+' '+e.strLname as stname,u.strfname+' '+u.strlname as gname,u.strCell from tbl_Enrollment e inner join tbl_Users u on e.nu_id=u.nu_id where e.strGender='Male' and e.nc_id=@val and e.nsc_id=(select nsc_id from tbl_Section where strSection=@secs and nc_id=@val and bisDeleted='False' and nsch_id=@schid1) and e.bisDeleted='False' and e.nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                        <asp:SessionParameter Name="schid1" SessionField="nschoolid" />
                                        <asp:SessionParameter Name="sch_id" SessionField="nschoolid" />
                                        <asp:SessionParameter Name="secs" SessionField="secs" />
                                        <asp:SessionParameter Name="val" SessionField="val" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
												</div>
                                            <div class="space-12"></div>
                                            <div class="clearfix"></div>
                                            <div class="widget-main no-padding">
                                                <div class="widget-header header-color-blue">
                                                    <h5 class="bigger lighter">
                                                Gender: Female (<u><asp:Label ID="lblfemcount" Text="lblmalecount" runat="server" /></u>)
                                                </h5>
                                                        </div>
                                                    <asp:GridView ID="gvfemalelist" OnRowDataBound="gvfemalelist_RowDataBound" CssClass=" table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="sqlfemalelist">
                                    <Columns>
                                        <asp:BoundField DataField="bRegisteredNum" HeaderText="Admn #" SortExpression="bRegisteredNum" />
                                        <asp:BoundField DataField="stname" HeaderText="Student Name" SortExpression="stname" />
                                        <asp:BoundField DataField="gname" HeaderText="Gaurdian Name" SortExpression="gname" />
                                        <asp:BoundField DataField="strCell" HeaderText="Cell #" SortExpression="strCell" />
                                        <asp:BoundField DataField="strDOB" HeaderText="DOB" SortExpression="strDOB" />
                                        
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sqlfemalelist" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="select e.strDOB,e.bRegisteredNum,e.strFname+' '+e.strLname as stname,u.strfname+' '+u.strlname as gname,u.strCell from tbl_Enrollment e inner join tbl_Users u on e.nu_id=u.nu_id where e.strGender='Female' and e.nc_id=@val and e.nsc_id=(select nsc_id from tbl_Section where strSection=@secs and nc_id=@val and bisDeleted='False' and nsch_id=@schid1) and e.bisDeleted='False' and e.nsch_id=@schid">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                        <asp:SessionParameter Name="schid1" SessionField="nschoolid" />
                                        <asp:SessionParameter Name="sch_id" SessionField="nschoolid" />
                                        <asp:SessionParameter Name="secs" SessionField="secs" />
                                        <asp:SessionParameter Name="val" SessionField="val" />
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
            </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
