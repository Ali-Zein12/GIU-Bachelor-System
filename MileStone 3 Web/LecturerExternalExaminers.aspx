<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LecturerExternalExaminers.aspx.cs" Inherits="MileStone_3_Web.LecturerExternalExaminers" MasterPageFile="~/master.Master" %>

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
 <button ID="SpecifyDeadline" runat="server" class="btn btn-dark" onclick="location.href='LecturerSpecifyDeadline.aspx';">Specify deadline</button>

</asp:Content>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div style="margin-left: auto; margin-right: auto; text-align: center;" >
    <asp:Label runat="server" style="font-family:'Times New Roman', Times, serif" ForeColor="Coral" Font-Size="20" Text="Unassigned External Examiners"></asp:Label>
</div>
<asp:Label runat="server" ForeColor="White" Text="Recommend External Examiner ID:"></asp:Label>&nbsp;
<asp:DropDownList ID="DropDownList" runat="server" OnSelectedIndexChanged="DropDownList_SelectedIndexChanged" AutoPostBack="true" style="min-width:150px">
 <asp:ListItem Value="None">None</asp:ListItem>
 </asp:DropDownList>&nbsp;<asp:Label runat="server" Text="to Academic Bachelor:"></asp:Label>&nbsp;

<asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList_SelectedIndexChanged" AutoPostBack="true" style="min-width:150px">
 <asp:ListItem Value="None">None</asp:ListItem>
 </asp:DropDownList><br>
 <asp:Button runat="server" class="btn btn-light" OnClick="RecommendEE" Text="Recommend"></asp:Button>&nbsp;
 <asp:Label ID="successfulRecommendation" Visible="false" runat="server" Text="Label"></asp:Label>

    <table id ="table">
        <asp:Panel ID="Panel3" runat="server"></asp:Panel>
    </table>

</asp:Content>
