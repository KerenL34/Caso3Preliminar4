import express, { Request, Response } from 'express';
import { NextFunction } from 'express-serve-static-core';
import { Logger } from './Logger';
import { EsencialVerdeController } from '../Caso3Bases/EsencialVerdeController';

const log = new Logger();
const app = express();

app.get("/ObtenerEstadosYPaises", (req: Request, res: Response, next: NextFunction) => {
    EsencialVerdeController.getInstance().ObtenerEstadosYPaises()
        .then((data: any) => {
            console.log(data);
            res.json(data);
        })
        .catch((err: any) => {
            log.error(err);
            return ({ error: { msg: "error" } });
        });
});

export { app as EsencialVerdeRouter };
