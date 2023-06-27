<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="TAAddToDo.aspx.cs" Inherits="MileStone_3_Web.TAAddToDo"  %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
        <button id="home" onclick="location.href='TAHome.aspx';" class="btn btn-dark">Home page</button>    
         <button id="createPRTA" onclick="location.href='TACreatePr.aspx';" class="btn btn-dark">Create Progress Report</button>
</asp:Content>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <h2>Add tasks to the "To-Do-List" of a meeting</h2>
  <div class="form-group"; style="margin:100px">
            <label for="MeetingID">Meeting ID:   &nbsp&nbsp </label>
                  <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList> <br><br>
            <label for="todo">To-Do:</label><br />
            <textarea id="TODO" name="todo" rows="10" cols="80"> </textarea><br><br />
            <input type="submit" value="Add task to the To-Do-List" class="btn btn-primary" /><br>
           <asp:Label ID="Label1" ForeColor="Red" visible="false" runat="server" Text=""></asp:Label><br>
            <a href="TAHome.aspx" font="10px">Home page.</a>
           </div>

</asp:Content>
