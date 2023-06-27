<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="EEHome.aspx.cs" Inherits="MileStone_3_Web.EEHome"  %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
    <td align="right" style="text-align:center">
        <button id="gradeThesis" onclick="location.href='EEGradeThesis.aspx';" class="btn btn-dark">Grade Thesis</button>
        <button id="gradeDefense" onclick="location.href='EEGradeDefense.aspx';" class="btn btn-dark">Grade Defense</button>
    </td>
    
 </asp:Content>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Welcome Examiner!</h2>
    <asp:Panel ID="Panel1" runat="server"></asp:Panel>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="viewProjs" runat="server">
    <label for="Type"> Project Type:   &nbsp&nbsp </label>
        <asp:DropDownList ID="Type" runat="server" OnSelectedIndexChanged="Type_SelectedIndexChanged" AutoPostBack="true" style="min-width:150px">
        </asp:DropDownList>
        <asp:Panel ID="Panel2" runat="server"></asp:Panel>
</asp:Content>