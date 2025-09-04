import { Module } from '@nestjs/common';
import { ClickProducerService } from './click-tracking.service';
import { ClickTrackingGateway } from './click-tracking.gateway';
import { MongooseModule } from '@nestjs/mongoose';
import { RedisModule } from 'src/redis/redis.module';
import { ProductClick, ProductClickSchema } from './model/click-tracking.schema';
import { BullModule } from '@nestjs/bullmq';
import { ClickConsumerProcessor } from './click-consumer.processor';
import { ClickTrackingController } from './click-tracking.controller';

@Module({
  imports: [
    BullModule.registerQueue({
      name: 'click-queue',
    }),
    RedisModule,
    MongooseModule.forFeature([
      { name: ProductClick.name, schema: ProductClickSchema },
    ]),
  ],
  controllers: [ClickTrackingController],
  providers: [ClickTrackingGateway, ClickProducerService, ClickConsumerProcessor],
  exports: [ClickTrackingGateway, ClickProducerService, ClickConsumerProcessor],
})
export class ClickTrackingModule { }
