<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testTimeTable.aspx.cs" Inherits="SchoolPRO.testTimeTable" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <label class="block clearfix">
                <span class="block input-icon input-icon-right">
                    <asp:DropDownList CssClass="input-medium" ID="ddtchr" runat="server" DataSourceID="sqltch" DataTextField="name" DataValueField="nu_id"></asp:DropDownList>
                    <i class="icon-user"></i>
                </span>
            </label>
            <asp:SqlDataSource ID="sqltch" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT strfname + ' ' + strlname AS name, nu_id FROM tbl_Users WHERE (nLevel = '2') AND (bisDeleted = 'False')"></asp:SqlDataSource>

            <asp:GridView runat="server" ID="gvclsec" AutoGenerateColumns="false" DataSourceID="sqlclsec">
                <Columns>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:CheckBox ID="chksizeok" OnCheckedChanged="chksizeok_CheckedChanged" AutoPostBack="true" runat="server" />
                        </HeaderTemplate>

                        <ItemTemplate>
                            <asp:CheckBox ID="chksizeselect" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="nc_id" HeaderText="cid" SortExpression="nc_id" />
                    <asp:BoundField DataField="nsc_id" HeaderText="sid" SortExpression="nsc_id" />
                    <asp:BoundField DataField="nsbj_id" SortExpression="nsbj_id" HeaderText="sbid" />
                    <asp:BoundField DataField="strClass" SortExpression="strClass" HeaderText="Class" />
                    <asp:BoundField DataField="strSection" SortExpression="strSection" HeaderText="Section" />
                    <asp:BoundField DataField="strSubject" SortExpression="strSubject" HeaderText="Subject" />

                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="sqlclsec" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT c.strClass, c.nc_id, s.strSection, s.nsc_id, sb.nsbj_id,sb.strSubject FROM tbl_Section s inner join tbl_Class c on s.nc_id=c.nc_id inner join tbl_Subject sb on c.nc_id=sb.nc_id where (s.bisDeleted = 'False' and c.bisDeleted='False' and sb.bisDeleted='False')"></asp:SqlDataSource>

            <label class="block clearfix">
                <span class="block input-icon input-icon-right">
                    <asp:DropDownList AutoPostBack="true" ID="ddltimetable11" runat="server" DataSourceID="TimetableDs" DataTextField="strtimetable" DataValueField="nshd_id">
                        <%--<asp:ListItem Text="---Select Time Table---"></asp:ListItem>--%>
                    </asp:DropDownList>
                </span>
            </label>
            <asp:SqlDataSource runat="server" ID="TimetableDs" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strtimetable], [nshd_id] FROM [tbl_Schedule]"></asp:SqlDataSource>

            <label class="block clearfix">
                <label>Select Period :</label>
                <span class="block input-icon input-icon-right">

                    <asp:DropDownList DataSourceID="sqlprd" AutoPostBack="true" CssClass="input-medium" ID="ddlperiod" runat="server" DataTextField="strPeriod" DataValueField="np_id">
                    </asp:DropDownList>

                    <i class="icon-user"></i>
                </span>
            </label>
            <asp:SqlDataSource runat="server" ID="sqlprd" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="select np_id,strPeriod from tbl_Period where nshdul_id=@shd">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddltimetable11" Name="shd" Type="String"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:GridView runat="server" DataSourceID="sqlperiod" AutoGenerateColumns="false" ID="gvpriod">
                <Columns>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:CheckBox ID="chksizeok1" OnCheckedChanged="chksizeok1_CheckedChanged" AutoPostBack="true" runat="server" />
                        </HeaderTemplate>

                        <ItemTemplate>
                            <asp:CheckBox ID="chksizeselect1" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="strPeriod" SortExpression="strPeriod" HeaderText="Period" />
                    <asp:BoundField DataField="strStartTime" SortExpression="strStartTime" HeaderText="start time" />
                    <asp:BoundField DataField="strEndTime" SortExpression="strEndTime" HeaderText="end time" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="sqlperiod" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="select strStartTime,strEndTime,strPeriod from tbl_Period">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlperiod" Name="pid" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:GridView runat="server" DataSourceID="sqlday" AutoGenerateColumns="false" ID="gvday">
                <Columns>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:CheckBox ID="chksizeok2" OnCheckedChanged="chksizeok2_CheckedChanged" AutoPostBack="true" runat="server" />
                        </HeaderTemplate>

                        <ItemTemplate>
                            <asp:CheckBox ID="chksizeselect2" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="nDay_id" SortExpression="nDay_id" HeaderText="id" />
                    <asp:BoundField DataField="strDayName" SortExpression="strDayName" HeaderText="day " />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="sqlday" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="select nDay_id,strDayName from tbl_Day" />

            <asp:Button Text="submit" ID="btnadd" OnClick="btnadd_Click" runat="server" />

        </div>
    </form>
</body>
</html>
