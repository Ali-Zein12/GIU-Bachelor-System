<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="coorAssTA.aspx.cs" Inherits="MileStone_3_Web.coorAssTA"  %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
    <button id="coorHome" onclick="location.href='coordinatorHome.aspx';" class="btn btn-dark">Home page</button>
    <li class="nav-item dropdown">
        <a class="btn btn-dark dropdown-toggle" href="#" data-toggle="dropdown" data-target="#menu-item-3">View</a>
        <ul class="dropdown-menu" id="menu-item-3" style="background-color:#35363a">
        <li style="border:solid;color:white"><a style="color:white" class="dropdown-item" href="coorSchedDef.aspx">Details of all users</a></li>
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
   <h2>Assign "Teaching Assistant" to a Bachelor Project</h2>
  <div class="form-group"; style="margin:100px">
            <label for="TA_ID">Teaching Assistant ID:   &nbsp&nbsp </label>
            <asp:DropDownList ID="DropDownList1" runat="server" style="min-width:150px"></asp:DropDownList> <br><br>
            <label for="projCode">Bachelor Project Code:  &nbsp&nbsp</label>
            <asp:DropDownList ID="DropDownList2" runat="server" style="min-width:150px"></asp:DropDownList> <br>  
            <asp:Label ID="Label1" ForeColor="Red" visible="false" runat="server" Text=""></asp:Label><br><br>
            <input type="submit" value="Assign" class="btn btn-primary" /><br>
           </div>
</asp:Content>
