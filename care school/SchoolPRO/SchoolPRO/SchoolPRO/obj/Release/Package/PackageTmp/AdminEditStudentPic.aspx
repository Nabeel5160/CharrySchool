<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminEditStudentPic.aspx.cs" Inherits="SchoolPRO.AdminEditStudentPic" %>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <asp:ScriptManager runat="server" />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <div class="row-fluid">


        
                                    <div class="col-lg-offset-10">
                                        
                                        <asp:Button ID="BackBtn" CssClass="btn-success" runat="server" Text="Go Back" OnClick="BackBtn_Click"  />
                                    </div>

                                    <div>
                                        <label class=" clearfix">
                                            <span class=" input-icon input-icon-right">Select Student Image
                                                <asp:FileUpload ID="editImagefile" runat="server" />
                                                <i class="icon-picture"></i>
                                            </span>
                                        </label>
                                                    <asp:Button ID="btnEditImg" CssClass="btn-success" runat="server" Text="Update Image" OnClick="btnEditImg_Click" />
                                                    
                                    </div>
       </div>
            </ContentTemplate>
        <Triggers>
           <asp:PostBackTrigger ControlID="btnEditImg" />
        </Triggers>
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
