<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LecturerCreatePG.aspx.cs" Inherits="MileStone_3_Web.LecturerCreatePG" MasterPageFile="~/master.Master" %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">

 <button ID="Home" runat="server" class="btn btn-dark" onclick="location.href='LecturerHome.aspx';">Supervise Ind. Bachelor</button>
 <button ID="createLocalBachelor" runat="server" class="btn btn-dark" onclick="location.href='LecturerCreateLB.aspx';">Create Local Bachelor</button>
     <li class="nav-item dropdown">
        <a class="btn btn-dark dropdown-toggle" href="#" data-toggle="dropdown" data-target="#menu-item-1">Meetings</a>
        <ul class="dropdown-menu" id="menu-item-1" style="background-color:#35363a">
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="LecturerMeetings.aspx">View/Edit Meetings</a></li>
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="LecturerCreateMeeting.aspx">Create Meeting</a></li>
        </ul>
    </li>
 <button ID="LectGradeStudent" runat="server" class="btn btn-dark" onclick="location.href='LecturerGradeStudent.aspx';">Grade Students</button>
 <button ID="ExternalExaminers" runat="server" class="btn btn-dark" onclick="location.href='LecturerExternalExaminers.aspx';">External Examiners</button>
 <button ID="SpecifyDeadline" runat="server" class="btn btn-dark" onclick="location.href='LecturerSpecifyDeadline.aspx';">Specify deadline</button>

</asp:Content>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div style="margin-left: auto; margin-right: auto; text-align: center;" >
    <asp:Label runat="server" style="font-family:'Times New Roman', Times, serif" ForeColor="Coral" Font-Size="20" Text="Create a progress Report for a student!"></asp:Label>
</div>

        <asp:Label ForeColor="White" runat="server" Text="Student ID: "></asp:Label>
 <asp:DropDownList ID="DropDownList" runat="server" AutoPostBack="true" style="min-width:150px">
 <asp:ListItem Value="None">None</asp:ListItem>
 </asp:DropDownList><br><br>

    <asp:TextBox ID="TextBox1" required="true" Height="300" Width="600" OnTextChanged="HideLabel" runat="server"></asp:TextBox><br><br>
    <asp:Button ID="Add" runat="server" class="btn btn-light" OnClick="AddProgressReport" Text="Add PR"></asp:Button>
    <asp:Label ID="addedSuccessfully" ForeColor="Green" Visible="false" runat="server" Text="Label"></asp:Label><br>


</asp:Content>
