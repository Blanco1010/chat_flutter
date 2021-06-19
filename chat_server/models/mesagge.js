const { Schema,model } = require('mongoose');


const MesaggeSchema = Schema({

    de: {
        type: Schema.Types.ObjectId,
        ref: 'Usuario',
        required: true
    },
    para: {
        type: Schema.Types.ObjectId,
        ref: 'Usuario',
        required: true
    },
    mensaje: {
        type: String,
        require: true
    }
}, {
    timestamps:true
});

MesaggeSchema.method('toJSON', function(){

    const { __v,_id, ...object } = this.toObject();
    return object;

});



module.exports = model('Message',MesaggeSchema);


