<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="CoordinatorHome.aspx.cs" Inherits="MileStone_3_Web.CoordinatorHome"  %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
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
    <h2>Welcome to your homepage Coordinator!</h2>
    <asp:Panel ID="Panel1" runat="server"></asp:Panel>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="viewProjs" runat="server">
    <label for="Type"> Project Type:   &nbsp&nbsp </label>
        <asp:DropDownList ID="Type" runat="server" OnSelectedIndexChanged="Type_SelectedIndexChanged" AutoPostBack="true" style="min-width:150px">
        </asp:DropDownList>
        <asp:Panel ID="Panel2" runat="server"></asp:Panel>
</asp:Content>

