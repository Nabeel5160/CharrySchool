<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageNewAdmissionMarks.aspx.cs" Inherits="SchoolPRO.AdminManageNewAdmissionMarks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" ID="sc" />
    <div class="col-xs-12">
        <asp:UpdatePanel ID="upmarks" runat="server">
            <ContentTemplate>
                <asp:MultiView ID="mvmarks" ActiveViewIndex="0" runat="server">
                    <asp:View ID="View1" runat="server">
                        <asp:DropDownList AutoPostBack="true" ID="dddlcl" OnSelectedIndexChanged="dddlcl_SelectedIndexChanged" runat="server" DataTextField="strClass" DataValueField="nc_id" AppendDataBoundItems="true" DataSourceID="dddlclDS">
                            <asp:ListItem Value="0">---Select Class---</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="dddlclDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nc_id], [strClass] FROM [tbl_Class] WHERE (([bisDeleted] = @bisDeleted) AND ([nsch_id] = @nsch_id))">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                <asp:SessionParameter SessionField="nschoolid" DefaultValue="1" Name="nsch_id" Type="Int32"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                       <%-- <asp:DropDownList ID="dddlsec" runat="server" DataTextField="strSection" DataValueField="nsc_id" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="dddlsec_SelectedIndexChanged" DataSourceID="dddlsecDS">
                            <asp:ListItem Value="0">---Select Class Section---</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="dddlsecDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [strSection], [nsc_id] FROM [tbl_Section] WHERE (([bisDeleted] = @bisDeleted) AND ([nsch_id] = @nsch_id) AND ([nc_id] = @nc_id))">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                <asp:SessionParameter SessionField="nschoolid" DefaultValue="1" Name="nsch_id"></asp:SessionParameter>
                                <asp:ControlParameter ControlID="dddlcl" PropertyName="SelectedValue" DefaultValue="1" Name="nc_id"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>--%>
                        <div class="space-24"></div>
                        <div class="table-responsive">

                            <asp:GridView ID="GridView1" class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                                <Columns>
                                    <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                    <%--<asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />--%>
                                    <asp:BoundField DataField="strCourseCode" HeaderText="Course Code" SortExpression="strCourseCode" />
                                    <asp:BoundField DataField="strSubject" HeaderText="Subject" SortExpression="strSubject" />
                                    <asp:TemplateField HeaderText="Add Marks">
                                        <ItemTemplate>
                                            <asp:Button ID="btnAddMarks" runat="server" Text="Add Marks" CssClass="width-55 pull-left btn btn-sm btn-primary" OnClick="btnAddMarks_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" HeaderText="View Marks">
                                        <ItemTemplate>
                                            <asp:Button ID="btnviewMarks" runat="server" Text="View Marks" CssClass="width-55 pull-left btn btn-sm btn-primary" OnClick="btnviewMarks_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nc_id" SortExpression="nc_id" HeaderText="S.NO" />
                                    <%--<asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nsc_id" SortExpression="nc_id" HeaderText="S.NO" />--%>
                                    <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nsbj_id" SortExpression="nc_id" HeaderText="S.NO" />

                                </Columns>
                            </asp:GridView>


                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT distinct c.strClass, c.nc_id, s.strCourseCode, s.strSubject, s.nsbj_id FROM tbl_TimeTable AS t INNER JOIN tbl_Class AS c ON t.nc_id = c.nc_id INNER JOIN tbl_Subject AS s ON t.nsbj_id = s.nsbj_id WHERE (t.bisDeleted = 'False') AND (t.nsch_id = @schid) AND (t.nc_id = @cid)" ><%--AND (t.nsc_id = @scid)">--%>
                                <SelectParameters>

                                    <asp:SessionParameter SessionField="nschoolid" Name="schid" />
                                    <asp:ControlParameter ControlID="dddlcl" PropertyName="SelectedValue" DefaultValue="0" Name="cid"></asp:ControlParameter>
                                  
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </asp:View>

                    <asp:View ID="View2" runat="server">
                        <div class="table-responsive">
                            <%--<asp:CheckBox ID="chqex" Text="Check if Adding Exam Marks" runat="server" />--%>
                            <asp:DropDownList ID="ddexams" runat="server" OnSelectedIndexChanged="ddexams_SelectedIndexChanged" AppendDataBoundItems="true" AutoPostBack="true" DataSourceID="AdmisDs" DataTextField="name" DataValueField="id">
                                <asp:ListItem Text="<---Select Type of Exam--->" Value="--"></asp:ListItem>

                                <%-- <asp:ListItem Text="Admission Marks" Value="Admission Marks"></asp:ListItem>--%>
                            </asp:DropDownList>

                            <asp:SqlDataSource runat="server" ID="AdmisDs" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT strExamName AS name, nExam_id AS id FROM tbl_Admission WHERE (bisDeleted = @fbit)">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="false" Name="fbit"></asp:Parameter>
                                </SelectParameters>
                            </asp:SqlDataSource>

                            <asp:TextBox ID="txttmrks" ValidationGroup="add" placeholder="Total Marks" runat="server"></asp:TextBox>
                           
                           <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationGroup="add" ForeColor="Red" Font-Bold="true" ErrorMessage="Only Digits(0-9)" ValidationExpression="^\d+$" ControlToValidate="txttmrks" runat="server" />
                            <div class="space-12"></div>
                            <asp:GridView ID="GridView2" class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
                                <Columns>
                                    <asp:BoundField DataField="bRegisteredNum" HeaderText="Student Reg Number" SortExpression="bRegisteredNum" />
                                    <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                                    <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strLname" />
                                    <asp:TemplateField HeaderText="Marks">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtmarks" placeholder="Obt. Marks" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Remarks">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrem" placeholder="Remarks" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" DataField="ne_id" HeaderText="S.No" SortExpression="neid" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT ne_id, bRegisteredNum, strFname, strLname FROM tbl_Enrollment WHERE (nc_id =  @cnm)   AND (strStudentNum IS NULL) and nsch_id=@sn and bisDeleted='True' and strStatus='Pending'">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="section" Name="sc" />
                                    <asp:SessionParameter SessionField="cname" Name="cnm" />
                                    <asp:SessionParameter SessionField="nschoolid" Name="sn" />

                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Button ID="btnsubmitattend" ValidationGroup="add" class="width-35 pull-right btn btn-sm btn-primary" runat="server" Text="Submit Marks" OnClick="btnsubmitattend_Click" />
                        </div>
                        <!-- /.table-responsive -->
                    </asp:View>

                    <%-- <asp:View ID="View3" runat="server">
                        <div class="table-responsive">
                            <asp:GridView ID="gvshowmarks" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource3">
                                <Columns>
                                    <asp:BoundField DataField="nr_id" HeaderText="S.NO" SortExpression="nr_id" />
                                    <asp:BoundField DataField="strStudentNum" HeaderText="Student Number" SortExpression="strStudentNum" />
                                    <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                                    <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strLname" />
                                    <asp:BoundField DataField="strTotalMarks" HeaderText="Total Marks" SortExpression="strTotalMarks" />
                                    <asp:BoundField DataField="strObtMarks" SortExpression="Obt. Marks" HeaderText="strObtMarks" />
                                    <asp:BoundField DataField="strRemarks" SortExpression="Remarks" HeaderText="strRemarks" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btned" runat="server" Text="Edit" OnClick="btned_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btndel" runat="server" Text="Delete" OnClick="btndel_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT ex.nr_id,e.strStudentNum, e.strFname, e.strLname,ex.strTotalMarks, ex.strObtMarks, ex.strRemarks FROM tbl_Enrollment AS e INNER JOIN tbl_Result AS ex ON e.ne_id = ex.ne_id WHERE (ex.nc_id = @cname) AND (ex.nsbj_id = @cc) and ex.nsc_id=@sce111 and ex.nu_id=@uem AND (ex.bisDeleted = 'False') and ex.nsch_id=@schid2">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="uid" Name="uem" />
                                    <asp:SessionParameter SessionField="sec11" Name="sce111" />
                                    <asp:SessionParameter SessionField="cname1" Name="cname" />
                                    <asp:SessionParameter SessionField="coursecode1" Name="cc" />
                                    <asp:SessionParameter SessionField="nschoolid" Name="schid1" />
                                    <asp:SessionParameter SessionField="nschoolid" Name="schid2" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Button ID="gottoback" class="width-35 pull-right btn btn-sm btn-primary" runat="server" Text="Go Back" OnClick="gottoback_Click" />
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
                                                Marks
                                            </h4>

                                            <div class="space-6"></div>
                                            <p>Edit marks: </p>
                                            <form id="freg">
                                                <fieldset>

                                                     <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txttol" placeholder="Total Marks" CssClass="form-actions" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                   

                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txteditmarks" placeholder="Marks" CssClass="form-actions" runat="server"></asp:TextBox>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <asp:TextBox ID="txtremarks" placeholder="ReMarks" CssClass="form-actions" runat="server"></asp:TextBox>
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
                    </asp:View>--%>
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
    <!-- /span -->


    <div class="hr hr-18 dotted hr-double"></div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
