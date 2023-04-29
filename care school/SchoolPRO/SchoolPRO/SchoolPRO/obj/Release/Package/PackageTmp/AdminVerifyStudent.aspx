<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminVerifyStudent.aspx.cs" Inherits="SchoolPRO.AdminVerifyStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <div class="row">
        <div class="col-xs-6">
            <div class="row-fluid">
                <asp:Label ID="btnreset" runat="server" ForeColor="Red" Text="Search students that are enrolled but not conform by admin :" class="width-30 " />
            </div>
        </div>
        <div class="col-xs-6">
            <div class="row-fluid">
                <asp:Label ID="Label1" runat="server" Visible="false" ForeColor="Red" Text="Now receive student fee :" class="width-30 pull-Right" />
            </div>
        </div>
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <div class="row">
                <div class="col-md-3">
                    <div class="form-group">
                        <div class="input-icon right">
                            <%--<asp:DropDownList AutoPostBack="true" ID="ddldpt" CssClass="form-control" AppendDataBoundItems="true" runat="server" DataSourceID="DDLclass" DataTextField="strClass" DataValueField="nc_id">
                                <asp:ListItem Value="0" Text="--Select Class--" />
                            </asp:DropDownList>
                            <asp:SqlDataSource runat="server" ID="DDLclass" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT DISTINCT nc_id, strClass FROM tbl_Class WHERE (nu_id = @uidd) AND (nsch_id = @schoolid) AND (bisDeleted = @fbit)">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="uid" DefaultValue="0" Name="uidd"></asp:SessionParameter>
                                    <asp:SessionParameter SessionField="nschoolid" DefaultValue="0" Name="schoolid"></asp:SessionParameter>
                                    <asp:Parameter DefaultValue="False" Name="fbit"></asp:Parameter>
                                </SelectParameters>
                            </asp:SqlDataSource>--%>

                        </div>
                    </div>
                </div>
                <div class="row-fluid">
                    Enter Registeration Number:
                <asp:TextBox ID="txtsrchstd" placeholder="Search..." runat="server" class="nav-search-input" Width="210" AutoPostBack="true" Enabled="true"></asp:TextBox>
                    <i style="margin-top: 28px;" class="icon-search nav-search-icon"></i>

                    <div class="table-responsive">
                        <asp:GridView ID="gdshow" DataSourceID="sqlshow" CssClass="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" ShowHeader="true" EnableViewState="true">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ne_id" SortExpression="ne_id" HeaderText="Enrollment Number" />
                                <asp:BoundField DataField="reg" SortExpression="reg" HeaderText="Registeration #" />
                                <asp:BoundField DataField="dtEn_Date" HeaderText="Enrollment Date" SortExpression="dtEn_Date" />
                                <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                                <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strLname" />
                                <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                <asp:BoundField DataField="strShift" HeaderText="Shift" SortExpression="strShift" />

                                <asp:TemplateField HeaderText="Student Roll NO">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtroll" runat="server"></asp:TextBox>
                                        <asp:Button ID="genraterol" class="width-65 btn btn-sm btn-primary" runat="server" Text="Generate Roll" OnClick="genraterol_Click" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="asignrol" class="width-95 btn btn-sm btn-primary" runat="server" Text="Verify" OnClick="asignrol_Click" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sqlshow" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT tbl_Enrollment.ne_id,tbl_Enrollment.bRegisteredNum as reg,tbl_Enrollment.dtEn_Date, tbl_Enrollment.strShift, tbl_Enrollment.strFname, tbl_Enrollment.strLname, tbl_Class.strClass, tbl_Section.strSection FROM tbl_Class INNER JOIN tbl_Enrollment ON tbl_Class.nc_id = tbl_Enrollment.nc_id INNER JOIN tbl_Section ON tbl_Class.nc_id = tbl_Section.nc_id WHERE (tbl_Enrollment.bRegisteredNum= @eid) and  tbl_Enrollment.strStudentNum is NULL and tbl_Enrollment.nsch_id=@schid and tbl_Section.bisDeleted='False'">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtsrchstd" Name="eid" PropertyName="Text" />
                                <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                </div>
                <!-- PAGE CONTENT ENDS -->
            </div>
        </div>
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
</asp:Content>

