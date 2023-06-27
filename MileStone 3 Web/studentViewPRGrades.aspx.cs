using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class studentViewPRGrades : System.Web.UI.Page
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

            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;
            SqlCommand t = new SqlCommand();

            string connStr2 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn2 = new SqlConnection(connStr2))
            {
                t.CommandText = "IF EXISTS(SELECT * FROM ProgressReport WHERE sid = @sid AND ComulativeProgressReportGrade > 00.00) SELECT 1 ELSE SELECT 0";
                t.Parameters.AddWithValue("@sid", c);
                t.Connection = conn2;
                conn2.Open();   
                object result = t.ExecuteScalar();

                if (result != null && result != DBNull.Value)
                {
                    int output = (int)result;
                    if (output != 1)
                    {
                        grade.ForeColor = System.Drawing.Color.Red;
                        grade.Text = "Your progress report grades haven't been posted yet.";
                        grade.Visible = true;
                        OK.Visible = false;
                        // Response.Redirect("error.aspx?message=You don't have access to this webpage.");
                    }


                    else
                    {
                        grade.Visible = false;
                        OK.Visible = true; ;
                        conn2.Close();
                        if (!IsPostBack)
                        {
                            // Execute the query and bind the results to the DropDownList control
                            BindDropDownList();
                            if (!IsPostBack)
                            {
                                // Set the default value of the dropdown list to "None"
                                DropDownList1.SelectedValue = "None";
                                // Display the table with the default "None" value
                                displayTable();
                            }
                        }
                    }
                }   }


        }
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            displayTable();
        }
        private void BindDropDownList()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT Date FROM ProgressReport WHERE sid = @sid ";
                cmd.Parameters.AddWithValue("@sid", c);

                cmd.Connection = conn;

                conn.Open();
                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "Date";
                DropDownList1.DataBind();
                DropDownList1.Items.Insert(0, new ListItem("All Dates", "All Dates"));
                DropDownList1.SelectedValue = "All Dates";
            }

        }
        private void displayTable()
        {
            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;
            string selectedDate = DropDownList1.SelectedValue;
           // if(selectedDate != "All Dates")
            //{    //---
           // DateTime actualDate = DateTime.Parse(selectedDate);
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand viewPR = new SqlCommand("ViewMyProgressReports",conn);
                viewPR.CommandText = "ViewMyProgressReports";
                viewPR.CommandType = CommandType.StoredProcedure;
                viewPR.Parameters.Add(new SqlParameter("@sid", c));
                if (selectedDate != "All Dates")
                {    //---
                    DateTime actualDate = DateTime.Parse(selectedDate);
                    viewPR.Parameters.Add(new SqlParameter("@date", actualDate));
                }
                else
                {
                    viewPR.Parameters.AddWithValue("@date", DBNull.Value);
                }
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(viewPR);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                StringBuilder sb = new StringBuilder();
                sb.Append("<center>");
                sb.Append("<table class=table-striped tbody tr:nth-of-type(odd) style=color:white>");
                sb.Append("<tr>");



                sb.Append("<th style=color:#00ffff>");
                sb.Append("ID");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Date");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Content");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Updating User id");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Grade");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Comulative Progress Report Grade");

                sb.Append("</tr>");

                foreach (DataRow dr in dt.Rows)
                {
                    sb.Append("<tr>");
                    foreach (DataColumn dc in dt.Columns)
                    {
                        sb.Append("<th>");
                        sb.Append(dr[dc.ColumnName].ToString());
                        sb.Append("</th>");

                    }
                    sb.Append("</tr>");
                }

                sb.Append("</table>");
                sb.Append("</center>");
                Panel3.Controls.Add(new Label { Text = sb.ToString() });
                conn.Close();
            }
            
        }
    }
}