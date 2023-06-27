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
    public partial class LecturerSpecifyDeadline : System.Web.UI.Page
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

        protected void SpecifyThesisDeadline(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            DateTime date = DateTime.Parse(Calendar.SelectedDate.ToString());
            if (TextBox1.Text == "")
                date = date.Add(new TimeSpan(23, 59, 59));
            else
                date = date.Add(TimeSpan.Parse(TextBox1.Text));

            SqlCommand specifyDeadline = new SqlCommand("SpecifyThesisDeadline", conn);
            specifyDeadline.CommandType = System.Data.CommandType.StoredProcedure;

            specifyDeadline.Parameters.Add(new SqlParameter("@deadline", date));

            conn.Open();
            specifyDeadline.ExecuteNonQuery();
            conn.Close();

            SuccessfulDeadline.Visible = true;
        }

        protected void clearLabel(object sender, EventArgs e)
        {
            SuccessfulDeadline.Visible = false;
        }
    }
}