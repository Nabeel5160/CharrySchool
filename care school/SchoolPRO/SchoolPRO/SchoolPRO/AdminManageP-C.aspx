<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageP-C.aspx.cs" Inherits="SchoolPRO.AdminManageP_C" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <script type="text/javascript">
        function ismaxlength(objTxtCtrl, nLength) {
            //if (objTxtCtrl.getAttribute && objTxtCtrl.value.length > nLength)
            //    objTxtCtrl.value = objTxtCtrl.value.substring(0, nLength)

            //if (document.all)
            //    document.getElementById('lblCaption').innerText = objTxtCtrl.value.length + ' Out Of ' + nLength;
            //else
            //    document.getElementById('lblCaption').textContent = objTxtCtrl.value.length + ' Out Of ' + nLength;
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
        function ismaxlength1(objTxtCtrl, nLength) {
            //if (objTxtCtrl.getAttribute && objTxtCtrl.value.length > nLength)
            //    objTxtCtrl.value = objTxtCtrl.value.substring(0, nLength)

            //if (document.all)
            //    document.getElementById('lblCaption1').innerText = objTxtCtrl.value.length + ' Out Of ' + nLength;
            //else
            //    document.getElementById('lblCaption1').textContent = objTxtCtrl.value.length + ' Out Of ' + nLength;
            document.getElementById('lblCaption1').style.display = "none";
            document.getElementById('lblCaption1').innerText = "You Are Exceeding the Size Limit";


            if (objTxtCtrl.value.length > nLength) {
                document.getElementById('lblCaption1').style.display = "block";
                document.getElementById('lblCaption1').style.color = "red";
                objTxtCtrl.value = objTxtCtrl.value.substring(0, nLength);
            }
            else
                document.getElementById('lblCaption1').style.display = "none";

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
    <asp:ToolkitScriptManager ID="tool1" runat="server"></asp:ToolkitScriptManager>
    <div class="col-xs-12">
        <div class="col-lg-12">
                    <h5 style="color:red">Instruction</h5>
            <ul>
                <li>Add Student Details and Parent Details Who Already Exists In Your School</li>
            </ul>
                </div>
        <asp:Label ID="lblSection" Visible="false" runat="server"></asp:Label>
        <!-- PAGE CONTENT BEGINS -->
        <div class="row-fluid">

            <div>
                <div class="position-relative">
                    <div class="no-border">
                        <%--<div class="widget-body">--%>
                        <div class="widget-main">
                            <div class="col-lg-offset-3 col col-lg-6" style="background: #f2f2f2;">
                                <h4 class="header green lighter bigger">
                                    <i class="icon-group blue"></i>
                                    Guardian & Child Registration
                                </h4>
                                <% if (Request.QueryString["ch"] == "1")
                                   {
                                %>
                                <div class="alert alert-success" role="alert">Record Added</div>
                                <%} %>
                                <div class="space-6"></div>
                                <p>Enter detail to begin: </p>



                                <form id="freg">
                                    <fieldset>
                                        <div class="form-group">



                                            <div class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtsfn" class="form-control" placeholder="Student First Name"  runat="server" ></asp:TextBox>
                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator14" runat="server" ErrorMessage="Enter First Name" ControlToValidate="txtsfn"></asp:RequiredFieldValidator>
                                                <i class="icon-user"></i>
                                            </div>
                                            <div class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtsln" class="form-control" placeholder=" Student Last Name" runat="server"></asp:TextBox>
                                                <div class="clearfix"></div>
                                                <br />
                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage="Please enter only alphanumeric." ValidationExpression="^[A-Za-zÀ-ú]"></asp:RequiredFieldValidator><i class="icon-user"></i>--%>
                                            </div>
                                            <div class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtadmnumber" class="form-control" placeholder="Admission Number" runat="server"></asp:TextBox>
                                                <div class="clearfix"></div>
                                                <asp:RequiredFieldValidator ControlToValidate="txtadmnumber" ID="RequiredFieldValidasstor15" runat="server" ErrorMessage="Only Digits" ValidationExpression="^\d+$"></asp:RequiredFieldValidator><i class="icon-user"></i>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="text-center">Admission Date :</label>
                                            <div class="form-group">
                                                <asp:TextBox ID="txtadmsndate" class="form-control" placeholder="Admission Date(dd-MM-yyyy)" runat="server" MaxLength="10" onkeyup="return ismaxlength(this,10)"></asp:TextBox>
                                                <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender1" TargetControlID="txtadmsndate" runat="server"></asp:CalendarExtender>
                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator21" runat="server" ErrorMessage="Enter Date Again Please" ValidationExpression="^[\s\S]{10,10}$" ControlToValidate="txtadmsndate"></asp:RequiredFieldValidator>
                                                <label id='lblCaption' style="font-family: Tahoma; font-size: 1em; font-weight: bold" cssclass="red"></label>
                                                <asp:RegularExpressionValidator ID="datecheck" runat="server" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ForeColor="Red" Font-Bold="true" ControlToValidate="txtadmsndate" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="text-center">Student Date of Brith :</label>
                                            <asp:TextBox ID="txtdob" class="form-control" placeholder="Date of Birth(dd-MM-yyyy)" runat="server" onkeyup="return ismaxlength1(this,10)" MaxLength="10"></asp:TextBox>
                                            <asp:CalendarExtender Format="dd-MM-yyyy" ID="CalendarExtender2" TargetControlID="txtdob" runat="server"></asp:CalendarExtender>
                                            <label id='lblCaption1' style="font-family: Tahoma; font-size: 1em; font-weight: bold" cssclass="red"></label>



                                            <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Date of Birth" ControlToValidate="txtdob"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="Please enter date in dd-mm-yyyy format" ToolTip="Please enter date in dd-mm-yyyy format" Display="Dynamic" ForeColor="Red" Font-Bold="true" ControlToValidate="txtdob" ValidationExpression="(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[012])-\d{4}"></asp:RegularExpressionValidator>
                                        </div>
                                        <div class="form-group">
                                            <div class="block input-icon input-icon-right">
                                                <asp:DropDownList ID="ddcl" Width="250px" runat="server" CssClass="input-medium" AutoPostBack="true" OnSelectedIndexChanged="ddcl_SelectedIndexChanged" DataTextField="strClass" DataValueField="nc_id" AppendDataBoundItems="True">
                                                    <asp:ListItem>Select Class</asp:ListItem>
                                                </asp:DropDownList>
                                                <%--<asp:SqlDataSource ID="sqlclass" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [nc_id],[strClass] FROM [tbl_Class] where bisDeleted=0 and nsch_id=@schid" OnSelecting="sqlclass_Selecting">
                                                    <SelectParameters>
                                                        <asp:SessionParameter Name="schid" SessionField="nschoolid" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>--%>

                                                <asp:DropDownList AutoPostBack="true" Width="250px" ID="ddsec" runat="server" CssClass="input-medium" DataTextField="strSection" DataValueField="nsc_id" OnSelectedIndexChanged="ddsec_SelectedIndexChanged" AppendDataBoundItems="True">
                                                    <asp:ListItem>Select Section</asp:ListItem>
                                                </asp:DropDownList>
                                                <%--<asp:SqlDataSource ID="sqlsec" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [nsc_id],[strSection] FROM [tbl_Section] where nc_id=(@cid) and bisDeleted=0 and nsch_id=@schid2">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="ddcl" Name="cid" Type="String" />
                                                        <asp:SessionParameter Name="schid1" SessionField="nschoolid" />
                                                        <asp:SessionParameter Name="schid2" SessionField="nschoolid" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>--%>

                                                <asp:Label ID="lblSectionn" runat="server" Visible="false" class="text-center"> Section :</asp:Label>
                                                <asp:TextBox ID="SelectedSec" class="form-control" placeholder=" Section" runat="server" Enabled="false" Visible="false"></asp:TextBox>

                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <div class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtstnum" ReadOnly="true" class="form-control" placeholder="Student Roll Num" runat="server" OnTextChanged="txtstnum_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter First Name" ControlToValidate="txtstnum"></asp:RequiredFieldValidator>
                                                <i class="icon-user"></i>
                                            </div>
                                            <div class="block input-icon input-icon-right">
                                                <label class="col-sm-3 control-label no-padding-right" for="form-field-1">Class Fee:</label>
                                                <asp:TextBox data-rel="tooltip" title="This is Class Fee!" data-placement="bottom" ID="txtclfee" ReadOnly="true" placeholder="Class Fee" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="block input-icon input-icon-right">
                                                 <label class="col-sm-3 control-label no-padding-right" for="form-field-1">Enter Discount:</label>
                                                <asp:TextBox data-rel="tooltip" title="Enter Fee Discount Here!" data-placement="bottom" ID="txtdisc" placeholder="Student Fee Discount" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="block input-icon input-icon-right">

                                                <asp:TextBox ID="txtstnic" MaxLength="13" AutoPostBack="true" OnTextChanged="txtstnic_TextChanged" class="form-control" placeholder="Student NIC or Nadara Brith Certificate No." runat="server"></asp:TextBox>
                                                <%--<asp:RegularExpressionValidator CssClass="red" runat="server" ID="RegularExpressionValidator3"
                                                    ControlToValidate="txtstnic" ErrorMessage="Range must be in 14 Character long!"
                                                    ValidationExpression="(\d{13})?" />--%>
                                                <div class="clearfix"></div>
                                            </div>

                                            <div class="block input-icon input-icon-right">
                                                <asp:DropDownList ID="ddshft" CssClass="input-medium" runat="server" Width="250px">
                                                    <asp:ListItem>Select Your Shift</asp:ListItem>
                                                    <asp:ListItem Selected="True">Morning</asp:ListItem>
                                                    <asp:ListItem>Evening</asp:ListItem>
                                                </asp:DropDownList>


                                                <asp:DropDownList ID="ddgaurd" CssClass="input-medium" runat="server" Width="250px">
                                                    <asp:ListItem>Select Relation</asp:ListItem>

                                                    <asp:ListItem Selected="True">Parents</asp:ListItem>
                                                    <asp:ListItem>Guardian</asp:ListItem>
                                                    <asp:ListItem>Donor</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:DropDownList ID="ddsex" CssClass="input-medium" runat="server" Width="250px">
                                                    <asp:ListItem>Select Gender</asp:ListItem>
                                                    <asp:ListItem>Male</asp:ListItem>
                                                    <asp:ListItem>Female</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <%--                                        <label class="clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:DropDownList ID="dddonr" CssClass="input-medium" DataSourceID="sqldonor" DataValueField="strfname" DataTextField="strfname" runat="server"></asp:DropDownList>
                                                <asp:SqlDataSource ID="sqldonor" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolPro %>" SelectCommand="SELECT [strfname] FROM [tbl_Users] where strRelation='Donor'"></asp:SqlDataSource>

                                            </span>
                                        </label>--%>
                                        <div class="form-group">

                                            <div class="block input-icon input-icon-right">

                                                <asp:TextBox MaxLength="13" ID="txtnic" class="form-control" AutoPostBack="true" placeholder="Father NIC" OnTextChanged="txtnic_TextChanged" runat="server"></asp:TextBox>
                                                <%--<asp:RegularExpressionValidator CssClass="red" runat="server" ID="ZipCodeValidator" ControlToValidate="txtnic" ErrorMessage="Range must be in 14 Character long!" ValidationExpression="(\d{13})?" />--%>
                                            </div>

                                            <asp:TextBox ID="txtgfn" class="form-control" placeholder="Father First Name" runat="server" ></asp:TextBox>
                                            <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator16" runat="server" ErrorMessage="Enter First Name" ControlToValidate="txtgfn"></asp:RequiredFieldValidator>

                                            <div class="form-group">
                                                <asp:TextBox ID="txtgln" class="form-control" placeholder=" Father Last Name" runat="server"></asp:TextBox>

                                                <%--<asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator17" runat="server" ErrorMessage="Enter Last Name" ControlToValidate="txtgln"></asp:RequiredFieldValidator>--%>
                                            </div>
                                            <asp:TextBox ID="txtgnic" class="form-control" placeholder=" Father NIC" runat="server"></asp:TextBox>

                                            <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter NIC" ControlToValidate="txtgnic"></asp:RequiredFieldValidator>


                                        </div>
                                        <div class="form-group">
                                            <asp:TextBox ID="txtgardnic" MaxLength="13" class="form-control" placeholder="Guardian CNIC" runat="server"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidassstosdr4" CssClass="red" ErrorMessage="Enter Guardian CNIC if any (0-9)" ControlToValidate="txtgardnic" ValidationExpression="^\d*$" runat="server" />

                                            <div class="form-group">
                                                <asp:TextBox ID="txtgardname" class="form-control" placeholder="Guardian Name" runat="server"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" CssClass="red" ErrorMessage="Invalid Input" ControlToValidate="txtgardname" ValidationExpression="^[a-zA-Z''-'\s]*$" runat="server" />


                                            </div>



                                        </div>

                                        <label class=" clearfix">

                                            <asp:TextBox ID="txtbplace" Text="Rawalpindi" class="form-control" placeholder="Birth Place" runat="server"></asp:TextBox>


                                            <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter Birth Place" ControlToValidate="txtbplace"></asp:RequiredFieldValidator>

                                        </label>

                                        <label class=" clearfix">

                                            <asp:TextBox ID="txtnt" Text="Pakistani" class="form-control" placeholder="Nationailty" runat="server"></asp:TextBox>

                                            <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator18" runat="server" ErrorMessage="Enter Nationality" ControlToValidate="txtnt"></asp:RequiredFieldValidator>

                                        </label>

                                        <label class=" clearfix">

                                            <asp:TextBox ID="txtlng" Text="Urdu" class="form-control" placeholder="Mother Language" runat="server"></asp:TextBox>

                                            <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator19" runat="server" ErrorMessage="Please Enter Mother Language" ControlToValidate="txtlng"></asp:RequiredFieldValidator>

                                        </label>

                                        <label class=" clearfix">

                                            <asp:TextBox ID="txtrelg" Text="Islam" class="form-control" placeholder="Religion" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator20" runat="server" ErrorMessage="Enter Religion" ControlToValidate="txtrelg"></asp:RequiredFieldValidator>

                                        </label>
                                        <div class="clearfix"></div>
                                        <label class="block clearfix">

                                            <asp:TextBox ID="txtadrs" class="form-control" placeholder="Address" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator13" runat="server" ErrorMessage="Enter Your Address" ControlToValidate="txtadrs"></asp:RequiredFieldValidator>


                                        </label>
                                        <div class="clearfix"></div>
                                        <div class="clearfix"></div>
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtcity" Text="Rawalpindi" class="form-control" placeholder="City" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please Enter your City" ControlToValidate="txtcity"></asp:RequiredFieldValidator>
                                                <i class="icon-user"></i>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtstate" Text="Punjab" class="form-control" placeholder="State" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator8" runat="server" ErrorMessage="Enter Your State" ControlToValidate="txtstate"></asp:RequiredFieldValidator>
                                                <i class="icon-user"></i>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtcntry" Text="Pakistan" class="form-control" placeholder="Country" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator9" runat="server" ErrorMessage="Please Enter your country" ControlToValidate="txtcntry"></asp:RequiredFieldValidator>
                                                <i class="icon-user"></i>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtpcode" Text="4600" class="form-control" placeholder="Postal Code" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator10" runat="server" ErrorMessage="Enter your Postal Code" ControlToValidate="txtpcode"></asp:RequiredFieldValidator>
                                                <i class="icon-user"></i>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtphn" class="form-control" placeholder="Phone" runat="server" ></asp:TextBox>
                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator11" runat="server" ErrorMessage="Enter your Phone No" ControlToValidate="txtphn"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="red"  ControlToValidate="txtphn" ValidationExpression="^\d*$" runat="server" />

                                                <i class="icon-user"></i>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <asp:TextBox ID="txtmobile" class="form-control" placeholder="Mobile" runat="server" ></asp:TextBox>
                                                <asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator12" runat="server" ErrorMessage="Please Enter Your Mobile No" ControlToValidate="txtmobile"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="red" ControlToValidate="txtmobile" ValidationExpression="^\d*$" runat="server" />

                                                <i class="icon-user"></i>
                                            </span>
                                        </label>
                                        <div class="clearfix"></div>
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <label class="text-center">Guardian/Father Email :</label>
                                                <asp:TextBox ID="txtem" TextMode="Email" Text="" class="form-control" placeholder="@hss.com" runat="server"></asp:TextBox>
                                                <%--<asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter Your Complete Email" ControlToValidate="txtem" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>--%>

                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <label class="text-center"></label>
                                                <asp:TextBox ID="txtpwd" TextMode="Password" class="form-control" placeholder="Guardian/Father Password" runat="server"></asp:TextBox>
                                                <%--<asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Password" ControlToValidate="txtpwd"></asp:RequiredFieldValidator>--%>

                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <label class="text-center"></label>
                                                <asp:TextBox ID="txtrepass" TextMode="Password" class="form-control" placeholder="Repeat Password" runat="server" ControlToValidate="txtrepass"></asp:TextBox>
                                                <%--<asp:CompareValidator CssClass="red" ID="CompareValidator1" runat="server" ErrorMessage="Password Does not match" ControlToValidate="txtrepass" ControlToCompare="txtpwd"></asp:CompareValidator>--%>

                                            </span>
                                        </label>
                                        <div class="clearfix"></div>
                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <label class="text-center">Student Email :</label>
                                                <asp:TextBox ID="txtsemail" TextMode="Email" Text="" class="form-control" placeholder="@hss.com" runat="server"></asp:TextBox>
                                                <%--<asp:RegularExpressionValidator CssClass="red" ID="RegularExpressionValidator2" runat="server" ErrorMessage="Enter Your Complete Email" ControlToValidate="txtsemail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>--%>
                                                <i class="icon-envelope"></i>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <label class="text-center"></label>
                                                <asp:TextBox ID="txtspwd" TextMode="Password" class="form-control" placeholder="Student Password" runat="server"></asp:TextBox>
                                                <%--<asp:RequiredFieldValidator CssClass="red" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Password" ControlToValidate="txtspwd"></asp:RequiredFieldValidator>--%>
                                                <i class="icon-lock"></i>
                                            </span>
                                        </label>

                                        <label class=" clearfix">
                                            <span class="block input-icon input-icon-right">
                                                <label class="text-center"></label>
                                                <asp:TextBox ID="txtsrpswd" TextMode="Password" class="form-control" placeholder="Student Password" runat="server" ControlToValidate="txtsrpswd"></asp:TextBox>
                                                <%--<asp:CompareValidator CssClass="red" ID="CompareValidator2" runat="server" ErrorMessage="Password Does not match" ControlToValidate="txtspwd" ControlToCompare="txtsrpswd"></asp:CompareValidator>--%>
                                                <i class="icon-retweet"></i>
                                            </span>
                                        </label>

                                        <%--<label class=" clearfix">
                                            <span class=" input-icon input-icon-right">Select Guardian Image
                                                <asp:FileUpload ID="fstimg" runat="server" />
                                                <i class="icon-picture"></i>
                                            </span>
                                        </label>--%>
                                        <label class=" clearfix">
                                            <span class=" input-icon input-icon-right">Select Student Image
                                                <asp:FileUpload ID="fustimg" runat="server" />
                                                <i class="icon-picture"></i>
                                            </span>
                                        </label>
                                        <div class="space-24"></div>

                                        <div class="clearfix">
                                            <%--<asp:Button ID="btnreset" runat="server" Text="Reset" class="width-30 pull-left btn btn-sm " OnClick="btnreset_Click" />--%>

                                            <asp:Button ID="btnreg" runat="server" Text="Register" class="width-65 pull-right btn btn-sm btn-success" OnClick="btnreg_Click" />
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
