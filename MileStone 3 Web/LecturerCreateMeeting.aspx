<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LecturerCreateMeeting.aspx.cs" Inherits="MileStone_3_Web.LecturerCreateMeeting" MasterPageFile="~/master.Master" %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
<button ID="Home" runat="server" class="btn btn-dark" onclick="location.href='LecturerHome.aspx';">Supervise Ind. Bachelor</button>
<button ID="createLocalBachelor" runat="server" class="btn btn-dark" onclick="location.href='LecturerCreateLB.aspx';">Create Local Bachelor</button>
    <button ID="LecturerMeetings" runat="server" class="btn btn-dark" onclick="location.href='LecturerMeetings.aspx';">View/Edit Meetings</button>
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
    <asp:Label runat="server" style="font-family:'Times New Roman', Times, serif" ForeColor="Coral" Font-Size="20" Text="Create a New Meeting"></asp:Label>
</div>
    <label for="appt">Select meeting date:</label>
    <asp:TextBox type="date" required="required" runat="server" id="date" name="appt"></asp:TextBox><br>
    <label for="appt">Select start time:</label>
    <asp:TextBox type="time" required="required" runat="server" id="start" name="appt"></asp:TextBox><br>
    <label for="appt">Select end time:</label>
    <asp:TextBox type="time" required="required" runat="server" id="end" name="appt"></asp:TextBox><br>
    <label for="appt">Type the meeting location:</label>
    <asp:TextBox type="text" required="required" runat="server" id="location" name="appt"></asp:TextBox><br>
    <asp:Button ID="CreateMeeting" class="btn btn-light" runat="server" OnClick="CreateM" Text="Create Meeting"></asp:Button><br>
    <asp:Label ID="successfulCreation" Visible="false" ForeColor="Green" runat="server" Text="Meeting created successfully!"></asp:Label>


</asp:Content>