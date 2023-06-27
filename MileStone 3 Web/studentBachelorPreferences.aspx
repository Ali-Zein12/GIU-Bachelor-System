<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="studentBachelorPreferences.aspx.cs" Inherits="MileStone_3_Web.studentBachelorPreferences"  %>

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
    <h2>Bachelor Preferences!</h2>
    <div class="form-group"; style="margin:100px">
     <h6>Select the bachelor code and your preferences number 1 is your most desired preference.</h6>
      <h6>This process cannot be undone. </h6>
      <h6>If there is no options to select, this means that you have made preferences to all the available bachelor projects. </h6>

        <asp:Label ID="grade" runat="server"></asp:Label>
        
        <asp:Panel ID="OK" runat="server" Visible="False">
    <asp:Panel ID="Panel1" runat="server"> 
        <asp:Label ID="Label1" runat="server" Text="" Visible="False"></asp:Label>
    </asp:Panel>
    <asp:Panel ID="Panel2" runat="server">
       <label for="CODE">Bachelor Project Code:   &nbsp&nbsp </label>
        <asp:DropDownList ID="BC" runat="server" OnSelectedIndexChanged="BC_SelectedIndexChanged" AutoPostBack="true" style="min-width:150px">
        </asp:DropDownList>

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <label for="PREFERNCES">Prefernce Number:   &nbsp&nbsp </label>

        <asp:DropDownList ID="PN" runat="server" OnSelectedIndexChanged="PN_SelectedIndexChanged" AutoPostBack="true" style="min-width:150px">
        </asp:DropDownList>
        <br />
        <asp:Button ID="submit" runat="server" Text="Submit!" OnClick="submit_Click" />
         </asp:Panel>
           <asp:Label ID="Label2" ForeColor="Red" visible="false" runat="server" Text=""></asp:Label><br>
            <a href="StudentHome.aspx" font="10px">Home page.</a>

    </asp:Panel>
        
           </div>

</asp:Content>
