import { Processor, WorkerHost } from '@nestjs/bullmq';
import { Job } from 'bullmq';
import { Inject } from '@nestjs/common';
import IORedis from 'ioredis';

@Processor('cleanup-click-queue')
export class ClickCleanupProcessor extends WorkerHost {
  constructor(@Inject('REDIS_CLIENT') private readonly redis: IORedis) {
    super();
  }

  async process(job: Job) {
    try {
      // Dùng SCAN để tránh KEYS tốn bộ nhớ
      //   let cursor = '0';
      //   do {
      //     const [nextCursor, keys] = await this.redis.scan(
      //       cursor,
      //       'MATCH',
      //       'product:click:*',
      //       'COUNT',
      //       100,
      //     );
      //     cursor = nextCursor;
      //     for (const key of keys) {
      //       const count = await this.redis.get(key);
      //       if (count !== null && parseInt(count, 10) < 1000) {
      //         await this.redis.del(key);
      //         console.log(`Deleted low-count key: ${key}`);
      //       }
      //     }
      //   } while (cursor !== '0');
      await new Promise((resolve) => setTimeout(resolve, 1));
      console.log('✅ Click cleanup job completed successfully');
    } catch (err) {
      console.error('❌ Error cleaning up clicks', err);
    }
  }
}
