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
    public partial class LecturerGradeStudent : System.Web.UI.Page
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
                DropDownList1.Items.Insert(1, new ListItem("Thesis", "Thesis"));
                DropDownList1.Items.Insert(2, new ListItem("Defense", "Defense"));
                DropDownList1.Items.Insert(3, new ListItem("Progress Report", "Progress Report"));
                DropDownList1.SelectedValue = "None";

            }

        }

        protected void GradeAnything(object sender, EventArgs e)
        {
            string connString = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            SqlConnection conn = new SqlConnection(connString);

            SqlParameter param = (SqlParameter)Session["user"];
            int L_id = (int)param.Value;

            int sid = Convert.ToInt32(DropDownList2.SelectedValue);

            if (DropDownList1.SelectedValue == "Thesis")
            {
                SqlCommand com = new SqlCommand("LecGradeThesis",conn);
                com.CommandType = System.Data.CommandType.StoredProcedure;
                com.Parameters.Add(new SqlParameter("@Lecturer_id",L_id));
                com.Parameters.Add(new SqlParameter("@sid", sid));
                com.Parameters.Add(new SqlParameter("@thesis_title",DropDownList3.SelectedValue));
                com.Parameters.Add(new SqlParameter("@Lecturer_grade", LecGrade.Text));
                try
                {
                    conn.Open();
                    com.ExecuteNonQuery();
                    conn.Close();
                    if (DropDownList3.SelectedValue != "None")
                    {
                        gradedSuccessfully.Text = "Grade added successfully!";
                        gradedSuccessfully.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        gradedSuccessfully.Text = "Thesis title is not chosen!";
                        gradedSuccessfully.ForeColor = System.Drawing.Color.Red;
                    }    
                    gradedSuccessfully.Visible = true;

                }
                catch
                {
                    gradedSuccessfully.Text = "This grade range is incorrect!";
                    gradedSuccessfully.ForeColor = System.Drawing.Color.Red;
                    gradedSuccessfully.Visible = true;
                }
            }
            else if (DropDownList1.SelectedValue == "Defense")
            {
                SqlCommand com = new SqlCommand("LecGradedefense", conn);
                com.CommandType = System.Data.CommandType.StoredProcedure;
                com.Parameters.Add(new SqlParameter("@Lecturer_id", L_id));
                com.Parameters.Add(new SqlParameter("@sid", sid));
                com.Parameters.Add(new SqlParameter("@defense_location", DropDownList3.SelectedValue));
                com.Parameters.Add(new SqlParameter("@Lecturer_grade", LecGrade.Text));
                try
                {
                    
                    if (DropDownList3.SelectedValue != "None")
                    {
                        conn.Open();
                        com.ExecuteNonQuery();
                        conn.Close();
                        gradedSuccessfully.Text = "Grade added successfully!";
                        gradedSuccessfully.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        gradedSuccessfully.Text = "Defense Location is not chosen!";
                        gradedSuccessfully.ForeColor = System.Drawing.Color.Red;
                    }
                    gradedSuccessfully.Visible = true;

                }
                catch
                {
                    gradedSuccessfully.Text = "This grade range is incorrect!";
                    gradedSuccessfully.ForeColor = System.Drawing.Color.Red;
                    gradedSuccessfully.Visible = true;
                }
            }
            else if(DropDownList1.SelectedValue == "Progress Report")
            {
                SqlCommand com = new SqlCommand("LecGradePR", conn);
                com.CommandType = System.Data.CommandType.StoredProcedure;
                com.Parameters.Add(new SqlParameter("@Lecturer_id", L_id));
                com.Parameters.Add(new SqlParameter("@sid", sid));
                com.Parameters.Add(new SqlParameter("@date", DateTime.Parse( DropDownList3.SelectedValue)));
                com.Parameters.Add(new SqlParameter("@Lecturer_grade",LecGrade.Text));
                
                try
                {
                    conn.Open();
                    com.ExecuteNonQuery();
                    conn.Close();
                    if (DropDownList3.SelectedValue != "None")
                    {
                        gradedSuccessfully.Text = "Grade added successfully!";
                        gradedSuccessfully.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        gradedSuccessfully.Text = "Progress Report date is not chosen!";
                        gradedSuccessfully.ForeColor = System.Drawing.Color.Red;
                    }
                    gradedSuccessfully.Visible = true;


                }
                catch
                {
                    gradedSuccessfully.Text = "This grade range is incorrect!";
                    gradedSuccessfully.ForeColor = System.Drawing.Color.Red;
                    gradedSuccessfully.Visible = true;
                }
                
            }

           
            
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            label2.Visible = false;
            DropDownList2.Visible = false;
            label3.Visible = false;
            label3.Text = "N/A";
            DropDownList3.Visible = false;
            label4.Visible = false;
            LecGrade.Visible = false;
            button.Visible = false;
            gradedSuccessfully.Visible = false;
            if (DropDownList1.SelectedValue != "None")
            {
                string connString = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                SqlConnection conn = new SqlConnection(connString);

                SqlCommand com = new SqlCommand();
                com.Connection = conn;
                com.CommandType = System.Data.CommandType.Text;
                com.CommandText = "SELECT s_id FROM Student";
                conn.Open();
                DropDownList2.DataSource = com.ExecuteReader();
                DropDownList2.DataTextField = "s_id";
                DropDownList2.DataBind();
                DropDownList2.Items.Insert(0, new ListItem("None", "None"));
                DropDownList2.SelectedValue = "None";
                conn.Close();


                label2.Visible = true;
                DropDownList2.Visible = true;
                DropDownList2.SelectedValue = "None";
            }
            else {
                label2.Visible = false;
                DropDownList2.Visible = false;
                DropDownList2.SelectedValue = "None";
                label3.Visible = false;
                DropDownList3.Visible = false;
                DropDownList3.SelectedValue = "None";
                label4.Visible = false;
                LecGrade.Visible = false;
                button.Visible = false;
                gradedSuccessfully.Visible = false;
            }
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            label3.Visible = false;
            label3.Text = "N/A";
            DropDownList3.Visible = false;
            label4.Visible = false;
            LecGrade.Visible = false;
            button.Visible = false;
            gradedSuccessfully.Visible = false;
            if (DropDownList2.SelectedValue != "None")
            {
                string connString = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                SqlConnection conn = new SqlConnection(connString);

                SqlCommand com = new SqlCommand();
                com.Connection = conn;
                com.CommandType = System.Data.CommandType.Text;

                int sid = Convert.ToInt32(DropDownList2.SelectedValue);
                com.Parameters.Add(new SqlParameter("@sid", sid));

                if (DropDownList1.SelectedValue == "Thesis")
                {
                    com.CommandText = "SELECT Title FROM Thesis WHERE sid = @sid";
                    DropDownList3.DataTextField = "Title";
                    label3.Text = "Thesis Title";
                }
                else if (DropDownList1.SelectedValue == "Defense")
                {
                    com.CommandText = "SELECT Location FROM Defense WHERE sid = @sid";
                    DropDownList3.DataTextField = "Location";
                    label3.Text = "Defense Location";
                }
                else
                {
                    com.CommandText = "SELECT Date FROM ProgressReport WHERE sid = @sid";
                    DropDownList3.DataTextField = "Date";
                    label3.Text = "PR Date";
                }
                conn.Open();
                DropDownList3.DataSource = com.ExecuteReader();
                DropDownList3.DataBind();
                DropDownList3.Items.Insert(0, new ListItem("None", "None"));
                DropDownList3.SelectedValue = "None";
                conn.Close();
                label3.Visible = true;
                DropDownList3.Visible = true;
                DropDownList3.SelectedValue = "None";
            }
            else
            {
                label3.Visible = false;
                DropDownList3.Visible = false;
                DropDownList3.SelectedValue = "None";
                label4.Visible = false;
                LecGrade.Visible = false;
                button.Visible = false;
                gradedSuccessfully.Visible = false;
            }
        }

        protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
        {
            label4.Visible = false;
            LecGrade.Visible = false;
            button.Visible = false;
            gradedSuccessfully.Visible = false;
            if (DropDownList1.SelectedValue != "None")
            {
                label4.Visible = true;
                LecGrade.Visible = true;
                button.Visible = true;
            }
            else
            {                
                label4.Visible = false;
                LecGrade.Visible = false;
                button.Visible = false;
                gradedSuccessfully.Visible = false;
            }
        }
    }
}