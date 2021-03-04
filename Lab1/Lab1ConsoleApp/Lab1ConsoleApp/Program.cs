using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
//ADO.NET -> set of classes in .NET apps to interact
//with different data sources (files, dbs etc.)
//.NET Framework Data Provider for SQL Server
    //4 main objects
        // CONNECTION
        // COMMAND
        // DATAREADER
        // DATAADAPTER
        //^^^^^^^^^^^
        //|||||||||||
        //----SQL----
//DataSet Class
// sqlcommand  - ExecuteScalar, ExecuteNonQuery(inserts updates deletes)

namespace Lab1ConsoleApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Int32 newCompanyID = 0;
            //SqlConnection dbConnection = new SqlConnection();
            string connectionString = "Data Source = DESKTOP-EDT65RK\\SQLEXPRESS;"
                + "Initial Catalog = Final_Lab_Doamne_Ajuta;"
                + "Integrated Security = SSPI";//key-value pairs
                                               //NameOfTheServerOfTheDataBase
                                               //Double the backslashes
            /*dbConnection.Open();
            Console.WriteLine("OK");
            dbConnection.Close();*/
            // dbConnection.Open();
            /*DataSet dataSet = new DataSet();

            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter("SELECT * FROM Company",dbConnection);
            SqlCommandBuilder cmd = new SqlCommandBuilder(sqlDataAdapter);
            sqlDataAdapter.Fill(dataSet, "Company");

            foreach(DataRow dr in dataSet.Tables[0].Rows)
            {
                Console.WriteLine("{0} - {1} - {2} ",dr["company_id"],dr["company_name"],dr["company_location"]);
            }


            DataRow newDataRow = dataSet.Tables[0].NewRow();
            newDataRow["company_id"] = 234;
            newDataRow["company_name"] = "kjsdnfjsdnfkdsnf";
            newDataRow["company_location"] = "Berceni";
            dataSet.Tables[0].Rows.Add(newDataRow);
            
            sqlDataAdapter.Update(dataSet, "Company");*/

           /* using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Company (company_id) values (@company_id);", conn);
                cmd.Parameters.Add("@company_id", SqlDbType.Int);
                cmd.Parameters["@company_id"].Value = 23456789;
                try
                {
                    conn.Open();
                    newCompanyID = (Int32)cmd.ExecuteScalar();
                }
                catch(Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }*/

            using(SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Company SET company_name = 'BoopBeep' WHERE company_name = 'a'", conn);
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
            }

        }
    }
}
