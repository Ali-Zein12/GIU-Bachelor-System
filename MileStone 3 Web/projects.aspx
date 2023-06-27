<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="projects.aspx.cs" Inherits="MileStone_3_Web.projects"  %>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <label for="Type"> Project Type:   &nbsp&nbsp </label>
        <asp:DropDownList ID="Type" runat="server" OnSelectedIndexChanged="Type_SelectedIndexChanged" AutoPostBack="true" style="min-width:150px">
             
        </asp:DropDownList>

    <table id ="table">
      <asp:Panel ID="Panel1" runat="server"></asp:Panel>
  </table>
</asp:Content>
