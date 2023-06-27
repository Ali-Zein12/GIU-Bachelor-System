<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="TACreatePr.aspx.cs" Inherits="MileStone_3_Web.TACreatePr"  %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
        <button id="home" onclick="location.href='TAHome.aspx';" class="btn btn-dark">Home page</button>
        <button id="addToDoTA" onclick="location.href='TAAddToDo.aspx';" class="btn btn-dark">Meeting To-Do list</button>
 </asp:Content>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Create a progress report for a student</h2>
  <div class="form-group"; style="margin:100px">
            <label for="studentID">Student ID:   &nbsp&nbsp </label>
            <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList> <br><br>
            <label for="date">Date:</label><br />
            <input type="date" id="DATE" name="date" class="form-control" required/><br />
            <label for="content">Content:</label><br />
            <textarea id="CONTENT" name="content" rows="10" cols="80"> </textarea><br><br />
            <input type="submit" value="Upload Progress Report" class="btn btn-primary" /><br>
           <asp:Label ID="Label1" ForeColor="Red" visible="false" runat="server" Text=""></asp:Label><br>
            <a href="TAHome.aspx" font="10px">Home page.</a>
           </div>
</asp:Content>