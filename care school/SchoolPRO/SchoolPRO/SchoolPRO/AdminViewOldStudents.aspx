<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewOldStudents.aspx.cs" Inherits="SchoolPRO.AdminViewOldStudents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->

								<div class="row-fluid">
                                    <h4 id="name" class="header green lighter bigger">
                                        <i  class="icon-group blue"></i>
                                        Search By Student Name
                                    </h4>
                                    <div class="space-6"></div>
                                     
                                    <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                                    <asp:UpdatePanel ID="upsub" runat="server">
                                        <ContentTemplate>
                                            <asp:MultiView ID="mvsub" ActiveViewIndex="0" runat="server">
                                                <asp:View ID="View1" runat="server">
                                                  
                                                    <asp:GridView ID="gvsearchsub" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="nold_id" DataSourceID="OldstDS">
                                                        <Columns>
                                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nold_id" HeaderText="S.No" ReadOnly="True" InsertVisible="False" SortExpression="nold_id"></asp:BoundField>
                                                            <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="strName" HeaderText="Name" SortExpression="strName"></asp:BoundField>
                                                            <asp:BoundField DataField="strAddmissionNum" HeaderText="Addmission Num" SortExpression="strAddmissionNum"></asp:BoundField>
                                                            <asp:BoundField DataField="strclass" HeaderText="Class" SortExpression="strclass"></asp:BoundField>
                                                            <asp:BoundField DataField="strFname" HeaderText="Father Name" SortExpression="strFname"></asp:BoundField>
                                                            <asp:BoundField DataField="strDOB" HeaderText="DOB" SortExpression="strDOB"></asp:BoundField>
                                                            <asp:BoundField DataField="strGender" HeaderText="Gender" SortExpression="strGender"></asp:BoundField>
                                                            <asp:BoundField DataField="strAddress" HeaderText="Address" SortExpression="strAddress"></asp:BoundField>
                                                            <asp:BoundField DataField="dtStart_Date" HeaderText="Start Date" SortExpression="dtStart_Date"></asp:BoundField>
                                                            <asp:BoundField DataField="dtEnd_Date" HeaderText="End_Date" SortExpression="dtEnd_Date"></asp:BoundField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>

                                                                    <asp:Button CssClass= "width-60 btn btn-success" Text="Edit" ID="btnedit" runat="server" OnClick="btnedit_Click" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                     <asp:Button CssClass="width-60 btn btn-success" Text="Delete" ID="btndel" runat="server" OnClick="btndel_Click" />
                                                                </ItemTemplate>
                     
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <asp:SqlDataSource runat="server" ID="OldstDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT nold_id, strName, strAddmissionNum, strclass, strFname, strDOB, strGender, strAddress, dtStart_Date, dtEnd_Date FROM tbl_OldStudents WHERE (bisDeleted = 0)"></asp:SqlDataSource>
                                                    <div class="space-4"></div>

                                           </div>
                                                    </asp:View>
                                                <asp:View  ID="View2" runat="server">
									                <div class="row-fluid">
                                                          <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click"/>
                                           

            <div>
                
                <div class="position-relative">
                    <div class="no-border">
                        <div class="widget-body">
                            <div class="widget-main">
                                <h4 class="header green lighter bigger">
                                    <i class="icon-group blue"></i>
                                    Update Student 
                                </h4>
                                
                                <div class="space-6"></div>
                             
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
                                        <asp:Label CssClass="hidden" ID="lblid" runat="server"></asp:Label>
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
                                            <asp:Button ID="btnupdate" runat="server" Text="Update" class="width-30 pull-right btn btn-sm btn-success" OnClick="btnupdate_Click" />
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
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
								</div><!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
            </div>
    
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
