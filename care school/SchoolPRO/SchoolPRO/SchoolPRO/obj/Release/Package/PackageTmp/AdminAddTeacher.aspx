<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAddTeacher.aspx.cs" Inherits="SchoolPRO.AdminAddTeacher" %>

<%@ Import Namespace="SchoolPRO" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function printDiv(printable) {
            var printContents = document.getElementById(printable).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }

        function ismaxlength(objTxtCtrl, nLength) {
            
            document.getElementById('lblCaption').style.display = "none";
            document.getElementById('lblCaption').innerText = "You Are Exceeding the Size Limit";


            if (objTxtCtrl.value.length > nLength) {
                document.getElementById('lblCaption').style.display = "block";
                document.getElementById('lblCaption').style.color = "red";
                objTxtCtrl.value = objTxtCtrl.value.substring(0, nLength);
            }
            else
                document.getElementById('lblCaption').style.display = "none";

        }
       
        
        
    </script>
    <script>
        function gridview() {
            $("#ContentPlaceHolder1_gvsearchclass").dataTable();
        };
    </script>
    <script>
        $("#ContentPlaceHolder1_btnbck").click(function () {
            $("#ContentPlaceHolder1_gvsearchclass").dataTable();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            
            <div class="row-fluid">
                <%--<asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>--%>
                <asp:ToolkitScriptManager ID="tool1" runat="server"></asp:ToolkitScriptManager>
                <asp:UpdatePanel ID="upt" runat="server">
                    <ContentTemplate>
                        <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">
                            <asp:View ID="View1" runat="server">
                              <!-- PAGE CONTENT BEGINS -->
               <div class="col-lg-12">
                    <h5 style="color:red">Instruction</h5>
            <ul>
                <li>Add All Details of Teacher Required in the Form  </li>
                <li>Do Gather All Valid Information Before Adding </li>
            </ul>
                </div>
                                <div class="col-xs-6">
                                    <asp:Button ID="btngotoAdd" runat="server" Text="Add" class="width-10 pull-left btn btn-sm btn-success" OnClick="btngotoAdd_Click" />
                                    <asp:Button ID="btnclinch" runat="server" Text="Add Class Incharge" class="width-10 pull-left btn btn-sm btn-success" OnClick="btnclinch_Click" />
                                    <asp:Button Visible="false" ID="btntsbj" runat="server" Text="Add Teacher's Subject" class="width-10 pull-left btn btn-sm btn-success" OnClick="btntsbj_Click" />
                                </div>
                                <div class="clearfix"></div>
                                <div class="space-12"></div>
                                <%--<div class="col-lg-3">
                                    <asp:TextBox ID="txtcc" placeholder="Search by First Name..." runat="server" class="nav-search-input" Width="210" OnTextChanged="txtcc_TextChanged" AutoPostBack="true"></asp:TextBox>
                                </div>--%>
                                <div class="clearfix"></div>
                                <div class="space-12"></div>
                                <div id="printable" class="table-responsive">
                                    <div class="widget-header header-color-blue">
                                        <h5 class="bigger lighter">
                                            <i class="icon-table"></i>Teachers List
                                        </h5>

                                        <div class="hidden-print widget-toolbar widget-toolbar-light no-border">
                                            <div class="icon-print icon-2x" onclick="printDiv('printable')"></div>
                                        </div>
                                    </div>
                                    <asp:GridView ID="gvsearchclass" EmptyDataText="NO DATA FOUND" class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" ShowHeader="true" EnableViewState="true" AllowSorting="True" >
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="nu_id" SortExpression="nu_id" HeaderText="S.NO" />

                                            <asp:TemplateField HeaderText="First Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcname" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strlname" HeaderText="Last Name" SortExpression="strlname" />

                                            <asp:BoundField DataField="strEmail" HeaderText="Email" SortExpression="strEmail" />
                                            <asp:BoundField DataField="strEducation" HeaderText="Qualification" SortExpression="strEducation" />
                                            <asp:BoundField DataField="strSalary" HeaderText="Salary" SortExpression="strSalary" />
                                            <asp:BoundField DataField="strPhone" HeaderText="Phone" SortExpression="strPhone" />

                                            <asp:TemplateField HeaderStyle-CssClass="hidden-print" ItemStyle-CssClass="hidden-print" HeaderText="View Full Info">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnshow" runat="server" Text="View Info" class="width-100 pull-left btn btn-sm btn-success" OnClick="btnshow_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strCity" HeaderText="Ph" SortExpression="strCity" />
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strCountry" HeaderText="Phone" SortExpression="strCountry" />
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strAddress" HeaderText="Phone" SortExpression="strAddress" />
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strState" HeaderText="Phone" SortExpression="strState" />
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strNIC" HeaderText="Phone" SortExpression="strState" />
                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strDOB" HeaderText="Phone" SortExpression="strState" />

                                            <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="strfname" HeaderText="Last Name" SortExpression="strlname" />
                                            <asp:BoundField NullDisplayText="N/A" DataField="strDesgName" HeaderText="Designation" SortExpression="Designation" />
                                            <asp:BoundField NullDisplayText="N/A" DataField="strDptName" HeaderText="Department" SortExpression="Designation" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button ID="btndeeted" runat="server" Text="Delete" class="width-100 pull-left btn btn-sm btn-success" OnClick="btndeeted_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <div class="space-4"></div>
                                </div>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <div>
                                    <div class="position-relative">
                                        <div class="no-border">
                                            <%--<div class="widget-body">--%>
                                            <div class="col-lg-offset-3 col col-lg-6" style="background: #f2f2f2;">

                                                <div class="widget-main">
                                                    <h4 class="header green lighter bigger">
                                                        <i class="icon-group blue"></i>
                                                        Teachers Registration
                                                    </h4>

                                                    <div class="space-6"></div>
                                                    <p>Enter details to begin. Fields with (*) are mandatory </p>
                                                    <form id="freg">
                                                        <fieldset>


                                                            <div class="block input-icon input-icon-right">
                                                                <i class="icon-user"></i>
                                                                    <p>NIC *: </p>
                                                                <asp:TextBox ID="txttchrnic" MaxLength="13" AutoPostBack="true" class="form-control" placeholder="Teacher NIC" OnTextChanged="txttchrnic_TextChanged" runat="server"></asp:TextBox>

                                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator14" runat="server" ControlToValidate="txttchrnic" ErrorMessage="Range must be in 13 Character long!" ValidationExpression="(\d{13})?"></asp:RequiredFieldValidator>
                                                            </div>
                                                            <div class="form-group">
                                                                
                                                                <div class="block input-icon input-icon-right">
                                                                    <i class="icon-user"></i>
                                                                    <p>First Name *: </p>
                                                                    <asp:TextBox ID="txtfn" class="form-control" placeholder="First Name" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter First name" ControlToValidate="txtfn"></asp:RequiredFieldValidator>

                                                                </div>
                                                                <div class="block input-icon input-icon-right">
                                                                    <i class="icon-user"></i>
                                                                    <p>Last Name *: </p>

                                                                    <asp:TextBox ID="txtln" class="form-control" placeholder="Last Name" Text="" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>

                                                                    <%--<asp:RequiredFieldValidator CssClass="red"  ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Last name" ControlToValidate="txtln"></asp:RequiredFieldValidator>--%>
                                                                </div>
                                                                <br />
                                                                <div class="block input-icon input-icon-right">
                                                                    <i class="icon-time"></i>
                                                                    <p>Date of Brith: *</p>
                                                                    <asp:TextBox ID="txtdob" class="form-control" placeholder="Date of Birth (dd-MM-yyyy)" runat="server" MaxLength="10" onkeyup="return ismaxlength(this,10)"></asp:TextBox>
                                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtdob" runat="server"></asp:CalendarExtender>
                                                                    <label id='lblCaption' style="font-family: Tahoma; font-size: 1em; font-weight: bold" cssclass="red"></label>


                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Date of Birth" ControlToValidate="txtdob"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="birthdatecheck" runat="server" ValidationGroup="loan" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ForeColor="Red" Font-Bold="true" ControlToValidate="txtdob" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>
                                                                </div>
                                                            </div>
                                                            <div class="block input-icon input-icon-right">
                                                                <i class="icon-user"></i>
                                                                    <p>Select *: </p>
                                                                <asp:DropDownList ID="ddsex" class="form-control" runat="server">
                                                                    <asp:ListItem>Select Gender</asp:ListItem>
                                                                    <asp:ListItem>Male</asp:ListItem>
                                                                    <asp:ListItem>Female</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <br />
                                                                <i class="icon-user"></i>
                                                                    <p>Select *: </p>
                                                                <asp:DropDownList ID="ddldpt" class="form-control" runat="server" DataSourceID="ddldptDS" DataTextField="name" DataValueField="nDpt_id" AppendDataBoundItems="true">
                                                                    <asp:ListItem> Select Department </asp:ListItem>

                                                                </asp:DropDownList>
                                                                <asp:SqlDataSource runat="server" ID="ddldptDS" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nDpt_id], [strDptName]+' '+[strDptCode] as name FROM [tbl_TeacherDepartment] WHERE (([bisDeleted] = @bisDeleted) AND ([nsch_id] = @nsch_id))">
                                                                    <SelectParameters>
                                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted"></asp:Parameter>
                                                                        <asp:SessionParameter SessionField="nschoolid" DefaultValue="" Name="nsch_id"></asp:SessionParameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <br />
                                                                <i class="icon-user"></i>
                                                                    <p>Select *: </p>
                                                                <asp:DropDownList ID="ddldesg" class="form-control" runat="server" DataSourceID="ddlDESGDS2" DataTextField="name" DataValueField="nDesg_id" AppendDataBoundItems="true">
                                                                    <asp:ListItem> Select Designation</asp:ListItem>

                                                                </asp:DropDownList>
                                                                <asp:SqlDataSource runat="server" ID="ddlDESGDS2" ConnectionString='<%$ ConnectionStrings:SchoolPro %>' SelectCommand="SELECT [nDesg_id], [strDesgName]+' '+[strDesgCode] as name FROM [tbl_Designation] WHERE (([bisDeleted] = @bisDeleted) AND ([nsch_id] = @nsch_id))">
                                                                    <SelectParameters>
                                                                        <asp:Parameter DefaultValue="False" Name="bisDeleted"></asp:Parameter>
                                                                        <asp:SessionParameter SessionField="nschoolid" DefaultValue="" Name="nsch_id"></asp:SessionParameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <br />
                                                                 </div>
                                                                <div class="block input-icon input-icon-right">
                                                                    <i class="icon-user"></i>
                                                                    <p>Education *: </p>
                                                                    <asp:TextBox ID="txtedu" class="form-control" placeholder="Education" runat="server"></asp:TextBox>
                                                                    <i class="icon-pencil"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter Education" ControlToValidate="txtedu"></asp:RequiredFieldValidator>
                                                                </div>
                                                                <div class="block input-icon input-icon-right">

                                                                    <i class="icon-user"></i>
                                                                    <p>Salary *: </p>
                                                                    <asp:TextBox ID="txtsal" class="form-control" placeholder="Salary" runat="server"></asp:TextBox>
                                                                    <i class="icon-money"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter Salary" ControlToValidate="txtsal"></asp:RequiredFieldValidator>
                                                                </div>

                                                                <div class="block input-icon input-icon-right">
                                                                    <i class="icon-home"></i>
                                                                    <p>Address *: </p>
                                                                    <asp:TextBox ID="txtadrs" class="form-control" placeholder="Address" runat="server"></asp:TextBox>
                                                                    <i class="icon-home"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Address" ControlToValidate="txtadrs"></asp:RequiredFieldValidator>
                                                                </div>
                                                           
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <i class="icon-home"></i>
                                                                    <p>City *: </p>
                                                                    <asp:TextBox ID="txtcity" class="form-control" placeholder="City" runat="server"></asp:TextBox>
                                                                    <i class="icon-home"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator7" runat="server" ErrorMessage="Enter City" ControlToValidate="txtcity"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtstate" class="form-control" placeholder="State" runat="server"></asp:TextBox>
                                                                    <i class="icon-home"></i>
                                                                    <%--<asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator8" runat="server" ErrorMessage="Enter State" ControlToValidate="txtstate"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>

                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtcntry" class="form-control" placeholder="Country" runat="server"></asp:TextBox>
                                                                    <i class="icon-home"></i>
                                                                    <%--<asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator9" runat="server" ErrorMessage="Enter Country" ControlToValidate="txtcntry"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>

                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtpcode" class="form-control" placeholder="Postal Code" runat="server"></asp:TextBox>
                                                                    <i class="icon-code"></i>
                                                                    <%--<asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator10" runat="server" ErrorMessage="Enter Postal Code" ControlToValidate="txtpcode"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>

                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <i class="icon-mobile-phone"></i>
                                                                    <p>Phone *: </p>
                                                                    <asp:TextBox ID="txtphn" class="form-control" placeholder="Phone" runat="server" AutoPostBack="true" OnTextChanged="txtphn_TextChanged"></asp:TextBox>
                                                                    <i class="icon-mobile-phone"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator11" runat="server" ErrorMessage="Enter Phone" ControlToValidate="txtphn"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>

                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <i class="icon-mobile-phone"></i>
                                                                    <p>Cell *: </p>
                                                                    <asp:TextBox ID="txtmobile" class="form-control" placeholder="Mobile" runat="server" AutoPostBack="true" OnTextChanged="txtmobile_TextChanged"></asp:TextBox>
                                                                    <i class="icon-mobile-phone"></i>
                                                                    <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator12" runat="server" ErrorMessage="Enter Mobile" ControlToValidate="txtmobile"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <br />
                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtem" TextMode="Email" class="form-control" placeholder="Email" runat="server"></asp:TextBox>
                                                                    <i class="icon-envelope"></i>
                                                                    <asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter Email" ControlToValidate="txtem" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                                </span>
                                                            </label>

                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtpwd" TextMode="Password" class="form-control" placeholder="Password" runat="server"></asp:TextBox>
                                                                    <i class="icon-lock"></i>
                                                                    <%--<asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator13" runat="server" ErrorMessage="Enter Password" ControlToValidate="txtpwd"></asp:RequiredFieldValidator>--%>
                                                                </span>
                                                            </label>

                                                            <label class=" clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtrepass" TextMode="Password" class="form-control" placeholder="Repeat Password" runat="server"></asp:TextBox>
                                                                    <i class="icon-retweet"></i>
                                                                    <asp:CompareValidator CssClass="red" ID="CompareValidator1" runat="server" ErrorMessage="Password Does not Match" ControlToValidate="txtrepass" ControlToCompare="txtpwd"></asp:CompareValidator>
                                                                </span>
                                                            </label>
                                                            <br />
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:FileUpload ID="fimg" runat="server" />
                                                                    <i class="icon-picture"></i>
                                                                </span>
                                                            </label>
                                                            <label class="hidden">
                                                                <asp:CheckBox ID="chqacpt" class="ace" runat="server" />
                                                                <span class="lbl">I accept the
															<a href="#">User Agreement</a>
                                                                </span>
                                                            </label>

                                                            <div class="space-24"></div>

                                                            <div class="clearfix">
                                                                <%--<asp:Button ID="btnrset" runat="server" Text="Reset" class="width-30 pull-left btn btn-sm " />--%>
                                                                <asp:Button ID="btntreg" runat="server" Text="Register" class="width-40 pull-right btn btn-sm btn-success" OnClick="btntreg_Click" />
                                                                <asp:Button ID="btngoback" runat="server" Text="View Teachers" class="width-40 pull-right btn btn-sm btn-success" OnClick="btngoback_Click" />
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
                                    stnum.Text = Session["email"].ToString();
                                %>
                                <%
                                    System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
                                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
                                    System.Data.SqlClient.SqlDataReader dr;
                                %>
                                <%
                                  
                                    string query = "select nu_id,strImage,strFname,strMname,strDOB,strEducation,strAddress,strCity,strState,strCountry,strPincode,strPhone,strEmail,strSalary,nEmployeeNumber from tbl_Users where nLevel=2 and nu_id='" + Session["edit"] + "' and strEmail='" + stnum.Text + "'";
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
                                                c.id = dr["nEmployeeNumber"].ToString();
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
                                                        <div class="profile-info-name">Emp. Code </div>

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
                                        else
                                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Teacher Not Found.');", true);
                                    }
                                                %>

                                                <div class="space-20"></div>
                                                <asp:Button ID="btnuedit" runat="server" Text="Edit" class="width-65 pull-left btn btn-sm btn-success" OnClick="btnuedit_Click" />
                                                <asp:Button ID="btndelete" runat="server" Text="Delete" class="width-65 pull-left btn btn-sm btn-success" OnClick="btndelete_Click" />
                                                <asp:Button Text="Go Back" runat="server" class="width-65 pull-left btn btn-sm btn-success" ID="btnbck" OnClick="btnbck_Click" />
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
                                                                    <asp:RegularExpressionValidator ControlToValidate="txtupemail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" runat="server" ID="RegularExpressionValidator8" ErrorMessage="Enter Correct Email" ForeColor="Red"></asp:RegularExpressionValidator>
                                                                    <asp:RequiredFieldValidator ControlToValidate="txtupemail" ID="RequiredFieldValidator25" ForeColor="Red" runat="server" ErrorMessage="Enter Email"></asp:RequiredFieldValidator>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtfnm" class="form-control" placeholder="Name" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="add" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter Name" ControlToValidate="txtfnm" runat="server" />
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ForeColor="Red" Font-Bold="true" ControlToValidate="txtfnm" ValidationExpression="[0-9a-zA-Z-_. ()]+" runat="server" ErrorMessage="You Can only Enter Alphabets"></asp:RegularExpressionValidator>
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtlnm" class="form-control" placeholder="Name" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ValidationGroup="add" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter Name" ControlToValidate="txtlnm" runat="server" />
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ForeColor="Red" Font-Bold="true" ControlToValidate="txtlnm" ValidationExpression="[0-9a-zA-Z-_. ()]+" runat="server" ErrorMessage="You Can only Enter Alphabets"></asp:RegularExpressionValidator>

                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtnic" class="form-control" placeholder="NIC" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ValidationGroup="add" ID="RequiredFieldValidator16" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter NIC" ControlToValidate="txtnic" runat="server" />
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ValidationGroup="add" ForeColor="Red" Font-Bold="true" ErrorMessage="Only Digits(0-9)" ValidationExpression="^\d+$" ControlToValidate="txtnic" runat="server" />

                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtdobb" class="form-control" placeholder="DOB" runat="server"></asp:TextBox>
                                                                    <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtdobb" runat="server"></asp:CalendarExtender>
                                                                    <asp:RequiredFieldValidator ValidationGroup="add" ForeColor="Red" Font-Bold="true" ID="RequiredFieldValidator17" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression="^[\s\S]{10,10}$" ControlToValidate="txtdobb"></asp:RequiredFieldValidator>

                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ValidationGroup="add" ForeColor="Red" Font-Bold="true" runat="server" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ControlToValidate="txtdobb" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>
                                                                    <i class="icon-user"></i>
                                                                </span>
                                                            </label>
                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txted" class="form-control" placeholder="Education" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ValidationGroup="add" ID="RequiredFieldValidator18" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter Education" ControlToValidate="txted" runat="server" />
                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtsl" class="form-control" placeholder="Salary" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ValidationGroup="add" ID="RequiredFieldValidator19" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter Salary" ControlToValidate="txtsl" runat="server" />
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ValidationGroup="add" ForeColor="Red" Font-Bold="true" ErrorMessage="Only Digits(0-9)" ValidationExpression="^\d+$" ControlToValidate="txtsl" runat="server" />

                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtadr" class="form-control" placeholder="Address" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ValidationGroup="add" ID="RequiredFieldValidator20" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter Address" ControlToValidate="txtadr" runat="server" />

                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtct" class="form-control" placeholder="City" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ValidationGroup="add" ID="RequiredFieldValidator21" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter City" ControlToValidate="txtct" runat="server" />

                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txts" class="form-control" placeholder="State" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ValidationGroup="add" ID="RequiredFieldValidator22" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter State" ControlToValidate="txts" runat="server" />

                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtctry" class="form-control" placeholder="Country" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ValidationGroup="add" ID="RequiredFieldValidator23" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter Country" ControlToValidate="txtctry" runat="server" />

                                                                </span>
                                                            </label>

                                                            <label class="block clearfix">
                                                                <span class="block input-icon input-icon-right">
                                                                    <asp:TextBox ID="txtmb" class="form-control" placeholder="Mobile" runat="server"></asp:TextBox>
                                                                    <i class="icon-user"></i>
                                                                    <asp:RequiredFieldValidator ValidationGroup="add" ID="RequiredFieldValidator24" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter Mobile" ControlToValidate="txtmb" runat="server" />
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ValidationGroup="add" ForeColor="Red" Font-Bold="true" ErrorMessage="Only Digits(0-9)" ValidationExpression="^\d+$" ControlToValidate="txtmb" runat="server" />

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

