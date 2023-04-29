<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherStudentAttendance.aspx.cs" Inherits="SchoolPRO.TeacherStudentAttendance" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="col-xs-12">
   <%-- <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>--%>
     <asp:ToolkitScriptManager  ID="tool1" runat="server"  ></asp:ToolkitScriptManager>
                <asp:UpdatePanel ID="upt" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                      <label >Enter Date:</label>
                                <asp:TextBox runat="server" ID="txtdate" CssClass="form-control" placeholder="dd-mm-yyyy" AutoPostBack="true"></asp:TextBox>
                     <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtdate" runat="server"></asp:CalendarExtender>
                                        <div class="table-responsive">
                                            
                                       
                                        <!-- /.table-responsive -->

                                        <asp:GridView ID="gvsubst" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="sqlst">
                                            <Columns>
                                                <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nc_id" SortExpression="nc_id" HeaderText="S.NO" />
                                                <asp:BoundField DataField="strClass" HeaderText="Class" SortExpression="strClass" />
                                                <asp:BoundField DataField="strSection" HeaderText="Section" SortExpression="strSection" />
                                                <asp:BoundField DataField="strCourseCode" HeaderText="Course Code" SortExpression="strCourseCode" />
                                                <asp:BoundField DataField="strSubject" HeaderText="Subject" SortExpression="strSubject" />
                                                <asp:TemplateField HeaderText="Attendance">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btndattnd" runat="server" Text="Take Attendance" CssClass="width-55 pull-left btn btn-sm btn-primary" OnClick="btndattnd_Click" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nsc_id" SortExpression="nc_id" HeaderText="S.NO" />
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nsbj_id" SortExpression="nc_id" HeaderText="S.NO" />
                                            </Columns>

                                        </asp:GridView>


                                        <asp:SqlDataSource ID="sqlst" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT c.nc_id,c.strClass, sc.strSection,sc.nsc_id,s.nsbj_id, s.strCourseCode, s.strSubject FROM tbl_TimeTable AS t inner join tbl_Section sc on t.nsc_id=sc.nsc_id INNER JOIN tbl_Class AS c ON t.nc_id = c.nc_id INNER JOIN tbl_Subject AS s ON t.nsbj_id = s.nsbj_id INNER JOIN tbl_Users AS u ON t.nu_id = u.nu_id WHERE (u.nu_id =@uem ) and t.bisDeleted='False' and t.strDay=@day and t.nsch_id=@schid">
                                            <SelectParameters>
                                                <asp:Parameter Name="day" DbType="String" />
                                                <asp:SessionParameter SessionField="uid" Name="uem" />
                                                <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
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
</asp:Content>
