<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="studentBookMeetings.aspx.cs" Inherits="MileStone_3_Web.studentBookMeetings"  %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
    
    <button id="MyHome" onclick="location.href='StudentHome.aspx';" class="btn btn-dark">Home Page</button>
    <button id="ViewProjects" onclick="location.href='projects.aspx';" class="btn btn-dark">Bachelor Projects</button>

    <button id="MyPrefrences" onclick="location.href='studentBachelorPreferences.aspx';" class="btn btn-dark">My Prefrences</button>
    <li class="nav-item dropdown">
        <a class="btn btn-dark dropdown-toggle" href="#" data-toggle="dropdown" data-target="#menu-item-1">Meetings</a>
        <ul class="dropdown-menu" id="menu-item-1" style="background-color:#35363a">
         <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentViewAvailableMeetings.aspx"> View Available Meetings</a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentBookMeetings.aspx">Book A Meeting</a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentViewBookedMeetings.aspx"> View My Booked Meetings</a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentAddToDo.aspx"> Add Meeting To Do List</a></li>

        </ul>
    </li>


     <li class="nav-item dropdown">
        <a class="btn btn-dark dropdown-toggle" href="#" data-toggle="dropdown" data-target="#menu-item-2">Thesis</a>
        <ul class="dropdown-menu" id="menu-item-2" style="background-color:#35363a">
         <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentViewThesis.aspx"> View </a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentSubmitThesis.aspx">Submit</a></li>
   

        </ul>
    </li>
 
 <li class="nav-item dropdown">
        <a class="btn btn-dark dropdown-toggle" href="#" data-toggle="dropdown" data-target="#menu-item-3">Defense</a>
        <ul class="dropdown-menu" id="menu-item-3" style="background-color:#35363a">
         <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentViewDefense.aspx"> View </a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentUpdateDefense.aspx">Update</a></li>
        
        </ul>
    </li>

<li class="nav-item dropdown">
        <a class="btn btn-dark dropdown-toggle" href="#" data-toggle="dropdown" data-target="#menu-item-4">Grades</a>
        <ul class="dropdown-menu" id="menu-item-4" style="background-color:#35363a">
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentViewBachGrades.aspx"> Total Bachelor Grade</a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="studentViewPRGrades.aspx"> Progress Report Grade</a></li>

        </ul>
    </li>
</asp:Content>
<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Booking A Meeting</h2>
    <asp:Panel ID="Panel1" runat="server" BorderColor="White">
        <asp:Label ID="Label2" ForeColor="#ffffff" visible="true" runat="server"   Text="Select the meeting ID that you want to book!"></asp:Label><br />
         <asp:Label ID="Label3" ForeColor="#ffffff" visible="true" runat="server"   Text=  "If there is no meeting IDs to select this means that all meetings have been booked or your lecturer hasn't made any meetings yet"></asp:Label>

   
        <br>
        <label for="Meeting_ID"> Meeting ID:   &nbsp&nbsp </label>
        <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true" style="min-width:150px">
        </asp:DropDownList><br />

        <asp:Label ID="Label1" runat="server" Text=""></asp:Label><br />
        <asp:Button ID="Book" runat="server" Text="Book!" OnClick="Book_Click" />


         </asp:Panel>
</asp:Content>
