import { Processor, WorkerHost } from '@nestjs/bullmq';
import { Job } from 'bullmq';
import IORedis from 'ioredis';
import { Inject } from '@nestjs/common';
import { ClickTrackingGateway } from './click-tracking.gateway';
import { ClickProducerService } from './click-tracking.service';

@Processor('click-queue', { concurrency: 50 })
export class ClickConsumerProcessor extends WorkerHost {
    constructor(
        private readonly gateway: ClickTrackingGateway,
        private readonly clickProducer: ClickProducerService,
        @Inject('REDIS_CLIENT') private readonly redis: IORedis,
    ) {
        super();
    }

    async process(job: Job,) {
        const { product_id, user_id, user_email, clicked_at } = job.data;
        try {
            // 1. Tăng counter Redis
            const redisCount = await this.redis.incr(`product:click:${product_id}`);
            // 2. Flush vào Mongo
            const updatedDoc = await this.clickProducer.flushToMongo({ product_id, user_id, user_email, clicked_at, count: redisCount });
            // 3. Emit realtime ra WebSocket
            if (updatedDoc) {
                await this.gateway.server.emit('productClick', {
                    product_id,
                    count: updatedDoc.count,
                });
            }
        } catch (err) {
            console.error('❌ Error processing job', job.id, err);
            throw err;
        }
    }

}
