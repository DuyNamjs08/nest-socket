import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { TransformInterceptor } from './transform/transform.interceptor';
import { AllExceptionsFilter } from './all-exceptions/all-exceptions.filter';
import { AllAuthGuard } from './all-auth/all-auth.guard';
import { Reflector } from '@nestjs/core';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';


async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const configService = app.get(ConfigService);
  app.enableCors({
    origin: '*',
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization'],
  });
  // RabbitMQ Microservice
  app.connectMicroservice<MicroserviceOptions>({
    transport: Transport.RMQ,
    options: {
      urls: [
        `amqp://${configService.get<string>('RABBITMQ_USER')}:${configService.get<string>('RABBITMQ_PASSWORD')}@${configService.get<string>('RABBITMQ_HOST')}:${configService.get<string>('RABBITMQ_AMQP_PORT')}`,
      ],
      queue: configService.get<string>('RABBITMQ_QUEUE'),
      queueOptions: { durable: true },
    },
  });
  await app.startAllMicroservices();
  app.useGlobalInterceptors(new TransformInterceptor());
  app.useGlobalFilters(new AllExceptionsFilter());
  // const reflector = app.get(Reflector);
  // const jwtService = app.get(JwtService);

  // app.useGlobalGuards(new AllAuthGuard(reflector, jwtService));
  const port = process.env.PORT ?? 3000;
  await app.listen(port);
  console.log(`🚀 HTTP + WebSocket server running on port ${port}`);

}
bootstrap();
