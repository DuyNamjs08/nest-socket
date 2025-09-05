import { Module } from '@nestjs/common';
import { ClickProducerService } from './click-tracking.service';
import { ClickTrackingGateway } from './click-tracking.gateway';
// import { MongooseModule } from '@nestjs/mongoose';
import { RedisModule } from 'src/redis/redis.module';
// import {
//   ProductClick,
//   ProductClickSchema,
// } from './model/click-tracking.schema';
import { BullModule } from '@nestjs/bullmq';
import { ClickConsumerProcessor } from './click-consumer.processor';
import { ClickTrackingController } from './click-tracking.controller';
import { ClickCleanupProcessor } from './click-cleanup.processor';
import { ClickCleanupService } from './click-cleanup.service';

@Module({
  imports: [
    BullModule.registerQueue(
      {
        name: 'click-queue',
      },
      { name: 'cleanup-click-queue' },
    ),
    RedisModule,
    // MongooseModule.forFeature([
    //   { name: ProductClick.name, schema: ProductClickSchema },
    // ]),
  ],
  controllers: [ClickTrackingController],
  providers: [
    ClickTrackingGateway,
    ClickProducerService,
    ClickConsumerProcessor,
    ClickCleanupProcessor,
    ClickCleanupService,
  ],
  exports: [
    ClickTrackingGateway,
    ClickProducerService,
    ClickConsumerProcessor,
    ClickCleanupProcessor,
  ],
})
export class ClickTrackingModule { }
