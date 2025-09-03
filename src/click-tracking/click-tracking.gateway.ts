import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
  OnGatewayDisconnect,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { ClickProducerService } from './click-tracking.service';

interface RateInfo {
  count: number;
  lastTime: number;
}

@WebSocketGateway({
  cors: { origin: '*' }, // ⚠️ production nên giới hạn domain
})
export class ClickTrackingGateway implements OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  private rateMap = new Map<string, RateInfo>();
  private readonly limit = 10; // 10 message / 1 giây

  constructor(private readonly clickProducer: ClickProducerService) { }

  @SubscribeMessage('productClick')
  async handleProductClick(
    @MessageBody() data: {
      product_id: number;
      count: number;
      user_id: number;
      user_email: string;
      clicked_at: Date;
    },
    @ConnectedSocket() client: Socket,
  ) {
    const clientId = client.id;
    const now = Date.now();
    let info = this.rateMap.get(clientId);

    if (!info) {
      info = { count: 1, lastTime: now };
      this.rateMap.set(clientId, info);
    } else {
      if (now - info.lastTime < 1000) {
        info.count += 1;
        if (info.count > this.limit) {
          client.emit('error', 'Too many messages! Please slow down.');
          return;
        }
      } else {
        // reset count sau mỗi 1 giây
        info.count = 1;
        info.lastTime = now;
      }
      this.rateMap.set(clientId, info);
    }

    const ip =
      (client.handshake.headers['x-forwarded-for'] as string) ||
      client.handshake.address;

    console.log('productClick event:', data, 'from IP:', ip);

    await this.clickProducer.sendClickEvent({ ...data, ip });

    console.log('📤 Sent job to BullMQ:', data, `Client ${clientId} count: ${info.count}`);
  }

  handleDisconnect(client: Socket) {
    // Xoá client khỏi rateMap để tránh memory leak
    this.rateMap.delete(client.id);
    console.log(`Client disconnected: ${client.id}`);
  }
}
