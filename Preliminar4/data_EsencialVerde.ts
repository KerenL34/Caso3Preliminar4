import { Logger } from './Logger';
const sql = require('mssql')

const sqlConfig = {
    user: "sa",
    password: "123456",
    database: "EsencielVerde",
    server: 'localhost',
    pool: {
        max: 1,
        idleTimeoutMillis: 30000,
        min: 1
    },
    options: {
        encrypt: true,
        trustServerCertificate: true
    }
};


export class data_EsencialVerde {
    private log: Logger;

    public constructor()
    {
        this.log = new Logger();
        //via singleton, accediendo a un solo pool tengo una conexiona la base de datos
    }
    
    public ObtenerEstadosYPaises(filter:string) : Promise<any>
    {
            {
                return sql.connect(sqlConfig).then((pool:any) => {
                    return pool.request()
                    .input('@searchcriteria', sql.varchar(40), filter) 
                    .execute('getFilteredClients')
            });
        }
    }
}
