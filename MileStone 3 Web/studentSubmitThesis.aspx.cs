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
    public partial class studentSubmitThesis : System.Web.UI.Page
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
            string Title;
            string connStr2 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn2 = new SqlConnection(connStr2))
            {
                cmd.CommandText = "IF EXISTS (SELECT * FROM Student WHERE s_id = @sid) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@sid", c);
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


                SqlCommand Get = new SqlCommand();
                Get.CommandText = "SELECT Title FROM Thesis WHERE sid = @sid";
                Get.Parameters.AddWithValue("@sid", c);
                Get.Connection = conn2;

                SqlCommand T = new SqlCommand();
                T.CommandText = "IF EXISTS (SELECT Title FROM Thesis WHERE sid = @sid) SELECT 1 ELSE SELECT 0";
                T.Parameters.AddWithValue("@sid", c);
                T.Connection = conn2;
                conn2.Open();
                // Execute the query and get the result
                object resultT = T.ExecuteScalar();
                if (resultT != null && resultT != DBNull.Value)
                {
                    int output = (int)resultT;
                    if (output != 1)
                    {
                        Label1.Text = "You don't have a thesis yet";
                        Label1.Visible = true;
                        OK.Visible = false;

                        //Response.Redirect("error.aspx?message=You don't have a thesis yet.");
                    }

                    //-------------------------
                    else
                    {
                        Label1.Visible = false;
                        OK.Visible = true;
                        Title = Get.ExecuteScalar().ToString();



                        conn2.Close();


                        // string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                        // Create a new connection
                        //SqlConnection conn = new SqlConnection(connStr);



                        string pdf = Request.Form["TS"];

                        SqlCommand SubmitMyThesis = new SqlCommand("SubmitMyThesis", conn2);
                        SubmitMyThesis.CommandType = CommandType.StoredProcedure;
                        SubmitMyThesis.Parameters.Add(new SqlParameter("@sid", c));
                        SubmitMyThesis.Parameters.Add(new SqlParameter("@title", Title));
                        SubmitMyThesis.Parameters.Add(new SqlParameter("@PDF_Document", pdf));



                        conn2.Open();
                        if (IsPostBack)
                        {
                            SubmitMyThesis.ExecuteNonQuery();
                            Response.Write(c.ToString());

                           // Response.Write(pdf.ToString());
                            //Response.Write(Title.ToString());


                            string connStr3 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                            using (SqlConnection conn3 = new SqlConnection(connStr3))
                            {
                                SqlCommand test = new SqlCommand();
                                test.CommandText = "IF EXISTS (SELECT * FROM Thesis WHERE sid = @sid AND PDF_doc = @PDF_Document) SELECT 1 ELSE SELECT 0";
                                test.Parameters.AddWithValue("@sid", c);
                                test.Parameters.AddWithValue("@PDF_Document", pdf);
                                test.Connection = conn3;
                                conn3.Open();
                                // Execute the query and get the result
                                object resultSS = test.ExecuteScalar();
                                if (resultSS != null && resultSS != DBNull.Value)
                                {
                                    int outputSS = (int)resultSS;
                                    if (outputSS == 1)
                                    {
                                        Label1.ForeColor = System.Drawing.Color.Green;
                                        Label1.Text = "Thesis submitted successfully!";

                                    }
                                    else
                                    {
                                        Label1.Text = "Thesis not submitted ";
                                        conn2.Open();
                                        SubmitMyThesis.ExecuteNonQuery();
                                        conn2.Close();
                                    }
                                    Label1.Visible = true;
                                    OK.Visible = true;

                                }
                                conn3.Close();
                            }
                        }
                        conn2.Close();
                    }
                }
            }
        }
    }
}
   