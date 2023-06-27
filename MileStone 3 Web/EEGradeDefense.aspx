<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="EEGradeDefense.aspx.cs" Inherits="MileStone_3_Web.EEGradeDefense"  %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
    <td align="right" style="text-align:center">
        <button id="home" onclick="location.href='EEHome.aspx';" class="btn btn-dark">Home Page</button>
        <button id="gradeThesis" onclick="location.href='EEGradeThesis.aspx';" class="btn btn-dark">Grade Thesis</button>
    </td>
    
 </asp:Content>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <h2>Submit "Thesis Grade" of a student</h2>
  <div class="form-group"; style="margin:100px">
            <label for="studentID">Student ID:   &nbsp&nbsp </label>
            <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList> <br><br>
            <label for="defenseLocation">Defense Location:</label><br />
            <asp:DropDownList ID="DropDownList2" runat="server"></asp:DropDownList> <br><br>
            <label for="EEGrade">Grade:</label><br />
            <input type="text" id="GRADE" name="grade" class="form-control" required/><br />
            <input type="submit" value="Submit Grade" class="btn btn-primary" /><br>
           <asp:Label ID="Label1" ForeColor="Red" visible="false" runat="server" Text=""></asp:Label><br>
           </div>

</asp:Content>