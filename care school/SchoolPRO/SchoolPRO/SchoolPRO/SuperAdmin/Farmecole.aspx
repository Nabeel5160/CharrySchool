<%@ Page Title="SuperAdmin" Language="C#" MasterPageFile="~/SuperAdmin/admin.Master" AutoEventWireup="true" CodeBehind="Farmecole.aspx.cs" Inherits="SchoolPRO.SuperAdmin.home" %>

<%@ Import Namespace="SchoolPRO" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        System.Data.SqlClient.SqlConnection con2 = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();

        System.Data.SqlClient.SqlDataReader dr;
        Boolean hasflag = false;
        List<enrollment> tempList = null;
        try
        {
            string query = "SELECT sch.nsch_id,sch.strSchName,sch.strAddress,sch.strPhone,u.strfname+' '+u.strlname as pname,u.strPhone as p_phone from tbl_School sch inner join tbl_Users u On sch.nu_id=u.nu_id  where sch.bisDeleted=0";
            cmd.Connection = con2;
            con2.Open();
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.CommandText = query;



            using (con2)
            {
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    hasflag = true;
                    tempList = new List<enrollment>();
                    while (dr.Read())
                    {
                        enrollment c = new enrollment();
                        c.id = dr["nsch_id"].ToString();
                        c.stnum = dr["strSchName"].ToString();
                        c.adrs = dr["strAddress"].ToString();
                        c.phn = dr["strPhone"].ToString();
                        c.emname = dr["pname"].ToString();
                        c.email = dr["p_phone"].ToString();

                        tempList.Add(c);
                    }
                    tempList.TrimExcess();
                    con2.Close();

                }
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("Error.aspx");
        }
        finally
        {
            if (con2.State == System.Data.ConnectionState.Open)
            {
                con2.Close();
            }
        }        %>


    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"> Statistics Overview
            </h1>
           <%-- <ol class="breadcrumb">
                <li class="active">
                    <i class="fa fa-dashboard"></i>
                </li>
            </ol>--%>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
    </div>
    <div class="row">
        <div class="col-lg-12">
            <%--<div class="alert alert-info alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <i class="fa fa-info-circle"></i><strong>Like FARMecole...?</strong> Try out <a href="#" class="alert-link">FARMecole  Admin</a> for additional features!
            </div>--%>
        </div>
    </div>
    <!-- /.row -->

    <div class="row">
        <%
            if (hasflag)
            {
                try
                {
                    foreach (var c in tempList)
                    {
                        int present = 0, absent = 0, totstd = 0, totFemalestd = 0, totmalestd = 0;
                        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
                        try
                        {

                            cmd.Connection = con;
                            con.Open();
                            cmd.CommandType = System.Data.CommandType.Text;
                            //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Present' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                            cmd.CommandText = "SELECT  COUNT(*) AS Expr1 FROM (SELECT ne_id FROM  tbl_Attendance  WHERE (strStatus = 'Present') AND (SUBSTRING(dtAddDate ,1,2)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,1,2)) AND (SUBSTRING(dtAddDate ,4,2)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2)) AND (bisDeleted = 'False') AND (nsch_id = '" + c.id + "') GROUP BY ne_id) AS tbl1";

                            present = Convert.ToInt32(cmd.ExecuteScalar());
                            //if (present > 0)
                            //{

                            //}
                            con.Close();
                        }
                        catch (Exception ex)
                        { }
                        finally
                        {
                            if (con.State == System.Data.ConnectionState.Open)
                            {
                                con.Close();
                            }
                        }
                        try
                        {
                            cmd.Connection = con;
                            con.Open();
                            cmd.CommandType = System.Data.CommandType.Text;
                            //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Present' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                            cmd.CommandText = "SELECT  COUNT(*) AS Expr1 FROM (SELECT ne_id FROM  tbl_Attendance  WHERE (strStatus = 'Absent') AND (SUBSTRING(dtAddDate ,1,2)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,1,2)) AND (SUBSTRING(dtAddDate ,4,2)=SUBSTRING(CONVERT(VARCHAR(10), GETDATE(), 105 ) ,4,2)) AND (bisDeleted = 'False') AND (nsch_id = '" + c.id + "') GROUP BY ne_id) AS tbl1";

                            absent = Convert.ToInt32(cmd.ExecuteScalar());
                            //if (present > 0)
                            //{

                            //}
                            con.Close();
                        }
                        catch (Exception ex)
                        { }
                        finally
                        {
                            if (con.State == System.Data.ConnectionState.Open)
                            {
                                con.Close();
                            }
                        }
                        try
                        {
                            cmd.Connection = con;
                            con.Open();
                            cmd.CommandType = System.Data.CommandType.Text;
                            //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Present' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                            cmd.CommandText = "Select count(*) from tbl_Enrollment where bisDeleted='False' AND (nsch_id = '" + c.id + "')";

                            totstd = Convert.ToInt32(cmd.ExecuteScalar());
                            //if (present > 0)
                            //{

                            //}
                            con.Close();
                        }
                        catch (Exception ex)
                        { }
                        finally
                        {
                            if (con.State == System.Data.ConnectionState.Open)
                            {
                                con.Close();
                            }
                        }
                        try
                        {
                            cmd.Connection = con;
                            con.Open();
                            cmd.CommandType = System.Data.CommandType.Text;
                            //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Present' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                            cmd.CommandText = "Select count(*) from tbl_Enrollment where bisDeleted='False' AND (nsch_id = '" + c.id + "') and strGender='Male'";

                            totmalestd = Convert.ToInt32(cmd.ExecuteScalar());
                            //if (present > 0)
                            //{

                            //}
                            con.Close();
                        }
                        catch (Exception ex)
                        { }
                        finally
                        {
                            if (con.State == System.Data.ConnectionState.Open)
                            {
                                con.Close();
                            }
                        }
                        try
                        {
                            cmd.Connection = con;
                            con.Open();
                            cmd.CommandType = System.Data.CommandType.Text;
                            //cmd.CommandText = "select count(strStatus) from tbl_TeacherAttendance where strStatus='Present' and nu_id=(select nu_id from tbl_Users where strlname='" + ddenm.Text + "' and nLevel=2 or nLevel=4)";
                            cmd.CommandText = "Select count(*) from tbl_Enrollment where bisDeleted='False' AND (nsch_id = '" + c.id + "') and strGender='Female'";

                            totFemalestd = Convert.ToInt32(cmd.ExecuteScalar());
                            //if (present > 0)
                            //{

                            //}
                            con.Close();
                        }
                        catch (Exception ex)
                        { }
                        finally
                        {
                            if (con.State == System.Data.ConnectionState.Open)
                            {
                                con.Close();
                            }
                        }
                                                                 
                                                                 
        %>
        <div class="col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-clock-o fa-fw"></i><% lblschName.Text = c.stnum; %><asp:Label runat="server" ID="lblschName" Text="School11"></asp:Label></h3>
                </div>
                <div class="panel-body">
                    <div class="list-group">
                        <a href="#" class="list-group-item">
                            <span class="badge">Address</span>
                            <i class="fa fa-fw fa-calendar"></i><% lblschAddress.Text = c.adrs; %><asp:Label runat="server" ID="lblschAddress" Text="School11"></asp:Label>
                        </a>
                        <a href="#" class="list-group-item">
                            <span class="badge">Contact</span>
                            <i class="fa fa-fw fa-comment"></i><% lblschContact.Text = c.phn; %><asp:Label runat="server" ID="lblschContact" Text="School11"></asp:Label>
                        </a>
                        <a href="#" class="list-group-item">
                            <span class="badge">Principal</span>
                            <i class="fa fa-fw fa-user"></i><% lblschPrnc.Text = c.emname; %><asp:Label runat="server" ID="lblschPrnc" Text="School11"></asp:Label>
                        </a>
                        <a href="#" class="list-group-item">
                            <span class="badge">Principal Phone</span>
                            <i class="fa fa-fw fa-phone"></i><% lblschP_phone.Text = c.email; %><asp:Label runat="server" ID="lblschP_phone" Text="School11"></asp:Label>
                        </a>
                        <a href="#" class="list-group-item">
                            <span class="badge">Total Students</span>
                            <i class="fa fa-fw fa-users"></i><% lblschTotStd.Text = totstd.ToString(); %><asp:Label runat="server" ID="lblschTotStd" Text="School11"></asp:Label>
                        </a>
                        <a href="#" class="list-group-item">
                            <span class="badge">Male Students</span>
                            <i class="fa fa-fw fa-check"></i><% lblschMaleStd.Text = totmalestd.ToString(); %><asp:Label runat="server" ID="lblschMaleStd" Text="School11"></asp:Label>
                        </a>
                        <a href="#" class="list-group-item">
                            <span class="badge">Female Students</span>
                            <i class="fa fa-fw fa-female"></i><% lblschFemaleStd.Text = totFemalestd.ToString(); %><asp:Label runat="server" ID="lblschFemaleStd" Text="School11"></asp:Label>
                        </a>
                        <a href="#" class="list-group-item">
                            <span class="badge">Absent Students Today</span>
                            <i class="fa fa-fw fa-thumbs-o-down"></i><% lblschAbsntStd.Text = absent.ToString(); %><asp:Label runat="server" ID="lblschAbsntStd" Text="School11"></asp:Label>
                        </a>
                        <a href="#" class="list-group-item">
                            <span class="badge">Present Students Today</span>
                            <i class="fa fa-fw fa-check"></i><% lblschPrsntStd.Text = present.ToString(); %><asp:Label runat="server" ID="lblschPrsntStd" Text="School11"></asp:Label>
                        </a>
                        <a href="#" class="list-group-item">
                            <span class="badge">Piad Fee Students</span>
                            <i class="fa fa-fw fa-thumbs-o-up"></i>
                            <asp:Label runat="server" ID="lblschPaidFeeStd" Text="10"></asp:Label>
                        </a>
                        <a href="#" class="list-group-item">
                            <span class="badge">UnPiad Fee Students</span>
                            <i class="fa fa-fw fa-thumbs-o-down"></i>
                            <asp:Label runat="server" ID="lblschUnpaidFeeStd" Text="20"></asp:Label>
                        </a>
                    </div>
                    <div class="text-right">
                        <%-- <asp:LinkButton runat="server"  Text="View School" OnClick="Unnamed_Click"><i class="fa fa-arrow-circle-right"></i></asp:LinkButton>--%>
                        <a href="../AdminDashBoard.aspx?utf=<% Response.Write(c.id); %>">View School <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <!--///////////////////////////////////////////////////////////////////////////////-->

        <!--///////////////////////////////////////////////////////////////////////////////-->
        <%
                                                             }
                                                         }
                           catch (Exception ex)
                           { }
                        }
                    
        %>
        <!-- /.row -->
    </div>


</asp:Content>
