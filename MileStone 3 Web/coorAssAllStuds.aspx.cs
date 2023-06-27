using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class coorAssAllStuds : System.Web.UI.Page
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
                cmd.CommandText = "IF EXISTS (SELECT * FROM Coordinator WHERE coordinator_id = @c_id) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@c_id", c);
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

            if(IsPostBack)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                // Create a new connection
                SqlConnection conn = new SqlConnection(connStr);



                SqlCommand AssignEE = new SqlCommand("AssignAllStudentsToLocalProject", conn);
                AssignEE.CommandType = CommandType.StoredProcedure;
                conn.Open();
                AssignEE.ExecuteNonQuery();
                conn.Close();
                Label1.Text = "All students assigned successfuly!";
                Label1.Visible = true;
                }
        }
        
    }
}