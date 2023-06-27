<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="studentAddToDo.aspx.cs" Inherits="MileStone_3_Web.studentAddToDo"  %>

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
   <h2>Add tasks to the "To-Do-List" of a meeting</h2>
  <div class="form-group"; style="margin:100px">
         <asp:Label ID="grade" style="font-size:20px" runat="server" Text=""></asp:Label>
        <asp:Panel ID="OK" runat="server" Visible="False">
      
            <label for="MeetingID">Meeting ID:   &nbsp&nbsp </label>
                  <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList> <br><br>
            <label for="todo">To-Do:</label><br />
            <textarea id="TODO" name="todo" rows="10" cols="80"> </textarea><br><br />
            <input type="submit" value="Add task to the To-Do-List" class="btn btn-primary" /><br>
           <asp:Label ID="Label1" ForeColor="Red" visible="false" runat="server" Text=""></asp:Label><br>
             </asp:Panel>
           <asp:Label ID="Label2" ForeColor="Red" visible="false" runat="server" Text=""></asp:Label><br><br>
            

            <h6 style="margin-left:10px;color:white">  Go to <a href="StudentHome.aspx">Home page </a>  ?&nbsp;&nbsp;
            <a href="studentBookMeetings.aspx">Book </a> a meeeting?&nbsp;&nbsp; View<a href="studentViewAvailableMeetings.aspx"> available </a> meeetings?</h6>

           
           </div>
   
</asp:Content>
