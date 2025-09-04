import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { JwtModule } from '@nestjs/jwt';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { PassportModule } from '@nestjs/passport';
import { AuthController } from './auth/auth.controller';
import { GoogleStrategy } from './google/google.strategy';
import { HttpModule } from '@nestjs/axios';
import { ClientsModule, Transport } from '@nestjs/microservices';
import { EventsGateway } from './gateway/events.gateway';
import { MongooseModule } from '@nestjs/mongoose';
import { MongoLoggerService } from './mongo/mongo.service';
import { ClickTrackingModule } from './click-tracking/click-tracking.module';
import mongoConfig from './configs/mongo.config';
import { ProductClick, ProductClickSchema } from './click-tracking/model/click-tracking.schema';
import { RedisModule } from './redis/redis.module';
import { BullModule } from '@nestjs/bullmq';



@Module({
  imports: [PrismaModule, HttpModule,
    ConfigModule.forRoot({
      isGlobal: true,
      load: [mongoConfig], // load file config
    }),
    RedisModule,
    BullModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (config: ConfigService) => ({
        connection: {
          host: config.get<string>('REDIS_HOST') || 'localhost',
          port: parseInt(config.get<string>('REDIS_PORT') || '6379', 10),
          password: config.get<string>('REDIS_PASSWORD') || undefined,
        },
      }),
    }),
    // Mongo
    MongooseModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (config: ConfigService) => {
        const mongo = config.get('mongo'); // lấy từ mongo.config.ts
        const uri = `mongodb://${mongo.user}:${mongo.password}@${mongo.host}:${mongo.port}/${mongo.db}?authSource=admin`;
        return {
          uri,
        };
      },
    }),
    // JWT
    JwtModule.registerAsync({
      imports: [ConfigModule,],
      inject: [ConfigService],
      useFactory: (config: ConfigService) => ({
        secret: config.get<string>('JWT_SECRET') || 'defaultSecret',
        signOptions: { expiresIn: '1h' },
      }),
    }),
    PassportModule.register({ defaultStrategy: 'google' }),
    ClientsModule.registerAsync([
      {
        name: 'RABBITMQ_SERVICE',
        imports: [ConfigModule],
        inject: [ConfigService],
        useFactory: (configService: ConfigService) => ({
          transport: Transport.RMQ,
          options: {
            urls: [
              `amqp://${configService.get<string>('RABBITMQ_USER')}:${configService.get<string>('RABBITMQ_PASSWORD')}@${configService.get<string>('RABBITMQ_HOST')}:${configService.get<string>('RABBITMQ_AMQP_PORT')}`,
            ],
            queue: configService.get<string>('RABBITMQ_QUEUE'),
            queueOptions: {
              durable: true, // giữ queue khi RabbitMQ restart
            },
            exchange: 'vodaplay_exchange', // exchange tên tùy chọn
            exchangeType: 'topic',
          },
        }),
      },
    ]),
    ClickTrackingModule,
  ],
  controllers: [AppController, AuthController],
  providers: [AppService, GoogleStrategy, EventsGateway, MongoLoggerService],
})
export class AppModule { }
