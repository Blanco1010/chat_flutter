const { response } = require("express");
const bcrypt = require('bcryptjs');

const Usuario = require('../models/usuario');
const { generarJWT } = require("../helpers/jwt");


const crearUsuario = async (req,res = response) => {

    const { email,password } = req.body;

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
        usuario.password = bcrypt.hashSync(password,salt);

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



const login = async (req,res = response) => {

    const {email,password } = req.body;

    try {

        const usuarioDB = await Usuario.findOne({email});
        if(!usuarioDB){
            return res.status(404).json({
                ok: false,
                msg: 'Email no encontrado'
            });
        }

        //Validar el password
        const validPassord = bcrypt.compareSync(password, usuarioDB.password);
        if(!validPassord) {
            return res.status(400).json({
                ok: false,
                msg: 'La contraseña no es valida'
            });
        }

        //Generar el JWT
        const token = await generarJWT(usuarioDB.id);

        res.json({
            ok:true,
            usuario: usuarioDB,
            token
        });


        
    } catch (error) {
        return res.status(500).json({
            ok:false,
            msg: 'Hable con el administrador'
        }) 
    }
} 


const renewToken = async (req,res = response) => {

    // const uid uid del usuario
    const uid = req.uid;

    // generar un nuevo JWT, generarJWT... uid...
    const token = await generarJWT(uid);

    // Obtener el usuario por el UID, Usuario.findById..
    const usuario = await Usuario.findById(uid);

    res.json({
        ok:true,
        usuario,
        token
    });



}







module.exports = {
    crearUsuario,
    login,
    renewToken
}



