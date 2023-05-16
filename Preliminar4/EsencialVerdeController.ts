import { Logger } from './Logger';

export class EsencialVerdeController {
    private static instance: EsencialVerdeController;
    private log: Logger;

    private constructor() {
        this.log = new Logger();
        try {

        } catch (e) {
            this.log.error(e as string); 
        }
    }

    public static getInstance(): EsencialVerdeController {
        if (!this.instance) {
            this.instance = new EsencialVerdeController();
        }
        return this.instance;
    }

    public ObtenerEstadosYPaises(): Promise<any> {
        return Promise.resolve(null);
    }
}
