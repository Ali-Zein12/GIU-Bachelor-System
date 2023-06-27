<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LecturerHome.aspx.cs" Inherits="MileStone_3_Web.LecturerHome" MasterPageFile="~/master.Master" %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server" style="height:100px">
 
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

</asp:Content>


<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div style="margin-left: auto; margin-right: auto; text-align: center;" >
    <asp:Label runat="server" style="font-family:'Times New Roman', Times, serif" ForeColor="Coral" Font-Size="20" Text="Welcome to your home page Lecturer!"></asp:Label>
</div>
<div style="margin-left:100px">
<asp:Label ForeColor="White" runat="server" Text="Would you like to supervise a project?"></asp:Label><br><br>
<asp:Label ForeColor="White" runat="server" Text="Project Code: "></asp:Label>
    <asp:DropDownList ID="DropDownList" runat="server" AutoPostBack="true" Style="min-width: 150px" OnSelectedIndexChanged="DropDownList_SelectedIndexChanged">
 <asp:ListItem Value="None">None</asp:ListItem>
 </asp:DropDownList><br><br>

    <asp:Button ID="Supervise" runat="server" class="btn btn-light" OnClick="SuperviseProject" Text="Supervise"></asp:Button>
    <asp:Label ID="addedSuccessfully" ForeColor="Green" Visible="false" runat="server" Text="Label"></asp:Label><br>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="viewProjs" runat="server">
    <label for="Type"> Project Type:   &nbsp&nbsp </label>
        <asp:DropDownList ID="Type" runat="server" OnSelectedIndexChanged="Type_SelectedIndexChanged" AutoPostBack="true" style="min-width:150px">
        </asp:DropDownList>
        <asp:Panel ID="Panel2" runat="server"></asp:Panel>
</asp:Content>
