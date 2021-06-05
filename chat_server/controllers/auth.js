const { response } = require("express");
const bcrypt = require('bcryptjs');

const Usuario = require('../models/usuario');
const { generarJWT } = require("../helpers/jwt");


const crearUsuario = async (req,res = response) => {

    const { email } = req.body;

    try {

        const existEmail = await Usuario.findOne({email});
        if(existEmail){
            return res.status(400).json({
                of:false,
                msg:'El correo ya está registrado'
            })
        }

        const usuario = new Usuario(req.body);

        //Encriptar la contraseña
        const salt = bcrypt.genSaltSync();
        usuario.password = bcrypt.hashSync(salt);

        await usuario.save();

        // Generar mi JWT
        const token = await generarJWT(usuario.id);
        
        res.json({
            ok:true,
            usuario,
            token
        });




        
    } catch (error) {
        console.log(error);
        res.status(500).json({
            ok:false,
            msg: 'Hable con el administrador.'
        });

    }


}

module.exports = {
    crearUsuario
}



