import { Global, Module } from '@nestjs/common';
import IORedis from 'ioredis';

@Global()
@Module({
    providers: [
        {
            provide: 'REDIS_CLIENT',
            useFactory: () => {
                return new IORedis({
                    host: 'localhost',
                    port: 6379,
                    password: 'VodaPlayBone123',
                });
            },
        },
    ],
    exports: ['REDIS_CLIENT'],
})
export class RedisModule { }
