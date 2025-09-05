import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { ClickProducerService } from './click-tracking.service';
import { PrismaService } from 'src/prisma/prisma.service';


@WebSocketGateway({
  cors: { origin: '*' }, // ⚠️ production nên giới hạn domain
})
export class ClickTrackingGateway {
  @WebSocketServer()
  server: Server;

  constructor(
    private readonly clickProducer: ClickProducerService,
    private readonly prisma: PrismaService,
  ) { }

  @SubscribeMessage('productClick')
  async handleProductClick(
    @MessageBody()
    data: {
      product_id: number;
      count: number;
      user_id: number;
      user_email: string;
      clicked_at: Date;
    },
    @ConnectedSocket() client: Socket,
  ) {
    const product = await this.prisma.products.findFirst({
      where: {
        id: data.product_id,
        user_id: data.user_id,
      },
    });
    if (!product) {
      client.emit('error', 'Product not found');
      return;
    }
    const ip =
      (client.handshake.headers['x-forwarded-for'] as string) ||
      client.handshake.address;
    await this.clickProducer.sendClickEvent({ ...data, ip, count: product.counts });
  }
}
