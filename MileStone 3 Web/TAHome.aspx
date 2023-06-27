<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="TAHome.aspx.cs" Inherits="MileStone_3_Web.TAHome"  %>

<asp:Content ID="navBarHolder" ContentPlaceHolderID="navBarHolder" runat="server">
    <button id="createPRTA" onclick="location.href='TACreatePr.aspx';" class="btn btn-dark">Create Progress Report</button>
    <button id="addToDoTA" onclick="location.href='TAAddToDo.aspx';" class="btn btn-dark">Meeting To-Do list</button>
   
 </asp:Content>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Welcome Teaching assistant!</h2>
    <asp:Panel ID="Panel1" runat="server"></asp:Panel>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="viewProjs" runat="server">
    <label for="Type"> Project Type:   &nbsp&nbsp </label>
        <asp:DropDownList ID="Type" runat="server" OnSelectedIndexChanged="Type_SelectedIndexChanged" AutoPostBack="true" style="min-width:150px">
        </asp:DropDownList>
        <asp:Panel ID="Panel2" runat="server"></asp:Panel>
</asp:Content>


