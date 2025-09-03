import { Module } from '@nestjs/common';
import { ClickProducerService } from './click-tracking.service';
import { ClickTrackingGateway } from './click-tracking.gateway';
import { MongooseModule } from '@nestjs/mongoose';
import { RedisModule } from 'src/redis/redis.module';
import { ProductClick, ProductClickSchema } from './model/click-tracking.schema';

@Module({
  imports: [
    RedisModule,
    MongooseModule.forFeature([
      { name: ProductClick.name, schema: ProductClickSchema },
    ]),
  ],
  providers: [ClickTrackingGateway, ClickProducerService],
})
export class ClickTrackingModule { }
