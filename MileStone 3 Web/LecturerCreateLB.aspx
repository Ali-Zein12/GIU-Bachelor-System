<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LecturerCreateLB.aspx.cs" Inherits="MileStone_3_Web.LecturerCreateLB" MasterPageFile="~/master.Master" %>


<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
 
 <button ID="createLocalBachelor" runat="server" class="btn btn-dark" onclick="location.href='LecturerHome.aspx';">Supervise Ind. Bachelor</button>
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
    <asp:Label runat="server" style="font-family:'Times New Roman', Times, serif" ForeColor="Coral" Font-Size="20" Text="Create a Local Bachelor"></asp:Label>
</div>
<asp:Label ID="label1" ForeColor="White" Font-Bold="true" runat="server" Text="Please enter the project code"></asp:Label><br/>
<asp:TextBox ID="ProjectCodeTextBox" required="true" placeholder="eg. ind5" runat="server" class="form-control"></asp:TextBox><br>
<asp:Label ID="label2" ForeColor="White" Font-Bold="true" runat="server" Text="Please enter the project title"></asp:Label><br/>
<asp:TextBox ID="TitleTextBox" required="true" placeholder="eg. Autonoumous AI space rockets" runat="server" class="form-control"></asp:TextBox><br>
<asp:Label ID="label3" ForeColor="White" Font-Bold="true" runat="server" Text="Please enter the project description"></asp:Label><br/>
    <asp:TextBox ID="DescriptionTextBox" required="true" placeholder="eg. A project describing the role of artificial intelligence in space exploration..." runat="server" class="form-control"></asp:TextBox><br>
<asp:Label ID="label4" ForeColor="White" Font-Bold="true" runat="server" Text="Please enter the major code"></asp:Label><br/>
<asp:TextBox ID="MajorCodeTextBox" required="true" placeholder="eg. DS" runat="server" class="form-control"></asp:TextBox><br>
<asp:Button ID="LecturerCreateBachelor" runat="server" Text="Create Bachelor" class="btn btn-primary" OnClick="CreateBachelor"/>
<asp:Label ID="SuccessfulBachelor" Visible="false" ForeColor="Green" runat="server" Text="Local Bachelor Project added successfully!"></asp:Label><br>



</asp:Content>