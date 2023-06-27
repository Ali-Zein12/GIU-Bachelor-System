<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="CompanyHome.aspx.cs" Inherits="MileStone_3_Web.CompanyHome"  %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
    <td align="right" style="text-align:center">
        <button id="GradeDefence" onclick="location.href='CompanyGradeDefence.aspx';" class="btn btn-dark">Grade Defence</button>
        <button id="GradePR" onclick="location.href='CompanyGradeProgressReport.aspx';" class="btn btn-dark">Grade PR</button>
        <button id="GradeThesis" onclick="location.href='CompanyGradeThesis.aspx';" class="btn btn-dark">Grade Thesis</button>
         <button id="CreateProject" onclick="location.href='CompanyCreatesProject.aspx';" class="btn btn-dark">Create Project</button>
                 <button id="AssignEmplyee" onclick="location.href='AssignEmployee.aspx';" class="btn btn-dark">Assign Employee</button>
                 <button id="AddEmployee" onclick="location.href='AddEmployee.aspx';" class="btn btn-dark">Add Employee</button>
    </td>
    
 </asp:Content>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Welcome Company!</h2>
    <asp:Panel ID="Panel1" runat="server" Height="65px"></asp:Panel>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="viewProjs" runat="server">
    <label for="Type"> Project Type:   &nbsp&nbsp </label>
        <asp:DropDownList ID="Type" runat="server" OnSelectedIndexChanged="Type_SelectedIndexChanged" AutoPostBack="true" style="min-width:150px">
        </asp:DropDownList>
        <asp:Panel ID="Panel2" runat="server"></asp:Panel>
</asp:Content>
