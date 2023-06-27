using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel.Design;
using System.Xml.Linq;
using System.Web.Configuration;




namespace MileStone_3_Web
{
    public partial class AddEmployee : System.Web.UI.Page
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

                   SqlParameter param = (SqlParameter)Session["user"];
                    int c = (int)param.Value;
                

                    string email = Emailbox.Text;
                    string name = Namebox.Text;
                    string phoneNumber = Phonenumberbox.Text;
                    string field = Fieldbox.Text;

                    SqlCommand AddEmployee = new SqlCommand("AddEmployee", conn);

                    AddEmployee.CommandType = CommandType.StoredProcedure;


                    AddEmployee.Parameters.Add("@ComapnyID", SqlDbType.Int).Value = c;
                    AddEmployee.Parameters.Add("@email", SqlDbType.VarChar, 50).Value = email;
                    AddEmployee.Parameters.Add("@name", SqlDbType.VarChar, 20).Value = name;
                    AddEmployee.Parameters.Add("@phone_number", SqlDbType.VarChar, 20).Value = phoneNumber;
                    AddEmployee.Parameters.Add("@field", SqlDbType.VarChar, 25).Value = field;
                    SqlParameter staffIDParameter = AddEmployee.Parameters.Add("@StaffID", SqlDbType.Int);
                    staffIDParameter.Direction = ParameterDirection.Output;
                    SqlParameter passwordParameter = AddEmployee.Parameters.Add("@password", SqlDbType.VarChar, 10);
                    passwordParameter.Direction = ParameterDirection.Output;


                    conn.Open();
                    AddEmployee.ExecuteNonQuery();
                    conn.Close();

                    // Retrieve output values
                    int staffID = (int)staffIDParameter.Value;
                    string password = (string)passwordParameter.Value;
                    if (staffID == -1)
                    {
                        // Employee already exists
                        ErrorLabel.Text = "An employee with the same email address or username already exists.";
                        ErrorLabel.Visible = true;
                    }
                    else
                    {
                        ErrorLabel.Text = "Employee added successfully";
                        ErrorLabel.Visible = true;
                        StaffIdLabel.Text = staffID.ToString();
                        passwordLabel.Text = password;
                        StaffIdLabel.Visible = true;
                        passwordLabel.Visible = true;
                    }
                }
            }

            catch (SqlException ex)
            {
                if (ex.Number == 2627)
                {
                    ErrorLabel.Text = "An employee with the same email address or username already exists.";
                    ErrorLabel.Visible = true;
                }
            }
            {

            }
        }


        protected void addemployeesbutton_Click(object sender, EventArgs e)
        {
           




        }
    }
}
    
