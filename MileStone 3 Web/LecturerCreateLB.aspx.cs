using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class LecturerCreateLB : System.Web.UI.Page
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
                cmd.CommandText = "IF EXISTS (SELECT * FROM Lecturer WHERE Lecturer_id = @Lecturer_id) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@Lecturer_id", c);
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
        }

        protected void CreateBachelor(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            int LecID = (int)((SqlParameter)Session["User"]).Value;
            string projCode = ProjectCodeTextBox.Text;
            string title = TitleTextBox.Text;
            string description = DescriptionTextBox.Text;
            string majorCode = MajorCodeTextBox.Text;

            SqlCommand command = new SqlCommand("LecturerCreateLocalProject", conn);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            command.Parameters.Add(new SqlParameter("@Lecturer_id", LecID));
            command.Parameters.Add(new SqlParameter("@proj_code", projCode));
            command.Parameters.Add(new SqlParameter("@title", title));
            command.Parameters.Add(new SqlParameter("@description", description));
            command.Parameters.Add(new SqlParameter("@major_code", majorCode));
            try
            {
                conn.Open();
                command.ExecuteNonQuery();
                conn.Close();
            }
            catch (Exception ex)
            {
                SuccessfulBachelor.ForeColor = System.Drawing.Color.Red;
                SuccessfulBachelor.Text = "This local bachelor already exists";
            }
            SuccessfulBachelor.Visible = true;
        }
            
    }
}