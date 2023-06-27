using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Collections.Specialized.BitVector32;

namespace MileStone_3_Web
{
    public partial class LecturerCreateMeeting : System.Web.UI.Page
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

        protected void CreateM(object sender, EventArgs e)
        {
            string connString = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            SqlConnection conn = new SqlConnection(connString);

            SqlCommand com = new SqlCommand("CreateMeeting", conn);
            com.CommandType = System.Data.CommandType.StoredProcedure;

            SqlParameter param = (SqlParameter)Session["user"];
            int L_id = (int)param.Value;

            com.Parameters.Add(new SqlParameter("@Lecturer_id",L_id));
            com.Parameters.Add(new SqlParameter("@start_time", start.Text));
            com.Parameters.Add(new SqlParameter("@end_time", end.Text));
            com.Parameters.Add(new SqlParameter("@date", date.Text));
            com.Parameters.Add(new SqlParameter("@meeting_point", location.Text));

            conn.Open();
            com.ExecuteNonQuery();
            conn.Close();

            successfulCreation.Visible = true;
        }
    }
}