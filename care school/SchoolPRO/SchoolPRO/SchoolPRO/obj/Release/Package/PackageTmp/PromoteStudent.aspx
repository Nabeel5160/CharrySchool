<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="PromoteStudent.aspx.cs" Inherits="SchoolPRO.PromoteStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <div class="row-fluid">

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvstlist" ActiveViewIndex="0" runat="server">

                            <asp:View ID="View2" runat="server">
                                <div class="col-xs-12 col-sm-12 widget-container-span">
                                    <div class="widget-box">
                                        <div class="widget-header header-color-blue">
                                            <h5 class=" bigger lighter">
                                                <i class="icon-table"></i>
                                                Promote Student
                                            </h5>

                                            <div class="widget-toolbar widget-toolbar-light no-border">
                                                <div class="hidden-print icon-print icon-2x" onclick="printDiv('printable')"></div>
                                            </div>
                                        </div>
                                        <div class="widget-body">
                                            <div class="widget-main no-padding">
                                                <div class="clearfix"></div>
                                                <div class="hidden-print space-4"></div>

                                                
                                                <div class=" hidden-print col-lg-3">
                                                   <asp:Label ID="Label1" runat="server" Text="From Class : "></asp:Label>
                                                    
                                                    <asp:DropDownList AutoPostBack="true" runat="server" ID="ddcl" AppendDataBoundItems="true" OnSelectedIndexChanged="ddcl_SelectedIndexChanged">
                                                        <asp:ListItem Text="<---Select Class--->" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>

                                                <div class="hidden-print col-lg-3">
                                                    <asp:Label ID="Label2" runat="server" Text="From Section : "></asp:Label>
                                                    <asp:DropDownList AutoPostBack="true" runat="server" ID="ddsec" AppendDataBoundItems="true" OnSelectedIndexChanged="ddsec_SelectedIndexChanged">
                                                        <asp:ListItem Text="<---Select Section--->" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class=" hidden-print col-lg-3">
                                                   <asp:Label ID="Label4" runat="server" Text= "To Class : "></asp:Label>
                                                    
                                                    <asp:DropDownList AutoPostBack="true" runat="server" ID="ddltoclass" AppendDataBoundItems="true" OnSelectedIndexChanged="ddltoclass_SelectedIndexChanged">
                                                        <asp:ListItem Text="<---Select Class--->" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>

                                                <div class="hidden-print col-lg-3">
                                                    <asp:Label ID="Label5" runat="server" Text="To Section : "></asp:Label>
                                                    <asp:DropDownList AutoPostBack="true" runat="server" ID="ddltosection" AppendDataBoundItems="true" OnSelectedIndexChanged="ddltosection_SelectedIndexChanged">
                                                        <asp:ListItem Text="<---Select Section--->" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <hr />
                                            <div class="clearfix"></div>
                                            <div class="space-24"></div>
                                            
                                                <asp:GridView ID="gv_students" AutoGenerateColumns="False" CssClass=" table table-striped table-bordered table-hover" runat="server">
                            
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Select">
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="CheckBox2" runat="server" AutoPostBack="true" OnCheckedChanged="CheckBox2_CheckedChanged"/>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="true" OnCheckedChanged="CheckBox1_CheckedChanged" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="ne_id" HeaderText="Addmission No." />
                                                        <asp:TemplateField HeaderText="Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("strFname")+" "+Eval("strLname") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                           
                                                    </Columns>
                                                    
                                                </asp:GridView>
                                                <asp:Label runat="server" id="lblstatus"></asp:Label>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </asp:View>
                        </asp:MultiView>
                        <div class="pull-right">
                            <asp:Button CssClass="hidden-print btn btn-success" ID="btnPromote" Text="Click Here To Promote" runat="server" OnClick="btnPromote_Click" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
