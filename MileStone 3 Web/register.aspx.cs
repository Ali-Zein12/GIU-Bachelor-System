using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(IsPostBack)
            {
                String selectedRole = dropdown.Value.ToString();
                if (selectedRole == "student")
                {
                    Response.Redirect("StudentSignup.aspx");
                }
                else if(selectedRole == "ta")
                {
                    Response.Redirect("TASignup.aspx");
                }
                else if (selectedRole == "lecturer")
                {
                    Response.Redirect("LecturerSignup.aspx");
                }
                else if (selectedRole == "ee")
                {
                    Response.Redirect("EESignup.aspx");
                }
                else if (selectedRole == "company")
                {
                   Response.Redirect("CompanySignup.aspx");
                }
                else if (selectedRole == "coordinator")
                {
                    Response.Redirect("CoordinatorSignup.aspx");
                }
                else
                {
                    Response.Redirect("error.aspx?message=Invalid role.");
                }
            }
        }
    }
}