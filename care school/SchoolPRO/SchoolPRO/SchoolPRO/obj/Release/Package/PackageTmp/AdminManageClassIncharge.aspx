<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageClassIncharge.aspx.cs" Inherits="SchoolPRO.AdminManageClassIncharge" %>
<%@ Import Namespace="SchoolPRO" %>
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
                                 
								<div class="row-fluid">
                                    <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upt" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <div class="col-lg-12">
                    <h5 style="color:red">Instruction</h5>
            <ul>
                <li>Add Class Teacher From here By Selecting Class ,Section and The Teacher Which you want to make class incharge</li>
            
            </ul>
                </div>
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                <asp:Button ID="btnChange" runat="server" Text="Interchange Sections Incharge " class="width-10 pull-left btn btn-sm btn-success" OnClick="btnChange_Click" />
                                <asp:Button ID="btnRemoveAndAssign" runat="server" Text="Change" class="width-10 pull-left btn btn-sm btn-success" OnClick="btnRemoveAndAssign_Click" />
                                <div class="clearfix"></div>
                                <div class="space-12"></div>
                                <div class="col-lg-3">
                                    <asp:TextBox ID="txtcc" placeholder="Search by Name..." runat="server" class="nav-search-input" Width="210" OnTextChanged="txtcc_TextChanged" AutoPostBack="true"></asp:TextBox>
                                </div>
                                <div class="space-30"></div>
                                <div class="space-30"></div>
                                <div id="printable" class="table-responsive">
                                    <div class="widget-header header-color-blue">
												<h5  class="bigger lighter">
													<i class="icon-table"></i>Class Incharge List
												</h5>

												<div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                                    <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
												</div>
											</div>
                                    <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server"  AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true"  EnableViewState="true">
                                        <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nclt_id" SortExpression="nclt_id" HeaderText="S.NO" />
                                           
                                            <asp:TemplateField HeaderText="Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                            <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                            <asp:TemplateField ItemStyle-CssClass="hidden-print" HeaderStyle-CssClass="hidden-print">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnshow" runat="server" Text="Delete" class="width-80 pull-left btn btn-sm btn-success" OnClick="btnshow_Click" />
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
                                                Manage Teacher's Classes
                                            </h4>

                                            <div class="space-6"></div>
                                            <p>Enter details of their Classes: </p>
                                        <form id="freg">
                                                <fieldset>

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddcl" CssClass="input-medium" runat="server" DataSourceID="sqlclass" DataTextField="strClass" DataValueField="nc_id" AutoPostBack="true" EnableViewState="true" ViewStateMode="Enabled"></asp:DropDownList>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddsec" CssClass="input-medium" runat="server" DataSourceID="sqlsec" DataTextField="strSection" DataValueField="nsc_id"></asp:DropDownList>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddtchr" CssClass="input-medium" runat="server" DataSourceID="sqltch" DataTextField="name" DataValueField="nu_id"></asp:DropDownList>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <div class="space-24"></div>

                                                    <div class="clearfix">
                                                        <asp:Button ID="btngoback" runat="server" Text="View" class="width-30 pull-left btn btn-sm " OnClick="btngoback_Click" />
                                                        
                                                        <asp:Button ID="btnadd" runat="server" Text="Submit" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnadd_Click" />
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
                                                Change Class Incharger
                                            </h4>

                                            <div class="space-6"></div>
                                            <p>Interchanging Class Incharges</p>
                                        <form id="Form1">
                                                <fieldset>
                                                    <p>Select Class Incharge To Change : </p>
                                                    <%--<label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddlclass" CssClass="input-medium" runat="server" DataSourceID="sqlClassDS" DataTextField="strClass" DataValueField="nc_id" AutoPostBack="true" ViewStateMode="Enabled"></asp:DropDownList>
                                                            <asp:SqlDataSource runat="server" ID="sqlClassDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Class.strClass, tbl_Class.nc_id FROM tbl_Class INNER JOIN tbl_ClassIncharge ON tbl_Class.nc_id = tbl_ClassIncharge.nc_id WHERE (tbl_Class.bisDeleted = 0) AND (tbl_Class.nsch_id = @schid)">
                                                                <SelectParameters>
                                                                   
                                                                    <asp:SessionParameter SessionField="nschoolid" Name="schid" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>

                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddlsec" CssClass="input-medium" runat="server" DataSourceID="sqlsecDS" DataTextField="strSection" DataValueField="nsc_id"></asp:DropDownList>
                                                            <asp:SqlDataSource runat="server" ID="sqlsecDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nsc_id, strSection FROM tbl_Section WHERE (bisDeleted = 0) AND (nc_id = @cid)">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter ControlID="ddlclass" PropertyName="SelectedValue" DefaultValue="0" Name="cid"></asp:ControlParameter>
                                                                
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    --%>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddltch" CssClass="input-medium" runat="server"  DataTextField="name" DataValueField="nu_id"  AutoPostBack="true" OnSelectedIndexChanged="ddltch_SelectedIndexChanged1" AppendDataBoundItems="True"></asp:DropDownList>
                                                            <asp:SqlDataSource runat="server" ID="sqltchDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT tbl_Users.nu_id, tbl_Users.strfname + ' ' + tbl_Users.strlname AS name FROM tbl_Users INNER JOIN tbl_ClassIncharge ON tbl_Users.nu_id = tbl_ClassIncharge.nu_id WHERE (tbl_Users.bisDeleted = 0) AND (tbl_Users.nLevel = 2) AND (tbl_Users.nsch_id = @schid) and tbl_ClassIncharge.bisDeleted = 0">

                                                                <SelectParameters>

                                                                    <asp:SessionParameter SessionField="nschoolid" Name="schid" DefaultValue="0" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtclassnm" runat="server" ></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtsecnm" runat="server" ></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <div class="space-24"></div>
                                                    <p>Select Class Incharge To Change with : </p>
                                                    <%--<label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddlclass2" CssClass="input-medium" runat="server" DataSourceID="sqlClassDS" DataTextField="strClass" DataValueField="nc_id" AutoPostBack="true" ViewStateMode="Enabled"></asp:DropDownList>
                                                            

                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddlsec2" CssClass="input-medium" runat="server" DataSourceID="sqlsec2DS" DataTextField="strSection" DataValueField="nsc_id"></asp:DropDownList>
                                                            <asp:SqlDataSource runat="server" ID="sqlsec2DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nsc_id, strSection FROM tbl_Section WHERE (bisDeleted = 0) AND (nc_id = @cid)">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter ControlID="ddlclass2" PropertyName="SelectedValue" DefaultValue="0" Name="cid"></asp:ControlParameter>
                                                                    
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    --%>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddltch2" CssClass="input-medium" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddltch2_SelectedIndexChanged" DataTextField="name" DataValueField="nu_id" AppendDataBoundItems="True">

                                                            </asp:DropDownList>
                                                            
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtclassnm2" runat="server" ></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtsecnm2" runat="server" ></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <div class="space-24"></div>

                                                    <div class="clearfix">
                                                        <%--<asp:Button ID="Button1" runat="server" Text="View" class="width-30 pull-left btn btn-sm " OnClick="btngoback_Click" />--%>
                                                        
                                                        <asp:Button ID="btnChangeIncharge" runat="server" Text="Change" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnChangeIncharge_Click" />
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
									<div class="login-container">
                            <div class="position-relative">
                                <div class="no-border">
                                    <div class="widget-body">
									<div class="widget-main">
                                            <h4 class="header green lighter bigger">
                                                <i class="icon-group blue"></i>
                                                Change Class Incharger
                                            </h4>

                                            <div class="space-6"></div>
                                            <p>Change Class Incharge</p>
                                        <form id="Form2">
                                                <fieldset>
                                                    <p>Select Class Incharge To Change : </p>
                                                    
                                                    
                                                   <%--<label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddlclass2" CssClass="input-medium" runat="server" DataSourceID="sqlClassDS" DataTextField="strClass" DataValueField="nc_id" AutoPostBack="true" ViewStateMode="Enabled"></asp:DropDownList>
                                                            

                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddlsec2" CssClass="input-medium" runat="server" DataSourceID="sqlsec2DS" DataTextField="strSection" DataValueField="nsc_id"></asp:DropDownList>
                                                            <asp:SqlDataSource runat="server" ID="sqlsec2DS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nsc_id, strSection FROM tbl_Section WHERE (bisDeleted = 0) AND (nc_id = @cid)">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter ControlID="ddlclass2" PropertyName="SelectedValue" DefaultValue="0" Name="cid"></asp:ControlParameter>
                                                                    
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    --%>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddltch3" OnSelectedIndexChanged="ddltch3_SelectedIndexChanged" CssClass="input-medium" runat="server" AutoPostBack="true" DataTextField="name" DataValueField="nu_id" AppendDataBoundItems="True" >
                                                            </asp:DropDownList>

                                                            
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtclassnm3" Enabled="false" runat="server" ></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtsecnm3" Enabled="false" runat="server" ></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <div class="space-24"></div>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddltch4" CssClass="input-medium" runat="server"  DataTextField="name" DataValueField="nu_id"  AutoPostBack="true" OnSelectedIndexChanged="ddltch4_SelectedIndexChanged" AppendDataBoundItems="True"></asp:DropDownList>
                                                                                                                        <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <div class="clearfix">
                                                        <%--<asp:Button ID="Button1" runat="server" Text="View" class="width-30 pull-left btn btn-sm " OnClick="btngoback_Click" />--%>
                                                        
                                                        <asp:Button ID="btnRemoveaandChangeIncharge" runat="server" Text="Change" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnRemoveaandChangeIncharge_Click" />
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
								</div><!-- PAGE CONTENT ENDS -->
							
         
            
</div>
            
						</div>
  
    <asp:SqlDataSource ID="sqlclass" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strClass],nc_id FROM [tbl_Class] where bisDeleted='False' and nsch_id=@nschid">
        <SelectParameters>
            <asp:SessionParameter Name="nschid" SessionField="nschoolid" />
        </SelectParameters>
    </asp:SqlDataSource>
      <asp:SqlDataSource ID="sqltch" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strfname]+' '+[strlname] as name,nu_id FROM [tbl_Users] WHERE ([nLevel] = @u_level) and bisDeleted='False' and nsch_id=@nschid">
          <SelectParameters>
              <asp:Parameter DefaultValue="2" Name="u_level" Type="Int32" />
              <asp:SessionParameter Name="nschid" SessionField="nschoolid" />
          </SelectParameters>
    </asp:SqlDataSource>
      <asp:SqlDataSource ID="sqlsec" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strSection],nsc_id FROM [tbl_Section] WHERE ([nc_id] = @cname ) and bisDeleted='False' and nsch_id=@nschid">
          <SelectParameters>
              <asp:ControlParameter ControlID="ddcl" PropertyName="SelectedValue" Name="cname" Type="String" />
              <asp:SessionParameter Name="nschid" SessionField="nschoolid" />
          </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>
