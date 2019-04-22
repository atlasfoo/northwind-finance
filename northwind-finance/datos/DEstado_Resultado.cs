using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;

namespace northwind_finance.datos
{
    class DEstado_Resultado
    {
        public DataTable ER()
        {
            DataTable dataER = new DataTable("Estado de resultado");
            SqlConnection SqlCon = new SqlConnection();
            try
            {
                SqlCon.ConnectionString = Conexion.Cn;
                SqlCommand SqlCmd = new SqlCommand();
                SqlCmd.Connection = SqlCon;
                SqlCmd.CommandText = "sp_Estado_Resultados";
                SqlCmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter SqlDat = new SqlDataAdapter(SqlCmd);
                SqlDat.Fill(dataER);

            }
            catch (Exception ex)
            {
                dataER = null;
            }
            return dataER;
        }
    }
}
