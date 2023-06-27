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
    public partial class LecturerCreatePG : System.Web.UI.Page
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
            if (!Page.IsPostBack)
            {

                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand command = new SqlCommand();
                command.Connection = conn;
                command.CommandType = System.Data.CommandType.Text;
                command.CommandText = "SELECT s_id FROM Student";


                conn.Open();
                DropDownList.DataSource = command.ExecuteReader();
                DropDownList.DataTextField = "s_id";
                DropDownList.DataBind();
                DropDownList.Items.Insert(0, new ListItem("None", "None"));
                DropDownList.SelectedValue = "None";
                conn.Close();

            }
        }

        protected void AddProgressReport(object sender, EventArgs e)
        {
            if (DropDownList.SelectedValue != "None")
            {
                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlParameter param = (SqlParameter)Session["user"];
                int L_ID = (int)param.Value;
                int sid = Convert.ToInt32(DropDownList.SelectedValue);

                SqlCommand command = new SqlCommand("LecCreatePR",conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add(new SqlParameter("@Lecturer_id",L_ID));
                command.Parameters.Add(new SqlParameter("@sid", sid));
                command.Parameters.Add(new SqlParameter("@date", DateTime.Now));
                command.Parameters.Add(new SqlParameter("@content", TextBox1.Text));
                try
                {
                    conn.Open();
                    command.ExecuteNonQuery();
                    conn.Close();

                    addedSuccessfully.Text = "Progress Report Added Successfully!";
                    addedSuccessfully.ForeColor = System.Drawing.Color.Green;
                    addedSuccessfully.Visible = true;
                }
                catch (Exception ex) {
                    addedSuccessfully.Text = "Could not add this Progress Report, please contact the administrator :(";
                    addedSuccessfully.ForeColor = System.Drawing.Color.Coral;
                    addedSuccessfully.Visible = true;
                }

            }
            else
            {
                addedSuccessfully.Text = "You must select a student first!";
                addedSuccessfully.ForeColor = System.Drawing.Color.Red;
                addedSuccessfully.Visible = true;
            }
        }

        protected void HideLabel(object sender, EventArgs e)
        {
            addedSuccessfully.Visible = false;
        }
    }
}