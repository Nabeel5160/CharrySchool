<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminHelp.aspx.cs" Inherits="SchoolPRO.AdminHelp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row-fluid">
                <h4 class="header green lighter bigger">
                    <i class="icon-group blue"></i>
                    CHERRY School Solution Help 
                </h4>
        <div class="col-lg-12">
            <h3 style="color:red">Note</h3>
            <ul style="list-style:none">
                <li>Do Not Move On To Next Step Until Pervious Step is Completely Done</li>
                <li>Do Not Delete Any Record From Perivious Step if You Have Move  To Next Step</li>
            </ul>
            <h6 style="color:red">Step 1</h6>
            <ul style="list-style:none">
                <li>Manage Class By Adding All Classes of your School <a href="AdminManageClass.aspx">click here</a></li>
            </ul>
            <h6 style="color:red">Step 2</h6>
            <ul style="list-style:none">
                <li>Manage Sections of Classes By Adding All Sections against Classes of your School <a href="AdminManageSection.aspx">click here</a></li>
            </ul>
            <h6 style="color:red">Step 3</h6>
            <ul style="list-style:none">
                <li>Manage Subjects of Classes By Adding All Subject against Classes of your School <a href="AdminManageSubjects.aspx">click here</a></li>
            </ul>
            <h6 style="color:red">Step 4</h6>
            <ul style="list-style:none">
                <li>Manage Fees of Classes By Adding All Fee against Classes of your School <a href="AdminManageFee.aspx">click here</a></li>
            </ul>
             <h6 style="color:red">Step 5 (Old Students)</h6>
            <ul style="list-style:none">
                <li>Manage Parents Details and Students Details Who Are Already in Your School (Not  New Admission)<a href="AdminManageP-C.aspx">click here</a></li>
                <li>Before Adding Do Gather All Valid Information Required In the Form <a href="AdminManageP-C.aspx">click here</a></li>
            </ul>
            <h6 style="color:red">Step 6 (New Students)</h6>
            <ul style="list-style:none">
                <li>Manage Parents Details and Students Details  (New Admission)<a href="AdminManageNewAdmission.aspx">click here</a></li>
                <li>Before Adding Do Gather All Valid Information Required In the Form <a href="AdminManageNewAdmission.aspx">click here</a></li>
            </ul>
              <h6 style="color:red">Step 7 (Teachers)</h6>
            <ul style="list-style:none">
                <li>Manage Teacher Departments By Add Their Name.. <a href="AdminManageTeacherDepartment.aspx">click here</a></li>
                <li>Before Adding Do Gather All Valid Information Required In the Form <a href="AdminManageTeacherDepartment.aspx">click here</a></li>
            </ul>
            <h6 style="color:red">Step 8 (Teachers)</h6>
            <ul style="list-style:none">
                <li>Manage Teacher Details After Adding Their Departments<a href="AdminAddTeacher.aspx">click here</a></li>
                <li>Before Adding Do Gather All Valid Information Required In the Form <a href="AdminAddTeacher.aspx">click here</a></li>
            </ul>
            <h6 style="color:red">Step 9 (Teachers)</h6>
            <ul style="list-style:none">
                <li>Manage Class Incharge  After Adding Teacher Details<a href="AdminManageClassIncharge.aspx">click here</a></li>
                <li>Before Adding Do Gather All Valid Information Required In the Form <a href="AdminManageClassIncharge.aspx">click here</a></li>
            </ul>
            <h6 style="color:red">Step 10 (TimeTable)</h6>
            <ul style="list-style:none">
                <li>Set Up Schedule Summer and Winter Both<a href="AdminManageSchedule.aspx">click here</a></li>
                <li>Before Adding Do Gather All Valid Information Required <a href="AdminManageSchedule.aspx">click here</a></li>
            </ul>
            <h6 style="color:red">Step 11 (TimeTable)</h6>
            <ul style="list-style:none">
                <li>Manage Periods And their Start and End Time <a href="AdminManagePeriod.aspx">click here</a></li>
                <li>Before Adding Do Gather All Valid Information Required <a href="AdminManagePeriod.aspx">click here</a></li>
            </ul>
             <h6 style="color:red">Step 12 (TimeTable)</h6>
            <ul style="list-style:none">
                <li>Manage Class Time Table  <a href="AdminManageClassTimeTable.aspx">click here</a></li>
                <li>Before Adding Do Gather All Valid Information Required <a href="AdminManageClassTimeTable.aspx">click here</a></li>
            </ul>
            <h6 style="color:red">Step 13 (TimeTable)</h6>
            <ul style="list-style:none">
                <li>Manage Exam Time Table  <a href="AdminManageExamTimeTable.aspx">click here</a></li>
                <li>Before Adding Do Gather All Valid Information Required <a href="AdminManageExamTimeTable.aspx">click here</a></li>
            </ul>
             <h6 style="color:red">Step 13 (Employees)</h6>
            <ul style="list-style:none">
               <li>Manage Employee Details<a href="AdminManageEmployees.aspx">click here</a></li>
                <li>Before Adding Do Gather All Valid Information Required In the Form <a href="AdminManageEmployees.aspx">click here</a></li> 

            </ul>
             <h6 style="color:red">Step 14 (Transport)</h6>
            <ul style="list-style:none">
               <li>Manage Routes Details , Vehicle and Allot Vans to students<a href="AdminSetRoutes.aspx">For Routes click here</a>|<a href="AdminManageVehicle.aspx">Manage Vehicle click here</a>| <a href="AdminAlloteTransport.aspx">Allotement Student click here</a></li>
                <li>Before Adding Do Gather All Valid Information Required In the Form <a href="AdminSetRoutes.aspx">click here</a></li> 

            </ul>
            




        </div>

        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
