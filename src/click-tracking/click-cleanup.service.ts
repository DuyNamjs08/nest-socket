import { Injectable, Inject, OnModuleInit } from '@nestjs/common';
import { Queue } from 'bullmq';
import IORedis from 'ioredis';

@Injectable()
export class ClickCleanupService implements OnModuleInit {
  private cleanupQueue: Queue;

  constructor(@Inject('REDIS_CLIENT') private readonly redis: IORedis) { }

  onModuleInit() {
    this.cleanupQueue = new Queue('cleanup-click-queue', {
      connection: this.redis,
    });

    // Thêm job chạy mỗi 20 phút
    this.addCleanupJob();
  }

  async addCleanupJob() {
    await this.cleanupQueue.add(
      'cleanup',
      {},
      {
        repeat: { every: 20 * 60 * 1000 }, // 20 phút
      },
    );
  }
}
