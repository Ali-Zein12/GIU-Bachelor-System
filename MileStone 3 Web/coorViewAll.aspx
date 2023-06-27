<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="coorViewAll.aspx.cs" Inherits="MileStone_3_Web.coorViewAll"  %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
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
 </asp:Content>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <h2>View All Users</h2><br><br>
        <label for="userType" style="margin-left:100px">User Type:   &nbsp&nbsp </label>
        <asp:DropDownList ID="DropDownList2" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true" style="min-width:150px">
            <asp:ListItem Value="None">None</asp:ListItem>
              <asp:ListItem Value="lecturer">Lecturer</asp:ListItem>
              <asp:ListItem Value="external examiner">External Examiner</asp:ListItem>
              <asp:ListItem Value="teaching assistant">Teaching Assistant</asp:ListItem>
              <asp:ListItem Value="coordinator">Coordinator</asp:ListItem>
              <asp:ListItem Value="company">Company</asp:ListItem>
              <asp:ListItem Value="student">Student</asp:ListItem>
        </asp:DropDownList>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
        <label for="userID">User ID:   &nbsp&nbsp </label>
        <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true" style="min-width:150px">
        </asp:DropDownList>

        <table id ="table">
            <asp:Panel ID="Panel3" runat="server"></asp:Panel>
        </table>
</asp:Content>
