"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.EsencialVerdeController = void 0;
const Caso3Bases_1 = require("../Caso3Bases");
class EsencialVerdeController {
    constructor() {
        this.log = new Caso3Bases_1.Logger();
        try {
        }
        catch (e) {
            this.log.error(e);
        }
    }
    static getInstance() {
        if (!this.instance) {
            this.instance = new EsencialVerdeController();
        }
        return this.instance;
    }
    ObtenerEstadosYPaises() {
        return Promise.resolve(null);
    }
}
exports.EsencialVerdeController = EsencialVerdeController;
