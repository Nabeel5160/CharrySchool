<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/admin.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="SchoolPRO.SuperAdmin.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    
                </h4>

                <div class="space-6"></div>
                <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upclassview" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="MultiView1" ActiveViewIndex="0" runat="server">
                                                      <asp:View ID="View2" runat="server">
                                <div class="login-container">
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Change Password
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter Old Password: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtoldpwd" TextMode="Password" class="form-control" placeholder="Old  Password" runat="server" OnTextChanged="txtoldpwd_TextChanged"></asp:TextBox>
                                                 <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Old Password" ControlToValidate="txtoldpwd"></asp:RequiredFieldValidator>
                                                
                                            </span>
                                        </label>
                                                            </label>
                                                           <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtpwd" TextMode="Password" class="form-control" placeholder="New  Password" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Password" ControlToValidate="txtpwd"></asp:RequiredFieldValidator>
                                                
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtrepass" TextMode="Password" class="form-control" placeholder="Repeat Password" runat="server" ControlToValidate="txtrepass"></asp:TextBox>
                                                <asp:CompareValidator CssClass="red" ID="CompareValidator1" runat="server" ErrorMessage="Password Does not match" ControlToValidate="txtrepass" ControlToCompare="txtpwd"></asp:CompareValidator>
                                               
                                            </span>
                                        </label>
                                        <div class="clearfix"></div>
                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <asp:Button ID="btnChange" runat="server" Text="Update" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnChange_Click" />
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
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                    <div class="loading" align="center">
        Loading. Please wait.<br />
        <br />
        <img src="../assets/images/loader.gif" alt="" />
    </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>

                <div class="space-12"></div>

                <!-- /.page-content -->
            </div>
            <!-- /.main-content -->

        </div>
    </div>
</asp:Content>
