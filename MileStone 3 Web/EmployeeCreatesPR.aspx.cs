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
    public partial class EmployeeCreatesPR : System.Web.UI.Page
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
                cmd.CommandText = "IF EXISTS (SELECT * FROM Employee WHERE Staff_id = @empid) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@empid", c);
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
               // String StudentID = Student_IDBox.Text;
                String Date = DateBox.Text;
                String Content = ContentBox.Text;
                //@Employee_id int, @sid int, @date datetime, @content varchar(1000)

                SqlCommand EmployeeCreatePR = new SqlCommand("EmployeeCreatePR", conn);
                EmployeeCreatePR.CommandType = CommandType.StoredProcedure;

                EmployeeCreatePR.Parameters.Add(new SqlParameter("@Employee_id", c));
                EmployeeCreatePR.Parameters.Add(new SqlParameter("@sid", Convert.ToInt16(st_id)));
                EmployeeCreatePR.Parameters.Add(new SqlParameter("@date", Date));
                EmployeeCreatePR.Parameters.Add(new SqlParameter("@content", Content));


                using (SqlConnection conn2 = new SqlConnection(connStr2))
                {
                    cmd.CommandText = "IF EXISTS (SELECT * FROM ProgressReport WHERE sid = @sid and Date = @Date) SELECT 1 ELSE SELECT 0";
                    cmd.Parameters.AddWithValue("@sid", st_id);
                      cmd.Parameters.AddWithValue("@Date", Date);
                    cmd.Connection = conn2;
                    conn2.Open();
                    // Execute the query and get the result
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        int output = (int)result;
                        if (output == 1)
                        {
                            ErrorLabel.ForeColor = System.Drawing.Color.Red;
                            ErrorLabel.Text = "This progress report already exists";
                        }
                        else
                        {
                            ErrorLabel.ForeColor = System.Drawing.Color.Green;
                            ErrorLabel.Text = "Progress report created successfuly!";
                            conn.Open();
                            EmployeeCreatePR.ExecuteNonQuery();
                            conn.Close();
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
                cmd.CommandText = "SELECT s_id FROM Student s INNER JOIN Industrial i ON i.Industrial_code = s.Assigned_Project_code INNER JOIN Employee e on e.Company_id=i.C_id where e.Staff_id=@staffid and e.Staff_id = i.E_id";
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
