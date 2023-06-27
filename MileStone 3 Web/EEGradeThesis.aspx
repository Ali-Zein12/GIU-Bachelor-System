<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="EEGradeThesis.aspx.cs" Inherits="MileStone_3_Web.EEGradeThesis"  %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
    <td align="right" style="text-align:center">
        <button id="home" onclick="location.href='EEHome.aspx';" class="btn btn-dark">Home Page</button>
        <button id="gradeDefense" onclick="location.href='EEGradeDefense.aspx';" class="btn btn-dark">Grade Defense</button>
    </td>
    
 </asp:Content>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <h2>Submit "Thesis Defense" of a student</h2>
  <div class="form-group"; style="margin:100px">
            <label for="studentID">Student ID:   &nbsp&nbsp </label>
            <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList> <br><br>
            <label for="thesisTitle">Thesis title:</label><br />
            <asp:DropDownList ID="DropDownList2" runat="server"></asp:DropDownList> <br><br>
            <label for="EEGrade">Grade:</label><br />
            <input type="text" id="GRADE" name="grade" class="form-control" required/><br />
            <input type="submit" value="Submit Grade" class="btn btn-primary" /><br>
           <asp:Label ID="Label1" ForeColor="Red" visible="false" runat="server" Text=""></asp:Label><br>
            <a href="TAHome.aspx" font="10px">Home page.</a>
           </div>

</asp:Content>