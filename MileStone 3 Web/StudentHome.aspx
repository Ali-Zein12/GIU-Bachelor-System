<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="StudentHome.aspx.cs" Inherits="MileStone_3_Web.StudentHome"  %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
    
   
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
    <h2>Welcome Student!</h2>
    <asp:Panel ID="Panel1" runat="server"  Direction="LeftToRight" HorizontalAlign="Center">
        
        <asp:Label ID="Label1" runat="server" Text=" “A little progress each day adds up to big results.”– Satya Nani " ForeColor="White"></asp:Label> <br /> <br />
       <asp:Label ID="Label2" runat="server" Text=" “Skill is only developed by hours and hours of work.”– Usain Bolt" ForeColor="White"></asp:Label> <br /> <br />
       <asp:Label ID="Label3" runat="server" Text=" “The way to get started is to quit talking and begin doing.”– Walt Disney " ForeColor="White"></asp:Label> <br /> <br />
       <asp:Label ID="Label4" runat="server" Text=" “Just one small positive thought in the morning can change your whole day.”– Dalai Lama " ForeColor="White"></asp:Label> <br /> <br />
       <asp:Label ID="Label5" runat="server" Text=" “You can’t have a better tomorrow if you’re still thinking about yesterday.”– Charles F. Kettering " ForeColor="White"></asp:Label> <br /> <br />
       <asp:Label ID="Label6" runat="server" Text=" “Every accomplishment starts with the decision to try.”– Gail Devers " ForeColor="White"></asp:Label> <br /> <br />
       <asp:Label ID="Label7" runat="server" Text=" “Procrastination makes easy things hard and hard things harder.”– Mason Cooley " ForeColor="White"></asp:Label> <br /> <br />
       <asp:Label ID="Label8" runat="server" Text=" “You don’t have to be great to start, but you have to start to be great.” – Zig Ziglar " ForeColor="White"></asp:Label> <br /> <br />


    </asp:Panel>
</asp:Content>
