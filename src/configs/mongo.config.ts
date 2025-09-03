import { registerAs } from '@nestjs/config';

export default registerAs('mongo', () => ({
    user: process.env.MONGO_USER,
    password: process.env.MONGO_PASSWORD,
    host: process.env.MONGO_HOST || 'localhost',
    port: parseInt(process.env.MONGO_PORT || '27017', 10),
    db: process.env.MONGO_DB || 'nestdb',
}));
