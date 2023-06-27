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
    public partial class  EmployeeGradeDefence: System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("error.aspx?message=You+must+sign+in+first.");
            }
            SqlCommand cmd = new SqlCommand();
            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;
            string connStr2 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn2 = new SqlConnection(connStr2))
            {
                cmd.CommandText = "IF EXISTS (SELECT * FROM Employee WHERE Staff_id = @emp_id) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@emp_id", c);
                cmd.Connection = conn2;
                conn2.Open();
                // Execute the query and get the result
                object result = cmd.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                {
                    int output = (int)result;
                    if (output != 1)
                    {
                        Response.Redirect("error.aspx?message=You don't have access to this webpage.");
                    }
                }
                conn2.Close();
            }
            if (!IsPostBack)
            {
                BindDropDownList();
            }

            else
            {
                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                // Create a new connection
                SqlConnection conn = new SqlConnection(connStr);
                string st_id = DropDownList1.SelectedValue;
             //   string st_id = StudentIDBox.Text;
                string location = Defense_LocationBox.Text;               
                SqlCommand EmployeeGradedefense = new SqlCommand("EmployeeGradedefense", conn);
                EmployeeGradedefense.CommandType = CommandType.StoredProcedure;
                decimal Employee_Grade = decimal.Parse(Employee_GradeBox.Text);

                EmployeeGradedefense.Parameters.Add(new SqlParameter("@Employee_id", c));
                EmployeeGradedefense.Parameters.Add(new SqlParameter("@sid", Convert.ToInt16(st_id)));
                EmployeeGradedefense.Parameters.Add(new SqlParameter("@defense_location", location));
                EmployeeGradedefense.Parameters.Add(new SqlParameter("@Employee_grade", Employee_Grade));



                using (SqlConnection conn2 = new SqlConnection(connStr2))
                {
                    cmd.CommandText = "IF EXISTS (SELECT * FROM Defense WHERE sid = @sid AND Location = @Location) SELECT 1 ELSE SELECT 0";
                    cmd.Parameters.AddWithValue("@sid", st_id);
                    cmd.Parameters.AddWithValue("@Location", location);
                    cmd.Connection = conn2;
                    conn2.Open();
                    // Execute the query and get the result
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        int output = (int)result;
                        if (output != 1)
                        {
                            ErrorLabel.Text = "This student doesn't have a defense or invalid Location";
                        }
                        else
                        {
                            conn.Open();
                            EmployeeGradedefense.ExecuteNonQuery();
                            conn.Close();
                            ErrorLabel.Text = "Defense grade updated successfuly!";
                        }
                        ErrorLabel.Visible = true;
                    }
                    conn2.Close();
                }
            }
        }
        private void BindDropDownList()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT s_id FROM Student s INNER JOIN Industrial i ON i.Industrial_code = s.Assigned_Project_code INNER JOIN Employee e on e.Company_id=i.C_id INNER JOIN Defense d on d.sid=s.s_id where e.Staff_id=@staffid and e.Staff_id = i.E_id";
                cmd.Parameters.Add(new SqlParameter("@staffid", c));
                cmd.Connection = conn;
                conn.Open();
                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "s_id";
                DropDownList1.DataBind();
            }
        }
    }

}
