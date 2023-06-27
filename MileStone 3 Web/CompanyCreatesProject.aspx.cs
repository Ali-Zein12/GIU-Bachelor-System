using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection.Emit;

namespace MileStone_3_Web
{
    public partial class CompanyCreatesProject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (IsPostBack)
                {
                    string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                    //create a new connection
                    SqlConnection conn = new SqlConnection(connStr);
                    SqlCommand CompanyCreateLocalProject = new SqlCommand("CompanyCreateLocalProject", conn);
                    CompanyCreateLocalProject.CommandType = System.Data.CommandType.StoredProcedure;
                    SqlParameter param = (SqlParameter)Session["user"];
                    int c = (int)param.Value;

                    String Proj_code = Project_CodeBox.Text;
                    String Title = TitleBox.Text;
                    String Description = DescriptionBox.Text;
                    String Major_code = Major_CodeBox.Text;
                    CompanyCreateLocalProject.Parameters.Add(new SqlParameter("@company_id", c));
                    CompanyCreateLocalProject.Parameters.Add(new SqlParameter("@proj_code", Proj_code));
                    CompanyCreateLocalProject.Parameters.Add(new SqlParameter("@title", Title));
                    CompanyCreateLocalProject.Parameters.Add(new SqlParameter("@description", Description));
                    CompanyCreateLocalProject.Parameters.Add(new SqlParameter("@major_code", Major_code));

                    //
                    conn.Open();
                    CompanyCreateLocalProject.ExecuteNonQuery();
                    conn.Close();


                    ErrorLabel.Text = "Project added successfully";
                    ErrorLabel.Visible = true;
                }
            }
            catch (SqlException ex)
            {

                if (ex.Number == 2627)
                {
                    ErrorLabel.Text = "A project with this code already exists.";
                    ErrorLabel.Visible = true;
                }

            }


        }
        }
    }
