using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;


namespace northwind_finance.datos
{
    class DBalance_General
    {
        public DataTable BG()
        {
            DataTable dataBG = new DataTable("Balance general");
            SqlConnection SqlCon = new SqlConnection();
            try
            {
                SqlCon.ConnectionString = Conexion.Cn;
                SqlCommand SqlCmd = new SqlCommand();
                SqlCmd.Connection = SqlCon;
                SqlCmd.CommandText = "sp_Balance_General";
                SqlCmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter SqlDat = new SqlDataAdapter(SqlCmd);
                SqlDat.Fill(dataBG);

            }
            catch (Exception ex)
            {
                dataBG = null;
            }
            return dataBG;
        }
    }
}
