"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.EsencialVerdeRouter = void 0;
const express_1 = __importDefault(require("express"));
const Common_1 = require("../Common");
const EsencialVerdeController_1 = require("../Caso3Bases/EsencialVerdeController");
const log = new Common_1.Logger();
const app = (0, express_1.default)();
exports.EsencialVerdeRouter = app;
app.get("/ObtenerEstadosYPaises", (req, res, next) => {
    EsencialVerdeController_1.EsencialVerdeController.getInstance().ObtenerEstadosYPaises(req.body.filter)
        .then((data) => {
        res.json(data);
    })
        .catch((err) => {
        log.error(err);
        return "{msg: \"error\"}";
    });
});
