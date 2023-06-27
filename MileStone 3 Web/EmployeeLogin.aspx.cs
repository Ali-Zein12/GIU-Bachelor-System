using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class EmployeeLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            if (IsPostBack)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                // Create a new connection
                SqlConnection conn = new SqlConnection(connStr);

                string email = Request.Form["email"];
                string password = Request.Form["password"];

                SqlCommand loginproc = new SqlCommand("EmployeeLogin", conn);
                loginproc.CommandType = CommandType.StoredProcedure;
                loginproc.Parameters.Add(new SqlParameter("@email", email));
                loginproc.Parameters.Add(new SqlParameter("@password", password));

                SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);
                SqlParameter id = loginproc.Parameters.Add("user_id", SqlDbType.Int);


                success.Direction = ParameterDirection.Output;
                id.Direction = ParameterDirection.Output;

                conn.Open();
                loginproc.ExecuteNonQuery();
                conn.Close();

                if (success.Value.ToString() == "1")
                {
                    Session["user"] = id;
                    SqlCommand cmd = new SqlCommand();
                    string connStr2 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                    using (SqlConnection conn2 = new SqlConnection(connStr2))
                    {
                        // Set the CommandText property to the SQL query with the IF EXISTS clause
                        cmd.CommandText = "IF EXISTS (SELECT * FROM Employee WHERE Staff_id = @Staff_id) SELECT 1 ELSE SELECT 0";

                        // Add a parameter for the Country column
                        SqlParameter param = (SqlParameter)Session["user"];
                        int c = (int)param.Value;
                        cmd.Parameters.AddWithValue("@Staff_id", c);

                        // Set the connection for the command
                        cmd.Connection = conn2;

                        // Open the connection
                        conn2.Open();

                        // Execute the query and get the result
                        object result = cmd.ExecuteScalar();

                        // Check the result
                        if (result != null && result != DBNull.Value)
                        {
                            // The query returned a result
                            int output = (int)result;
                            if (output == 1)
                            {
                                // The query returned at least one row
                                Response.Redirect("EmployeeHome.aspx");

                            }
                        }
                        conn2.Close();
                    }
                    }
            }
        }
    }
}
