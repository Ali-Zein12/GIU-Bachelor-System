<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeCreatesPR.aspx.cs" Inherits="MileStone_3_Web.EmployeeCreatesPR" %>



<!DOCTYPE html>

<html>
<head runat="server">
    <title>GIU Bachelors' System</title>
    <link rel="icon" type="image/x-icon" href="images/gradpen.ico">
    <link crossorigin="anonymous" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" rel="stylesheet">
    <link rel="stylesheet" href="mainSheet.css">
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">   
    <link href="https://fonts.cdnfonts.com/css/welcome" rel="stylesheet">
    <!-- Dropdown required bootstrap-->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.16.6/dist/umd/popper.min.js" integrity="sha384-F9JjTmy1sQ+fJEkVzG4YsjJzyV/Tp/xo7VbSgTlTZc+2ZYoN/vl4z4C/0q0V7OuN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

                
</head>
<body style="background-color:#35363a">
    <nav class="navbar navbar-expand-md navbar-light" style="max-height:100px;background-image:linear-gradient(to right, rgba(255,255,255,1),rgba(255,255,255,1),rgba(255,255,255),rgba(255,255,255),rgba(255,255,255), rgb(0, 0, 0, 1), rgb(0, 0, 0, 1), rgb(0, 0, 0, 1), rgb(0, 0, 0, 1), rgb(221, 0, 0, 1), rgb(255, 0, 0, 1), rgb(255, 0, 0, 1), rgb(255, 204, 0, 1), rgb(255, 204, 0, 1),rgb(255, 204, 0, 1), rgb(255, 204, 0, 1)");
}" > 
            <div class="container-fluid">
                <!--a class="navbar-brand" href="/"><span class="blue"><h1><b></b></h1></span></!--a-->
                <a href="/Login.aspx"><img href="Login.aspx" src="images/GIU_LOGO_Mina-removebg-preview.png" alt="GIU Logo" style="max-height:70px"></a>
                <button aria-controls="navbar" aria-expanded="false" aria-label="Toggle navigation" class="navbar-toggler" data-bs-target="#navbar" data-bs-toggle="collapse" type="button">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbar" style="text-align:right;float:right;margin-left:auto;left:0">
                        <div class="navbar-nav ms-auto mt-2">
                                <button id="GradeDefence" onclick="location.href='EmployeeGradeDefence.aspx';" class="btn btn-dark">Grade Defence</button>
                                <button id="GradeThesis" onclick="location.href='EmployeeGradeThesis.aspx';" class="btn btn-dark">Grade Thesis</button>
                                <button id="GradePR" onclick="location.href='EmployeeCreatesPR.aspx';" class="btn btn-dark">Create PR</button>
                            &nbsp&nbsp<a href="EmployeeViewProfile.aspx"><img src="images/profile.png" style="max-width:50px;max-height:30px"/></a>&nbsp&nbsp
                          <button id="logout" onclick="location.href='Logout.aspx';" class="btn btn-light">Logout</button>
                        </div>
                </div>
            </div>
        </nav>

     
    <form id="form1" runat="server"  style="margin:70px">
       <h2 style="text-align:center;color:blue">Hello Employee You Can Create Progress Reports Here!</h2><br>
    <h4 style="color:red">Please fill in the following details to add a new PR</h4><br>
    <asp:Label ID="Label3" runat="server" Text="Student_ID"></asp:Label>
    <br />
    <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList> 
    <br>
    <asp:Label ID="Label4" runat="server" Text="Date"></asp:Label>
    <asp:TextBox ID="DateBox" type="date" runat="server" required="true" class="form-control"></asp:TextBox><br>
    <asp:Label ID="Label5" runat="server" Text="Content"></asp:Label>
    <asp:TextBox ID="ContentBox" placeholder="eg. This is the contents of the PR" runat="server" required="true" class="form-control" TextMode="MultiLine"></asp:TextBox>
    <br />
    <br />
    
               <input type="submit" value="CreatePR" class="btn btn-primary" /><br>
    <br>
    <h5>Return to <a href="EmployeeHome.aspx">Home</a>?</h5>
    <div class ="center">
        <asp:Label ID="ErrorLabel" runat="server" Text="Label" Visible="False"></asp:Label>
       
        <br /> 
       
     </div>
          &nbsp;</form>

    <nav class="navbar navbar-expand-md navbar-light" style="position:fixed;bottom:0;max-height:100px;width:100% ;overflow:hidden;background-image:linear-gradient(to right, rgba(255,255,255,1),rgba(255,255,255,1),rgba(255,255,255),rgba(255,255,255),rgba(255,255,255), rgb(0, 0, 0, 1), rgb(0, 0, 0, 1), rgb(0, 0, 0, 1), rgb(0, 0, 0, 1), rgb(221, 0, 0, 1), rgb(255, 0, 0, 1), rgb(255, 0, 0, 1), rgb(255, 204, 0, 1), rgb(255, 204, 0, 1),rgb(255, 204, 0, 1), rgb(255, 204, 0, 1)");
}" > 
          
        </nav>
</body>
</html>

    

