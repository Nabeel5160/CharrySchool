﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageEmployees.aspx.cs" Inherits="SchoolPRO.AdminManageEmployees" %>
<%@ Import Namespace="SchoolPRO" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row-fluid">
               <%-- <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>--%>
                 <asp:ToolkitScriptManager  ID="tool1" runat="server"  ></asp:ToolkitScriptManager>
                <asp:UpdatePanel ID="upt" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                <div class="clearfix"></div>
                                <div class="space-12"></div>
                                <div class="col-lg-3">
                                    <asp:TextBox ID="txtcc" placeholder="Search by Name..." runat="server" class="nav-search-input" Width="210" OnTextChanged="txtcc_TextChanged" AutoPostBack="true"></asp:TextBox>
                                </div>
                                <div class="table-responsive">
                                    <asp:GridView ID="gvsearchclass" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="False" AllowSorting="True" AutoGenerateColumns="False" ShowHeader="true" EnableViewState="true" OnPageIndexChanging="gvsearchclass_PageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField >
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nu_id" SortExpression="nu_id" HeaderText="S.NO" />
                                            
                                            <asp:TemplateField HeaderText="Name"><ItemTemplate><asp:Label ID="lblcname" runat="server" Text='<%# Eval("name") %>'></asp:Label></ItemTemplate></asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strlname" HeaderText="Last Name" SortExpression="strlname" />
                                            <asp:BoundField DataField="strEmail" HeaderText="Email" SortExpression="strEmail" />
                                            <asp:BoundField DataField="strEducation" HeaderText="Qualification" SortExpression="strEducation" />
                                            <asp:BoundField DataField="strSalary" HeaderText="Salary" SortExpression="strSalary" />
                                            <asp:BoundField DataField="strPhone" HeaderText="Phone" SortExpression="strPhone" />
                                            <asp:TemplateField HeaderText="View Full Info">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnshow" runat="server" Text="View Info" class="width-95 pull-left btn btn-sm btn-success" OnClick="btnshow_Click" />

                                                </ItemTemplate>

                                            </asp:TemplateField>
                                             <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strCity" HeaderText="Ph" SortExpression="strCity" />
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strCountry" HeaderText="Phone" SortExpression="strCountry" />
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strAddress" HeaderText="Phone" SortExpression="strAddress" />
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strState" HeaderText="Phone" SortExpression="strState" />
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strNIC" HeaderText="Phone" SortExpression="strState" />
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strDOB" HeaderText="Phone" SortExpression="strState" />
                                            
                                              <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strfname" HeaderText="Last Name" SortExpression="strlname" />
                                        </Columns>
                                    </asp:GridView>
                                    <div class="space-4"></div>
                                </div>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <%--<div class="widget-body">--%>
                                                <div class="widget-main">
                                                    <div class="col-lg-offset-3 col col-lg-6" style="background: #f2f2f2;">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Employee Registration
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter details to begin: </p>
                                                    <form id="freg">
                                                        <fieldset>
                                                            <label class="block clearfix">
                                                                <asp:TextBox ID="txttchrnic" MaxLength="13" AutoPostBack="true" class="form-control" placeholder="Employee NIC" OnTextChanged="txttchrnic_TextChanged" runat="server"></asp:TextBox>

                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator14" runat="server"  ControlToValidate="txttchrnic" ErrorMessage="Range must be in 13 Character long!" ValidationExpression="(\d{13})?"></asp:RequiredFieldValidator>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtfn" class="form-control" placeholder="First Name" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter First name" ControlToValidate="txtfn"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtml" class="form-control" placeholder="Middle Name" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    
                                                                </span>
                                                              
                                                            </label>
                                                              <div class="space-12"></div>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtln" class="form-control" placeholder="Last Name" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                  
                                                                </span>
                                                           
                                                            </label>
                                                              <div class="form-group">
                                                                 <label class=" clearfix">
                                                                
                                                                    <asp:DropDownList runat="server" class="form-control" ID="ddlgroup" DataSourceID="gid" DataTextField="name" DataValueField="nGid" AppendDataBoundItems="true"><asp:ListItem Value="0">--Select Group--</asp:ListItem></asp:DropDownList>
                                                                    <asp:SqlDataSource runat="server" ID="gid" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nGid], [strGname]+' '+[nGcode] as name FROM [tbl_Group] WHERE ([bisDeleted] = @bisDeleted)">
                                                                        <SelectParameters>
                                                                            <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean"></asp:Parameter>
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                
                                                            </label>
                                                                  </div>
                                                            <div class="space-12"></div>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtdob" class="form-control" MaxLength="10" placeholder="Date of Birth" runat="server"></asp:TextBox>
                                                                     <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtdob" runat="server"></asp:CalendarExtender>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator3" ValidationGroup="add"  runat="server" ErrorMessage="Enter Date of Birth" ControlToValidate="txtdob"></asp:RequiredFieldValidator>
                                                               <asp:RegularExpressionValidator ID="birthdatecheck" runat="server" ValidationGroup="add" ErrorMessage="Please enter date in dd-mm-yyyy format" Tooltip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ForeColor="Red" Font-Bold="true"   ControlToValidate="txtdob" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator> 
                                                                     </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtedu" class="form-control" placeholder="Education" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ValidationGroup="add"  ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Education" ControlToValidate="txtedu"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtsal" class="form-control" placeholder="Salary" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ValidationGroup="add" ForeColor="Red" Font-Bold="true" ErrorMessage="Only Digits" ValidationExpression="[0-9-_.% ()]+" ControlToValidate="txtsal" runat="server" />
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator5"  ValidationGroup="add"  runat="server" ErrorMessage="Enter Salary" ControlToValidate="txtsal"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtadrs" class="form-control" placeholder="Address" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ValidationGroup="add"  ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Address" ControlToValidate="txtadrs"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtcity" class="form-control" placeholder="City" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ValidationGroup="add"  ID="RequiredFieldValidator7" runat="server" ErrorMessage="Enter City" ControlToValidate="txtcity"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtstate" class="form-control" placeholder="State" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ValidationGroup="add"  ID="RequiredFieldValidator8" runat="server" ErrorMessage="Enter State" ControlToValidate="txtstate"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtcntry" class="form-control" placeholder="Country" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ValidationGroup="add"  ID="RequiredFieldValidator9" runat="server" ErrorMessage="Enter Country" ControlToValidate="txtcntry"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtpcode" class="form-control" placeholder="Postal Code" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ValidationGroup="add" ForeColor="Red" Font-Bold="true" ErrorMessage="Only Digits(0-9)" ValidationExpression="^\d+$" ControlToValidate="txtpcode" runat="server" />
                                                                    <asp:RequiredFieldValidator CssClass="red" ValidationGroup="add"  ID="RequiredFieldValidator10" runat="server" ErrorMessage="Enter Postal Code" ControlToValidate="txtpcode"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtphn" class="form-control" placeholder="Phone" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ValidationGroup="add" ForeColor="Red" Font-Bold="true" ErrorMessage="Only Digits(0-9)" ValidationExpression="^\d+$" ControlToValidate="txtphn" runat="server" />
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator11" runat="server" ValidationGroup="add" ErrorMessage="Enter Phone" ControlToValidate="txtphn"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtmobile" class="form-control" placeholder="Mobile" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ValidationGroup="add" ForeColor="Red" Font-Bold="true" ErrorMessage="Only Digits(0-9)" ValidationExpression="^\d+$" ControlToValidate="txtmobile" runat="server" />
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator12" ValidationGroup="add"  runat="server" ErrorMessage="Enter Mobile" ControlToValidate="txtmobile"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtem" TextMode="Email" class="form-control" placeholder="Email" runat="server"></asp:TextBox>
                                                                    <i class="icon-envelope"></i>

                                                                    <asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter Email" ControlToValidate="txtem" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtpwd" TextMode="Password" class="form-control" placeholder="Password" runat="server"></asp:TextBox>
                                                                    <i class="icon-lock"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator13" runat="server" ErrorMessage="Enter Password" ControlToValidate="txtpwd"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtrepass" TextMode="Password" class="form-control" placeholder="Repeat Password" runat="server"></asp:TextBox>
                                                                    <i class="icon-retweet"></i>
                                                                    <asp:CompareValidator CssClass="red" ID="CompareValidator1" runat="server" ErrorMessage="Password Does not Match" ControlToValidate="txtrepass" ControlToCompare="txtpwd"></asp:CompareValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:FileUpload ID="fimg" runat="server" />
                                                                    <i class="icon-retweet"></i>
                                                                </span>
                                                            </label>
                                                            <label class="hidden block">
                                                                <asp:CheckBox ID="chqacpt" class="ace" runat="server" />
                                                                <span class="lbl">I accept the
															<a href="#">User Agreement</a>
                                                                </span>
                                                            </label>

                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                               
                                                                <asp:Button ID="btnrset" runat="server" Text="Reset" class="width-30 pull-left btn btn-sm " />
                                                                <asp:Button ID="btntreg" runat="server" Text="Add" class="width-65 pull-right btn btn-sm btn-success" ValidationGroup="add"  OnClick="btntreg_Click" />
                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </asp:View>
                            <asp:View ID="View3" runat="server">
                                <asp:Label ID="stnum" runat="server" Text="Label" Visible="false"></asp:Label>
                                <!-- PAGE CONTENT BEGINS -->
                                <%
                                    //stnum.Text = Session["email"].ToString();
                                %>
                                <%
                                    System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
                                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
                                    System.Data.SqlClient.SqlDataReader dr;
                                %>

                                <%
                                  
                                    string query = "select nu_id,strImage,strFname,strMname,strDOB,strEducation,strAddress,strCity,strState,strCountry,strPincode,strPhone,strEmail,strSalary from tbl_Users where nu_id='" + Session["edit"] + "' and nsch_id='"+Session["nschoolid"]+"' and bisDeleted='false'";
                                    cmd.Connection = con;
                                    con.Open();
                                    cmd.CommandType = System.Data.CommandType.Text;
                                    cmd.CommandText = query;
                                    List<enrollment> tempList = null;

                                    using (con)
                                    {
                                        dr = cmd.ExecuteReader();
                                        if (dr.HasRows)
                                        {
                                            tempList = new List<enrollment>();
                                            while (dr.Read())
                                            {
                                                enrollment c = new enrollment();
                                                c.id = dr["nu_id"].ToString();
                                                c.image = dr["strImage"].ToString();
                                                c.efname = dr["strFname"].ToString();
                                                c.emname = dr["strMname"].ToString();
                                                c.dob = dr["strDOB"].ToString();
                                                c.edu = dr["strEducation"].ToString();
                                                c.adrs = dr["strAddress"].ToString();
                                                c.city = dr["strCity"].ToString();
                                                c.state = dr["strState"].ToString();
                                                c.country = dr["strCountry"].ToString();
                                                c.pcode = dr["strPincode"].ToString();
                                                c.phn = dr["strPhone"].ToString();
                                                c.email = dr["strEmail"].ToString();
                                                c.inc = dr["strSalary"].ToString();
                                                tempList.Add(c);
                                            }
                                            tempList.TrimExcess();
                                            con.Close();
                                            foreach (var c in tempList)
                                            {
                                %>
                                <div class="row-fluid">
                                    <div>
                                        <div id="user-profile-1" class="user-profile row">
                                            <div class="col-xs-12 col-sm-3 center">
                                                <div>
                                                    <span class="profile-picture">
                                                        <% avatar.ImageUrl = c.image; %><asp:Image ID="avatar" class="editable img-responsive" runat="server" />
                                                        <%--<img ID="avatar" class="editable img-responsive" alt="Alex's Avatar" src="assets/avatars/profile-pic.jpg" />--%>
                                                    </span>

                                                    <div class="space-4"></div>

                                                    <div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
                                                        <div class="inline position-relative">
                                                            <a href="#" class="user-title-label dropdown-toggle" data-toggle="dropdown">
                                                                <i class="icon-circle light-green middle"></i>
                                                                &nbsp;
															<span class="white"><%lblefn.Text = c.efname; %><asp:Label ID="lblefn" runat="server" Text="Label"></asp:Label>&nbsp;<%lblmn.Text = c.emname; %><asp:Label ID="lblmn" runat="server" Text="Label"></asp:Label></span>
                                                            </a>


                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="space-6"></div>



                                                <div class="hr hr12 dotted"></div>
                                                <div class="hr hr16 dotted"></div>
                                            </div>

                                            <div class="col-xs-12 col-sm-9">


                                                <div class="space-12"></div>

                                                <div class="profile-user-info profile-user-info-striped">
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">ID </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span2"><%lbluid.Text = c.id; %><asp:Label ID="lbluid" runat="server" Text=""></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Email </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="username"><%lblem.Text = c.email; %><asp:Label ID="lblem" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>



                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Date of Birth </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="age"><%lbldob.Text = c.dob; %><asp:Label ID="lbldob" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Education </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span1"><%lbledu.Text = c.edu; %><asp:Label ID="lbledu" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Address </div>

                                                        <div class="profile-info-value">
                                                            <i class="icon-map-marker light-orange bigger-110"></i>
                                                            <span class="editable" id="country"><%lbladr.Text = c.adrs; %><asp:Label ID="lbladr" runat="server" Text="Label"></asp:Label></span>

                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">City </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span6"><%lblcit.Text = c.city; %><asp:Label ID="lblcit" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">State </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span8"><%lblst.Text = c.state; %><asp:Label ID="lblst" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Country </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span7"><%lblcnt.Text = c.country; %><asp:Label ID="lblcnt" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Pincode </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span9"><%lblpcode.Text = c.pcode; %><asp:Label ID="lblpcode" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Phone </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span10"><%lblph.Text = c.phn; %><asp:Label ID="lblph" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>
                                                    <div class="profile-info-row">
                                                        <div class="profile-info-name">Salary </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span11"><%lblfee.Text = c.inc; %><asp:Label ID="lblfee" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>

                                                </div>
                                                <%}
                                                %>
                                                <%
                                        }
                                    }
                                                %>

                                                <div class="space-20"></div>
                                                <asp:Button ID="btnuedit" runat="server" Text="Edit" class="width-65 pull-left btn btn-sm btn-success" OnClick="btnuedit_Click" />
                                                <asp:Button ID="btndelete" runat="server" Text="Delete" class="width-65 pull-left btn btn-sm btn-success" OnClick="btndelete_Click" />
                                                
                                                <asp:Button ID="btngoback" runat="server" Text="Go Back" class="width-65 pull-left btn btn-sm btn-success" OnClick="btngoback_Click" />
                                                <div class="hr hr2 hr-double"></div>

                                                <div class="space-6"></div>


                                            </div>
                                        </div>
                                    </div>

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
                                                        Teachers Info
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter details to Update: </p>
                                                    <form id="Form2">
                                                        <fieldset>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtupemail" class="form-control" placeholder="Email" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtfnm" class="form-control" placeholder="Name" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtlnm" class="form-control" placeholder="Name" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtnic" class="form-control" placeholder="NIC" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtdobb" class="form-control" placeholder="DOB" runat="server"></asp:TextBox>
                                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtdobb" runat="server"></asp:CalendarExtender>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txted" class="form-control" placeholder="Education" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtsl" class="form-control" placeholder="Salary" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtadr" class="form-control" placeholder="Address" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtct" class="form-control" placeholder="City" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txts" class="form-control" placeholder="State" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtctry" class="form-control" placeholder="Country" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtmb" class="form-control" placeholder="Mobile" runat="server"></asp:TextBox>
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
                            </asp:View>
                        </asp:MultiView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="btntreg" />
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
            </div>
            <!-- PAGE CONTENT ENDS -->
        </div>
    </div>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
