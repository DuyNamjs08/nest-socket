import { Injectable, OnApplicationBootstrap, } from '@nestjs/common';
import { InjectConnection } from '@nestjs/mongoose';
import { Connection } from 'mongoose';

@Injectable()
export class MongoLoggerService implements OnApplicationBootstrap {
    constructor(@InjectConnection() private readonly connection: Connection) { }

    onApplicationBootstrap() {
        if (this.connection.readyState === 1) {
            console.log('[MongoDB] Already connected');
        }

        this.connection.on('connected', () => {
            console.log('[MongoDB] Connected successfully');
        });

        this.connection.on('error', (err) => {
            console.error('[MongoDB] Connection error:', err);
        });

        this.connection.on('disconnected', () => {
            console.warn('[MongoDB] Disconnected');
        });
    }
}
