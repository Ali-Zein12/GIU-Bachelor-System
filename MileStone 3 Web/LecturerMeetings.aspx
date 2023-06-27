<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LecturerMeetings.aspx.cs" Inherits="MileStone_3_Web.LecturerMeetings" MasterPageFile="~/master.Master" %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
<button ID="Home" runat="server" class="btn btn-dark" onclick="location.href='LecturerHome.aspx';">Supervise Ind. Bachelor</button>
<button ID="createLocalBachelor" runat="server" class="btn btn-dark" onclick="location.href='LecturerCreateLB.aspx';">Create Local Bachelor</button>
    <button ID="LecturerMeeetings" runat="server" class="btn btn-dark" onclick="location.href='LecturerCreateMeeting.aspx';">Create Meeting</button>
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
    <asp:Label runat="server" style="font-family:'Times New Roman', Times, serif" ForeColor="Coral" Font-Size="20" Text="View your Meetings and add to their To-Do lists"></asp:Label>
</div>

    <asp:Label ForeColor="White" runat="server" Text="Type here what you would like to add to a meeting then select the meeting id and click add (max 200 words)"></asp:Label>

    <asp:TextBox ID="TextBox1" required="true" Height="50" Width="760px" runat="server"></asp:TextBox>&nbsp;
    <asp:Button ID="Add" runat="server" class="btn btn-light" OnClick="addToDoList" Text="Add"></asp:Button><br>
    <asp:Label ID="addedSuccessfully" ForeColor="Green" Visible="false" runat="server" Text="Label"></asp:Label><br>

    <asp:Label ForeColor="White" runat="server" Text="Meeting ID: "></asp:Label>
 <asp:DropDownList ID="DropDownList" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true" style="min-width:150px">
 <asp:ListItem Value="None">None</asp:ListItem>
 </asp:DropDownList>
    <table id ="table">
        <asp:Panel ID="Panel3" runat="server"></asp:Panel>
    </table>

</asp:Content>
