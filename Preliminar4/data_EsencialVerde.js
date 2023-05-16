"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.data_EsencialVerde = void 0;
const Caso3Bases_1 = require("../Caso3Bases");
const sql = require('mssql');
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
class data_EsencialVerde {
    constructor() {
        this.log = new Caso3Bases_1.Logger();
        //via singleton, accediendo a un solo pool tengo una conexiona la base de datos
    }
    ObtenerEstadosYPaises(filter) {
        {
            return sql.connect(sqlConfig).then((pool) => {
                return pool.request()
                    .input('@searchcriteria', sql.varchar(40), filter)
                    .execute('getFilteredClients');
            });
        }
    }
}
exports.data_EsencialVerde = data_EsencialVerde;
