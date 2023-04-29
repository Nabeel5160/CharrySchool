<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewMessage.aspx.cs" Inherits="SchoolPRO.AdminViewMessage" %>
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
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
     <div class="page-content-area">
        <div class="row">
            <div id="printable" class="col-xs-12">
                <!-- PAGE CONTENT BEGINS -->
                <div class="space-6"></div>

                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <div class="widget-box transparent">
                            <div class="widget-header widget-header-large">
                                <h3 class="widget-title grey lighter">
                                    <i class="ace-icon fa fa-leaf green"></i>
                                    <asp:Label ID="txtSchool" runat="server"></asp:Label>
                                </h3>
                            </div>
                            <%
                                string query = "";
                                Boolean MSGFLAG = false;
                                System.Data.SqlClient.SqlConnection con2 = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
                                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
                                System.Data.SqlClient.SqlDataReader dr;
                                if (Request.QueryString["ms"] == "0")
                                {
                                    query = "SELECT nMsg_id,strMsgTitle,nU_sndr_id,strMsgDesc,dtAddDate from tbl_Message where  bisDeleted=0 and nU_rcv_id='" + Session["uid"] + "' and nsch_id='" + Session["nschoolid"] + "'";
                                }
                                else
                                    query = "SELECT nMsg_id,nU_sndr_id,strMsgTitle,strMsgDesc,dtAddDate from tbl_Message where  bisDeleted=0 and nU_rcv_id='" + Session["uid"] + "' and nMsg_id='" + Request.QueryString["ms"].ToString() + "' and nsch_id='" + Session["nschoolid"] + "'";
                                cmd.Connection = con2;
                                con2.Open();
                                cmd.CommandType = System.Data.CommandType.Text;
                                cmd.CommandText = query;

                                List<enrollment> tempList = null;

                                using (con2)
                                {
                                    dr = cmd.ExecuteReader();
                                    if (dr.HasRows)
                                    {
                                        MSGFLAG = true;
                                        tempList = new List<enrollment>();
                                        while (dr.Read())
                                        {
                                            enrollment c = new enrollment();
                                            c.id = dr["nMsg_id"].ToString();
                                            c.stnum = dr["strMsgTitle"].ToString();
                                            c.vnum = dr["strMsgDesc"].ToString();
                                            c.fee = dr["dtAddDate"].ToString();
                                            c.senid = dr["nU_sndr_id"].ToString();
                                            Session["senderid1"] = dr["nU_sndr_id"].ToString();

                                            tempList.Add(c);
                                        }
                                        tempList.TrimExcess();
                                        con2.Close();

                                    }
                                }        %>
                            <div class="widget-body">
                                <div class="widget-main padding-24">


                                    <% 
                                        if (MSGFLAG)
                                        {
                                            try
                                            {
                                                foreach (var c in tempList)
                                                {
                                    %>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="row">
                                                <div class="col-xs-11 label label-lg label-info arrowed-in arrowed-right">
                                                    <b><%txtEventTitle2.Text = c.stnum; %>
                                                        <asp:Label runat="server" ID="txtEventTitle2"></asp:Label></b>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <ul class="list-unstyled spaced">

                                                     <li><%labname.Text = Session["Aname"].ToString(); %>
                                                    <li class="ace-icon fa fa-caret-right blue"></li>
                                                    Sender Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :
                                                        <asp:Label runat="server" ID="labname"></asp:Label>

                                                    <li><%txtEventDesc.Text = c.vnum; %>
                                                        <i class="ace-icon fa fa-caret-right blue"></i>
                                                        Message  Description&nbsp;&nbsp; :
                                                        <asp:Label runat="server" ID="txtEventDesc"></asp:Label>
                                                    </li>

                                                    <li><%txtEventstDate.Text = c.fee; %>
                                                        <i class="ace-icon fa fa-caret-right blue"></i>
                                                        Message Send Date&nbsp;&nbsp;&nbsp;&nbsp; :
                                                        <asp:Label runat="server" ID="txtEventstDate"></asp:Label></li>


                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <%}
                                            }
                                            catch (Exception ex)
                                            {
                                                Response.Redirect("Error.aspx");
                                            }
                                        }
                                        else
                                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('You Donot have Any Message.'); window.location='TeacherDashBoard.aspx';", true);
                                                         
                                    %>
                                    <div class="space"></div>
                                    <div class="row">
                                    </div>
                                    <div>


                                        <div class="hr hr8 hr-double hr-dotted"></div>
                                        <div class="space-6"></div>
                                        <div class="well">
                                            <div class="align-center">
                                                Powered By AT-Teachsoul , Farmecole School Management Sys | www.farmecole.com
                                                                    0321-9883140
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- PAGE CONTENT ENDS -->
                </div>
                <!-- /.col -->
                <asp:Button ID="btnreply" runat="server" Text="Reply" class="hidden-print width-30 pull-center btn btn-sm btn-success" OnClick="btnreply_Click"/>
                <label class="hidden-print width-30 pull-right btn btn-sm btn-success" onclick="printDiv('printable')">Print</label>
            </div>
            <!-- /.row -->
        </div>
        <!-- /.page-content-area -->
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
