const { comprobarJWT } = require('../helpers/jwt');
const { io } = require('../index');
const {usuarioConectado,usuarioDesconectado} = require('../controllers/socket');


// Mensajes de Sockets
io.on('connection', async (client) => {
    console.log('Cliente conectado');


    console.log(client.handshake.headers['x-token']);
    const [valido,uid] = comprobarJWT(client.handshake.headers['x-token']);
    
    // Verificar autenticación
    if(!valido){ return client.disconnect(); }

   //Cliente autenticación
   usuarioConectado(uid);


    client.on('disconnect', () => {
        console.log('Cliente desconectado');
        usuarioDesconectado(uid);
    });

    // client.on('mensaje', ( payload ) => {
    //     console.log('Mensaje', payload);

    //     io.emit( 'mensaje', { admin: 'Nuevo mensaje' } );

    // });


});
