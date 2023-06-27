
    using System;
    using System.Collections.Generic;
    using System.Data.SqlClient;
    using System.Data;
    using System.Linq;
    using System.Web;
    using System.Web.Configuration;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using System.Security.Cryptography;
    using System.Reflection.Emit;

namespace MileStone_3_Web
{
    public partial class studentUpdateDefense : System.Web.UI.Page
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
            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;

            string connStr2 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn2 = new SqlConnection(connStr2))
            {
                cmd.CommandText = "IF EXISTS (SELECT * FROM Defense WHERE sid = @sid) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@sid", c);
                cmd.Connection = conn2;
                conn2.Open();
                // Execute the query and get the result
                object resultD = cmd.ExecuteScalar();
                if (resultD != null && resultD != DBNull.Value)
                {
                    int output = (int)resultD;
                    if (output != 1)
                    {
                        Label1.Text = "You don't have a defense yet";
                        Label1.Visible = true;
                        OK.Visible = false;
                    }




                    else
                    {
                        Label1.Visible = false;
                        OK.Visible = true;
                        conn2.Close();

                        string pdf = Request.Form["TS"];

                        SqlCommand UpdateMyDefense = new SqlCommand("UpdateMyDefense", conn2);
                        UpdateMyDefense.CommandType = CommandType.StoredProcedure;
                        UpdateMyDefense.Parameters.Add(new SqlParameter("@sid", c));
                        UpdateMyDefense.Parameters.Add(new SqlParameter("@defense_content", pdf));



                        conn2.Open();
                        if (IsPostBack)
                        {
                            UpdateMyDefense.ExecuteNonQuery();
                            
                            string connStr3 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                            using (SqlConnection conn3 = new SqlConnection(connStr3))
                            {
                                SqlCommand test = new SqlCommand();
                                test.CommandText = "IF EXISTS (SELECT * FROM Defense WHERE sid = @sid AND Content = @defense_content) SELECT 1 ELSE SELECT 0";
                                test.Parameters.AddWithValue("@sid", c);
                                test.Parameters.AddWithValue("@defense_content", pdf);
                                test.Connection = conn3;
                                conn3.Open();
                                // Execute the query and get the result
                                object result1 = test.ExecuteScalar();
                                if (result1 != null && result1 != DBNull.Value)
                                {
                                    int output1 = (int)result1;
                                    if (output1 == 1)
                                    {
                                        Label1.Text = "Defense updated successfuly!";
                                    }
                                    else
                                    {
                                        Label1.Text = "Defense not updated ";
                                        conn2.Open();
                                        UpdateMyDefense.ExecuteNonQuery();
                                        conn2.Close();
                                    }
                                    Label1.Visible = true;
                                }
                                conn3.Close();
                            }
                        }
                        conn2.Close();



                    }
                    ///////////////////////////////////////
                }
            }
        }
    }
}




