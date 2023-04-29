<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageSchoolLeaving.aspx.cs" Inherits="SchoolPRO.AdminManageSchoolLeaving" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <div class="form-search">
                    <span class="input-icon">
                        <p>Add Admission and Student Fee</p>

                    </span>
                </div>
                <div class="space-10"></div>
                <%--<div class="clearfix"><asp:Button ID="btnsrch" runat="server" class="width-20 pull-left btn btn-sm " Text="Search" /></div>--%>
                <asp:ScriptManager ID="sc" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upregst" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ActiveViewIndex="0" ID="mvsub" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngo" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngo_Click" />
                                <div class="space-10"></div>
                                <asp:GridView ID="gvfee" CssClass="table table-responsive table-hover" runat="server" AllowSorting="true" AllowPaging="true" DataKeyNames="nfee_id" AutoGenerateColumns="false" EnableViewState="true">
                                    <Columns>
                                        <asp:BoundField DataField="nS_No" SortExpression="nS_No" HeaderText="S.NO" />
                                        <asp:BoundField DataField="strStudentNum" SortExpression="strStudentNum" HeaderText="Roll #" />
                                        <asp:BoundField DataField="strfname" SortExpression="strfname" HeaderText="Gaurdian" />
                                        <asp:BoundField DataField="strClass" SortExpression="strClass" HeaderText="Class" />
                                        <asp:BoundField DataField="strStartDate" SortExpression="strStartDate" HeaderText="Start Date" />
                                        <asp:BoundField DataField="strEndDate" SortExpression="strEndDate" HeaderText="End Date" />
                                        <asp:BoundField DataField="strTotalMarks" SortExpression="strTotalMarks" HeaderText="Total Marks" />
                                        <asp:BoundField DataField="strObtMarks" SortExpression="strObtMarks" HeaderText="Obt Marks" />
                                        
                                    </Columns>
                                </asp:GridView>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <div >
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage School Leaving Certificate
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Student Roll Number: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="lblsno" ReadOnly="true" runat="server"></asp:TextBox>
                                                                </span>
                                                            </label>
                                                            <label class=" clearfix">
                                                                <span class=" input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtstnum" class="form-control" placeholder="Roll Number" AutoPostBack="true" OnTextChanged="txtstnum_TextChanged" runat="server"></asp:TextBox>
                                                                   
                                                                </span>
                                                            </label>
                                                            <br />
                                                            <label class="clearfix">
                                                                <span class=" input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtfn" ReadOnly="true" runat="server"></asp:TextBox>
                                                                </span>
                                                            </label>
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtln" ReadOnly="true" runat="server"></asp:TextBox>
                                                                    
                                                                </span>
                                                            </label>
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtpfn" ReadOnly="true" runat="server"></asp:TextBox>
                                                                </span>
                                                            </label>
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                   <asp:TextBox ID="txtpln" ReadOnly="true" runat="server"></asp:TextBox>
                                                                </span>
                                                            </label>
                                                            <br />
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtecl" ReadOnly="true" runat="server"></asp:TextBox>
                                                                </span>
                                                            </label>
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtsdt" ReadOnly="true" runat="server"></asp:TextBox>
                                                                </span>
                                                            </label>
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    
                                                                    <asp:TextBox ID="txtedt" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                                                                    
                                                                </span>
                                                            </label>
                                                            <br />
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txttmarks" class="form-control"  runat="server"></asp:TextBox>
                                                                    
                                                                </span>
                                                            </label>
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtobtmarks" class="form-control"  runat="server"></asp:TextBox>
                                                                    
                                                                </span>
                                                            </label>
                                                            <br />
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtdtfg" class="form-control"  runat="server"></asp:TextBox>
                                                                    
                                                                </span>
                                                            </label>
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:Label ID="lbldtwd" runat="server" placeholder="in words" Text="words"></asp:Label>
                                                                    
                                                                </span>
                                                            </label>
                                                            <br />
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtdesc" TextMode="MultiLine" MaxLength="200" Columns="50" class="form-control"  runat="server"></asp:TextBox>
                                                                    
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnsub" runat="server" Text="Add Certificate" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnsub_Click" />
                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </asp:View>
                            <%--<asp:View ID="View3" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Manage Fees
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter details of Fees according to their Classes: </p>
                                                    <form id="Form2">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:DropDownList ID="ddecl" runat="server" DataSourceID="sqlcl" DataTextField="strClass" DataValueField="strClass"></asp:DropDownList>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtefee" class="form-control" placeholder="Tution Fee" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txteadm" class="form-control" placeholder="Admission Fee" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnupdate" runat="server" Text="Update" class="width-30 pull-left btn btn-sm " OnClick="btnupdate_Click" />

                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <asp:SqlDataSource ID="sqlcl" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strClass] FROM [tbl_Class] where bisDeleted='False'"></asp:SqlDataSource>

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
            <!-- PAGE CONTENT ENDS -->
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
