import { Injectable, Inject, OnModuleInit } from '@nestjs/common';
import { Queue } from 'bullmq';
import IORedis from 'ioredis';

@Injectable()
export class ClickCleanupService implements OnModuleInit {
  private cleanupQueue: Queue;

  constructor(@Inject('REDIS_CLIENT') private readonly redis: IORedis) {}

  onModuleInit() {
    this.cleanupQueue = new Queue('cleanup-click-queue', {
      connection: this.redis,
    });

    // Thêm job chạy mỗi 2 phút
    this.addCleanupJob();
  }

  async addCleanupJob() {
    console.log('Adding cleanup job to run every 2 minutes');
    await this.cleanupQueue.add(
      'cleanup',
      {},
      {
        repeat: { every: 2 * 60 * 1000 }, // 2 phút
      },
    );
  }
}
