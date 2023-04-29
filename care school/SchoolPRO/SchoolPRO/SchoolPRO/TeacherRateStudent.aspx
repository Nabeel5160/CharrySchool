<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher.Master" AutoEventWireup="true" CodeBehind="TeacherRateStudent.aspx.cs" Inherits="SchoolPRO.TeacherRateStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                Student Evaluation
            </h4>

            <div class="space-6"></div>
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="upclassview" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvdata" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <div class="panel panel-blue" style="background: #FFF;">
                                <div class="panel-body">
                                    <%--<div class="col-xs-15 pre-scrollable table-responsive">--%>
                                    <%--<div class="table-responsive">
                                        <asp:GridView runat="server" ID="ratgrid" CssClass="table table-bordered table-striped table-hover" ShowFooter="true" AllowSorting="true" AutoGenerateColumns="false">
                                            <EmptyDataTemplate>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            No Data Found.
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EmptyDataTemplate>
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Rating Element" HeaderStyle-ForeColor="Tomato" HeaderText="Rating Element" />
                                                <asp:TemplateField HeaderText="Select" HeaderStyle-ForeColor="Tomato" >
                                                    <ItemTemplate>
                                                        <asp:RadioButtonList CssClass="btn btn-success" RepeatDirection="Horizontal" ID="BTNRAD"  runat="server">
                                                            <asp:ListItem Text="Satisfactory" Value="1" />
                                                            <asp:ListItem Text="Needs Of Improve" Value="2" />
                                                            <asp:ListItem Text="UnSatisfactory" Value="3" />
                                                        </asp:RadioButtonList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <%--</div>--%>
                                </div>
                                 <div class="container">
                                     <h2>Table</h2>
                                <table border="1" id="tabid" runat="server" class="table table-striped">
                                    <tr class="success">
                                        <td>Sn#</td>
                                        <td>Optlion</td>
                                        <td>
                                            <%--<% 
                                            System.Data.DataTable dt = new System.Data.DataTable();
                                            System.Data.DataRow datarow = null;
                                            int sz = 0;
                                            List<string> lis1 = new List<string>();

                                            for (int k = 1; k < 5; k++)
                                            {
                                                if (k == 1)
                                                {
                                                    lis1.Add("Readin Skill Improved..... ?");
                                                }
                                                else if (k == 2)
                                                {
                                                    lis1.Add("Writing Skill Improved..... ?");
                                                }
                                                else if (k == 3)
                                                {
                                                    lis1.Add("Particapate in Class..... ?");
                                                }
                                                else
                                                {
                                                    lis1.Add("Submit the assignment at time..... ?");
                                                }
                                            }
                                            foreach (string aa in lis1)
                                            
                                                datarow = dt.NewRow();
                                                datarow["Rating Element"] = "Satisfactory";
                                                datarow["Check"] = string.Empty;
                                                dt.Rows.Add(datarow);
                                                
                                                RadioButtonList rad= new RadioButtonList();
                                                rad.Text="Satisfactory";
                                                ListItem ls=new ListItem();
                                                ls.Text="Satisfactory";
                                                ls.Value="1";
                                                
                                                ListItem ls1=new ListItem();
                                                ls1.Text="Satisfactory";
                                                ls1.Value="1";
                                                
                                            //    <asp:RadioButtonList runat="server" ID="radid" RepeatDirection="Horizontal">
                                            //    <asp:ListItem Text="Satisfactory" Value="1" />
                                            //    <asp:ListItem Text="Needs Of Improve" Value="2" />
                                            //    <asp:ListItem Text="UnSatisfactory" Value="3" />
                                            //</asp:RadioButtonList>
                                            } %>--%>
                                            Select
                                            
                                        </td>

                                    </tr>

                                    <tr class="warning">
                                        <td>2</td>
                                        <td>Readin Skill Improved..... ?</td>
                                        <td>
                                            <asp:RadioButtonList ID="RadioButtonList1" RepeatDirection="Horizontal" runat="server">
                                                <asp:ListItem Text="Satisfactory" />
                                                <asp:ListItem Text="Needs Of Improve" />
                                                <asp:ListItem Text="UnSatisfactory" Value="3" />
                                            </asp:RadioButtonList>
                                            
                                        </td>

                                    </tr>

                                    <tr class="danger">
                                        <td>3</td>
                                        <td>Writing Skill Improved..... ?</td>
                                        <td>
                                            <asp:RadioButtonList ID="RadioButtonList2" RepeatDirection="Horizontal" runat="server">
                                                <asp:ListItem Text="Satisfactory" />
                                                <asp:ListItem Text="Needs Of Improve" />
                                                <asp:ListItem Text="UnSatisfactory" Value="3" />
                                            </asp:RadioButtonList>
                                            
                                        </td>

                                    </tr>

                                    <tr class="info">
                                        <td>4</td>
                                        <td>Submit the assignment at time..... ?</td>
                                        <td>
                                            <asp:RadioButtonList ID="RadioButtonList3" RepeatDirection="Horizontal" runat="server">
                                                <asp:ListItem Text="Satisfactory" />
                                                <asp:ListItem Text="Needs Of Improve" />
                                                <asp:ListItem Text="UnSatisfactory" Value="3" />
                                            </asp:RadioButtonList>
                                            
                                        </td>

                                    </tr>

                                    <tr class="success">
                                        <td>5</td>
                                        <td>Particapate in Class..... ?</td>
                                        <td>
                                            <asp:RadioButtonList ID="RadioButtonList4" RepeatDirection="Horizontal" runat="server">
                                                <asp:ListItem Text="Satisfactory" />
                                                <asp:ListItem Text="Needs Of Improve" />
                                                <asp:ListItem Text="UnSatisfactory" Value="3" />
                                            </asp:RadioButtonList>
                                            
                                        </td>

                                    </tr>
                                </table>
                                     </div>
                            </div>
                            <hr />
                            <div class="form-actions text-right pal">
                                <asp:Button ID="btnADDForm" Text="Submit" ValidationGroup="add" OnClick="btnADDForm_Click" CssClass="btn btn-success" runat="server" />
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

            <div class="space-12"></div>

            <!-- /.page-content -->
        </div>
        <!-- /.main-content -->

    </div>


</asp:Content>
