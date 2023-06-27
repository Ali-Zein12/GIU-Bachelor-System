<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="viewProfile.aspx.cs" Inherits="MileStone_3_Web.viewProfile"  %>


<asp:Content ID="Content1" ContentPlaceHolderID="navBarHolder" runat="server">

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<% SqlParameter param = (SqlParameter)Session["user"]; 
 int c = (int)param.Value;
string role = "";

using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString()))
{
    string sql = "SELECT Role FROM Users WHERE user_id = @ID";
    using (SqlCommand command = new SqlCommand(sql, connection))
    {
        command.Parameters.AddWithValue("@ID", c);
        connection.Open();
        using (SqlDataReader reader = command.ExecuteReader())
        {
            if (reader.Read())
            {
                role = reader["Role"].ToString();
            }
        }
    }
}
%>

<% if (role == "coordinator") { %>
    <button id="coorHome" onclick="location.href='coordinatorHome.aspx';" class="btn btn-dark">Home page</button>
    <li class="nav-item dropdown">
        <a class="btn btn-dark dropdown-toggle" href="#" data-toggle="dropdown" data-target="#menu-item-3">View</a>
        <ul class="dropdown-menu" id="menu-item-3" style="background-color:#35363a">
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="coorViewAll.aspx">Details of all users</a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="coorEERecommendations.aspx">External Examiner <br> recommendations</a></li>
        </ul>
    </li>
    <li class="nav-item dropdown">
        <a class="btn btn-dark dropdown-toggle" href="#" data-toggle="dropdown" data-target="#menu-item-4">Assign</a>
        <ul class="dropdown-menu" id="menu-item-4" style="background-color:#35363a">
        <li style="border:solid;color:white;transition: all 0.2s ease-in-out 0.1s"><a style="color:white" class="dropdown-item" href="coorAssAllStuds.aspx">Students to <br> bachelor project</a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="coorAssTA.aspx">TA to local bachelor</a></li>
         <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="coorAssEE.aspx">External Examiner <br> to local bachelor</a></li>
        </ul>
    </li>
    <button id="coorSchedDef" onclick="location.href='coorSchedDef.aspx';" class="btn btn-dark">Schedule Defense</button> 
<% } else if (role == "external examiner") { %>
        <button id="eeHome" onclick="location.href='EEHome.aspx';" class="btn btn-dark">Home page</button>
        <button id="gradeThesis" onclick="location.href='EEGradeThesis.aspx';" class="btn btn-dark">Grade Thesis</button>
        <button id="gradeDefense" onclick="location.href='EEGradeDefense.aspx';" class="btn btn-dark">Grade Defense</button>
<% } else if (role == "teaching assistant") { %>
    <button id="taHome" onclick="location.href='TAHome.aspx';" class="btn btn-dark">Home page</button>
    <button id="createPRTA" onclick="location.href='TACreatePr.aspx';" class="btn btn-dark">Create Progress Report</button>
    <button id="addToDoTA" onclick="location.href='TAAddToDo.aspx';" class="btn btn-dark">Meeting To-Do list</button>
    <% } else if (role == "lecturer") { %>
    <button id="lecHome" onclick="location.href='LecturerHome.aspx';" class="btn btn-dark">Home page</button>
    <button ID="createLocalBachelor" runat="server" class="btn btn-dark" onclick="location.href='LecturerCreateLB.aspx';">Create Local Bachelor</button>
     <li class="nav-item dropdown">
        <a class="btn btn-dark dropdown-toggle" href="#" data-toggle="dropdown" data-target="#menu-item-1">Meetings</a>
        <ul class="dropdown-menu" id="menu-item-1" style="background-color:#35363a">
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="LecturerMeetings.aspx">View/Edit Meetings</a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="LecturerCreateMeeting.aspx">Create Meeting</a></li>
        </ul>
    </li>
     <li class="nav-item dropdown">
        <a class="btn btn-dark dropdown-toggle" href="#" data-toggle="dropdown" data-target="#menu-item-2">Students</a>
        <ul class="dropdown-menu" id="menu-item-2" style="background-color:#35363a">
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="LecturerGradeStudent.aspx">Grade Students</a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="LecturerCreatePG.aspx">Create Progress Report</a></li>
        </ul>
    </li>
    <button ID="ExternalExaminers" runat="server" class="btn btn-dark" onclick="location.href='LecturerExternalExaminers.aspx';">External Examiners</button>
    <button ID="SpecifyDeadline" runat="server" class="btn btn-dark" onclick="location.href='LecturerSpecifyDeadline.aspx';">Specify deadline</button>
<% } else if (role == "student") { %>
    <button id="Home" onclick="location.href='TAHome.aspx';" class="btn btn-dark">Home page</button>
    <button id="ViewProjects" onclick="location.href='projects.aspx';" class="btn btn-dark">Bachelor Projects</button>

    <button id="MyPrefrences" onclick="location.href='studentBachelorPreferences.aspx';" class="btn btn-dark">My Prefrences</button>

    <li class="nav-item dropdown">
        <a class="btn btn-dark dropdown-toggle" href="#" data-toggle="dropdown" data-target="#menu-item-6">Meetings</a>
        <ul class="dropdown-menu" id="menu-item-16" style="background-color:#35363a">
         <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentViewAvailableMeetings.aspx"> View Available Meetings</a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentBookMeetings.aspx">Book A Meeting</a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentViewBookedMeetings.aspx"> View My Booked Meetings</a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentAddToDo.aspx"> Add Meeting To Do List</a></li>

        </ul>
    </li>


     <li class="nav-item dropdown">
        <a class="btn btn-dark dropdown-toggle" href="#" data-toggle="dropdown" data-target="#menu-item-7">Thesis</a>
        <ul class="dropdown-menu" id="menu-item-7" style="background-color:#35363a">
         <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentViewThesis.aspx"> View </a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentSubmitThesis.aspx">Submit</a></li>
     

        </ul>
    </li>
 
    <li class="nav-item dropdown">
        <a class="btn btn-dark dropdown-toggle" href="#" data-toggle="dropdown" data-target="#menu-item-8">Defense</a>
        <ul class="dropdown-menu" id="menu-item-8" style="background-color:#35363a">
         <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentViewDefense.aspx"> View </a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentUpdateDefense.aspx">Update</a></li>
        
        </ul>
    </li>

    <li class="nav-item dropdown">
        <a class="btn btn-dark dropdown-toggle" href="#" data-toggle="dropdown" data-target="#menu-item-9">Grades</a>
        <ul class="dropdown-menu" id="menu-item-9" style="background-color:#35363a">
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentViewBachGrades.aspx"> Total Bachelor Grade</a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentViewPRGrades.aspx"> Progress Report Grade</a></li>

        </ul>
    </li>

<% } %>


 </asp:Content>



<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2>View Profile</h2><br /><br />
  <asp:Panel ID="Panel2" runat="server"></asp:Panel>

</asp:Content>