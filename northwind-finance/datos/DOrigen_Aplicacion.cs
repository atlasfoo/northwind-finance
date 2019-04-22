using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;

namespace northwind_finance.datos
{
    class DOrigen_Aplicacion
    {
        public DataTable OYA()
        {
            DataTable dataOYA = new DataTable("Origen y Aplicacion");
            SqlConnection SqlCon = new SqlConnection();
            try
            {
                SqlCon.ConnectionString = Conexion.Cn;
                SqlCommand SqlCmd = new SqlCommand();
                SqlCmd.Connection = SqlCon;
                SqlCmd.CommandText = "sp_origen_aplicacion";
                SqlCmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter SqlDat = new SqlDataAdapter(SqlCmd);
                SqlDat.Fill(dataOYA);

            }
            catch (Exception ex)
            {
                dataOYA = null;
            }
            return dataOYA;
        }
    }
}
