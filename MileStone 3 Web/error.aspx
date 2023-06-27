<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="error.aspx.cs" Inherits="MileStone_3_Web.error" %>

<!DOCTYPE html>

<html>
<head runat="server">
  <title>Error</title>
  <style>
    .error {
      color: red;
      font-size: larger;
    }
    body
    {
        background-size:cover;
        background-image: url(\images/stars.gif);
        background-repeat: no-repeat;
    }
    .bg
    {
        height:100%
    }

  </style>
</head>
<body>
  <form id="form1" runat="server">
    <div>
      <h1 style="text-align:center;color:white">Something went wrong</h1>
      <div id="error-message" style="text-align:center;color:white">
        <asp:Label ID="errorMessageLabel" runat="server" CssClass="error" />
      </div>
    </div>
  </form>
</body>
</html>
