const { Schema,model } = require('mongoose');


const UsuarioSchema = Schema({

    nombre: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required:true,
        unique:true //Unico
    },
    password: {
        type:String,
        required:true
    },
    isOnline: {
        type:Boolean,
        default:false
    }
});

module.exports = model('Usuario',UsuarioSchema);


