<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="studentUpdateDefense.aspx.cs" Inherits="MileStone_3_Web.studentUpdateDefense"  %>

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
   <h2>Update Defense</h2>
  <div class="form-group"; style="margin:100px">
       <asp:Panel ID="OK" runat="server" Visible="False">
       <asp:Label ID="Label2" ForeColor="#ffffff" visible="true" runat="server" Text="Type your updates here"></asp:Label><br>

      <textarea id="TS" name="TS" rows="10" cols="80"> </textarea><br><br />
            <input type="submit" value="Submit" class="btn btn-primary" /><br>
                </asp:Panel>
           <asp:Label ID="Label1" ForeColor="Red" visible="false" runat="server" Text=""></asp:Label><br>
            <a href="StudentHome.aspx" font="10px">Home page.</a>
           </div>

</asp:Content>

