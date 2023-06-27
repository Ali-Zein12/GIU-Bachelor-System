using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Net.NetworkInformation;
using System.Security.Cryptography;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class studentBachelorPreferences : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("error.aspx?message=You+must+sign+in+first.");
            }

            SqlCommand cmd45 = new SqlCommand();
            SqlParameter param45 = (SqlParameter)Session["user"];
            int c45 = (int)param45.Value;
            string connStr45 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn45 = new SqlConnection(connStr45))
            {
                cmd45.CommandText = "IF EXISTS (SELECT * FROM Student WHERE s_id = @sid) SELECT 1 ELSE SELECT 0";
                cmd45.Parameters.AddWithValue("@sid", c45);
                cmd45.Connection = conn45;
                conn45.Open();
                // Execute the query and get the result
                object result45 = cmd45.ExecuteScalar();
                if (result45 != null && result45 != DBNull.Value)
                {
                    int output = (int)result45;
                    if (output != 1)
                    {
                        Response.Redirect("error.aspx?message=You don't have access to this webpage.");
                    }
                }
                conn45.Close();
            }

            SqlCommand cmd = new SqlCommand();
            SqlCommand cmd2 = new SqlCommand();

            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;
            string connStr2 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn2 = new SqlConnection(connStr2))
            {

                cmd.CommandText = "IF EXISTS (SELECT * FROM Student WHERE s_id = @sid AND Assigned_Project_code  IS NOT NULL) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@sid", c);
                cmd.Connection = conn2;
                //cmd2.CommandText = "IF EXISTS (SELECT * FROM Student WHERE s_id = @sid AND Assigned_Project_code IS NOT NULL) SELECT 1 ELSE SELECT 0";
                //cmd2.Parameters.AddWithValue("@sid", c);
                //cmd2.Connection = conn2;
                conn2.Open();
                // Execute the query and get the result
                object result = cmd.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                {
                    int output = (int)result;
                    if (output == 1)
                    {
                        grade.ForeColor = System.Drawing.Color.Red;
                        grade.Text = "You have been assigned to a project already";
                        grade.Visible = true;
                        OK.Visible = false;
                        // Response.Redirect("error.aspx?message=You don't have access to this webpage.");
                    }

                    else
                    {
                        OK.Visible = true;

                        if (!IsPostBack)
                        {
                            if (Session["user"] == null)
                            {
                                Response.Redirect("error.aspx?message=You+must+sign+in+first.");
                            }

                            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                            // Create a new connection
                            SqlConnection conn = new SqlConnection(connStr);

                            PN_BindDropDownList();
                            BC_BindDropDownList();
                        }
                    }
                }
            }
        }
        protected void BC_SelectedIndexChanged(object sender, EventArgs e)
        {
           
        }
        protected void PN_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        private void BC_BindDropDownList()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT BP.Code FROM Bachelor_Project BP INNER JOIN MajorHasBachelorProject MB ON BP.Code = MB.Project_code INNER JOIN Student S ON MB.Major_code = S.Major_code  WHERE S.s_id = @sid EXCEPT ( SELECT DISTINCT SP.PCode FROM StudentPreferences SP WHERE SP.sid = @sid )";
                cmd.Parameters.Add(new SqlParameter("@sid", c));

                cmd.Connection = conn;

                conn.Open();
                BC.DataSource = cmd.ExecuteReader();
                BC.DataTextField = "Code";
                BC.DataBind();

                BC.Items.Insert(0, new ListItem("Select a project code", "Select a project code"));
                BC.SelectedValue = "Select a project code";
            }


        }

        private void PN_BindDropDownList()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT COUNT(BP.Code) FROM Bachelor_Project BP INNER JOIN MajorHasBachelorProject MB ON BP.Code = MB.Project_code INNER JOIN Student S ON MB.Major_code = S.Major_code  WHERE S.s_id = @sid EXCEPT ( SELECT COUNT( DISTINCT SP.PCode) FROM StudentPreferences SP WHERE SP.sid = @sid )";
                //SqlParameter countOfProjects = cmd.Parameters.Add("@success", SqlDbType.Int);
                cmd.Parameters.Add(new SqlParameter("@sid", c));

                SqlCommand modifier = new SqlCommand();
                modifier.CommandText = "SELECT PreferenceNumber FROM StudentPreferences  WHERE sid = @sid ";
                modifier.Parameters.Add(new SqlParameter("@sid", c));

                List<string> alreadySelected = new List<string>();

                //--Get File names from datbase table

                conn.Open();
                using (SqlCommand cmd1 = new SqlCommand("SELECT PreferenceNumber FROM StudentPreferences  WHERE sid = @sid", conn))
                {
                    cmd1.Parameters.Add(new SqlParameter("@sid", c));

                    SqlDataReader reader = cmd1.ExecuteReader();
                    while (reader.Read())
                    {
                        if (!string.IsNullOrEmpty(Convert.ToString(reader["PreferenceNumber"])))
                            alreadySelected.Add(Convert.ToString(reader["PreferenceNumber"]));
                    }
                }
                conn.Close();

                cmd.Connection = conn;

                conn.Open();
                string countOfProjects = cmd.ExecuteScalar().ToString();
                int CP = Int16.Parse(countOfProjects);
                var list = new List<int>();
                for (int i = 1; i <= CP; i++)
                {
                    list.Add(i);

                }
                foreach (int l in list)
                {
                    PN.Items.Add(l.ToString());
                }

                foreach (string l in alreadySelected)
                {
                   PN.Items.Remove(PN.Items.FindByValue(l));
                }
                //PN.DataSource = cmd.ExecuteScalar();
                // PN.DataTextField = "Count";
                // PN.DataBind();

                PN.Items.Insert(0, new ListItem("Select a number", "Select a number"));
                PN.SelectedValue = "Select a number";



            }

        }




      



        protected void submit_Click(object sender, EventArgs e)
        {
            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;
            string n = PN.SelectedValue;
            string b = BC.SelectedValue;

            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand makePreferences = new SqlCommand("MakePreferencesLocalProject");
                makePreferences.Connection = conn;
                makePreferences.CommandType = System.Data.CommandType.StoredProcedure;
                makePreferences.Parameters.Add(new SqlParameter("@sid", c));
                if (b.ToString() != "Select a project code")
                {
                    string bp = b.ToString();
                    if (n != "Select a number")
                    {
                        int p = Int16.Parse(n);
                        makePreferences.Parameters.Add(new SqlParameter("@preference_number", n));
                        makePreferences.Parameters.Add(new SqlParameter("@bachelor_code", bp));
                        conn.Open();
                        makePreferences.ExecuteNonQuery();
                        conn.Close();
                        SqlCommand test = new SqlCommand("IF ( EXISTS ( SELECT * FROM StudentPreferences WHERE sid = @i AND  PCode= @code AND PreferenceNumber = @num) ) SELECT 1 ELSE SELECT 0 ");
                        test.Connection = conn;
                        test.Parameters.Add(new SqlParameter("@i", c));
                        test.Parameters.Add(new SqlParameter("@num", n));
                        test.Parameters.Add(new SqlParameter("@code", bp));

                        conn.Open();
                        object result = test.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            int output = (int)result;
                            if (output == 1)
                            {
                                Label1.Text = "Preference Added Successfully";
                                Label1.ForeColor = System.Drawing.Color.Green;

                                BC.Items.Remove(BC.Items.FindByValue(b));
                                PN.Items.Remove(PN.Items.FindByValue(n));
                                //PN_BindDropDownList();
                                BC_BindDropDownList();


                            }
                            else
                            {
                                Label1.Text = "Failed TO Add Preference";
                                Label1.ForeColor = System.Drawing.Color.Red;
                                makePreferences.ExecuteNonQuery();
                               // PN_BindDropDownList();
                                BC_BindDropDownList();
                                conn.Close();
                               
                            }
                            Label1.Visible = true;
                        }
                    
                        Label1.Visible = true;
                        conn.Close();
                    }
                    else
                    {
                        Label1.Text = "You have to select a project code  and preference number";
                        Label1.ForeColor = System.Drawing.Color.Red;
                        Label1.Visible = true;
                       // PN_BindDropDownList();
                        BC_BindDropDownList();

                    }

                }
                else
                {
                    Label1.Text = "You have to select a project code and preference number";
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Visible = true;
                   // PN_BindDropDownList();
                    BC_BindDropDownList();

                }
            }
        }




        

    }
}


