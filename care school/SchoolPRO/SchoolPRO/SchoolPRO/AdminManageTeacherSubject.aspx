<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageTeacherSubject.aspx.cs" Inherits="SchoolPRO.AdminManageTeacherSubject" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                
                                <div class="clearfix"></div>
                                <div class="space-12"></div>
                                <div class="col-lg-3">
                                    <asp:TextBox ID="txtcc" placeholder="Search by Name..." runat="server" class="nav-search-input" Width="210" OnTextChanged="txtcc_TextChanged" AutoPostBack="true"></asp:TextBox>
                                </div>
                                <div class="table-responsive">
                                    <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true"  EnableViewState="true" OnPageIndexChanging="gvsearchclass_PageIndexChanging">
                                        <Columns><asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ntsbj_id" SortExpression="ntsbj_id" HeaderText="S.NO" />
                                            
                                            <asp:TemplateField HeaderText="Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("strfname") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                            <asp:BoundField DataField="strSubject" HeaderText="Subject" SortExpression="strSubject" />
                                            <asp:TemplateField>
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
                                                            <asp:DropDownList ID="ddsbj" CssClass="input-medium" runat="server" DataSourceID="sqlsbj" DataTextField="strSubject" DataValueField="nsbj_id"></asp:DropDownList>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:DropDownList ID="ddtchr" CssClass="input-medium" runat="server" DataSourceID="sqltch" DataTextField="strfname" DataValueField="nu_id"></asp:DropDownList>
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
  
    <asp:SqlDataSource ID="sqlclass" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strClass],[nc_id] FROM [tbl_Class] where bisDeleted='False' and nsch_id=@schid">
        <SelectParameters>
            <asp:SessionParameter Name="schid" SessionField="nschoolid" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqltch" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT strfname + ' ' + strlname AS name, nu_id FROM tbl_Users WHERE (nLevel = '2') AND (bisDeleted = 'False') and nsch_id=@schid">
        <SelectParameters>
            <asp:SessionParameter Name="schid" SessionField="nschoolid" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlsbj" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strSubject],[nsbj_id] FROM [tbl_Subject] WHERE [nc_id]=@cname  and bisDeleted='False'and nsch_id=@schid">
        <SelectParameters>
            <asp:SessionParameter Name="schid" SessionField="nschoolid" />

              <asp:ControlParameter ControlID="ddcl" PropertyName="SelectedValue" Name="cname" Type="String" />
              
          </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>
