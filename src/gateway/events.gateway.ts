import {
    WebSocketGateway,
    WebSocketServer,
    SubscribeMessage,
    MessageBody,
    ConnectedSocket,
    OnGatewayInit,
    OnGatewayConnection,
    OnGatewayDisconnect,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';

@WebSocketGateway({
    cors: {
        origin: '*', // cho phép tất cả domain
    },
    transports: ['websocket', 'polling'], // fallback polling nếu websocket fail
})
export class EventsGateway
    implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect {
    @WebSocketServer()
    server: Server;

    afterInit(server: Server) {
        console.log('🚀 Socket server initialized');

        // Debug tất cả connection
        server.on('connection', (socket) => {
            console.log('🔌 Socket connected (handshake):', socket.id);
        });
    }

    handleConnection(client: Socket) {
        console.log(`✅ Client connected: ${client.id}`);
    }

    handleDisconnect(client: Socket) {
        console.log(`❌ Client disconnected: ${client.id}`);
    }

    @SubscribeMessage('send_message')
    handleMessage(
        @MessageBody() data: any,
        @ConnectedSocket() client: Socket,
    ): void {
        console.log(`📩 Received from ${client.id}:`, data);

        // broadcast lại cho tất cả client, trừ client gửi
        client.broadcast.emit('receive_message', data);

        // Nếu muốn gửi luôn lại cho chính client:
        client.emit('receive_message', data);
    }
}
