using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlTypes;

namespace MileStone_3_Web
{
    public partial class StudentSignup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                //create a new connection
                SqlConnection conn = new SqlConnection(connStr);

                String fname = FIRSTNAME.Text;
                String lname = LASTNAME.Text;
                String uname = USERNAME.Text;
                String pnumber = PHONENUMBER.Text;
                String email = EMAIL.Text;
                String dob = DOB.Text;
                //DateTime dob = Convert.ToDateTime(ToString(DOB));
                String add = ADDRESS.Text;

                int s = 0;
                if(SEMESTER.Text != null && SEMESTER.Text != "")
                   s = Int16.Parse(SEMESTER.Text);
                String mc = MAJORCODE.Text;
                String role = "Student";


                SqlDecimal @decimal = (SqlDecimal)0.0;
                 if(GPA.Text != null && GPA.Text != "")
                    SqlDecimal.Parse(GPA.Text);


                SqlCommand studentRegister = new SqlCommand("UserRegister", conn);
                studentRegister.CommandType = System.Data.CommandType.StoredProcedure;
                //matching inputs
                studentRegister.Parameters.Add(new SqlParameter("@first_name", fname));
                studentRegister.Parameters.Add(new SqlParameter("@last_name", lname));
                studentRegister.Parameters.Add(new SqlParameter("@userName", uname));
                studentRegister.Parameters.Add(new SqlParameter("@email", email));
                studentRegister.Parameters.Add(new SqlParameter("@birth_date", dob));
                studentRegister.Parameters.Add(new SqlParameter("@address", add));
                studentRegister.Parameters.Add(new SqlParameter("@GPA", @decimal));
                studentRegister.Parameters.Add(new SqlParameter("@semester", s));
                studentRegister.Parameters.Add(new SqlParameter("@major_code", mc));
                studentRegister.Parameters.Add(new SqlParameter("@usertype", role));

                //declaring outputs
                SqlParameter password = studentRegister.Parameters.Add("@password", SqlDbType.VarChar, 10);
                SqlParameter id = studentRegister.Parameters.Add("@user_id", SqlDbType.Int);
                password.Direction = ParameterDirection.Output;
                id.Direction = ParameterDirection.Output;


                conn.Open();
                studentRegister.ExecuteNonQuery();
                conn.Close();
                LabelID.Text = "ID: " + id.Value.ToString();
                LabelID.Visible = true;

                //
                if (id.Value.ToString() != "-1" && id.Value.ToString() != "")
                {
                    LabelPass.Text = "Password: " + password.Value.ToString();
                }
                else
                {
                    LabelPass.Text = "username and email must be unique or missing data ";
                    id.Value = "-1";
                }

                LabelID.Text = "ID: " + id.Value.ToString();
                LabelID.Visible = true;
                LabelPass.Visible = true;

            }
        }
    }
}