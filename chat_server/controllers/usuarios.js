const { response } = require('express');
const Usuario = require('../models/usuario')

const getUsuarios = async(req,res = response) => {


    const desde = Number(req.query.desde) || 0;



    const usuarios = await Usuario
            .find({ _id: { $ne: req.uid } })// No aparece su token, el resto si
            .sort('-isOnline') //ordenar el isOnline
            .skip(desde)
            .limit(20)
       
    res.json({
        ok:true,
        usuarios,
        desde
    });
}

module.exports = {
    getUsuarios
}