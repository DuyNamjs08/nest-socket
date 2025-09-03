import { Injectable } from '@nestjs/common';
import { Public } from './decorators/public.decorator';

@Injectable()
@Public()
export class AppService {
  getHello(): string {
    console.log('Hello World!');
    return 'Hello World!';
  }
}
