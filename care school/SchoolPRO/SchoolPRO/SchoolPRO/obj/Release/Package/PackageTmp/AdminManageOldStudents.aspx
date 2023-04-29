<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageOldStudents.aspx.cs" Inherits="SchoolPRO.AdminManageOldStudents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
        
        <div class="row-fluid">


            <div>
                
                <div class="position-relative">
                    <div class="no-border">
                        <div class="widget-body">
                            <div class="widget-main">
                                <h4 class="header green lighter bigger">
                                    <i class="icon-group blue"></i>
                                    New Student Registration
                                </h4>
                                
                                <div class="space-6"></div>
                                <p>Enter your details to begin: </p>
                                <form id="sreg">
                                    <fieldset>
                                        <%--<label class="clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:CheckBox ID="chkdnr" Text="Check if Donor's Child" runat="server" Visible="False" />
                                                <i class="icon-angle-down"></i>
                                            </span>
                                        </label>
                                        <label class="clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:DropDownList ID="dddonr" CssClass="input-large" DataSourceID="sqldonor" DataValueField="strfname" DataTextField="strfname" runat="server" Visible="False"></asp:DropDownList>
                                                <i class="icon-angle-down"></i>
                                            </span>
                                        </label>--%>
                                        
                                        <br />
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtstn" class="form-control" placeholder="Student Name" runat="server"></asp:TextBox>
                                                <i class="icon-user"></i>
                                                
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Student Name" ControlToValidate="txtstn"></asp:RequiredFieldValidator>
                                        </label>

<%--                                        <label class="clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtml" class="form-control" placeholder="Middle Name" runat="server"></asp:TextBox>
                                                <i class="icon-user"></i>
                                                </span> 

                                        </label>--%>
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtaddmissionnum" class="form-control" placeholder="Addmission Number" runat="server"></asp:TextBox>
                                                <i class="icon-user"></i>
                                                
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Addmission Number" ControlToValidate="txtaddmissionnum"></asp:RequiredFieldValidator>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtfn" class="form-control" placeholder="Father Name" runat="server"></asp:TextBox>
                                                <i class="icon-user"></i>
                                                
                                            </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Father Name" ControlToValidate="txtfn"></asp:RequiredFieldValidator>
                                        </label>
                                        <br />
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:DropDownList ID="ddcl" runat="server"  >
                                                    <asp:ListItem Text="--Select Class--"></asp:ListItem>
                                                    <asp:ListItem Text="Nursery" Value="Nursery"></asp:ListItem>
                                                    <asp:ListItem Text="Prep" Value="Prep"></asp:ListItem>
                                                    <asp:ListItem Text="1st" Value="1st"></asp:ListItem>
                                                    <asp:ListItem Text="2nd" Value="2nd"></asp:ListItem>
                                                    <asp:ListItem Text="3rd" Value="3rd"></asp:ListItem>
                                                    <asp:ListItem Text="4th" Value="4th"></asp:ListItem>
                                                    <asp:ListItem Text="5th" Value="5th"></asp:ListItem>
                                                    <asp:ListItem Text="6th" Value="7th"></asp:ListItem>
                                                    <asp:ListItem Text="8th" Value="8th"></asp:ListItem>
                                                    <asp:ListItem Text="9th" Value="9th"></asp:ListItem>
                                                    <asp:ListItem Text="10th" Value="10th"></asp:ListItem>

                                                </asp:DropDownList>
                                                <i class="icon-angle-down"></i>
                                            </span>
                                        </label>

                                       

                                       
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:DropDownList ID="ddsex" runat="server">
                                                    <asp:ListItem>Select Gender</asp:ListItem>
                                                    <asp:ListItem>Male</asp:ListItem>
                                                    <asp:ListItem>Female</asp:ListItem>
                                                </asp:DropDownList>
                                            </span>
                                            </label>
                                         <label class="clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <p>Enter DOB :</p>
                                                <asp:TextBox ID="txtdob" class="form-control" TextMode="Date" placeholder="Date of Birth" runat="server"></asp:TextBox>
                                                <i class="icon-calendar"></i>
                                                
                                            </span>
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Date of Birth" ControlToValidate="txtdob"></asp:RequiredFieldValidator>
                                        
                                         </label>
                                        <label class="clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <p>Enter Addmission Date :</p>
                                                <asp:TextBox ID="txtstartdate" class="form-control" TextMode="Date" placeholder="" runat="server"></asp:TextBox>
                                                <i class="icon-calendar"></i>
                                                
                                            </span>
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Date of Addmission" ControlToValidate="txtstartdate"></asp:RequiredFieldValidator>
                                        
                                         </label>
                                        <label class="clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <p>Enter Leave Date :</p>
                                                <asp:TextBox ID="txtenddate" class="form-control" TextMode="Date" placeholder="Date of End " runat="server"></asp:TextBox>
                                                <i class="icon-calendar"></i>
                                                
                                            </span>
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter Date " ControlToValidate="txtenddate"></asp:RequiredFieldValidator>
                                        
                                         </label>

                                        <br />
                                        <br />
                                       
                                        <label class="block clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtaddrs" class="form-control" placeholder="Full Address" runat="server"></asp:TextBox>
                                                <i class="icon-home"></i>
                                                </span> <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Enter Address" ControlToValidate="txtaddrs"></asp:RequiredFieldValidator>
                                           
                                        </label>
                                       
                                        <br />
                                        

                                        <br />
                                        <br />




                                        
                                        <div class="space-24"></div>

                                        <div class="clearfix">
                                            <%--<asp:Button ID="btnreset" runat="server" Text="Reset" class="width-30 pull-left btn btn-sm " />--%>
                                            <asp:Button ID="btnsreg" runat="server" Text="Enroll" class="width-30 pull-right btn btn-sm btn-success" OnClick="btnsreg_Click" />
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- PAGE CONTENT ENDS -->
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
    <!-- /.col -->

    <asp:Label ID="lbluserval" runat="server" Text=""></asp:Label>
    

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
