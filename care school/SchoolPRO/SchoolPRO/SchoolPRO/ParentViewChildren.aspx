<%@ Page Title="" Language="C#" MasterPageFile="~/Parent.Master" AutoEventWireup="true" CodeBehind="ParentViewChildren.aspx.cs" Inherits="SchoolPRO.ParentViewChildren" %>

<%@ Import Namespace="SchoolPRO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function printDiv(printable) {
            var printContents = document.getElementById(printable).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lbluval" runat="server" Text="Label" Visible="false"></asp:Label>
    <asp:Label ID="lbluemail" runat="server" Text="Label" Visible="false"></asp:Label>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
           <%-- <asp:UpdatePanel ID="upt" runat="server">
                <ContentTemplate>--%>
                         <div class="col-lg-12 col-md-12">
  <div class="widget-box transparent" id="recent-box">
                    <div class="widget-header">
                        <h4 class="lighter smaller"><i class="icon-rss orange"></i>Students </h4>
                        <div class="widget-toolbar no-border">
                            <ul class="nav nav-tabs" id="recent-tab">
                                <li <% if (mvt.ActiveViewIndex == 4) Response.Write("class=\"active\""); %> ><asp:LinkButton ID="linkforAdmission" OnClick="linkforAdmission_ServerClick"  Text="Applied For Admission" runat="server" /> </li>
                                <li <% if (mvt.ActiveViewIndex == 0) Response.Write("class=\"active\""); %>> <asp:LinkButton ID="linkConfirm" OnClick="linkConfirm_ServerClick"  Text="Admitted Students" runat="server" /></li>
                                
                            </ul>
                        </div>
                    </div>
                    <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                       
                            <div class="widget-body">
                        <div class="widget-main padding-4">
                            <div class="tab-content padding-8 overflow-visible">
                               
                            <div class="table-responsive">
                                <asp:GridView ID="gdpstudent" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="pstview" DataKeyNames="ne_id">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ne_id" HeaderText="ne_id" ReadOnly="True" InsertVisible="False" SortExpression="ne_id"></asp:BoundField>
                                        <asp:BoundField DataField="Student #" HeaderText="Student #" SortExpression="Student #"></asp:BoundField>
                                        <asp:BoundField DataField="Student Name" HeaderText="Student Name" SortExpression="Student Name" ReadOnly="True"></asp:BoundField>
                                        <asp:BoundField DataField="Class" HeaderText="Class" SortExpression="Class"></asp:BoundField>
                                        <asp:BoundField DataField="Section" SortExpression="Section" HeaderText="Section" />
                                        <asp:BoundField  DataField="Date of Brith" HeaderText="Date of Brith" SortExpression="Date of Brith" />
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="cid" HeaderText="cid" SortExpression="cid" />
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="scid" HeaderText="scid" SortExpression="scid" />
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="fid" HeaderText="fid" SortExpression="fid" />
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="regno" HeaderText="regno" SortExpression="regno"></asp:BoundField>
                                           <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnviewatndnc" runat="server" Text="View Detail" class="width-95 pull-left btn btn-sm btn-success" OnClick="btnviewatndnc_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnprintfee" runat="server" Text="Print Fee Challan" OnClick="btnprintfee_Click" class="width-95 pull-left btn btn-sm btn-success" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                      
                                    </Columns>
                                </asp:GridView>

                                  <asp:SqlDataSource ID="pstview" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT e.ne_id, e.strStudentNum AS 'Student #', e.strFname + ' ' + e.strLname AS 'Student Name', c.strClass AS 'Class', tbl_Section.strSection AS Section, e.strDOB AS 'Date of Brith', e.nc_id AS cid, e.nsc_id AS scid, e.nfee_id AS fid, e.bRegisteredNum AS regno FROM tbl_Enrollment AS e INNER JOIN tbl_Class AS c ON e.nc_id = c.nc_id INNER JOIN tbl_Section ON e.nsc_id = tbl_Section.nsc_id WHERE (e.bisDeleted = 'False') AND (e.nu_id = @u_id OR e.nu_id = (SELECT nu_id FROM tbl_Users WHERE (strEmail = @em) AND (bisDeleted = 'False'))) AND (e.nsch_id = @schid) AND (tbl_Section.bisDeleted = @fbit) AND (c.bisDeleted = @fbit)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="u_id" SessionField="uid" Type="Int32" />
                                        <asp:SessionParameter Name="em" SessionField="userval" Type="String" />
                                        <asp:SessionParameter SessionField="nschoolid" Name="schid" />
                                        <asp:Parameter DefaultValue="false" Name="fbit"></asp:Parameter>
                                      
                                    </SelectParameters>
                                </asp:SqlDataSource>
                               

                            </div>
                                 
                                </div>
                            </div>
                                </div>
                               
                        </asp:View>
                        <asp:View runat="server">

                            <!-- PAGE CONTENT BEGINS -->

                            <%
                                System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
                                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
                                System.Data.SqlClient.SqlDataReader dr;
                            %>
                            <%
                                  
                                string query = "select c.strClass,f.strTutionFee,e.ne_id,e.strImage,e.strFname,e.strLname,e.strDOB,e.strBirthPlace,e.strNationality,e.strMotherlang,e.strReligion,e.strPhAddress,e.strCity,e.strState,e.strCountry,e.nPincode,e.strPhone,e.strEmail from tbl_Enrollment e inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Fee f on e.nfee_id=f.nfee_id where e.ne_id='" + Session["id"] + "' and e.bisDeleted='False' and e.nsch_id='" + Session["nschoolid"] + "' ";
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
                                            c.id = dr["ne_id"].ToString();
                                            c.classnm = dr["strClass"].ToString();
                                            c.fee = dr["strTutionFee"].ToString();
                                            c.image = dr["strImage"].ToString();
                                            c.efname = dr["strFname"].ToString();
                                            c.emname = dr["strLname"].ToString();
                                            c.dob = dr["strDOB"].ToString();
                                            c.bplace = dr["strBirthPlace"].ToString();
                                            c.nationality = dr["strNationality"].ToString();
                                            c.mlang = dr["strMotherlang"].ToString();
                                            c.religion = dr["strReligion"].ToString();
                                            c.adrs = dr["strPhAddress"].ToString();
                                            c.city = dr["strCity"].ToString();
                                            c.state = dr["strState"].ToString();
                                            c.country = dr["strCountry"].ToString();
                                            c.pcode = dr["nPincode"].ToString();
                                            c.phn = dr["strPhone"].ToString();
                                            c.email = dr["strEmail"].ToString();
                                            tempList.Add(c);
                                        }
                                        tempList.TrimExcess();
                                        con.Close();
                                        foreach (var c in tempList)
                                        {
                            %>
                            <div class="row-fluid">
                                <div id="printable">
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
                                                    <div class="profile-info-name">Enrolment # </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span3"><%lbleid.Text = c.id; %><asp:Label ID="lbleid" runat="server" Text="Label"></asp:Label></span>
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
                                                    <div class="profile-info-name">BirthPlace </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span1"><%lblbp.Text = c.bplace; %><asp:Label ID="lblbp" runat="server" Text="Label"></asp:Label></span>
                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Nationality </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span2"><%lblntn.Text = c.nationality; %><asp:Label ID="lblntn" runat="server" Text="Label"></asp:Label></span>
                                                    </div>
                                                </div>
                                                <%--<div class="profile-info-row">
                                                        <div class="profile-info-name">Mother Language </div>

                                                        <div class="profile-info-value">
                                                            <span class="editable" id="Span3"><%lblmlng.Text = c.mlang; %><asp:Label ID="lblmlng" runat="server" Text="Label"></asp:Label></span>
                                                        </div>
                                                    </div>--%>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Religion </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span4"><%lblrelg.Text = c.religion; %><asp:Label ID="lblrelg" runat="server" Text="Label"></asp:Label></span>
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
                                                    <div class="profile-info-name">Fee </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span11"><%lblfee.Text = c.fee; %><asp:Label ID="lblfee" runat="server" Text="Label"></asp:Label></span>
                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Class </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span5"><%lblcl.Text = c.classnm; %><asp:Label ID="lblcl" runat="server" Text="Label"></asp:Label></span>
                                                    </div>
                                                </div>

                                            </div>
                                            <%}
                                            %>
                                            <%
                                    }
                                }
                                            %>



                                            <div class="space-6"></div>


                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-12 col-sm-9" style="float: right;">
                                    <div class="space-20"></div>
                                    <asp:Button ID="Button1" runat="server" Text="Go Back" class="width-65 pull-center btn btn-sm btn-success" OnClick="btnuedit_Click" />
                                    <asp:Button ID="Button2" runat="server" class="width-65 pull-center btn btn-sm btn-success" Text="Print Form" OnClientClick="printDiv('printable')" />
                                    <div class="hr hr2 hr-double"></div>
                                </div>
                            </div>
                        </asp:View>

                        <asp:View ID="View2" runat="server">
                            <div class="login-container" style="width:60%;">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Recieve Fee
                                                </h4>

                                                <div class="space-6"></div>
                                                
                                                <form id="freg">
                                                    <fieldset>
                                                        <label class="block clearfix">
                                                            <Label class="block clearfix">Account Number :</Label>
                                                            
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:DropDownList ID="ddacnum" DataTextField="name" DataValueField="strAccNum" DataSourceID="sqlacnum" class="form-control" runat="server"></asp:DropDownList>
                                                                <i class="icon-user"></i>
                                                                <asp:SqlDataSource ID="sqlacnum" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strAccNum],[strAccTitle]+'-'+[strAccNum] as name FROM [tbl_Bank] WHERE ([bisDeleted] = @bisDeleted)  and nsch_id=@nschid">
                                                                <SelectParameters>
                                                                    <asp:Parameter DefaultValue="False" Name="bisDeleted" Type="Boolean" />
                                                                    <asp:SessionParameter Name="nschid" SessionField="nschoolid" />
                                                                     <asp:SessionParameter Name="uid" SessionField="uid" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            </span>
                                                        </label>
                                                        
                                                       

                                                       
                                                        <label class="block clearfix">
                                                            <Label class="block clearfix">Student Number :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtstnum" ReadOnly="true"  class="form-control" placeholder="Student Number" runat="server" ></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                      
                                                       
                                                       
                                                        <label class="hidden block clearfix">
                                                             <Label class="block clearfix">Student Name :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtnm" ReadOnly="true" class="form-control" placeholder="Name" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <Label class="block clearfix">Fee Due Date :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtDueDate" ReadOnly="true" class="form-control" placeholder="Due Date " runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                             <Label class="block clearfix">Fee Fine :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtFine" ReadOnly="true" class="form-control" placeholder="Fine" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <Label class="block clearfix">Class Fee :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtfee" ReadOnly="true" class="form-control" placeholder="Class Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="hidden block clearfix">
                                                            <Label class="block clearfix">Generator Fee :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtgenfee" ReadOnly="true" class="form-control" placeholder="Generator Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                         <label class="hidden block clearfix">
                                                            <Label class="block clearfix">Folder Fee :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtflderfee" ReadOnly="true" class="form-control" placeholder="Folder Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        
                                                        <label class="hidden block clearfix">
                                                            <Label class="block clearfix">Stationary Fee :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtstatfee" ReadOnly="true" class="form-control" placeholder="Stationary Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <Label class="block clearfix">Remaining Dues :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtRemnfee" ReadOnly="true" class="form-control" placeholder="Student Remaining Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                         <label class="block clearfix">
                                                             <Label class="block clearfix">Concession Fee :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox  ReadOnly="true" ID="txtfeecons" AutoPostBack="true" class="form-control" placeholder="Student Concession Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <Label class="block clearfix">Total Fee :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtTotfee" ReadOnly="true" class="form-control" placeholder="Student Total  Fee" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                       
                                                       
                                                        <label class="block clearfix">
                                                            <Label class="block clearfix">Enter Receive :</Label>
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtRcvfee" AutoPostBack="true" class="form-control" placeholder="Student receive  fee" runat="server"></asp:TextBox>
                                                                  <asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator1" ErrorMessage=" (digits only)" ValidationExpression="^\d+$" ControlToValidate="txtRcvfee" runat="server" />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <div class="space-24"></div>

                                                       

                                                    </fieldset>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:View>

                        <asp:View runat="server">
                            <div class="container">
        <div id="printable1" class="row">
            <div class="col-lg-12">
            <div class="col-md-4">
                 <div>
                                     <h3 class="widget-title grey lighter"><i class="ace-icon fa fa-leaf green"></i>
                                                    <asp:Label ID="txtschool1" Text="Schoollllllllll sd" runat="server"></asp:Label>
                                                </h3>
                                   
                                    <table>
                                        <tr>
                                            <td class="invoice-info-label">Challan #..</td><td><span class="red"><asp:Label ID="txtinv1" runat="server"></asp:Label></span></td></tr><tr>
                                            <td class="invoice-info-label">Date.......</td><td><span class="blue">
                                                    <asp:Label ID="txtdate1" runat="server"></asp:Label>
                                                    </span></td></tr><tr>
                                            <td class="invoice-info-label">Due Date...</td><td><span class="blue">
                                                    <asp:Label ID="txtduedate1" runat="server"></asp:Label>
                                                    </span></td></tr><tr>
                                             <td class="invoice-info-label"> Reg #....</td><td>  <asp:Label ID="txtreg1" runat="server"></asp:Label></td></tr><tr>
                                             <td class="invoice-info-label"> Name.....</td><td>   <asp:Label ID="txtname1" runat="server"></asp:Label> </td></tr><tr>
                                             <td class="invoice-info-label"> Class....</td><td>   <asp:Label ID="txtcls1" runat="server"></asp:Label> </td></tr><tr>
                                             <td class="invoice-info-label"> Section..</td><td>  <asp:Label ID="txtsec1" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                    <table class="table table-striped table-bordered">
                                                            <thead>
                                                                
                                                                <tr>
                                                                    <th>Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstFee1" runat="server"></asp:Label>
                                                                     </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Months</th>
                                                                    <td>
                                                                        <asp:Label ID="txtmonths1" runat="server" Text=""></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Late Fee Fine</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstFine1" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Concession</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstConc1" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Remaining Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstRemainingFee1" runat="server"></asp:Label>
                                                                      </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Total Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstTOTFee1" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Received Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstRcvFee1" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                            </thead>
                                                           
                                                        </table>
                                   <div class="row">
														<div class="col-sm-4 pull-right">
															<h4 class="pull-right">
																Total Fee Received :
																<span class="red"><td><asp:Label runat="server" Text="000" ID="txtstTOTRcvfee1"></asp:Label></span>
															</h4>
														</div>
                                       <div class="col-sm-4">
                                                           <div id="stdbarcode">

                                                            <asp:TextBox ID="getCodetxt" runat="server" Visible="false"></asp:TextBox>
                                                            <asp:Panel ID="pnlPrint" runat="server">
                                                              
                                                                    <asp:Image ID="img" runat="server" Style="height: 43px; width: 130px;" /> 
                                                            
              
                                                            </asp:Panel>
                                                        </div>
                                                    </div>
                                                         <div class="col-sm-4">
															<h6 class="pull-right">
																Student Copy
																
															</h6>
														</div>
														
													</div>
                                </div>
            </div>
            <div class="col-md-4">
                 <div>
                                     <h3 class="widget-title grey lighter"><i class="ace-icon fa fa-leaf green"></i>
                                                    <asp:Label ID="txtschool2" Text="Schoollllllllll sd" runat="server"></asp:Label>
                                                </h3>
                                   
                                    <table>
                                        <tr>
                                            <td class="invoice-info-label">Challan #..</td><td><span class="red"><asp:Label ID="txtinv2" runat="server"></asp:Label></span></td></tr><tr>
                                            <td class="invoice-info-label">Date.......</td><td><span class="blue">
                                                    <asp:Label ID="txtdate2" runat="server"></asp:Label>
                                                    </span></td></tr><tr>
                                            <td class="invoice-info-label">Due Date...</td><td><span class="blue">
                                                    <asp:Label ID="txtduedate2" runat="server"></asp:Label>
                                                    </span></td></tr><tr>
                                             <td class="invoice-info-label"> Reg #....</td><td>  <asp:Label ID="txtreg2" runat="server"></asp:Label></td></tr><tr>
                                             <td class="invoice-info-label"> Name.....</td><td>   <asp:Label ID="txtname2" runat="server"></asp:Label> </td></tr><tr>
                                             <td class="invoice-info-label"> Class....</td><td>   <asp:Label ID="txtcls2" runat="server"></asp:Label> </td></tr><tr>
                                             <td class="invoice-info-label"> Section..</td><td>  <asp:Label ID="txtsec2" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                    <table class="table table-striped table-bordered">
                                                            <thead>
                                                                
                                                                <tr>
                                                                    <th>Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstFee2" runat="server"></asp:Label>
                                                                     </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Months</th>
                                                                    <td>
                                                                        <asp:Label ID="txtmonths2" runat="server" Text=""></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Late Fee Fine</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstFine2" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Concession</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstConc2" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Remaining Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstRemainingFee2" runat="server"></asp:Label>
                                                                      </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Total Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstTOTFee2" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Received Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstRcvFee2" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                            </thead>
                                                           
                                                        </table>
                                   <div class="row">
														<div class="col-sm-4 pull-right">
															<h4 class="pull-right">
																Total Fee Received :
																<span class="red"><td><asp:Label runat="server" Text="000" ID="txtstTOTRcvfee2"></asp:Label></span>
															</h4>
														</div>
                                       <div class="col-sm-4">
                                                           <div id="stdbarcode">

                                                           
                                                            <asp:Panel ID="pnlPrint1" runat="server">
                                                              
                                                                    <asp:Image ID="img1" runat="server" Style="height: 43px; width: 130px;" /> 
                                                            
              
                                                            </asp:Panel>
                                                        </div>
                                                    </div>
                                                         <div class="col-sm-4">
															<h6 class="pull-right">
																School Copy
																
															</h6>
														</div>
														
													</div>
                                </div>
            </div>
            <div class="col-md-4">
                 <div>
                                     <h3 class="widget-title grey lighter"><i class="ace-icon fa fa-leaf green"></i>
                                                    <asp:Label ID="txtschool3" Text="Schoollllllllll sd" runat="server"></asp:Label>
                                                </h3>
                                   
                                    <table>
                                        <tr>
                                            <td class="invoice-info-label">Challan #..</td><td><span class="red"><asp:Label ID="txtinv3" runat="server"></asp:Label></span></td></tr><tr>
                                            <td class="invoice-info-label">Date.......</td><td><span class="blue">
                                                    <asp:Label ID="txtdate3" runat="server"></asp:Label>
                                                    </span></td></tr><tr>
                                            <td class="invoice-info-label">Due Date...</td><td><span class="blue">
                                                    <asp:Label ID="txtduedate3" runat="server"></asp:Label>
                                                    </span></td></tr><tr>
                                             <td class="invoice-info-label"> Reg #....</td><td>  <asp:Label ID="txtreg3" runat="server"></asp:Label></td></tr><tr>
                                             <td class="invoice-info-label"> Name.....</td><td>   <asp:Label ID="txtname3" runat="server"></asp:Label> </td></tr><tr>
                                             <td class="invoice-info-label"> Class....</td><td>   <asp:Label ID="txtcls3" runat="server"></asp:Label> </td></tr><tr>
                                             <td class="invoice-info-label"> Section..</td><td>  <asp:Label ID="txtsec3" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                    <table class="table table-striped table-bordered">
                                                            <thead>
                                                                
                                                                <tr>
                                                                    <th>Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstFee3" runat="server"></asp:Label>
                                                                     </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Months</th>
                                                                    <td>
                                                                        <asp:Label ID="txtmonths3" runat="server" Text=""></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Late Fee Fine</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstFine3" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Concession</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstConc3" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Remaining Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstRemainingFee3" runat="server"></asp:Label>
                                                                      </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Total Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstTOTFee3" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>Received Fee</th>
                                                                    <td>
                                                                        <asp:Label ID="txtstRcvFee3" runat="server"></asp:Label>
                                                                       </td>
                                                                </tr>
                                                            </thead>
                                                           
                                                        </table>
                                   <div class="row">
														<div class="col-sm-4 pull-right">
															<h4 class="pull-right">
																Total Fee Received :
																<span class="red"><td><asp:Label runat="server" Text="000" ID="txtstTOTRcvfee3"></asp:Label></span>
															</h4>
														</div>
                                       <div class="col-sm-4">
                                                           <div id="Div1">

                                                       
                                                            <asp:Panel ID="pnlPrint2" runat="server">
                                                              
                                                                    <asp:Image ID="img2" runat="server" Style="height: 43px; width: 130px;" /> 
                                                            
              
                                                            </asp:Panel>
                                                        </div>
                                                    </div>
                                                         <div class="col-sm-4">
															<h6 class="pull-right">
																Bank Copy
																
															</h6>
														</div>
														
													</div>
                                </div>
            </div>
                </div>
               
        </div>
                                <label class="width-30 pull-right btn btn-sm btn-success" onclick="printDiv('printable1')"  > Print</label>
    </div>

                        </asp:View>

                        <asp:View runat="server">
                            <div class="widget-body">
                        <div class="widget-main padding-4">
                            <div class="tab-content padding-8 overflow-visible">
                                <!-- member-tab -->
                                
                            <div class="table-responsive">
                                <asp:GridView ID="GVAdmission" class="table table-striped table-bordered table-hover" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="GVAdmissionDS">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Student Reg #" HeaderText="Student Reg #" SortExpression="Student Reg #"></asp:BoundField>
                                        <asp:BoundField DataField="Student Name" HeaderText="Student Name" SortExpression="Student Name" ReadOnly="True"></asp:BoundField>
                                        <asp:BoundField DataField="Class" HeaderText="Class" SortExpression="Class"></asp:BoundField>
                                        <asp:BoundField DataField="Date of Brith" HeaderText="Date of Brith" SortExpression="Date of Brith"></asp:BoundField>
                                          <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnprintREG" runat="server" Text="Print Reg No"  OnClick="btnprintREG_Click" class="width-95 pull-left btn btn-sm btn-success" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="GVAdmissionDS" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT e.bRegisteredNum AS 'Student Reg #', e.strFname + ' ' + e.strLname AS 'Student Name', c.strClass AS 'Class', e.strDOB AS 'Date of Brith' FROM tbl_Enrollment AS e INNER JOIN tbl_Class AS c ON e.nc_id = c.nc_id WHERE (e.bisDeleted = 'True') AND (e.nu_id = @u_id OR e.nu_id = (SELECT nu_id FROM tbl_Users WHERE (strEmail = @em) AND (bisDeleted = 'False'))) AND (e.nsch_id = @schid) AND (c.bisDeleted = @fbit) AND (e.strStatus = @pd)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="u_id" SessionField="uid" Type="Int32" />
                                        <asp:SessionParameter Name="em" SessionField="userval" Type="String" />
                                        <asp:SessionParameter SessionField="nschoolid" Name="schid" />
                                        <asp:Parameter DefaultValue="false" Name="fbit"></asp:Parameter>
                                        <asp:Parameter DefaultValue="Pending" Name="pd"></asp:Parameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
                              

                            </div>
                                 
                                </div>
                            </div>
                                </div>
                        </asp:View>
                    </asp:MultiView>
       </div>
                                </div>
              <%--  </ContentTemplate>
            </asp:UpdatePanel>--%>

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

</asp:Content>

