import { Global, Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import IORedis from 'ioredis';

@Global()
@Module({
    imports: [ConfigModule], // để inject ConfigService
    providers: [
        {
            provide: 'REDIS_CLIENT',
            inject: [ConfigService],
            useFactory: (config: ConfigService) => {
                return new IORedis({
                    host: config.get<string>('REDIS_HOST') || 'localhost',
                    port: parseInt(config.get<string>('REDIS_PORT') || '6379', 10),
                    password: config.get<string>('REDIS_PASSWORD') || undefined,
                });
            },
        },
    ],
    exports: ['REDIS_CLIENT'],
})
export class RedisModule { }
