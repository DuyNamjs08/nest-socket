import { Injectable, Inject } from '@nestjs/common';
import { Queue } from 'bullmq';
import IORedis from 'ioredis';
// import { ProductClick } from './model/click-tracking.schema';
import { Model } from 'mongoose';
import { InjectModel } from '@nestjs/mongoose';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class ClickProducerService {
  private queue: Queue;
  private cleanupQueue: Queue;

  constructor(
    @Inject('REDIS_CLIENT') private readonly redis: IORedis,
    // @InjectModel(ProductClick.name)
    // private readonly productClickModel: Model<ProductClick>,
    private readonly prisma: PrismaService,
  ) {
    this.queue = new Queue('click-queue', { connection: this.redis });
    this.cleanupQueue = new Queue('cleanup-click-queue', {
      connection: this.redis,
    });
  }

  async sendClickEvent(event: any) {
    try {
      const job = await this.queue.add('productClick', event, {
        attempts: 5,
        backoff: { type: 'exponential', delay: 500 }, // retry với delay tăng dần
      });
    } catch (err) {
      console.error('Failed to enqueue product click event', err);
      // Có thể fallback: lưu tạm vào Redis để retry sau
      await this.redis.lpush('failed-click-events', JSON.stringify(event));
    }
  }

  // flush DB được gọi từ service khác
  async flushToDB(data: any) {
    const { user_email, clicked_at, ip, product_id, user_id, count } = data;
    try {

      // const updatedDoc = await this.productClickModel
      //   .findOneAndUpdate(
      //     { product_id, user_id },
      //     {
      //       $inc: { count: parseInt(count, 10) },
      //       $set: { user_email, clicked_at, ip },
      //     },
      //     { upsert: true, new: true },
      //   )
      //   .lean();
      const updatedDoc = await this.prisma.products.update({
        where: {
          id: product_id,
          user_id: user_id,
        },
        data: {
          counts: parseInt(count, 10),
        },
      });
      return updatedDoc;
    } catch (err) {
      console.error('Failed to flush clicks to db', data.product_id, err);
    }
  }
  // async getListCountClickByUserProduct(data: any) {
  //   try {
  //     const clicks = await this.productClickModel.find({
  //       user_id: data.user_id,
  //     });
  //     return clicks;
  //   } catch (err) {
  //     console.error('Failed to get click count from Mongo', err);
  //   }
  // }
  async addCleanupJob() {
    await this.cleanupQueue.add(
      'cleanup',
      {},
      {
        repeat: {
          pattern: '*/2 * * * *', // mỗi 2 phút
          tz: 'Asia/Ho_Chi_Minh',
        },
      },
    );
    // Lặp lại mỗi ngày lúc 0:00
  }
}
