<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LecturerSpecifyDeadline.aspx.cs" Inherits="MileStone_3_Web.LecturerSpecifyDeadline" MasterPageFile="~/master.Master" %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">

 <button ID="LecturerHome" runat="server" class="btn btn-dark" onclick="location.href='LecturerHome.aspx';">Supervise Ind. Bachelor</button>
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

</asp:Content>

<asp:Content ID="sdgsrg" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div style="margin-left: auto; margin-right: auto; text-align: center;" >
    <asp:Label runat="server" style="font-family:'Times New Roman', Times, serif" ForeColor="Coral" Font-Size="20" Text="Specify the Deadline of Thesis Submission"></asp:Label>
</div>
    <div style="margin-left: auto; margin-right: auto;width:600px;">
          <asp:Calendar ID="Calendar" Width="600px" OnSelectionChanged="SpecifyThesisDeadline" Caption="Please Select the thesis deadline, time is by default 11:59:59 pm, if you would like to change it, enter a time then click on the date from the calendar to set it." runat="server"></asp:Calendar>
    </div>
        <div style="margin-left: auto; margin-right: auto;width:fit-content;height:fit-content">
            <asp:TextBox ID="TextBox1" runat="server" type="time" OnTextChanged="clearLabel"></asp:TextBox>
        </div>
    <div style="margin-left: auto; margin-right: auto; text-align: center;">
  <asp:Label ID="SuccessfulDeadline" Visible="false" ForeColor="Green" runat="server" Text="Deadline changed successfully!"></asp:Label><br/>
        </div>
</asp:Content>