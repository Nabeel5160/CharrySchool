<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewClassStudents.aspx.cs" Inherits="SchoolPRO.AdminViewClassStudents" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
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
    <script type="text/javascript">

        function KeyUp(txtsearch, gvbystnum) {
            if ($(txtsearch).val() != "") {

                $(gvbystnum).children('tbody').children('tr').each(function () {
                    $(this).show();
                });

                $(gvbystnum).children('tbody').children('tr').each(function () {
                    var match = false;
                    if ($(this).text().toUpperCase().indexOf($(txtsearch).val().toUpperCase()) > 0) match = true;
                    if (match) $(this).show();
                    else $(this).hide();
                });
            }
            else {

                $(gvbystnum).children('tbody').children('tr').each(function () {
                    $(this).show();
                });
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div class="row-fluid">
            <%-- <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>--%>
            <asp:ToolkitScriptManager ID="tool1" runat="server"></asp:ToolkitScriptManager>
            <asp:UpdatePanel ID="upt" runat="server">
                <ContentTemplate>
                    <asp:MultiView ID="mvt" ActiveViewIndex="0" runat="server">
                        <asp:View ID="View1" runat="server">
                            <div class="table-responsive">
                                <asp:Button Text="Go Back" class="width-25 pull-left btn btn-sm btn-success" runat="server" ID="btngobck" OnClick="btngobck_Click" />
                                <div class="space-12"></div>
                                <br />
                                <br />
                                <%--<div class="col-md-5">
                                            <asp:TextBox ID="txtsrch" placeholder="Search..." runat="server" class="nav-search-input pull-right" Width="210" OnTextChanged="txtsrch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                        </div>--%>
                                <div class="col-md-5">
                                    <asp:TextBox ID="txtsearch" runat="server" type="text" class="form-control" onkeyup="return KeyUp(this, '#ContentPlaceHolder1_gvbystnum');" placeholder="Search. . . " />
                                </div>
                                <asp:GridView class="table table-striped table-bordered table-hover" AutoGenerateColumns="false" ID="gvbystnum" runat="server">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" DataField="ne_id" HeaderText="S.NO" SortExpression="ne_id" />
                                        <asp:BoundField DataField="strStudentNum" HeaderText="Student Number" SortExpression="strStudentNum" />
                                        <asp:BoundField DataField="strFname" HeaderText="First Name" SortExpression="strFname" />
                                        <asp:BoundField DataField="strLname" HeaderText="Last Name" SortExpression="strLname" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnviewfull" runat="server" Text="View Full Detail" class="pull-left btn btn-success" OnClick="btnviewfull_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnTransfer" runat="server" Text="Transfer to Other Branch" class="pull-left btn btn-success" OnClick="btnTransfer_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnMessagesend" runat="server" Text="Send Message" class=" pull-left btn btn-success" OnClick="btnMessagesend_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sqlbyclst" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [ne_id],[strStudentNum], [strFname], [strLname] FROM [tbl_Enrollment] WHERE ([nc_id] = @nc_id) and nsc_id=@strsec and bisDeleted='False' and nsch_id=@schid1">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="nc_id" SessionField="cid" Type="Int32" />
                                        <asp:SessionParameter Name="strsec" SessionField="__scid" Type="String" />
                                        <asp:SessionParameter Name="schid1" SessionField="nschoolid" />
                                        <asp:SessionParameter Name="schid2" SessionField="nschoolid" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </asp:View>
                        <asp:View runat="server">
                            <%
                                string n = "nill", fee = "Not Paid";
                                System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
                                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
                                System.Data.SqlClient.SqlDataReader dr;
                                string query2 = "select u.strfname+' '+u.strlname+' On '+e.dtUpdate as name from tbl_Enrollment e  inner join tbl_Users u on e.nUpdateByu_id=u.nu_id where e.ne_id='" + Session["id"] + "' and e.bisDeleted=0 and e.nsch_id='" + Session["nschoolid"] + "'";
                                cmd.Connection = con;
                                con.Open();
                                cmd.CommandType = System.Data.CommandType.Text;
                                cmd.CommandText = query2;
                                dr = cmd.ExecuteReader();
                                if (dr.HasRows)
                                {

                                    dr.Read();
                                    n = dr["name"].ToString();
                                }
                                con.Close();
                                try
                                {
                                    string query3 = "SELECT tbl_RecieveFee.strFeeAmount, tbl_RecieveFee.strFeeAmountReceived, tbl_RecieveFee.strFeeAmountRemaining, tbl_RecieveFee.dtAddDate FROM tbl_RecieveFee INNER JOIN tbl_Enrollment ON tbl_RecieveFee.ne_id = tbl_Enrollment.ne_id WHERE tbl_Enrollment.ne_id='" + Session["id"] + "' and tbl_RecieveFee.strRecieveType='Class' and (SUBSTRING(tbl_RecieveFee.dtAddDate,4,2) =SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2)) AND (SUBSTRING(tbl_RecieveFee.dtAddDate ,7,10) = SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,7,10)) AND (tbl_RecieveFee.nsch_id = @nschid)";
                                    cmd.Connection = con;
                                    con.Open();
                                    cmd.CommandType = System.Data.CommandType.Text;
                                    cmd.CommandText = query3;
                                    cmd.Parameters.AddWithValue("@nschid", Session["nschoolid"]);
                                    dr = cmd.ExecuteReader();
                                    if (dr.HasRows)
                                    {

                                        dr.Read();
                                        fee = dr["strFeeAmountReceived"].ToString();
                                    }
                                    con.Close();
                                }
                                catch (Exception)
                                {

                                }





                                string Id = "";
                            %>
                            <%
                                  
                                string query = "select bRegisteredNum,strStudentNum,u.strfname,u.strlname,u.strNIC,c.strClass,f.strTutionFee,e.strImage,e.strFname,e.strLname,e.strDOB,e.strBirthPlace,e.strNationality,e.strMotherlang,e.strReligion,e.strPhAddress,e.strCity,e.strState,e.strCountry,e.nPincode,e.strPhone,e.strEmail,sc.strSection,e.ne_id,e.strAdmissionNumber from tbl_Enrollment e inner join tbl_Class c on e.nc_id=c.nc_id inner join tbl_Fee f on e.nfee_id=f.nfee_id inner join tbl_Section sc on e.nsc_id=sc.nsc_id inner join tbl_Users u on e.nu_id=u.nu_id where e.ne_id='" + Session["id"] + "' and e.bisDeleted=0 and e.nsch_id='" + Session["nschoolid"] + "'";
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
                                            if (dr["bRegisteredNum"].ToString() == "")
                                                c.id = "nill";
                                            else
                                                c.id = dr["bRegisteredNum"].ToString();
                                            c.admano = dr["strStudentNum"].ToString();
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
                                            c.section = dr["strSection"].ToString();
                                            c.gfn = dr["strfname"].ToString();
                                            c.vnum = dr["strlname"].ToString();
                                            c.inc = dr["strNIC"].ToString();
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
                                        <div class="col-xs-12 col-lg-3 col-md-3 col-sm-3">
                                            <div>
                                                <span class="profile-picture">
                                                    <% avatar.ImageUrl = c.image; %><asp:Image ID="avatar" class="editable img-responsive" runat="server" />
                                                    <%--<img ID="avatar" class="editable img-responsive" alt="Alex's Avatar" src="assets/avatars/profile-pic.jpg" />--%>
                                                </span>

                                                <div class="space-4"></div>



                                                <span class="white"><%txtfname.Text = c.efname; %><%txtlname.Text = c.emname; %><asp:TextBox ID="txtfname" ReadOnly="true" runat="server" Text="name"></asp:TextBox><asp:TextBox ID="txtlname" ReadOnly="true" runat="server" Text="name"></asp:TextBox>&nbsp;<%lblmn.Text = c.emname; %><asp:Label ID="lblmn" runat="server" Text="Label"></asp:Label></span>

                                                

                                                <asp:Button ID="btnimageupdate" CssClass="btn-success" runat="server" Text="Update Image" OnClick="btnimageupdate_Click" />

                                            </div>

                                            <div class="space-6"></div>



                                            <div class="hr hr12 dotted"></div>
                                            <div class="hr hr16 dotted"></div>
                                        </div>

                                        <div class="col-xs-12 col-sm-9">


                                            <div class="space-12"></div>

                                            <div class="profile-user-info profile-user-info-striped">

                                                <div class=" profile-info-row">
                                                    <div class="profile-info-name">Admn. # </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span13"><%lblid.Text = c.id;  %><asp:Label ID="lblid" runat="server"></asp:Label></span>
                                                    </div>
                                                </div>

                                                <div class=" profile-info-row">
                                                    <div class="profile-info-name">Roll No. </div>

                                                    <%--<div class="profile-info-value">
                                                        <span class="editable" id="Span18"><%labadmno.Text = c.admano;  %><asp:TextBox ReadOnly="true" CssClass="form-control" ID="labadmno" runat="server"></asp:TextBox>
                                                           <span> <asp:RequiredFieldValidator ValidationGroup="add" ID="RequiredFieldValidator2" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter Admission Number" ControlToValidate="labadmno" runat="server" />
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationGroup="add" ForeColor="Red" Font-Bold="true" ErrorMessage="Only Digits(0-9)" ValidationExpression="^\d+$" ControlToValidate="labadmno" runat="server" />
                                                           </span></span>
                                                    </div>--%>
                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span18"><%labrollno.Text = c.admano;  %><asp:TextBox ReadOnly="true" CssClass="form-control" ID="labrollno" runat="server"></asp:TextBox>
                                                            <span>
                                                                <asp:RequiredFieldValidator ValidationGroup="add" ID="RequiredFieldValidator2" ForeColor="Red" Font-Bold="true" ErrorMessage="Enter Roll Number" ControlToValidate="labrollno" runat="server" />
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationGroup="add" ForeColor="Red" Font-Bold="true" ErrorMessage="Only Digits(0-9)" ValidationExpression="^\d+$" ControlToValidate="labrollno" runat="server" />
                                                            </span></span>
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
                                                        <span class="editable" id="age"><%lbldob.Text = c.dob; %><asp:TextBox ReadOnly="true" CssClass="form-control" ID="lbldob" runat="server"></asp:TextBox>
                                                        </span>
                                                    </div>


                                                    <div class="profile-info-row" style="z-index: 10000;">
                                                        <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="lbldob" runat="server"></asp:CalendarExtender>
                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">BirthPlace </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span1"><%lblbp.Text = c.bplace; %><asp:TextBox ReadOnly="true" CssClass="form-control" ID="lblbp" runat="server" Text="Label"></asp:TextBox></span>
                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Nationality </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span2"><%lblntn.Text = c.nationality; %><asp:TextBox ReadOnly="true" CssClass="form-control" ID="lblntn" runat="server" Text="Label"></asp:TextBox></span>
                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Mother Language </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span3"><%lblmlng.Text = c.mlang; %><asp:TextBox ReadOnly="true" CssClass="form-control" ID="lblmlng" runat="server" Text="Label"></asp:TextBox></span>
                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Religion </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span4"><%lblrelg.Text = c.religion; %><asp:TextBox ReadOnly="true" CssClass="form-control" ID="lblrelg" runat="server" Text="Label"></asp:TextBox></span>
                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Address </div>

                                                    <div class="profile-info-value">

                                                        <span class="editable" id="country"><%lbladr.Text = c.adrs; %><asp:TextBox ReadOnly="true" CssClass="form-control" ID="lbladr" runat="server" Text="Label"></asp:TextBox></span>

                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">City </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span6"><%lblcit.Text = c.city; %><asp:TextBox ReadOnly="true" CssClass="form-control" ID="lblcit" runat="server" Text="Label"></asp:TextBox></span>
                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">State </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span8"><%lblst.Text = c.state; %><asp:TextBox ReadOnly="true" CssClass="form-control" ID="lblst" runat="server" Text="Label"></asp:TextBox></span>
                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Country </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span7"><%lblcnt.Text = c.country; %><asp:TextBox ReadOnly="true" CssClass="form-control" ID="lblcnt" runat="server" Text="Label"></asp:TextBox></span>
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
                                                        <span class="editable" id="Span10"><%lblph.Text = c.phn; %><asp:TextBox ReadOnly="true" CssClass="form-control" ID="lblph" MaxLength="15" runat="server" Text="Label"></asp:TextBox><asp:RegularExpressionValidator ErrorMessage="Phone Number Should in Digits up to 15 digits" ControlToValidate="lblph" runat="server" ValidationExpression="^\d+$" /></span>
                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Gardian Name </div>

                                                    <div class="profile-info-value">
                                                        <span id="Span14"><%txtgfnm.Text = c.gfn; %><%txtglnm.Text = c.vnum; %><asp:TextBox ID="txtgfnm" ReadOnly="true" runat="server"></asp:TextBox><asp:TextBox ID="txtglnm" ReadOnly="true" runat="server"></asp:TextBox></span>
                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Gardian CNIC No. </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span15"><%txtgdnic.Text = c.inc; %><asp:TextBox ID="txtgdnic" ReadOnly="true" runat="server" Text="Label"></asp:TextBox></span>
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
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Class Section </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span12"><%lblclsc.Text = c.section; %><asp:Label ID="lblclsc" runat="server" Text="Label"></asp:Label></span>
                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name"><span>Fee Paid for This Month </span></div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span17"><%txtfee.Text = fee; %><asp:Label ID="txtfee" runat="server" Text="Label"></asp:Label>
                                                            <br />
                                                            <br />
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="profile-info-row">
                                                    <div class="profile-info-name">Last Updated By </div>

                                                    <div class="profile-info-value">
                                                        <span class="editable" id="Span16"><%upuser.Text = n; %><asp:Label ID="upuser" runat="server" Text="Label"></asp:Label></span>
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
                                            <asp:Button ID="btnEdit" runat="server" Text="Click to Update RECORD" class="width-65 pull-left btn btn-sm btn-success" OnClick="btnEdit_Click" />
                                            <asp:Button Visible="false" ID="btnupdatestudent" runat="server" Text="UPDATE RECORD" class="width-65 pull-left btn btn-sm btn-success" OnClick="btnupdatestudent_Click" />

                                            <asp:Button ID="btnuedit" runat="server" Text="Go Back" class="width-65 pull-left btn btn-sm btn-success" OnClick="btnuedit_Click" />
                                            <div class="hr hr2 hr-double"></div>

                                            <div class="space-6"></div>


                                        </div>
                                    </div>
                                </div>

                            </div>
                        </asp:View>




                        <asp:View runat="server">
                            <div class="login-container">
                                <div class="position-relative">
                                    <div class="no-border">
                                        <div class="widget-body">
                                            <div class="widget-main">
                                                <h4 class="header green lighter bigger">
                                                    <i class="icon-group blue"></i>
                                                    Send Message
                                                </h4>

                                                <%--<div class="space-6"></div>--%>
                                                <form id="freg">
                                                    <fieldset>


                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:CheckBox runat="server" ID="chkstd" Text="Message Send To Student" />
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>


                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txttitle" placeholder="Message Tittle" CssClass="form-actions" runat="server"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <label class="block clearfix">
                                                            <span class="block input-icon input-icon-right">
                                                                <asp:TextBox ID="txtDiscreption" placeholder="Message Discription" CssClass="form-actions" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                                <i class="icon-user"></i>
                                                            </span>
                                                        </label>
                                                        <asp:Button ID="btnsend" runat="server" Text="Send" class="width-65 pull-left btn btn-sm btn-success" OnClick="btnsend_Click" />

                                                    </fieldset>
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
        </div>
    </div>
</asp:Content>


