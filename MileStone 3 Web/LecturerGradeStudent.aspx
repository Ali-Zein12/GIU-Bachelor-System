<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LecturerGradeStudent.aspx.cs" Inherits="MileStone_3_Web.LecturerGradeStudent" MasterPageFile="~/master.Master" %>

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
 <button ID="CreatePG" runat="server" class="btn btn-dark" onclick="location.href='LecturerCreatePG.aspx';">Create Progress Report</button>
 <button ID="ExternalExaminers" runat="server" class="btn btn-dark" onclick="location.href='LecturerExternalExaminers.aspx';">External Examiners</button>
 <button ID="SpecifyDeadline" runat="server" class="btn btn-dark" onclick="location.href='LecturerSpecifyDeadline.aspx';">Specify deadline</button>

</asp:Content>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <div style="margin-left: auto; margin-right: auto; text-align: center;" >
    <asp:Label runat="server" style="font-family:'Times New Roman', Times, serif" ForeColor="Coral" Font-Size="20" Text="Grade a Thesis, Defense or Progress Report"></asp:Label>
</div>
<asp:Label ForeColor="White" runat="server" Text="I would like to grade a"></asp:Label>&nbsp<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" Style="min-width: 150px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
<asp:ListItem Value="None">None</asp:ListItem></asp:DropDownList><br><br />
<asp:Label ForeColor="White" ID="label2" runat="server" Visible="false" Text="Student ID"></asp:Label>&nbsp&nbsp&nbsp<asp:DropDownList ID="DropDownList2" Visible="false" runat="server" AutoPostBack="true" Style="min-width: 150px" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
<asp:ListItem  Value="None">None</asp:ListItem></asp:DropDownList><br><br />
<asp:Label ForeColor="White" ID="label3" runat="server" Visible="false" Text="N/A"></asp:Label>&nbsp&nbsp&nbsp<asp:DropDownList ID="DropDownList3" Visible="false" runat="server" AutoPostBack="true" Style="min-width: 150px" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged">
<asp:ListItem Value="None">None</asp:ListItem></asp:DropDownList><br><br />
<asp:Label ForeColor="White" ID="label4" runat="server" Visible="false" Text="Grade"></asp:Label>&nbsp&nbsp&nbsp
<asp:TextBox type="number" Visible="false" required="required" runat="server" ID="LecGrade"></asp:TextBox><br><br />

<asp:Button ID="button" runat="server" Visible="false" class="btn btn-light" OnClick="GradeAnything" Text="Submit Grade"></asp:Button>
<asp:Label ID="gradedSuccessfully" ForeColor="Green" Visible="false" runat="server" Text="Label"></asp:Label><br>

</asp:Content>
