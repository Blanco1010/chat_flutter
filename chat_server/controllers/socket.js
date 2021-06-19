const Usuario = require('../models/usuario');
const Message = require('../models/mesagge');


const usuarioConectado = async (uid = '') => {

    const usuario    = await Usuario.findById(uid);
    usuario.isOnline = true;
    await usuario.save();
    return usuario;
}

const usuarioDesconectado = async (uid = '') => {

    const usuario    = await Usuario.findById(uid);
    usuario.isOnline = false;
    await usuario.save();
    return usuario;
}

const grabarMensaje = async( payload ) => {

    /*
        payload: {
            de: '',
            para: '',
            text: ''
        }
    */

    try {
        const mensaje = new Message(payload);
        await mensaje.save();
        return true;
    } catch (error) {
        return false;    
    }

}

module.exports = {
    usuarioConectado,
    usuarioDesconectado,
    grabarMensaje
}